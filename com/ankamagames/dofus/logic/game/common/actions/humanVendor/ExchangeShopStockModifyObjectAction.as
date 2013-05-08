package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class ExchangeShopStockModifyObjectAction extends Object implements Action
   {
         

      public function ExchangeShopStockModifyObjectAction() {
         super();
      }

      public static function create(pObjectUID:uint, pQuantity:int, pPrice:int) : ExchangeShopStockModifyObjectAction {
         var a:ExchangeShopStockModifyObjectAction = new ExchangeShopStockModifyObjectAction();
         a.objectUID=pObjectUID;
         a.quantity=pQuantity;
         a.price=pPrice;
         return a;
      }

      public var objectUID:uint;

      public var quantity:int;

      public var price:int;
   }

}