package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class RemoveFriendAction extends Object implements Action
    {
        public var name:String;

        public function RemoveFriendAction()
        {
            return;
        }// end function

        public static function create(param1:String) : RemoveFriendAction
        {
            var _loc_2:* = new RemoveFriendAction;
            _loc_2.name = param1;
            return _loc_2;
        }// end function

    }
}
