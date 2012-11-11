package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LeaveBidHouseAction extends Object implements Action
    {

        public function LeaveBidHouseAction()
        {
            return;
        }// end function

        public static function create() : LeaveBidHouseAction
        {
            var _loc_1:* = new LeaveBidHouseAction;
            return _loc_1;
        }// end function

    }
}
