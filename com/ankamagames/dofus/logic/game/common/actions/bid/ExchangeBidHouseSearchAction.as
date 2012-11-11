package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeBidHouseSearchAction extends Object implements Action
    {
        public var type:uint;
        public var genId:uint;

        public function ExchangeBidHouseSearchAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : ExchangeBidHouseSearchAction
        {
            var _loc_3:* = new ExchangeBidHouseSearchAction;
            _loc_3.type = param1;
            _loc_3.genId = param2;
            return _loc_3;
        }// end function

    }
}
