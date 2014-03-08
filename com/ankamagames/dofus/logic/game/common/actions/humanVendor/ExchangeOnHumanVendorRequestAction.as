package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeOnHumanVendorRequestAction extends Object implements Action
   {
      
      public function ExchangeOnHumanVendorRequestAction() {
         super();
      }
      
      public static function create(pHumanVendorId:uint, pHumanVendorCell:uint) : ExchangeOnHumanVendorRequestAction {
         var a:ExchangeOnHumanVendorRequestAction = new ExchangeOnHumanVendorRequestAction();
         a.humanVendorId = pHumanVendorId;
         a.humanVendorCell = pHumanVendorCell;
         return a;
      }
      
      public var humanVendorId:int;
      
      public var humanVendorCell:int;
   }
}
