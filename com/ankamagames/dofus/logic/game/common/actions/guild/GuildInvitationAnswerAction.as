package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildInvitationAnswerAction extends Object implements Action
    {
        public var accept:Boolean;

        public function GuildInvitationAnswerAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : GuildInvitationAnswerAction
        {
            var _loc_2:* = new GuildInvitationAnswerAction;
            _loc_2.accept = param1;
            return _loc_2;
        }// end function

    }
}
