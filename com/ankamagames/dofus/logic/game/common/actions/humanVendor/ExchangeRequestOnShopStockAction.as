package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeRequestOnShopStockAction extends Object implements Action
    {

        public function ExchangeRequestOnShopStockAction()
        {
            return;
        }// end function

        public static function create() : ExchangeRequestOnShopStockAction
        {
            var _loc_1:* = new ExchangeRequestOnShopStockAction;
            return _loc_1;
        }// end function

    }
}
