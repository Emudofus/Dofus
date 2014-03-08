package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeShopStockMouvmentRemoveAction extends Object implements Action
   {
      
      public function ExchangeShopStockMouvmentRemoveAction() {
         super();
      }
      
      public static function create(param1:uint, param2:int) : ExchangeShopStockMouvmentRemoveAction {
         var _loc3_:ExchangeShopStockMouvmentRemoveAction = new ExchangeShopStockMouvmentRemoveAction();
         _loc3_.objectUID = param1;
         _loc3_.quantity = -Math.abs(param2);
         return _loc3_;
      }
      
      public var objectUID:uint;
      
      public var quantity:int;
   }
}
