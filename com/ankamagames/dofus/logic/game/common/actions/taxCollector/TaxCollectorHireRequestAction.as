package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class TaxCollectorHireRequestAction extends Object implements Action
   {
         

      public function TaxCollectorHireRequestAction() {
         super();
      }

      public static function create() : TaxCollectorHireRequestAction {
         var action:TaxCollectorHireRequestAction = new TaxCollectorHireRequestAction();
         return action;
      }


   }

}