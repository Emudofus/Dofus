package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeShopStockMouvmentAddAction extends Object implements Action
   {
      
      public function ExchangeShopStockMouvmentAddAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint) : ExchangeShopStockMouvmentAddAction {
         var _loc4_:ExchangeShopStockMouvmentAddAction = new ExchangeShopStockMouvmentAddAction();
         _loc4_.objectUID = param1;
         _loc4_.quantity = param2;
         _loc4_.price = param3;
         return _loc4_;
      }
      
      public var objectUID:uint;
      
      public var quantity:uint;
      
      public var price:uint;
   }
}
