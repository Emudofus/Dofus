package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeBidHouseBuyAction extends Object implements Action
    {
        public var uid:uint;
        public var qty:uint;
        public var price:uint;

        public function ExchangeBidHouseBuyAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint) : ExchangeBidHouseBuyAction
        {
            var _loc_4:* = new ExchangeBidHouseBuyAction;
            new ExchangeBidHouseBuyAction.uid = param1;
            _loc_4.qty = param2;
            _loc_4.price = param3;
            return _loc_4;
        }// end function

    }
}
