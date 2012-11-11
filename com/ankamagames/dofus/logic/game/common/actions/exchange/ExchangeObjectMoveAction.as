package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectMoveAction extends Object implements Action
    {
        public var objectUID:uint;
        public var quantity:int;

        public function ExchangeObjectMoveAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:int) : ExchangeObjectMoveAction
        {
            var _loc_3:* = new ExchangeObjectMoveAction;
            _loc_3.objectUID = param1;
            _loc_3.quantity = param2;
            return _loc_3;
        }// end function

    }
}
