package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PaddockSellRequestAction extends Object implements Action
    {
        public var price:uint;

        public function PaddockSellRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : PaddockSellRequestAction
        {
            var _loc_2:* = new PaddockSellRequestAction;
            _loc_2.price = param1;
            return _loc_2;
        }// end function

    }
}
