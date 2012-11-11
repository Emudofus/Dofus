package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildInvitationAction extends Object implements Action
    {
        public var targetId:uint;

        public function GuildInvitationAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GuildInvitationAction
        {
            var _loc_2:* = new GuildInvitationAction;
            _loc_2.targetId = param1;
            return _loc_2;
        }// end function

    }
}
