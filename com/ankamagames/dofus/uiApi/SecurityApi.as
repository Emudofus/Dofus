package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.dofus.logic.common.managers.*;

    public class SecurityApi extends Object implements IApi
    {

        public function SecurityApi()
        {
            return;
        }// end function

        public static function askSecureModeCode(param1:Function) : void
        {
            SecureModeManager.getInstance().askCode(param1);
            return;
        }// end function

        public static function sendSecureModeCode(param1:String, param2:Function, param3:String = null) : void
        {
            SecureModeManager.getInstance().computerName = param3;
            SecureModeManager.getInstance().sendCode(param1, param2);
            return;
        }// end function

        public static function SecureModeisActive() : Boolean
        {
            return SecureModeManager.getInstance().active;
        }// end function

    }
}
