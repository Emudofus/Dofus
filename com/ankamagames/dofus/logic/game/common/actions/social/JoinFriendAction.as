package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class JoinFriendAction extends Object implements Action
    {
        public var name:String;

        public function JoinFriendAction()
        {
            return;
        }// end function

        public static function create(param1:String) : JoinFriendAction
        {
            var _loc_2:* = new JoinFriendAction;
            _loc_2.name = param1;
            return _loc_2;
        }// end function

    }
}
