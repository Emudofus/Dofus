package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ClearChatAction implements Action 
    {

        public var channel:Array;


        public static function create(channel:Array):ClearChatAction
        {
            var a:ClearChatAction = new (ClearChatAction)();
            a.channel = channel;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat

