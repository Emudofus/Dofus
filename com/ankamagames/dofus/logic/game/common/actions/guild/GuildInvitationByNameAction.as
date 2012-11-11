package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildInvitationByNameAction extends Object implements Action
    {
        public var target:String;

        public function GuildInvitationByNameAction()
        {
            return;
        }// end function

        public static function create(param1:String) : GuildInvitationByNameAction
        {
            var _loc_2:* = new GuildInvitationByNameAction;
            _loc_2.target = param1;
            return _loc_2;
        }// end function

    }
}
