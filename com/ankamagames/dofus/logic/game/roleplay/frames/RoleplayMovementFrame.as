package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.messages.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.messages.game.interactive.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.pathfinding.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.utils.*;

    public class RoleplayMovementFrame extends Object implements Frame
    {
        private var _wantToChangeMap:int = -1;
        private var _followingMove:MapPoint;
        private var _followingIe:Object;
        private var _followingMessage:Object;
        private var _isRequestingMovement:Boolean;
        private var _latestMovementRequest:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayMovementFrame));
        private static const CONSECUTIVE_MOVEMENT_DELAY:uint = 250;

        public function RoleplayMovementFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            this._wantToChangeMap = -1;
            this._followingIe = null;
            this._followingMove = null;
            this._isRequestingMovement = false;
            this._latestMovementRequest = 0;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:GameMapMovementMessage = null;
            var _loc_3:IEntity = null;
            var _loc_4:MovementPath = null;
            var _loc_5:EntityMovementCompleteMessage = null;
            var _loc_6:EntityMovementStoppedMessage = null;
            var _loc_7:TeleportOnSameMapMessage = null;
            var _loc_8:IEntity = null;
            var _loc_9:GameMapMovementConfirmMessage = null;
            var _loc_10:GameMapMovementCancelMessage = null;
            switch(true)
            {
                case param1 is GameMapNoMovementMessage:
                {
                    this._isRequestingMovement = false;
                    if (this._followingIe)
                    {
                        this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie);
                        this._followingIe = null;
                    }
                    return true;
                }
                case param1 is GameMapMovementMessage:
                {
                    _loc_2 = param1 as GameMapMovementMessage;
                    _loc_3 = DofusEntities.getEntity(_loc_2.actorId);
                    if (!_loc_3)
                    {
                        _log.warn("The entity " + _loc_2.actorId + " moved before it was added to the scene. Aborting movement.");
                        return false;
                    }
                    TooltipManager.hide("smiley" + _loc_2.actorId);
                    TooltipManager.hide("msg" + _loc_2.actorId);
                    if (_loc_3.id == PlayedCharacterManager.getInstance().id)
                    {
                        this._isRequestingMovement = false;
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerMove);
                    }
                    _loc_4 = MapMovementAdapter.getClientMovement(_loc_2.keyMovements);
                    (_loc_3 as IMovable).move(_loc_4);
                    return true;
                }
                case param1 is EntityMovementCompleteMessage:
                {
                    _loc_5 = param1 as EntityMovementCompleteMessage;
                    if (_loc_5.entity.id == PlayedCharacterManager.getInstance().id)
                    {
                        _loc_9 = new GameMapMovementConfirmMessage();
                        ConnectionsHandler.getConnection().send(_loc_9);
                        if (this._wantToChangeMap >= 0)
                        {
                            this.askMapChange();
                            this._isRequestingMovement = false;
                        }
                        if (this._followingIe)
                        {
                            this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie);
                            this._followingIe = null;
                        }
                        Kernel.getWorker().process(new CharacterMovementStoppedMessage());
                    }
                    return true;
                }
                case param1 is EntityMovementStoppedMessage:
                {
                    _loc_6 = param1 as EntityMovementStoppedMessage;
                    if (_loc_6.entity.id == PlayedCharacterManager.getInstance().id)
                    {
                        _loc_10 = new GameMapMovementCancelMessage();
                        _loc_10.initGameMapMovementCancelMessage(_loc_6.entity.position.cellId);
                        ConnectionsHandler.getConnection().send(_loc_10);
                        this._isRequestingMovement = false;
                        if (this._followingMove)
                        {
                            this.askMoveTo(this._followingMove);
                            this._followingMove = null;
                        }
                        if (this._followingMessage)
                        {
                            switch(true)
                            {
                                case this._followingMessage is PlayerFightRequestAction:
                                {
                                    Kernel.getWorker().process(this._followingMessage);
                                    break;
                                }
                                default:
                                {
                                    ConnectionsHandler.getConnection().send(this._followingMessage);
                                    break;
                                    break;
                                }
                            }
                            this._followingMessage = null;
                        }
                    }
                    return true;
                }
                case param1 is TeleportOnSameMapMessage:
                {
                    _loc_7 = param1 as TeleportOnSameMapMessage;
                    _loc_8 = DofusEntities.getEntity(_loc_7.targetId);
                    if (_loc_8)
                    {
                        if (_loc_8 is IMovable)
                        {
                            (_loc_8 as IMovable).jump(MapPoint.fromCellId(_loc_7.cellId));
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
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        function setNextMoveMapChange(param1:int) : void
        {
            this._wantToChangeMap = param1;
            return;
        }// end function

        function resetNextMoveMapChange() : void
        {
            this._wantToChangeMap = -1;
            return;
        }// end function

        function setFollowingInteraction(param1:Object) : void
        {
            this._followingIe = param1;
            return;
        }// end function

        public function setFollowingMessage(param1) : void
        {
            if (!(param1 is INetworkMessage || param1 is Action))
            {
                throw new Error("The message is neither INetworkMessage or Action");
            }
            this._followingMessage = param1;
            return;
        }// end function

        function askMoveTo(param1:MapPoint) : Boolean
        {
            if (this._isRequestingMovement)
            {
                return false;
            }
            var _loc_2:* = getTimer();
            if (this._latestMovementRequest + CONSECUTIVE_MOVEMENT_DELAY > _loc_2)
            {
                return false;
            }
            this._isRequestingMovement = true;
            var _loc_3:* = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            var _loc_4:* = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if (!DofusEntities.getEntity(PlayedCharacterManager.getInstance().id))
            {
                _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                this._isRequestingMovement = false;
                return false;
            }
            if (IMovable(_loc_4).isMoving)
            {
                IMovable(_loc_4).stop();
                if (_loc_4 is AnimatedCharacter)
                {
                    (_loc_4 as AnimatedCharacter).getRootEntity();
                }
                this._followingMove = param1;
                return false;
            }
            Pathfinding.findPath(DataMapProvider.getInstance(), _loc_4.position, param1, !PlayedCharacterManager.getInstance().restrictions.cantWalk8Directions, true, this.sendPath);
            return true;
        }// end function

        private function sendPath(param1:MovementPath) : void
        {
            if (param1.start.cellId == param1.end.cellId)
            {
                _log.warn("Discarding a movement path that begins and ends on the same cell (" + param1.start.cellId + ").");
                this._isRequestingMovement = false;
                if (this._followingIe)
                {
                    this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie);
                    this._followingIe = null;
                }
                return;
            }
            var _loc_2:* = new GameMapMovementRequestMessage();
            _loc_2.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(param1), PlayedCharacterManager.getInstance().currentMap.mapId);
            ConnectionsHandler.getConnection().send(_loc_2);
            this._latestMovementRequest = getTimer();
            return;
        }// end function

        function askMapChange() : void
        {
            var _loc_1:* = new ChangeMapMessage();
            _loc_1.initChangeMapMessage(this._wantToChangeMap);
            ConnectionsHandler.getConnection().send(_loc_1);
            this._wantToChangeMap = -1;
            return;
        }// end function

        function activateSkill(param1:uint, param2:InteractiveElement) : void
        {
            var _loc_3:* = new InteractiveUseRequestMessage();
            _loc_3.initInteractiveUseRequestMessage(param2.elementId, param1);
            ConnectionsHandler.getConnection().send(_loc_3);
            return;
        }// end function

    }
}
