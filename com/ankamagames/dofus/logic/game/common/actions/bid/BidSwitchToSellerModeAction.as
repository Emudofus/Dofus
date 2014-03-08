package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BidSwitchToSellerModeAction extends Object implements Action
   {
      
      public function BidSwitchToSellerModeAction() {
         super();
      }
      
      public static function create() : BidSwitchToSellerModeAction {
         var a:BidSwitchToSellerModeAction = new BidSwitchToSellerModeAction();
         return a;
      }
   }
}
