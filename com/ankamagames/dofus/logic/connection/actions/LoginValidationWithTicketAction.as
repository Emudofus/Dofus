package com.ankamagames.dofus.logic.connection.actions
{

    public class LoginValidationWithTicketAction extends LoginValidationAction
    {
        public var ticket:String;

        public function LoginValidationWithTicketAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:Boolean, param3:uint = 0) : LoginValidationWithTicketAction
        {
            var _loc_4:* = new LoginValidationWithTicketAction;
            new LoginValidationWithTicketAction.password = "";
            _loc_4.username = "";
            _loc_4.ticket = param1;
            _loc_4.autoSelectServer = param2;
            _loc_4.serverId = param3;
            return _loc_4;
        }// end function

    }
}
