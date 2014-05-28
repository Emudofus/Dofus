package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.logic.shield.SecureModeManager;
   
   public class SecurityApi extends Object implements IApi
   {
      
      public function SecurityApi() {
         super();
      }
      
      public static function askSecureModeCode(callback:Function) : void {
         SecureModeManager.getInstance().askCode(callback);
      }
      
      public static function sendSecureModeCode(code:String, callback:Function, computerName:String = null) : void {
         SecureModeManager.getInstance().computerName = computerName;
         SecureModeManager.getInstance().sendCode(code,callback);
      }
      
      public static function SecureModeisActive() : Boolean {
         return SecureModeManager.getInstance().active;
      }
      
      public static function setShieldLevel(level:uint) : void {
         SecureModeManager.getInstance().shieldLevel = level;
      }
      
      public static function getShieldLevel() : uint {
         return SecureModeManager.getInstance().shieldLevel;
      }
   }
}
