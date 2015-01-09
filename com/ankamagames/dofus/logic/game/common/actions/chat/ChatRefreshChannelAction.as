package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChatRefreshChannelAction implements Action 
    {


        public static function create():ChatRefreshChannelAction
        {
            var a:ChatRefreshChannelAction = new (ChatRefreshChannelAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat

