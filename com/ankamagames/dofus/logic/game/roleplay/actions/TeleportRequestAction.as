package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TeleportRequestAction extends Object implements Action
    {
        public var mapId:uint;
        public var teleportType:uint;
        public var cost:uint;

        public function TeleportRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint) : TeleportRequestAction
        {
            var _loc_4:* = new TeleportRequestAction;
            new TeleportRequestAction.teleportType = param1;
            _loc_4.mapId = param2;
            _loc_4.cost = param3;
            return _loc_4;
        }// end function

    }
}
