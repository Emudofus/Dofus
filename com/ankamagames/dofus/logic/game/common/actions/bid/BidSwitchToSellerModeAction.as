package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BidSwitchToSellerModeAction extends Object implements Action
   {
      
      public function BidSwitchToSellerModeAction() {
         super();
      }
      
      public static function create() : BidSwitchToSellerModeAction {
         var _loc1_:BidSwitchToSellerModeAction = new BidSwitchToSellerModeAction();
         return _loc1_;
      }
   }
}
