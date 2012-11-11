package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AuthorizedCommandAction extends Object implements Action
    {
        public var command:String;

        public function AuthorizedCommandAction()
        {
            return;
        }// end function

        public static function create(param1:String) : AuthorizedCommandAction
        {
            var _loc_2:* = new AuthorizedCommandAction;
            _loc_2.command = param1;
            return _loc_2;
        }// end function

    }
}
