package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class PrismBalanceRequestAction extends Object implements Action
   {
         

      public function PrismBalanceRequestAction() {
         super();
      }

      public static function create() : PrismBalanceRequestAction {
         var action:PrismBalanceRequestAction = new PrismBalanceRequestAction();
         return action;
      }


   }

}