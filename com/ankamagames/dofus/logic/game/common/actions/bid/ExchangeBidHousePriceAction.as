package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHousePriceAction extends Object implements Action
   {
      
      public function ExchangeBidHousePriceAction() {
         super();
      }
      
      public static function create(param1:uint) : ExchangeBidHousePriceAction {
         var _loc2_:ExchangeBidHousePriceAction = new ExchangeBidHousePriceAction();
         _loc2_.genId = param1;
         return _loc2_;
      }
      
      public var genId:uint;
   }
}
