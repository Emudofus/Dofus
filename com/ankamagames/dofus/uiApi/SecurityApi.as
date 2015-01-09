package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.dofus.logic.shield.SecureModeManager;

    public class SecurityApi implements IApi 
    {


        [Trusted]
        public static function askSecureModeCode(callback:Function):void
        {
            SecureModeManager.getInstance().askCode(callback);
        }

        [Trusted]
        public static function sendSecureModeCode(code:String, callback:Function, computerName:String=null):void
        {
            SecureModeManager.getInstance().computerName = computerName;
            SecureModeManager.getInstance().sendCode(code, callback);
        }

        [Trusted]
        public static function SecureModeisActive():Boolean
        {
            return (SecureModeManager.getInstance().active);
        }

        [Trusted]
        public static function setShieldLevel(level:uint):void
        {
            SecureModeManager.getInstance().shieldLevel = level;
        }

        [Trusted]
        public static function getShieldLevel():uint
        {
            return (SecureModeManager.getInstance().shieldLevel);
        }


    }
}//package com.ankamagames.dofus.uiApi

