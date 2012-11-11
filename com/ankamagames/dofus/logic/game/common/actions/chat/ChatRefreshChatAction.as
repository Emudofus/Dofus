package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChatRefreshChatAction extends Object implements Action
    {
        public var currentTab:uint;

        public function ChatRefreshChatAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ChatRefreshChatAction
        {
            var _loc_2:* = new ChatRefreshChatAction;
            _loc_2.currentTab = param1;
            return _loc_2;
        }// end function

    }
}
