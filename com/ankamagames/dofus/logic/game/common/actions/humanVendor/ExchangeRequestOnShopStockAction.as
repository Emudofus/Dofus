package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class ExchangeRequestOnShopStockAction extends Object implements Action
   {
         

      public function ExchangeRequestOnShopStockAction() {
         super();
      }

      public static function create() : ExchangeRequestOnShopStockAction {
         var a:ExchangeRequestOnShopStockAction = new ExchangeRequestOnShopStockAction();
         return a;
      }


   }

}