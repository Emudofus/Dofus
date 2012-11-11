package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeItemGoldAddAsPaymentAction extends Object implements Action
    {
        public var onlySuccess:Boolean;
        public var kamas:uint;

        public function ExchangeItemGoldAddAsPaymentAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean, param2:uint) : ExchangeItemGoldAddAsPaymentAction
        {
            var _loc_3:* = new ExchangeItemGoldAddAsPaymentAction;
            _loc_3.onlySuccess = param1;
            _loc_3.kamas = param2;
            return _loc_3;
        }// end function

    }
}
