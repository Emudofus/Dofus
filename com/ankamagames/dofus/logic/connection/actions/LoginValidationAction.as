package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.messages.IDontLogThisMessage;
   
   public class LoginValidationAction extends Object implements Action, IDontLogThisMessage
   {
      
      public function LoginValidationAction() {
         super();
      }
      
      public static function create(param1:String, param2:String, param3:Boolean, param4:uint=0) : LoginValidationAction {
         var _loc5_:LoginValidationAction = new LoginValidationAction();
         _loc5_.password = param2;
         _loc5_.username = param1;
         _loc5_.autoSelectServer = param3;
         _loc5_.serverId = param4;
         return _loc5_;
      }
      
      public var username:String;
      
      public var password:String;
      
      public var autoSelectServer:Boolean;
      
      public var serverId:uint;
   }
}
