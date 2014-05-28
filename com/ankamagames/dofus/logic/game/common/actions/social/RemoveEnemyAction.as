package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveEnemyAction extends Object implements Action
   {
      
      public function RemoveEnemyAction() {
         super();
      }
      
      public static function create(accountId:int) : RemoveEnemyAction {
         var a:RemoveEnemyAction = new RemoveEnemyAction();
         a.accountId = accountId;
         return a;
      }
      
      public var accountId:int;
   }
}
