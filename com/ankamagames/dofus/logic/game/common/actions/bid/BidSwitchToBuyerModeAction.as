package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class BidSwitchToBuyerModeAction extends Object implements Action
    {

        public function BidSwitchToBuyerModeAction()
        {
            return;
        }// end function

        public static function create() : BidSwitchToBuyerModeAction
        {
            var _loc_1:* = new BidSwitchToBuyerModeAction;
            return _loc_1;
        }// end function

    }
}
