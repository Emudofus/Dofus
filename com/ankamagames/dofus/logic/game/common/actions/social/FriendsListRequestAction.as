package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class FriendsListRequestAction extends Object implements Action
    {

        public function FriendsListRequestAction()
        {
            return;
        }// end function

        public static function create() : FriendsListRequestAction
        {
            var _loc_1:* = new FriendsListRequestAction;
            return _loc_1;
        }// end function

    }
}
