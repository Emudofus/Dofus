package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class BidSwitchToBuyerModeAction implements Action 
    {


        public static function create():BidSwitchToBuyerModeAction
        {
            var a:BidSwitchToBuyerModeAction = new (BidSwitchToBuyerModeAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.bid

