package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildHouseTeleportRequestAction extends Object implements Action
    {
        public var houseId:uint;

        public function GuildHouseTeleportRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GuildHouseTeleportRequestAction
        {
            var _loc_2:* = new GuildHouseTeleportRequestAction;
            _loc_2.houseId = param1;
            return _loc_2;
        }// end function

    }
}
