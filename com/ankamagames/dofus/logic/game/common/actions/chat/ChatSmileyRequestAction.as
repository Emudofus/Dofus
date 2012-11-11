package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChatSmileyRequestAction extends Object implements Action
    {
        public var smileyId:int;

        public function ChatSmileyRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : ChatSmileyRequestAction
        {
            var _loc_2:* = new ChatSmileyRequestAction;
            _loc_2.smileyId = param1;
            return _loc_2;
        }// end function

    }
}
