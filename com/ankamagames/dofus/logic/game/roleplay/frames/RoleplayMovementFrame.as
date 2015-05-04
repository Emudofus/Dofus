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
   import com.ankamagames.dofus.logic.game.common.frames.StackManagementFrame;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.MoveBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.types.entities.RiderBehavior;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.logic.game.roleplay.managers.AnimFunManager;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.network.messages.game.context.GameCautiousMapMovementMessage;
   import com.ankamagames.atouin.entities.behaviours.movements.WalkingMovementBehavior;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
   import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.GameMapNoMovementMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.network.messages.game.context.GameCautiousMapMovementRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementRequestMessage;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.ChangeMapMessage;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayAttackMonsterRequestMessage;
   
   public class RoleplayMovementFrame extends Object implements Frame
   {
      
      public function RoleplayMovementFrame()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayMovementFrame));
      
      private static const CONSECUTIVE_MOVEMENT_DELAY:uint = 250;
      
      private var _wantToChangeMap:int = -1;
      
      private var _followingMove:MapPoint;
      
      private var _followingIe:Object;
      
      private var _followingMonsterGroup:Object;
      
      private var _followingMessage;
      
      private var _isRequestingMovement:Boolean;
      
      private var _latestMovementRequest:uint;
      
      private var _destinationPoint:uint;
      
      private var _nextMovementBehavior:uint;
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get isRequestingMovement() : Boolean
      {
         return this._isRequestingMovement;
      }
      
      public function pushed() : Boolean
      {
         this._wantToChangeMap = -1;
         this._followingIe = null;
         this._followingMonsterGroup = null;
         this._followingMove = null;
         this._isRequestingMovement = false;
         this._latestMovementRequest = 0;
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
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
         var _loc13_:StackManagementFrame = null;
         var _loc14_:MoveBehavior = null;
         switch(true)
         {
            case param1 is GameMapNoMovementMessage:
               this._isRequestingMovement = false;
               if(this._followingIe)
               {
                  this.activateSkill(this._followingIe.skillInstanceId,this._followingIe.ie);
                  this._followingIe = null;
               }
               if(this._followingMonsterGroup)
               {
                  this.requestMonsterFight(this._followingMonsterGroup.id);
                  this._followingMonsterGroup = null;
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
               if((_loc5_ && !_loc4_.isCreatureMode) && (_loc5_.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)) && !_loc5_.getSubEntityBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER))
               {
                  _loc5_.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
               }
               delete _loc4_.lastStaticAnimations[_loc2_.actorId];
               true;
               TooltipManager.hide("smiley" + _loc2_.actorId);
               TooltipManager.hide("msg" + _loc2_.actorId);
               if(_loc3_.id == PlayedCharacterManager.getInstance().id)
               {
                  this._isRequestingMovement = false;
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerMove);
               }
               _loc6_ = MapMovementAdapter.getClientMovement(_loc2_.keyMovements);
               if(OptionManager.getOptionManager("dofus")["allowAnimsFun"] == true)
               {
                  AnimFunManager.getInstance().cancelAnim(_loc2_.actorId);
               }
               (_loc3_ as IMovable).move(_loc6_,null,param1 is GameCautiousMapMovementMessage?WalkingMovementBehavior.getInstance():null);
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
                  if(this._followingMonsterGroup)
                  {
                     this.requestMonsterFight(this._followingMonsterGroup.id);
                     this._followingMonsterGroup = null;
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
                     _loc13_ = Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame;
                     if(_loc13_.stackOutputMessage.length > 0)
                     {
                        _loc14_ = _loc13_.stackOutputMessage[0] as MoveBehavior;
                        if((_loc14_) && !(_loc14_.position.cellId == this._followingMove.cellId))
                        {
                           Kernel.getWorker().process(EmptyStackAction.create());
                        }
                     }
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
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      function setNextMoveMapChange(param1:int) : void
      {
         this._wantToChangeMap = param1;
      }
      
      function resetNextMoveMapChange() : void
      {
         this._wantToChangeMap = -1;
      }
      
      function setFollowingInteraction(param1:Object) : void
      {
         this._followingIe = param1;
      }
      
      function setFollowingMonsterFight(param1:Object) : void
      {
         this._followingMonsterGroup = param1;
      }
      
      public function setFollowingMessage(param1:*) : void
      {
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
      
      public function forceNextMovementBehavior(param1:uint) : void
      {
         this._nextMovementBehavior = param1;
      }
      
      function askMoveTo(param1:MapPoint) : Boolean
      {
         if(this._isRequestingMovement)
         {
            return false;
         }
         var _loc2_:StackManagementFrame = Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame;
         var _loc3_:MoveBehavior = _loc2_.stackOutputMessage.length > 0?_loc2_.stackOutputMessage[0] as MoveBehavior:null;
         var _loc4_:uint = getTimer();
         if(this._latestMovementRequest + CONSECUTIVE_MOVEMENT_DELAY > _loc4_ && (!_loc3_ || !_loc3_.getMapPoint().equals(param1)))
         {
            return false;
         }
         this._isRequestingMovement = true;
         var _loc5_:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
         if(!_loc5_)
         {
            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
            this._isRequestingMovement = false;
            return false;
         }
         this._destinationPoint = param1.cellId;
         if(IMovable(_loc5_).isMoving)
         {
            IMovable(_loc5_).stop();
            if(_loc5_ is AnimatedCharacter)
            {
               (_loc5_ as AnimatedCharacter).getRootEntity();
            }
            this._followingMove = param1;
            return false;
         }
         Pathfinding.findPath(DataMapProvider.getInstance(),_loc5_.position,param1,!PlayedCharacterManager.getInstance().restrictions.cantWalk8Directions,true,this.sendPath);
         return true;
      }
      
      private function sendPath(param1:MovementPath) : void
      {
         var _loc2_:GameCautiousMapMovementRequestMessage = null;
         var _loc3_:GameMapMovementRequestMessage = null;
         if(param1.start.cellId == param1.end.cellId)
         {
            _log.warn("Discarding a movement path that begins and ends on the same cell (" + param1.start.cellId + ").");
            this._isRequestingMovement = false;
            if(this._followingIe)
            {
               this.activateSkill(this._followingIe.skillInstanceId,this._followingIe.ie);
               this._followingIe = null;
            }
            if(this._followingMonsterGroup)
            {
               this.requestMonsterFight(this._followingMonsterGroup.id);
               this._followingMonsterGroup = null;
            }
            return;
         }
         if(!AirScanner.isStreamingVersion() && OptionManager.getOptionManager("dofus")["enableForceWalk"] == true && (this._nextMovementBehavior == AtouinConstants.MOVEMENT_WALK || this._nextMovementBehavior == 0 && ((ShortcutsFrame.ctrlKeyDown) || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && (ShortcutsFrame.altKeyDown))))
         {
            _loc2_ = new GameCautiousMapMovementRequestMessage();
            _loc2_.initGameCautiousMapMovementRequestMessage(MapMovementAdapter.getServerMovement(param1),PlayedCharacterManager.getInstance().currentMap.mapId);
            ConnectionsHandler.getConnection().send(_loc2_);
         }
         else
         {
            _loc3_ = new GameMapMovementRequestMessage();
            _loc3_.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(param1),PlayedCharacterManager.getInstance().currentMap.mapId);
            ConnectionsHandler.getConnection().send(_loc3_);
         }
         this._nextMovementBehavior = 0;
         this._latestMovementRequest = getTimer();
      }
      
      function askMapChange() : void
      {
         var _loc1_:ChangeMapMessage = new ChangeMapMessage();
         _loc1_.initChangeMapMessage(this._wantToChangeMap);
         ConnectionsHandler.getConnection().send(_loc1_);
         this._wantToChangeMap = -1;
      }
      
      function activateSkill(param1:uint, param2:InteractiveElement) : void
      {
         var _loc4_:InteractiveUseRequestMessage = null;
         var _loc3_:RoleplayInteractivesFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
         if((_loc3_ && !(_loc3_.currentRequestedElementId == param2.elementId)) && (!_loc3_.usingInteractive) && !_loc3_.isElementChangingState(param2.elementId))
         {
            _loc3_.currentRequestedElementId = param2.elementId;
            _loc4_ = new InteractiveUseRequestMessage();
            _loc4_.initInteractiveUseRequestMessage(param2.elementId,param1);
            ConnectionsHandler.getConnection().send(_loc4_);
         }
      }
      
      function requestMonsterFight(param1:uint) : void
      {
         var _loc2_:GameRolePlayAttackMonsterRequestMessage = new GameRolePlayAttackMonsterRequestMessage();
         _loc2_.initGameRolePlayAttackMonsterRequestMessage(param1);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
   }
}
