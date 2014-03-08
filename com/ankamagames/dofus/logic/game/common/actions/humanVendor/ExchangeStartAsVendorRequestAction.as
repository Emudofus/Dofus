package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeStartAsVendorRequestAction extends Object implements Action
   {
      
      public function ExchangeStartAsVendorRequestAction() {
         super();
      }
      
      public static function create() : ExchangeStartAsVendorRequestAction {
         var _loc1_:ExchangeStartAsVendorRequestAction = new ExchangeStartAsVendorRequestAction();
         return _loc1_;
      }
   }
}
