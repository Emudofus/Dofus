package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeShowVendorTaxAction extends Object implements Action
   {
      
      public function ExchangeShowVendorTaxAction() {
         super();
      }
      
      public static function create() : ExchangeShowVendorTaxAction {
         var a:ExchangeShowVendorTaxAction = new ExchangeShowVendorTaxAction();
         return a;
      }
   }
}
