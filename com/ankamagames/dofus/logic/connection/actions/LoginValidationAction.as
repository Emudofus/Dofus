package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.messages.IDontLogThisMessage;
   
   public class LoginValidationAction extends Object implements Action, IDontLogThisMessage
   {
      
      public function LoginValidationAction() {
         super();
      }
      
      public static function create(username:String, password:String, autoSelectServer:Boolean, serverId:uint = 0) : LoginValidationAction {
         var a:LoginValidationAction = new LoginValidationAction();
         a.password = password;
         a.username = username;
         a.autoSelectServer = autoSelectServer;
         a.serverId = serverId;
         return a;
      }
      
      public var username:String;
      
      public var password:String;
      
      public var autoSelectServer:Boolean;
      
      public var serverId:uint;
   }
}
