package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeShowVendorTaxAction extends Object implements Action
    {

        public function ExchangeShowVendorTaxAction()
        {
            return;
        }// end function

        public static function create() : ExchangeShowVendorTaxAction
        {
            var _loc_1:* = new ExchangeShowVendorTaxAction;
            return _loc_1;
        }// end function

    }
}
