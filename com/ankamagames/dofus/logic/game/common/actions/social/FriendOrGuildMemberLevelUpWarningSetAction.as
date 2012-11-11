package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class FriendOrGuildMemberLevelUpWarningSetAction extends Object implements Action
    {
        public var enable:Boolean;

        public function FriendOrGuildMemberLevelUpWarningSetAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : FriendOrGuildMemberLevelUpWarningSetAction
        {
            var _loc_2:* = new FriendOrGuildMemberLevelUpWarningSetAction;
            _loc_2.enable = param1;
            return _loc_2;
        }// end function

    }
}
