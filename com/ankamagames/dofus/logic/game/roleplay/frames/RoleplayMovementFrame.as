package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.TeleportOnSameMapMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementConfirmMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementCancelMessage;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.types.entities.RiderBehavior;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.GameMapNoMovementMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.ChangeMapMessage;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseRequestMessage;
   
   public class RoleplayMovementFrame extends Object implements Frame
   {
      
      public function RoleplayMovementFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayMovementFrame));
      
      private static const CONSECUTIVE_MOVEMENT_DELAY:uint = 250;
      
      private var _wantToChangeMap:int = -1;
      
      private var _followingMove:MapPoint;
      
      private var _followingIe:Object;
      
      private var _followingMessage;
      
      private var _isRequestingMovement:Boolean;
      
      private var _latestMovementRequest:uint;
      
      private var _destinationPoint:uint;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         this._wantToChangeMap = -1;
         this._followingIe = null;
         this._followingMove = null;
         this._isRequestingMovement = false;
         this._latestMovementRequest = 0;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GameMapMovementMessage = null;
         var _loc3_:IEntity = null;
         var _loc4_:RoleplayEntitiesFrame = null;
         var _loc5_:TiphonSprite = null;
         var _loc6_:MovementPath = null;
         var _loc7_:EntityMovementCompleteMessage = null;
         var _loc8_:EntityMovementStoppedMessage = null;
         var _loc9_:TeleportOnSameMapMessage = null;
         var _loc10_:IEntity = null;
         var _loc11_:GameMapMovementConfirmMessage = null;
         var _loc12_:GameMapMovementCancelMessage = null;
         switch(true)
         {
            case param1 is GameMapNoMovementMessage:
               this._isRequestingMovement = false;
               if(this._followingIe)
               {
                  this.activateSkill(this._followingIe.skillInstanceId,this._followingIe.ie);
                  this._followingIe = null;
               }
               return true;
            case param1 is GameMapMovementMessage:
               _loc2_ = param1 as GameMapMovementMessage;
               _loc3_ = DofusEntities.getEntity(_loc2_.actorId);
               if(!_loc3_)
               {
                  _log.warn("The entity " + _loc2_.actorId + " moved before it was added to the scene. Aborting movement.");
                  return true;
               }
               _loc4_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               _loc5_ = _loc3_ as TiphonSprite;
               if(((_loc5_) && (!_loc4_.isCreatureMode)) && (_loc5_.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)) && !_loc5_.getSubEntityBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER))
               {
                  _loc5_.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
               }
               delete _loc4_.lastStaticAnimations[[_loc2_.actorId]];
               TooltipManager.hide("smiley" + _loc2_.actorId);
               TooltipManager.hide("msg" + _loc2_.actorId);
               if(_loc3_.id == PlayedCharacterManager.getInstance().id)
               {
                  this._isRequestingMovement = false;
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerMove);
               }
               _loc6_ = MapMovementAdapter.getClientMovement(_loc2_.keyMovements);
               (_loc3_ as IMovable).move(_loc6_);
               return true;
            case param1 is EntityMovementCompleteMessage:
               _loc7_ = param1 as EntityMovementCompleteMessage;
               if(_loc7_.entity.id == PlayedCharacterManager.getInstance().id)
               {
                  _loc11_ = new GameMapMovementConfirmMessage();
                  ConnectionsHandler.getConnection().send(_loc11_);
                  if(this._wantToChangeMap >= 0 && _loc7_.entity.position.cellId == this._destinationPoint)
                  {
                     this.askMapChange();
                     this._isRequestingMovement = false;
                  }
                  if(this._followingIe)
                  {
                     this.activateSkill(this._followingIe.skillInstanceId,this._followingIe.ie);
                     this._followingIe = null;
                  }
                  Kernel.getWorker().process(new CharacterMovementStoppedMessage());
               }
               return true;
            case param1 is EntityMovementStoppedMessage:
               _loc8_ = param1 as EntityMovementStoppedMessage;
               if(_loc8_.entity.id == PlayedCharacterManager.getInstance().id)
               {
                  _loc12_ = new GameMapMovementCancelMessage();
                  _loc12_.initGameMapMovementCancelMessage(_loc8_.entity.position.cellId);
                  ConnectionsHandler.getConnection().send(_loc12_);
                  this._isRequestingMovement = false;
                  if(this._followingMove)
                  {
                     this.askMoveTo(this._followingMove);
                     this._followingMove = null;
                  }
                  if(this._followingMessage)
                  {
                     switch(true)
                     {
                        case this._followingMessage is PlayerFightRequestAction:
                           Kernel.getWorker().process(this._followingMessage);
                           break;
                        default:
                           ConnectionsHandler.getConnection().send(this._followingMessage);
                     }
                     this._followingMessage = null;
                  }
               }
               return true;
            case param1 is TeleportOnSameMapMessage:
               _loc9_ = param1 as TeleportOnSameMapMessage;
               _loc10_ = DofusEntities.getEntity(_loc9_.targetId);
               if(_loc10_)
               {
                  if(_loc10_ is IMovable)
                  {
                     if(IMovable(_loc10_).isMoving)
                     {
                        IMovable(_loc10_).stop(true);
                     }
                     (_loc10_ as IMovable).jump(MapPoint.fromCellId(_loc9_.cellId));
                  }
                  else
                  {
                     _log.warn("Cannot teleport a non IMovable entity. WTF ?");
                  }
               }
               else
               {
                  _log.warn("Received a teleportation request for a non-existing entity. Aborting.");
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      function setNextMoveMapChange(param1:int) : void {
         this._wantToChangeMap = param1;
      }
      
      function resetNextMoveMapChange() : void {
         this._wantToChangeMap = -1;
      }
      
      function setFollowingInteraction(param1:Object) : void {
         this._followingIe = param1;
      }
      
      public function setFollowingMessage(param1:*) : void {
         if(!(param1 is INetworkMessage || param1 is Action))
         {
            throw new Error("The message is neither INetworkMessage or Action");
         }
         else
         {
            this._followingMessage = param1;
            return;
         }
      }
      
      function askMoveTo(param1:MapPoint) : Boolean {
         if(this._isRequestingMovement)
         {
            return false;
         }
         var _loc2_:uint = getTimer();
         if(this._latestMovementRequest + CONSECUTIVE_MOVEMENT_DELAY > _loc2_)
         {
            return false;
         }
         this._isRequestingMovement = true;
         var _loc3_:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
         if(!_loc3_)
         {
            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
            this._isRequestingMovement = false;
            return false;
         }
         this._destinationPoint = param1.cellId;
         if(IMovable(_loc3_).isMoving)
         {
            IMovable(_loc3_).stop();
            if(_loc3_ is AnimatedCharacter)
            {
               (_loc3_ as AnimatedCharacter).getRootEntity();
            }
            this._followingMove = param1;
            return false;
         }
         Pathfinding.findPath(DataMapProvider.getInstance(),_loc3_.position,param1,!PlayedCharacterManager.getInstance().restrictions.cantWalk8Directions,true,this.sendPath);
         return true;
      }
      
      private function sendPath(param1:MovementPath) : void {
         if(param1.start.cellId == param1.end.cellId)
         {
            _log.warn("Discarding a movement path that begins and ends on the same cell (" + param1.start.cellId + ").");
            this._isRequestingMovement = false;
            if(this._followingIe)
            {
               this.activateSkill(this._followingIe.skillInstanceId,this._followingIe.ie);
               this._followingIe = null;
            }
            return;
         }
         var _loc2_:GameMapMovementRequestMessage = new GameMapMovementRequestMessage();
         _loc2_.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(param1),PlayedCharacterManager.getInstance().currentMap.mapId);
         ConnectionsHandler.getConnection().send(_loc2_);
         this._latestMovementRequest = getTimer();
      }
      
      function askMapChange() : void {
         var _loc1_:ChangeMapMessage = new ChangeMapMessage();
         _loc1_.initChangeMapMessage(this._wantToChangeMap);
         ConnectionsHandler.getConnection().send(_loc1_);
         this._wantToChangeMap = -1;
      }
      
      function activateSkill(param1:uint, param2:InteractiveElement) : void {
         var _loc4_:InteractiveUseRequestMessage = null;
         var _loc3_:RoleplayInteractivesFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
         if(((_loc3_) && (!(_loc3_.currentRequestedElementId == param2.elementId))) && (!_loc3_.usingInteractive) && !_loc3_.isElementChangingState(param2.elementId))
         {
            _loc3_.currentRequestedElementId = param2.elementId;
            _loc4_ = new InteractiveUseRequestMessage();
            _loc4_.initInteractiveUseRequestMessage(param2.elementId,param1);
            ConnectionsHandler.getConnection().send(_loc4_);
         }
      }
   }
}
