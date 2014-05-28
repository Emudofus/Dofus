package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveIgnoredAction extends Object implements Action
   {
      
      public function RemoveIgnoredAction() {
         super();
      }
      
      public static function create(accountId:int) : RemoveIgnoredAction {
         var a:RemoveIgnoredAction = new RemoveIgnoredAction();
         a.accountId = accountId;
         return a;
      }
      
      public var accountId:int;
   }
}
