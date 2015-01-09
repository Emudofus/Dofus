package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AuthorizedCommandAction implements Action 
    {

        public var command:String;


        public static function create(command:String):AuthorizedCommandAction
        {
            var a:AuthorizedCommandAction = new (AuthorizedCommandAction)();
            a.command = command;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.common.actions

