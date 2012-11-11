package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChatCommandAction extends Object implements Action
    {
        public var command:String;

        public function ChatCommandAction()
        {
            return;
        }// end function

        public static function create(param1:String) : ChatCommandAction
        {
            var _loc_2:* = new ChatCommandAction;
            _loc_2.command = param1;
            return _loc_2;
        }// end function

    }
}
