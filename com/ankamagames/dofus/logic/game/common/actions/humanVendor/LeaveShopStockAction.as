package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveShopStockAction extends Object implements Action
   {
      
      public function LeaveShopStockAction() {
         super();
      }
      
      public static function create() : LeaveShopStockAction {
         var _loc1_:LeaveShopStockAction = new LeaveShopStockAction();
         return _loc1_;
      }
   }
}
