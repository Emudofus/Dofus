package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class FriendSpouseFollowAction extends Object implements Action
    {
        public var enable:Boolean;

        public function FriendSpouseFollowAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : FriendSpouseFollowAction
        {
            var _loc_2:* = new FriendSpouseFollowAction;
            _loc_2.enable = param1;
            return _loc_2;
        }// end function

    }
}
