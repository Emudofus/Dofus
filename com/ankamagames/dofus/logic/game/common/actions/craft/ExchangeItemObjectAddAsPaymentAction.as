package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeItemObjectAddAsPaymentAction extends Object implements Action
    {
        public var onlySuccess:Boolean;
        public var objectUID:uint;
        public var quantity:int;
        public var isAdd:Boolean;

        public function ExchangeItemObjectAddAsPaymentAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean, param2:uint, param3:Boolean, param4:int) : ExchangeItemObjectAddAsPaymentAction
        {
            var _loc_5:* = new ExchangeItemObjectAddAsPaymentAction;
            new ExchangeItemObjectAddAsPaymentAction.onlySuccess = param1;
            _loc_5.objectUID = param2;
            _loc_5.quantity = param4;
            _loc_5.isAdd = param3;
            return _loc_5;
        }// end function

    }
}
