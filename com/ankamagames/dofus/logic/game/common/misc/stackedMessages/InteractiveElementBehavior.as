package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
   import flash.filters.GlowFilter;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.datacenter.interactives.Interactive;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveElementUpdatedMessage;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.atouin.types.SpriteWrapper;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUsedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseEndedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseErrorMessage;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import flash.display.InteractiveObject;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
   import flash.geom.ColorTransform;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.managers.FiltersManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class InteractiveElementBehavior extends AbstractBehavior
   {
      
      public function InteractiveElementBehavior() {
         super();
         this._startTime = 0;
         this._timeOutRecolte = 0;
         type = ALWAYS;
         isAvailableToStart = false;
         this._isMoving = false;
      }
      
      private static var interactiveElements:Array;
      
      private static var currentElementId:int = -1;
      
      private static const FILTER_1:GlowFilter;
      
      private static const FILTER_2:GlowFilter;
      
      public var interactiveElement:InteractiveElement;
      
      public var currentSkillInstanceId:int;
      
      private var _tmpInteractiveElementId:int;
      
      private var _isMoving:Boolean;
      
      private var _time:int = 1000;
      
      private var _startTime:int = 0;
      
      private var _timeOutRecolte:int = 0;
      
      private var _duration:int;
      
      private var _lastCellExpected:int = -1;
      
      private var _isFreeMovement:Boolean = false;
      
      override public function processInputMessage(pMsgToProcess:Message, pMode:String) : Boolean {
         var msg:InteractiveElementActivationMessage = null;
         var interactive:Interactive = null;
         var ieumsg:InteractiveElementUpdatedMessage = null;
         canBeStacked = true;
         var entity:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
         var returnValue:Boolean = false;
         if(pMsgToProcess is MouseClickMessage)
         {
            this._isFreeMovement = !((pMsgToProcess as MouseClickMessage).target is SpriteWrapper);
            return false;
         }
         if(pMsgToProcess is InteractiveElementActivationMessage)
         {
            msg = pMsgToProcess as InteractiveElementActivationMessage;
            type = ALWAYS;
            interactive = Interactive.getInteractiveById(msg.interactiveElement.elementTypeId);
            if(interactive)
            {
               switch(interactive.actionId)
               {
                  case 3:
                  case 15:
                     type = STOP;
                     break;
               }
            }
            else
            {
               type = NORMAL;
               if(pMode == ALWAYS)
               {
                  canBeStacked = false;
                  return false;
               }
            }
            this.interactiveElement = msg.interactiveElement;
            this.currentSkillInstanceId = msg.skillInstanceId;
            position = msg.position;
            interactiveElements[msg.interactiveElement.elementId] = true;
            InteractiveElementBehavior.currentElementId = msg.interactiveElement.elementId;
            pendingMessage = pMsgToProcess;
            returnValue = true;
         }
         else if((pMsgToProcess is GameMapMovementMessage) && ((pMsgToProcess as GameMapMovementMessage).actorId == PlayedCharacterManager.getInstance().id) && ((pMsgToProcess as GameMapMovementMessage).keyMovements[0] == entity.position.cellId))
         {
            this._isMoving = true;
            if(this._isFreeMovement)
            {
               this._lastCellExpected = (pMsgToProcess as GameMapMovementMessage).keyMovements[(pMsgToProcess as GameMapMovementMessage).keyMovements.length - 1];
            }
            else
            {
               this._lastCellExpected = -1;
            }
         }
         else if(pMsgToProcess is CharacterMovementStoppedMessage)
         {
            this._lastCellExpected = -1;
            this._isMoving = false;
         }
         else if((pMode == ALWAYS) && (pMsgToProcess is CellClickMessage) && (this._isMoving))
         {
            isAvailableToStart = false;
            returnValue = true;
            canBeStacked = false;
         }
         else if(pMsgToProcess is InteractiveElementUpdatedMessage)
         {
            ieumsg = pMsgToProcess as InteractiveElementUpdatedMessage;
            if(ieumsg.interactiveElement.enabledSkills.length)
            {
               interactiveElements[ieumsg.interactiveElement.elementId] = true;
            }
            else if((ieumsg.interactiveElement.disabledSkills.length) && (interactiveElements[ieumsg.interactiveElement.elementId]))
            {
               interactiveElements[ieumsg.interactiveElement.elementId] = null;
            }
            
         }
         
         
         
         
         return returnValue;
      }
      
      override public function checkAvailability(pMsgToProcess:Message) : void {
         if((!(this._startTime == 0)) && (getTimer() >= this._startTime + this._time))
         {
            isAvailableToStart = false;
            this._startTime = 0;
         }
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            this._startTime = 0;
            isAvailableToStart = false;
         }
         else if((pMsgToProcess is InteractiveUsedMessage) && ((pMsgToProcess as InteractiveUsedMessage).entityId == PlayedCharacterManager.getInstance().id))
         {
            isAvailableToStart = true;
            this._tmpInteractiveElementId = (pMsgToProcess as InteractiveUsedMessage).elemId;
            this._startTime = 0;
         }
         else if((pMsgToProcess is InteractiveUseEndedMessage) && (this._tmpInteractiveElementId == (pMsgToProcess as InteractiveUseEndedMessage).elemId))
         {
            this._startTime = getTimer();
         }
         
         
      }
      
      override public function processOutputMessage(pMsgToProcess:Message, pMode:String) : Boolean {
         var returnValue:Boolean = false;
         if(pMsgToProcess is InteractiveUseEndedMessage)
         {
            this.stopAction();
            returnValue = true;
         }
         else if(pMsgToProcess is InteractiveUseErrorMessage)
         {
            this.stopAction();
            returnValue = true;
            actionStarted = true;
         }
         else if(pMsgToProcess is InteractiveUsedMessage)
         {
            this.removeIcon();
            this._duration = (pMsgToProcess as InteractiveUsedMessage).duration * 100;
            this._timeOutRecolte = getTimer();
            actionStarted = true;
            returnValue = this._duration == 0;
         }
         else if((this._timeOutRecolte > 0) && (getTimer() > this._timeOutRecolte + this._duration + 1000))
         {
            this.stopAction();
            returnValue = true;
         }
         
         
         
         return returnValue;
      }
      
      private function stopAction() : void {
         actionStarted = false;
         InteractiveElementBehavior.currentElementId = -1;
         this.removeIcon();
      }
      
      override public function isAvailableToProcess(pMsg:Message) : Boolean {
         if(interactiveElements[this.interactiveElement.elementId])
         {
            return true;
         }
         return false;
      }
      
      override public function addIcon() : void {
         var skillId:* = 0;
         var ieskill:InteractiveElementSkill = null;
         var s:Skill = null;
         var io:InteractiveObject = null;
         if(this.interactiveElement == null)
         {
            return;
         }
         for each(ieskill in this.interactiveElement.enabledSkills)
         {
            if(ieskill.skillInstanceUid == this.currentSkillInstanceId)
            {
               skillId = ieskill.skillId;
               break;
            }
         }
         s = Skill.getSkillById(skillId);
         sprite = RoleplayInteractivesFrame.getCursor(s.cursor,true,false);
         sprite.y = sprite.y - sprite.height;
         sprite.x = sprite.x - sprite.width / 2;
         sprite.transform.colorTransform = new ColorTransform(0.33,0.33,0.33,0.5,0,0,0,0);
         io = Atouin.getInstance().getIdentifiedElement(this.interactiveElement.elementId);
         FiltersManager.getInstance().addEffect(io,FILTER_1);
         FiltersManager.getInstance().addEffect(io,FILTER_2);
         super.addIcon();
      }
      
      override public function removeIcon() : void {
         if(this.interactiveElement == null)
         {
            return;
         }
         var io:InteractiveObject = Atouin.getInstance().getIdentifiedElement(this.interactiveElement.elementId);
         if(io)
         {
            FiltersManager.getInstance().removeEffect(io,FILTER_1);
            FiltersManager.getInstance().removeEffect(io,FILTER_2);
         }
         super.removeIcon();
      }
      
      override public function remove() : void {
         InteractiveElementBehavior.currentElementId = -1;
         super.remove();
      }
      
      override public function copy() : AbstractBehavior {
         var cp:InteractiveElementBehavior = new InteractiveElementBehavior();
         cp.pendingMessage = this.pendingMessage;
         cp.interactiveElement = this.interactiveElement;
         cp.position = this.position;
         cp.sprite = this.sprite;
         cp.currentSkillInstanceId = this.currentSkillInstanceId;
         cp.isAvailableToStart = this.isAvailableToStart;
         cp.type = this.type;
         return cp;
      }
      
      override public function isMessageCatchable(pMsg:Message) : Boolean {
         if(pMsg is GameMapMovementMessage)
         {
            return !((this._isMoving) || (actionStarted));
         }
         return true;
      }
      
      override public function get canBeRemoved() : Boolean {
         return !(this.interactiveElement.elementId == InteractiveElementBehavior.currentElementId);
      }
      
      override public function get needToWait() : Boolean {
         return (this._isMoving) && (!(this._lastCellExpected == -1));
      }
      
      override public function getFakePosition() : MapPoint {
         var mp:MapPoint = new MapPoint();
         mp.cellId = this._lastCellExpected;
         return mp;
      }
   }
}
