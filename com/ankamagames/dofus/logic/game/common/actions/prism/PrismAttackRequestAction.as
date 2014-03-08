package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismAttackRequestAction extends Object implements Action
   {
      
      public function PrismAttackRequestAction() {
         super();
      }
      
      public static function create() : PrismAttackRequestAction {
         var action:PrismAttackRequestAction = new PrismAttackRequestAction();
         return action;
      }
   }
}
