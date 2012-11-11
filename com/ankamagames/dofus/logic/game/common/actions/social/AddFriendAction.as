package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AddFriendAction extends Object implements Action
    {
        public var name:String;

        public function AddFriendAction()
        {
            return;
        }// end function

        public static function create(param1:String) : AddFriendAction
        {
            var _loc_2:* = new AddFriendAction;
            _loc_2.name = param1;
            return _loc_2;
        }// end function

    }
}
