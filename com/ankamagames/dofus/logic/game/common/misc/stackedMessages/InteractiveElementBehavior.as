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
      
      private static var interactiveElements:Array = new Array();
      
      private static var currentElementId:int = -1;
      
      private static const FILTER_1:GlowFilter = new GlowFilter(16777215,0.8,6,6,4);
      
      private static const FILTER_2:GlowFilter = new GlowFilter(2845168,0.8,4,4,2);
      
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
      
      override public function processInputMessage(param1:Message, param2:String) : Boolean {
         var _loc5_:InteractiveElementActivationMessage = null;
         var _loc6_:Interactive = null;
         var _loc7_:InteractiveElementUpdatedMessage = null;
         canBeStacked = true;
         var _loc3_:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
         var _loc4_:* = false;
         if(param1 is MouseClickMessage)
         {
            this._isFreeMovement = !((param1 as MouseClickMessage).target is SpriteWrapper);
            return false;
         }
         if(param1 is InteractiveElementActivationMessage)
         {
            _loc5_ = param1 as InteractiveElementActivationMessage;
            type = ALWAYS;
            _loc6_ = Interactive.getInteractiveById(_loc5_.interactiveElement.elementTypeId);
            if(_loc6_)
            {
               switch(_loc6_.actionId)
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
               if(param2 == ALWAYS)
               {
                  canBeStacked = false;
                  return false;
               }
            }
            this.interactiveElement = _loc5_.interactiveElement;
            this.currentSkillInstanceId = _loc5_.skillInstanceId;
            position = _loc5_.position;
            interactiveElements[_loc5_.interactiveElement.elementId] = true;
            InteractiveElementBehavior.currentElementId = _loc5_.interactiveElement.elementId;
            pendingMessage = param1;
            _loc4_ = true;
         }
         else
         {
            if(param1 is GameMapMovementMessage && (param1 as GameMapMovementMessage).actorId == PlayedCharacterManager.getInstance().id && (param1 as GameMapMovementMessage).keyMovements[0] == _loc3_.position.cellId)
            {
               this._isMoving = true;
               if(this._isFreeMovement)
               {
                  this._lastCellExpected = (param1 as GameMapMovementMessage).keyMovements[(param1 as GameMapMovementMessage).keyMovements.length-1];
               }
               else
               {
                  this._lastCellExpected = -1;
               }
            }
            else
            {
               if(param1 is CharacterMovementStoppedMessage)
               {
                  this._lastCellExpected = -1;
                  this._isMoving = false;
               }
               else
               {
                  if(param2 == ALWAYS && param1 is CellClickMessage && (this._isMoving))
                  {
                     isAvailableToStart = false;
                     _loc4_ = true;
                     canBeStacked = false;
                  }
                  else
                  {
                     if(param1 is InteractiveElementUpdatedMessage)
                     {
                        _loc7_ = param1 as InteractiveElementUpdatedMessage;
                        if(_loc7_.interactiveElement.enabledSkills.length)
                        {
                           interactiveElements[_loc7_.interactiveElement.elementId] = true;
                        }
                        else
                        {
                           if((_loc7_.interactiveElement.disabledSkills.length) && (interactiveElements[_loc7_.interactiveElement.elementId]))
                           {
                              interactiveElements[_loc7_.interactiveElement.elementId] = null;
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      override public function checkAvailability(param1:Message) : void {
         if(!(this._startTime == 0) && getTimer() >= this._startTime + this._time)
         {
            isAvailableToStart = false;
            this._startTime = 0;
         }
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            this._startTime = 0;
            isAvailableToStart = false;
         }
         else
         {
            if(param1 is InteractiveUsedMessage && (param1 as InteractiveUsedMessage).entityId == PlayedCharacterManager.getInstance().id)
            {
               isAvailableToStart = true;
               this._tmpInteractiveElementId = (param1 as InteractiveUsedMessage).elemId;
               this._startTime = 0;
            }
            else
            {
               if(param1 is InteractiveUseEndedMessage && this._tmpInteractiveElementId == (param1 as InteractiveUseEndedMessage).elemId)
               {
                  this._startTime = getTimer();
               }
            }
         }
      }
      
      override public function processOutputMessage(param1:Message, param2:String) : Boolean {
         var _loc3_:* = false;
         if(param1 is InteractiveUseEndedMessage)
         {
            this.stopAction();
            _loc3_ = true;
         }
         else
         {
            if(param1 is InteractiveUseErrorMessage)
            {
               this.stopAction();
               _loc3_ = true;
               actionStarted = true;
            }
            else
            {
               if(param1 is InteractiveUsedMessage)
               {
                  this.removeIcon();
                  this._duration = (param1 as InteractiveUsedMessage).duration * 100;
                  this._timeOutRecolte = getTimer();
                  actionStarted = true;
                  _loc3_ = this._duration == 0;
               }
               else
               {
                  if(this._timeOutRecolte > 0 && getTimer() > this._timeOutRecolte + this._duration + 1000)
                  {
                     this.stopAction();
                     _loc3_ = true;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function stopAction() : void {
         actionStarted = false;
         InteractiveElementBehavior.currentElementId = -1;
         this.removeIcon();
      }
      
      override public function isAvailableToProcess(param1:Message) : Boolean {
         if(interactiveElements[this.interactiveElement.elementId])
         {
            return true;
         }
         return false;
      }
      
      override public function addIcon() : void {
         var _loc1_:* = 0;
         var _loc2_:InteractiveElementSkill = null;
         var _loc3_:Skill = null;
         var _loc4_:InteractiveObject = null;
         if(this.interactiveElement == null)
         {
            return;
         }
         for each (_loc2_ in this.interactiveElement.enabledSkills)
         {
            if(_loc2_.skillInstanceUid == this.currentSkillInstanceId)
            {
               _loc1_ = _loc2_.skillId;
               break;
            }
         }
         _loc3_ = Skill.getSkillById(_loc1_);
         sprite = RoleplayInteractivesFrame.getCursor(_loc3_.cursor,true,false);
         sprite.y = sprite.y - sprite.height;
         sprite.x = sprite.x - sprite.width / 2;
         sprite.transform.colorTransform = new ColorTransform(0.33,0.33,0.33,0.5,0,0,0,0);
         _loc4_ = Atouin.getInstance().getIdentifiedElement(this.interactiveElement.elementId);
         FiltersManager.getInstance().addEffect(_loc4_,FILTER_1);
         FiltersManager.getInstance().addEffect(_loc4_,FILTER_2);
         super.addIcon();
      }
      
      override public function removeIcon() : void {
         if(this.interactiveElement == null)
         {
            return;
         }
         var _loc1_:InteractiveObject = Atouin.getInstance().getIdentifiedElement(this.interactiveElement.elementId);
         if(_loc1_)
         {
            FiltersManager.getInstance().removeEffect(_loc1_,FILTER_1);
            FiltersManager.getInstance().removeEffect(_loc1_,FILTER_2);
         }
         super.removeIcon();
      }
      
      override public function remove() : void {
         InteractiveElementBehavior.currentElementId = -1;
         super.remove();
      }
      
      override public function copy() : AbstractBehavior {
         var _loc1_:InteractiveElementBehavior = new InteractiveElementBehavior();
         _loc1_.pendingMessage = this.pendingMessage;
         _loc1_.interactiveElement = this.interactiveElement;
         _loc1_.position = this.position;
         _loc1_.sprite = this.sprite;
         _loc1_.currentSkillInstanceId = this.currentSkillInstanceId;
         _loc1_.isAvailableToStart = this.isAvailableToStart;
         _loc1_.type = this.type;
         return _loc1_;
      }
      
      override public function isMessageCatchable(param1:Message) : Boolean {
         if(param1 is GameMapMovementMessage)
         {
            return !((this._isMoving) || (actionStarted));
         }
         return true;
      }
      
      override public function get canBeRemoved() : Boolean {
         return !(this.interactiveElement.elementId == InteractiveElementBehavior.currentElementId);
      }
      
      override public function get needToWait() : Boolean {
         return (this._isMoving) && !(this._lastCellExpected == -1);
      }
      
      override public function getFakePosition() : MapPoint {
         var _loc1_:MapPoint = new MapPoint();
         _loc1_.cellId = this._lastCellExpected;
         return _loc1_;
      }
   }
}
