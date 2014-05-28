package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveFriendAction extends Object implements Action
   {
      
      public function RemoveFriendAction() {
         super();
      }
      
      public static function create(accountId:int) : RemoveFriendAction {
         var a:RemoveFriendAction = new RemoveFriendAction();
         a.accountId = accountId;
         return a;
      }
      
      public var accountId:int;
   }
}
