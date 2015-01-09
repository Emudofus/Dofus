package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChatLoadedAction implements Action 
    {


        public static function create():ChatLoadedAction
        {
            var a:ChatLoadedAction = new (ChatLoadedAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat

