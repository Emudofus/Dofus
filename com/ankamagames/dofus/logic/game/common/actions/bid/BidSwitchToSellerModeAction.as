package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class BidSwitchToSellerModeAction extends Object implements Action
    {

        public function BidSwitchToSellerModeAction()
        {
            return;
        }// end function

        public static function create() : BidSwitchToSellerModeAction
        {
            var _loc_1:* = new BidSwitchToSellerModeAction;
            return _loc_1;
        }// end function

    }
}
