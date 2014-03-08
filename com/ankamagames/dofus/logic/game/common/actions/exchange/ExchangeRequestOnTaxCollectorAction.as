package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRequestOnTaxCollectorAction extends Object implements Action
   {
      
      public function ExchangeRequestOnTaxCollectorAction() {
         super();
      }
      
      public static function create(param1:int) : ExchangeRequestOnTaxCollectorAction {
         var _loc2_:ExchangeRequestOnTaxCollectorAction = new ExchangeRequestOnTaxCollectorAction();
         _loc2_.taxCollectorId = param1;
         return _loc2_;
      }
      
      public var taxCollectorId:int;
   }
}
