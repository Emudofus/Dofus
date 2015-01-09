package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChatRefreshChatAction implements Action 
    {

        public var currentTab:uint;


        public static function create(currentTab:uint):ChatRefreshChatAction
        {
            var a:ChatRefreshChatAction = new (ChatRefreshChatAction)();
            a.currentTab = currentTab;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat

