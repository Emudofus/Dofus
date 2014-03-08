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
      
      public function process(msg:Message) : Boolean {
         var gmmmsg:GameMapMovementMessage = null;
         var movedEntity:IEntity = null;
         var rpEntitiesFrame:RoleplayEntitiesFrame = null;
         var tiphonSpr:TiphonSprite = null;
         var entityPath:MovementPath = null;
         var emcmsg:EntityMovementCompleteMessage = null;
         var emsmsg:EntityMovementStoppedMessage = null;
         var tosmmsg:TeleportOnSameMapMessage = null;
         var teleportedEntity:IEntity = null;
         var gmmcmsg:GameMapMovementConfirmMessage = null;
         var canceledMoveMessage:GameMapMovementCancelMessage = null;
         switch(true)
         {
            case msg is GameMapNoMovementMessage:
               this._isRequestingMovement = false;
               if(this._followingIe)
               {
                  this.activateSkill(this._followingIe.skillInstanceId,this._followingIe.ie);
                  this._followingIe = null;
               }
               return true;
            case msg is GameMapMovementMessage:
               gmmmsg = msg as GameMapMovementMessage;
               movedEntity = DofusEntities.getEntity(gmmmsg.actorId);
               if(!movedEntity)
               {
                  _log.warn("The entity " + gmmmsg.actorId + " moved before it was added to the scene. Aborting movement.");
                  return true;
               }
               rpEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               tiphonSpr = movedEntity as TiphonSprite;
               if(((tiphonSpr) && (!rpEntitiesFrame.isCreatureMode)) && (tiphonSpr.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)) && (!tiphonSpr.getSubEntityBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER)))
               {
                  tiphonSpr.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
               }
               delete rpEntitiesFrame.lastStaticAnimations[[gmmmsg.actorId]];
               TooltipManager.hide("smiley" + gmmmsg.actorId);
               TooltipManager.hide("msg" + gmmmsg.actorId);
               if(movedEntity.id == PlayedCharacterManager.getInstance().id)
               {
                  this._isRequestingMovement = false;
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerMove);
               }
               entityPath = MapMovementAdapter.getClientMovement(gmmmsg.keyMovements);
               (movedEntity as IMovable).move(entityPath);
               return true;
            case msg is EntityMovementCompleteMessage:
               emcmsg = msg as EntityMovementCompleteMessage;
               if(emcmsg.entity.id == PlayedCharacterManager.getInstance().id)
               {
                  gmmcmsg = new GameMapMovementConfirmMessage();
                  ConnectionsHandler.getConnection().send(gmmcmsg);
                  if((this._wantToChangeMap >= 0) && (emcmsg.entity.position.cellId == this._destinationPoint))
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
            case msg is EntityMovementStoppedMessage:
               emsmsg = msg as EntityMovementStoppedMessage;
               if(emsmsg.entity.id == PlayedCharacterManager.getInstance().id)
               {
                  canceledMoveMessage = new GameMapMovementCancelMessage();
                  canceledMoveMessage.initGameMapMovementCancelMessage(emsmsg.entity.position.cellId);
                  ConnectionsHandler.getConnection().send(canceledMoveMessage);
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
                     }
                     this._followingMessage = null;
                  }
               }
               return true;
            case msg is TeleportOnSameMapMessage:
               tosmmsg = msg as TeleportOnSameMapMessage;
               teleportedEntity = DofusEntities.getEntity(tosmmsg.targetId);
               if(teleportedEntity)
               {
                  if(teleportedEntity is IMovable)
                  {
                     if(IMovable(teleportedEntity).isMoving)
                     {
                        IMovable(teleportedEntity).stop(true);
                     }
                     (teleportedEntity as IMovable).jump(MapPoint.fromCellId(tosmmsg.cellId));
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
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      function setNextMoveMapChange(mapId:int) : void {
         this._wantToChangeMap = mapId;
      }
      
      function resetNextMoveMapChange() : void {
         this._wantToChangeMap = -1;
      }
      
      function setFollowingInteraction(interaction:Object) : void {
         this._followingIe = interaction;
      }
      
      public function setFollowingMessage(message:*) : void {
         if(!((message is INetworkMessage) || (message is Action)))
         {
            throw new Error("The message is neither INetworkMessage or Action");
         }
         else
         {
            this._followingMessage = message;
            return;
         }
      }
      
      function askMoveTo(cell:MapPoint) : Boolean {
         if(this._isRequestingMovement)
         {
            return false;
         }
         var now:uint = getTimer();
         if(this._latestMovementRequest + CONSECUTIVE_MOVEMENT_DELAY > now)
         {
            return false;
         }
         this._isRequestingMovement = true;
         var playerEntity:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
         if(!playerEntity)
         {
            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
            this._isRequestingMovement = false;
            return false;
         }
         this._destinationPoint = cell.cellId;
         if(IMovable(playerEntity).isMoving)
         {
            IMovable(playerEntity).stop();
            if(playerEntity is AnimatedCharacter)
            {
               (playerEntity as AnimatedCharacter).getRootEntity();
            }
            this._followingMove = cell;
            return false;
         }
         Pathfinding.findPath(DataMapProvider.getInstance(),playerEntity.position,cell,!PlayedCharacterManager.getInstance().restrictions.cantWalk8Directions,true,this.sendPath);
         return true;
      }
      
      private function sendPath(path:MovementPath) : void {
         if(path.start.cellId == path.end.cellId)
         {
            _log.warn("Discarding a movement path that begins and ends on the same cell (" + path.start.cellId + ").");
            this._isRequestingMovement = false;
            if(this._followingIe)
            {
               this.activateSkill(this._followingIe.skillInstanceId,this._followingIe.ie);
               this._followingIe = null;
            }
            return;
         }
         var gmmrmsg:GameMapMovementRequestMessage = new GameMapMovementRequestMessage();
         gmmrmsg.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(path),PlayedCharacterManager.getInstance().currentMap.mapId);
         ConnectionsHandler.getConnection().send(gmmrmsg);
         this._latestMovementRequest = getTimer();
      }
      
      function askMapChange() : void {
         var cmmsg:ChangeMapMessage = new ChangeMapMessage();
         cmmsg.initChangeMapMessage(this._wantToChangeMap);
         ConnectionsHandler.getConnection().send(cmmsg);
         this._wantToChangeMap = -1;
      }
      
      function activateSkill(skillInstanceId:uint, ie:InteractiveElement) : void {
         var iurmsg:InteractiveUseRequestMessage = null;
         var rpInteractivesFrame:RoleplayInteractivesFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
         if(((rpInteractivesFrame) && (!(rpInteractivesFrame.currentRequestedElementId == ie.elementId))) && (!rpInteractivesFrame.usingInteractive) && (!rpInteractivesFrame.isElementChangingState(ie.elementId)))
         {
            rpInteractivesFrame.currentRequestedElementId = ie.elementId;
            iurmsg = new InteractiveUseRequestMessage();
            iurmsg.initInteractiveUseRequestMessage(ie.elementId,skillInstanceId);
            ConnectionsHandler.getConnection().send(iurmsg);
         }
      }
   }
}
