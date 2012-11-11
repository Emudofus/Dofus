package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeBidHouseTypeAction extends Object implements Action
    {
        public var type:uint;

        public function ExchangeBidHouseTypeAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ExchangeBidHouseTypeAction
        {
            var _loc_2:* = new ExchangeBidHouseTypeAction;
            _loc_2.type = param1;
            return _loc_2;
        }// end function

    }
}
