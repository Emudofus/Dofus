package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class FriendGuildSetWarnOnAchievementCompleteAction extends Object implements Action
    {
        public var enable:Boolean;

        public function FriendGuildSetWarnOnAchievementCompleteAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : FriendGuildSetWarnOnAchievementCompleteAction
        {
            var _loc_2:* = new FriendGuildSetWarnOnAchievementCompleteAction;
            _loc_2.enable = param1;
            return _loc_2;
        }// end function

    }
}
