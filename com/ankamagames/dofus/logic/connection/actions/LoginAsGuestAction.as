package com.ankamagames.dofus.logic.connection.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.jerakine.messages.IDontLogThisMessage;

    public class LoginAsGuestAction implements Action, IDontLogThisMessage 
    {


        public static function create():LoginAsGuestAction
        {
            var a:LoginAsGuestAction = new (LoginAsGuestAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.connection.actions

