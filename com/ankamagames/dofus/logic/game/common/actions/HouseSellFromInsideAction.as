package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseSellFromInsideAction extends Object implements Action
    {
        public var amount:uint;

        public function HouseSellFromInsideAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : HouseSellFromInsideAction
        {
            var _loc_2:* = new HouseSellFromInsideAction;
            _loc_2.amount = param1;
            return _loc_2;
        }// end function

    }
}
