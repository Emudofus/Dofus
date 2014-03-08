package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LockableChangeCodeAction extends Object implements Action
   {
      
      public function LockableChangeCodeAction() {
         super();
      }
      
      public static function create(code:String) : LockableChangeCodeAction {
         var action:LockableChangeCodeAction = new LockableChangeCodeAction();
         action.code = code;
         return action;
      }
      
      public var code:String;
   }
}
