package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeOnHumanVendorRequestAction extends Object implements Action
   {
      
      public function ExchangeOnHumanVendorRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : ExchangeOnHumanVendorRequestAction {
         var _loc3_:ExchangeOnHumanVendorRequestAction = new ExchangeOnHumanVendorRequestAction();
         _loc3_.humanVendorId = param1;
         _loc3_.humanVendorCell = param2;
         return _loc3_;
      }
      
      public var humanVendorId:int;
      
      public var humanVendorCell:int;
   }
}
