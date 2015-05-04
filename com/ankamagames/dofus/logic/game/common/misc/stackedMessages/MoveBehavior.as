package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
   import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import flash.display.Sprite;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class MoveBehavior extends AbstractBehavior
   {
      
      public function MoveBehavior()
      {
         super();
         type = NORMAL;
         isAvailableToStart = true;
      }
      
      private var _abstractEntitiesFrame:AbstractEntitiesFrame;
      
      private var _fakepos:int = -1;
      
      public var forceWalk:Boolean;
      
      override public function processInputMessage(param1:Message, param2:String) : Boolean
      {
         var _loc3_:IEntity = null;
         var _loc4_:uint = 0;
         var _loc5_:CellClickMessage = null;
         canBeStacked = false;
         if(this._abstractEntitiesFrame == null)
         {
            this._abstractEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         }
         if((param1 is CellClickMessage || param1 is EntityClickMessage) && !PlayedCharacterManager.getInstance().isFighting && param2 == type)
         {
            _loc3_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if(param1 is CellClickMessage)
            {
               _loc4_ = (param1 as CellClickMessage).cellId;
            }
            else if(param1 is EntityClickMessage && this._abstractEntitiesFrame.getEntityInfos((param1 as EntityClickMessage).entity.id) is GameRolePlayGroupMonsterInformations)
            {
               _loc4_ = (param1 as EntityClickMessage).entity.position.cellId;
            }
            else
            {
               return false;
            }
            
            if(!(_loc3_ == null) && !(_loc3_.position.cellId == _loc4_))
            {
               pendingMessage = param1;
               canBeStacked = true;
               isAvailableToStart = true;
               if(param1 is CellClickMessage)
               {
                  _loc5_ = param1 as CellClickMessage;
                  position = _loc5_.cell;
                  if(!position)
                  {
                     position = MapPoint.fromCellId(_loc5_.cellId);
                  }
               }
               else if(param1 is EntityClickMessage)
               {
                  position = (param1 as EntityClickMessage).entity.position;
               }
               
               this.forceWalk = AirScanner.isStreamingVersion()?false:OptionManager.getOptionManager("dofus")["enableForceWalk"] == true && ((ShortcutsFrame.ctrlKeyDown) || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && (ShortcutsFrame.altKeyDown));
               return true;
            }
         }
         else if(param1 is CellClickMessage && !PlayedCharacterManager.getInstance().isFighting && param2 == ALWAYS)
         {
            this._fakepos = (param1 as CellClickMessage).cellId;
            return true;
         }
         
         return false;
      }
      
      override public function processOutputMessage(param1:Message, param2:String) : Boolean
      {
         var _loc3_:IEntity = null;
         if(param1 is CellClickMessage && param2 == ALWAYS)
         {
            isAvailableToStart = false;
         }
         else if(param1 is CharacterMovementStoppedMessage || param1 is EntityMovementStoppedMessage)
         {
            this._fakepos = -1;
            _loc3_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if(!(_loc3_ == null) && _loc3_.position.cellId == position.cellId)
            {
               this._fakepos = -1;
               actionStarted = true;
               return true;
            }
            this._fakepos = _loc3_.position.cellId;
         }
         
         return false;
      }
      
      override public function checkAvailability(param1:Message) : void
      {
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            isAvailableToStart = false;
         }
         else
         {
            isAvailableToStart = true;
         }
      }
      
      override public function copy() : AbstractBehavior
      {
         var _loc1_:MoveBehavior = new MoveBehavior();
         _loc1_.pendingMessage = this.pendingMessage;
         _loc1_.position = this.position;
         _loc1_.type = this.type;
         _loc1_.forceWalk = this.forceWalk;
         _loc1_.sprite = _loc1_.forceWalk?EmbedAssets.getSprite("CHECKPOINT_CLIP_WALK"):EmbedAssets.getSprite("CHECKPOINT_CLIP");
         return _loc1_;
      }
      
      override public function get needToWait() : Boolean
      {
         return !(this._fakepos == -1);
      }
      
      override public function getFakePosition() : MapPoint
      {
         var _loc1_:MapPoint = new MapPoint();
         _loc1_.cellId = this._fakepos;
         return _loc1_;
      }
      
      override public function processMessageToWorker() : void
      {
         var _loc1_:RoleplayMovementFrame = Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
         _loc1_.forceNextMovementBehavior(this.forceWalk?AtouinConstants.MOVEMENT_WALK:AtouinConstants.MOVEMENT_NORMAL);
         super.processMessageToWorker();
      }
      
      override public function isAvailableToProcess(param1:Message) : Boolean
      {
         var _loc2_:RoleplayMovementFrame = Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
         return !_loc2_.isRequestingMovement;
      }
   }
}
