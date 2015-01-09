package com.ankamagames.dofus.logic.connection.actions
{
    public class LoginValidationWithTicketAction extends LoginValidationAction 
    {

        public var ticket:String;


        public static function create(ticket:String, autoSelectServer:Boolean, serverId:uint=0):LoginValidationWithTicketAction
        {
            var a:LoginValidationWithTicketAction = new (LoginValidationWithTicketAction)();
            a.password = "";
            a.username = "";
            a.ticket = ticket;
            a.autoSelectServer = autoSelectServer;
            a.serverId = serverId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.connection.actions

