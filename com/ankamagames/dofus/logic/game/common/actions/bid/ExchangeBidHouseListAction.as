package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeBidHouseListAction extends Object implements Action
    {
        public var id:uint;

        public function ExchangeBidHouseListAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ExchangeBidHouseListAction
        {
            var _loc_2:* = new ExchangeBidHouseListAction;
            _loc_2.id = param1;
            return _loc_2;
        }// end function

    }
}
