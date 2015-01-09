package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChatCommandAction implements Action 
    {

        public var command:String;


        public static function create(command:String):ChatCommandAction
        {
            var a:ChatCommandAction = new (ChatCommandAction)();
            a.command = command;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat

