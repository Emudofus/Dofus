package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildFarmTeleportRequestAction extends Object implements Action
    {
        public var farmId:uint;

        public function GuildFarmTeleportRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GuildFarmTeleportRequestAction
        {
            var _loc_2:* = new GuildFarmTeleportRequestAction;
            _loc_2.farmId = param1;
            return _loc_2;
        }// end function

    }
}
