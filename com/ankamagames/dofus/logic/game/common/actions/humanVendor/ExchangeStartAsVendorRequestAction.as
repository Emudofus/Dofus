package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeStartAsVendorRequestAction extends Object implements Action
    {

        public function ExchangeStartAsVendorRequestAction()
        {
            return;
        }// end function

        public static function create() : ExchangeStartAsVendorRequestAction
        {
            var _loc_1:* = new ExchangeStartAsVendorRequestAction;
            return _loc_1;
        }// end function

    }
}
