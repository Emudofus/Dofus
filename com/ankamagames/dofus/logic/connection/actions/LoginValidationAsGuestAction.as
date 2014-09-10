package com.ankamagames.dofus.logic.connection.actions
{
   public class LoginValidationAsGuestAction extends LoginValidationAction
   {
      
      public function LoginValidationAsGuestAction() {
         super();
      }
      
      public static function create(username:String, password:String) : LoginValidationAsGuestAction {
         var a:LoginValidationAsGuestAction = new LoginValidationAsGuestAction();
         a.password = password;
         a.username = username;
         a.autoSelectServer = true;
         a.serverId = 0;
         return a;
      }
   }
}
