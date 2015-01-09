package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
    import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.TeleportOnSameMapMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementConfirmMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementCancelMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameMapNoMovementMessage;
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
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
    import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
    import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.jerakine.pathfinding.Pathfinding;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.ChangeMapMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseRequestMessage;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;

    public class RoleplayMovementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayMovementFrame));
        private static const CONSECUTIVE_MOVEMENT_DELAY:uint = 250;

        private var _wantToChangeMap:int = -1;
        private var _followingMove:MapPoint;
        private var _followingIe:Object;
        private var _followingMessage;
        private var _isRequestingMovement:Boolean;
        private var _latestMovementRequest:uint;
        private var _destinationPoint:uint;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            this._wantToChangeMap = -1;
            this._followingIe = null;
            this._followingMove = null;
            this._isRequestingMovement = false;
            this._latestMovementRequest = 0;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:GameMapMovementMessage;
            var _local_3:IEntity;
            var _local_4:RoleplayEntitiesFrame;
            var _local_5:TiphonSprite;
            var _local_6:MovementPath;
            var _local_7:EntityMovementCompleteMessage;
            var _local_8:EntityMovementStoppedMessage;
            var _local_9:TeleportOnSameMapMessage;
            var _local_10:IEntity;
            var gmmcmsg:GameMapMovementConfirmMessage;
            var canceledMoveMessage:GameMapMovementCancelMessage;
            switch (true)
            {
                case (msg is GameMapNoMovementMessage):
                    this._isRequestingMovement = false;
                    if (this._followingIe)
                    {
                        this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie);
                        this._followingIe = null;
                    };
                    return (true);
                case (msg is GameMapMovementMessage):
                    _local_2 = (msg as GameMapMovementMessage);
                    _local_3 = DofusEntities.getEntity(_local_2.actorId);
                    if (!(_local_3))
                    {
                        _log.warn((("The entity " + _local_2.actorId) + " moved before it was added to the scene. Aborting movement."));
                        return (true);
                    };
                    _local_4 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    _local_5 = (_local_3 as TiphonSprite);
                    if (((((((_local_5) && (!(_local_4.isCreatureMode)))) && (_local_5.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0)))) && (!(_local_5.getSubEntityBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER)))))
                    {
                        _local_5.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, new RiderBehavior());
                    };
                    delete _local_4.lastStaticAnimations[_local_2.actorId];
                    TooltipManager.hide(("smiley" + _local_2.actorId));
                    TooltipManager.hide(("msg" + _local_2.actorId));
                    if (_local_3.id == PlayedCharacterManager.getInstance().id)
                    {
                        this._isRequestingMovement = false;
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerMove);
                    };
                    _local_6 = MapMovementAdapter.getClientMovement(_local_2.keyMovements);
                    if (OptionManager.getOptionManager("dofus")["allowAnimsFun"] == true)
                    {
                        AnimFunManager.getInstance().cancelAnim(_local_2.actorId);
                    };
                    (_local_3 as IMovable).move(_local_6);
                    return (true);
                case (msg is EntityMovementCompleteMessage):
                    _local_7 = (msg as EntityMovementCompleteMessage);
                    if (_local_7.entity.id == PlayedCharacterManager.getInstance().id)
                    {
                        gmmcmsg = new GameMapMovementConfirmMessage();
                        ConnectionsHandler.getConnection().send(gmmcmsg);
                        if ((((this._wantToChangeMap >= 0)) && ((_local_7.entity.position.cellId == this._destinationPoint))))
                        {
                            this.askMapChange();
                            this._isRequestingMovement = false;
                        };
                        if (this._followingIe)
                        {
                            this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie);
                            this._followingIe = null;
                        };
                        Kernel.getWorker().process(new CharacterMovementStoppedMessage());
                    };
                    return (true);
                case (msg is EntityMovementStoppedMessage):
                    _local_8 = (msg as EntityMovementStoppedMessage);
                    if (_local_8.entity.id == PlayedCharacterManager.getInstance().id)
                    {
                        canceledMoveMessage = new GameMapMovementCancelMessage();
                        canceledMoveMessage.initGameMapMovementCancelMessage(_local_8.entity.position.cellId);
                        ConnectionsHandler.getConnection().send(canceledMoveMessage);
                        Kernel.getWorker().process(EmptyStackAction.create());
                        this._isRequestingMovement = false;
                        if (this._followingMove)
                        {
                            this.askMoveTo(this._followingMove);
                            this._followingMove = null;
                        };
                        if (this._followingMessage)
                        {
                            switch (true)
                            {
                                case (this._followingMessage is PlayerFightRequestAction):
                                    Kernel.getWorker().process(this._followingMessage);
                                    break;
                                default:
                                    ConnectionsHandler.getConnection().send(this._followingMessage);
                            };
                            this._followingMessage = null;
                        };
                    };
                    return (true);
                case (msg is TeleportOnSameMapMessage):
                    _local_9 = (msg as TeleportOnSameMapMessage);
                    _local_10 = DofusEntities.getEntity(_local_9.targetId);
                    if (_local_10)
                    {
                        if ((_local_10 is IMovable))
                        {
                            if (IMovable(_local_10).isMoving)
                            {
                                IMovable(_local_10).stop(true);
                            };
                            (_local_10 as IMovable).jump(MapPoint.fromCellId(_local_9.cellId));
                        }
                        else
                        {
                            _log.warn("Cannot teleport a non IMovable entity. WTF ?");
                        };
                    }
                    else
                    {
                        _log.warn("Received a teleportation request for a non-existing entity. Aborting.");
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        function setNextMoveMapChange(mapId:int):void
        {
            this._wantToChangeMap = mapId;
        }

        function resetNextMoveMapChange():void
        {
            this._wantToChangeMap = -1;
        }

        function setFollowingInteraction(interaction:Object):void
        {
            this._followingIe = interaction;
        }

        public function setFollowingMessage(message:*):void
        {
            if (!((((message is INetworkMessage)) || ((message is Action)))))
            {
                throw (new Error("The message is neither INetworkMessage or Action"));
            };
            this._followingMessage = message;
        }

        function askMoveTo(cell:MapPoint):Boolean
        {
            if (this._isRequestingMovement)
            {
                return (false);
            };
            var now:uint = getTimer();
            if ((this._latestMovementRequest + CONSECUTIVE_MOVEMENT_DELAY) > now)
            {
                return (false);
            };
            this._isRequestingMovement = true;
            var playerEntity:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if (!(playerEntity))
            {
                _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                this._isRequestingMovement = false;
                return (false);
            };
            this._destinationPoint = cell.cellId;
            if (IMovable(playerEntity).isMoving)
            {
                IMovable(playerEntity).stop();
                if ((playerEntity is AnimatedCharacter))
                {
                    (playerEntity as AnimatedCharacter).getRootEntity();
                };
                this._followingMove = cell;
                return (false);
            };
            Pathfinding.findPath(DataMapProvider.getInstance(), playerEntity.position, cell, !(PlayedCharacterManager.getInstance().restrictions.cantWalk8Directions), true, this.sendPath);
            return (true);
        }

        private function sendPath(path:MovementPath):void
        {
            if (path.start.cellId == path.end.cellId)
            {
                _log.warn((("Discarding a movement path that begins and ends on the same cell (" + path.start.cellId) + ")."));
                this._isRequestingMovement = false;
                if (this._followingIe)
                {
                    this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie);
                    this._followingIe = null;
                };
                return;
            };
            var gmmrmsg:GameMapMovementRequestMessage = new GameMapMovementRequestMessage();
            gmmrmsg.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(path), PlayedCharacterManager.getInstance().currentMap.mapId);
            ConnectionsHandler.getConnection().send(gmmrmsg);
            this._latestMovementRequest = getTimer();
        }

        function askMapChange():void
        {
            var cmmsg:ChangeMapMessage = new ChangeMapMessage();
            cmmsg.initChangeMapMessage(this._wantToChangeMap);
            ConnectionsHandler.getConnection().send(cmmsg);
            this._wantToChangeMap = -1;
        }

        function activateSkill(skillInstanceId:uint, ie:InteractiveElement):void
        {
            var iurmsg:InteractiveUseRequestMessage;
            var rpInteractivesFrame:RoleplayInteractivesFrame = (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame);
            if (((((((rpInteractivesFrame) && (!((rpInteractivesFrame.currentRequestedElementId == ie.elementId))))) && (!(rpInteractivesFrame.usingInteractive)))) && (!(rpInteractivesFrame.isElementChangingState(ie.elementId)))))
            {
                rpInteractivesFrame.currentRequestedElementId = ie.elementId;
                iurmsg = new InteractiveUseRequestMessage();
                iurmsg.initInteractiveUseRequestMessage(ie.elementId, skillInstanceId);
                ConnectionsHandler.getConnection().send(iurmsg);
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames

