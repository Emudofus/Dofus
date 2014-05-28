package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AuthorizedCommandAction extends Object implements Action
   {
      
      public function AuthorizedCommandAction() {
         super();
      }
      
      public static function create(command:String) : AuthorizedCommandAction {
         var a:AuthorizedCommandAction = new AuthorizedCommandAction();
         a.command = command;
         return a;
      }
      
      public var command:String;
   }
}
