package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildFightJoinRequestAction extends Object implements Action
    {
        public var taxCollectorId:uint;

        public function GuildFightJoinRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GuildFightJoinRequestAction
        {
            var _loc_2:* = new GuildFightJoinRequestAction;
            _loc_2.taxCollectorId = param1;
            return _loc_2;
        }// end function

    }
}
