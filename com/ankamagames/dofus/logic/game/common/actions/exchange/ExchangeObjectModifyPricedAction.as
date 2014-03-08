package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectModifyPricedAction extends Object implements Action
   {
      
      public function ExchangeObjectModifyPricedAction() {
         super();
      }
      
      public static function create(param1:uint, param2:int, param3:int) : ExchangeObjectModifyPricedAction {
         var _loc4_:ExchangeObjectModifyPricedAction = new ExchangeObjectModifyPricedAction();
         _loc4_.objectUID = param1;
         _loc4_.quantity = param2;
         _loc4_.price = param3;
         return _loc4_;
      }
      
      public var objectUID:uint;
      
      public var quantity:int;
      
      public var price:int;
   }
}
