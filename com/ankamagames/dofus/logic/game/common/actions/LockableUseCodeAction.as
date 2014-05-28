package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LockableUseCodeAction extends Object implements Action
   {
      
      public function LockableUseCodeAction() {
         super();
      }
      
      public static function create(code:String) : LockableUseCodeAction {
         var action:LockableUseCodeAction = new LockableUseCodeAction();
         action.code = code;
         return action;
      }
      
      public var code:String;
   }
}
