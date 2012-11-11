package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeRequestOnTaxCollectorAction extends Object implements Action
    {
        public var taxCollectorId:int;

        public function ExchangeRequestOnTaxCollectorAction()
        {
            return;
        }// end function

        public static function create(param1:int) : ExchangeRequestOnTaxCollectorAction
        {
            var _loc_2:* = new ExchangeRequestOnTaxCollectorAction;
            _loc_2.taxCollectorId = param1;
            return _loc_2;
        }// end function

    }
}
