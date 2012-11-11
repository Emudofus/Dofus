package com.ankamagames.dofus.logic.connection.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.messages.*;

    public class LoginValidationAction extends Object implements Action, IDontLogThisMessage
    {
        public var username:String;
        public var password:String;
        public var autoSelectServer:Boolean;
        public var serverId:uint;

        public function LoginValidationAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:String, param3:Boolean, param4:uint = 0) : LoginValidationAction
        {
            var _loc_5:* = new LoginValidationAction;
            new LoginValidationAction.password = param2;
            _loc_5.username = param1;
            _loc_5.autoSelectServer = param3;
            _loc_5.serverId = param4;
            return _loc_5;
        }// end function

    }
}
