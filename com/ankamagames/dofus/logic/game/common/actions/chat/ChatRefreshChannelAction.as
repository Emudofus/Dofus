package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChatRefreshChannelAction extends Object implements Action
    {

        public function ChatRefreshChannelAction()
        {
            return;
        }// end function

        public static function create() : ChatRefreshChannelAction
        {
            var _loc_1:* = new ChatRefreshChannelAction;
            return _loc_1;
        }// end function

    }
}
