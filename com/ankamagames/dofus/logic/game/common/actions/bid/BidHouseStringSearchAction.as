package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class BidHouseStringSearchAction extends Object implements Action
    {
        public var searchString:String;

        public function BidHouseStringSearchAction()
        {
            return;
        }// end function

        public static function create(param1:String) : BidHouseStringSearchAction
        {
            var _loc_2:* = new BidHouseStringSearchAction;
            _loc_2.searchString = param1;
            return _loc_2;
        }// end function

    }
}
