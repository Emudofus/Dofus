package com.ankamagames.dofus.logic.connection.actions
{
   public class LoginValidationAsGuestAction extends LoginValidationAction
   {
      
      public function LoginValidationAsGuestAction()
      {
         super();
      }
      
      public static function create(param1:String, param2:String) : LoginValidationAsGuestAction
      {
         var _loc3_:LoginValidationAsGuestAction = new LoginValidationAsGuestAction();
         _loc3_.password = param2;
         _loc3_.username = param1;
         _loc3_.autoSelectServer = true;
         _loc3_.serverId = 0;
         return _loc3_;
      }
   }
}
