package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseSellAction extends Object implements Action
    {
        public var amount:uint;

        public function HouseSellAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : HouseSellAction
        {
            var _loc_2:* = new HouseSellAction;
            _loc_2.amount = param1;
            return _loc_2;
        }// end function

    }
}
