package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeShopStockMouvmentRemoveAction extends Object implements Action
   {
      
      public function ExchangeShopStockMouvmentRemoveAction() {
         super();
      }
      
      public static function create(pObjectUID:uint, pQuantity:int) : ExchangeShopStockMouvmentRemoveAction {
         var a:ExchangeShopStockMouvmentRemoveAction = new ExchangeShopStockMouvmentRemoveAction();
         a.objectUID = pObjectUID;
         a.quantity = -Math.abs(pQuantity);
         return a;
      }
      
      public var objectUID:uint;
      
      public var quantity:int;
   }
}
