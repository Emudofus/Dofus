package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeStartAsVendorRequestAction extends Object implements Action
   {
      
      public function ExchangeStartAsVendorRequestAction() {
         super();
      }
      
      public static function create() : ExchangeStartAsVendorRequestAction {
         var a:ExchangeStartAsVendorRequestAction = new ExchangeStartAsVendorRequestAction();
         return a;
      }
   }
}
