package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeBidHousePriceAction extends Object implements Action
    {
        public var genId:uint;

        public function ExchangeBidHousePriceAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ExchangeBidHousePriceAction
        {
            var _loc_2:* = new ExchangeBidHousePriceAction;
            _loc_2.genId = param1;
            return _loc_2;
        }// end function

    }
}
