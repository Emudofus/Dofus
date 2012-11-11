package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildFightLeaveRequestAction extends Object implements Action
    {
        public var taxCollectorId:uint;
        public var characterId:uint;
        public var warning:Boolean;

        public function GuildFightLeaveRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:Boolean = false) : GuildFightLeaveRequestAction
        {
            var _loc_4:* = new GuildFightLeaveRequestAction;
            new GuildFightLeaveRequestAction.taxCollectorId = param1;
            _loc_4.characterId = param2;
            _loc_4.warning = param3;
            return _loc_4;
        }// end function

    }
}
