package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRequestOnTaxCollectorAction extends Object implements Action
   {
      
      public function ExchangeRequestOnTaxCollectorAction() {
         super();
      }
      
      public static function create(taxCollectorId:int) : ExchangeRequestOnTaxCollectorAction {
         var a:ExchangeRequestOnTaxCollectorAction = new ExchangeRequestOnTaxCollectorAction();
         a.taxCollectorId = taxCollectorId;
         return a;
      }
      
      public var taxCollectorId:int;
   }
}
