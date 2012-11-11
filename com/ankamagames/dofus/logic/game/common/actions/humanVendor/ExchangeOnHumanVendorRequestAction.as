package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeOnHumanVendorRequestAction extends Object implements Action
    {
        public var humanVendorId:int;
        public var humanVendorCell:int;

        public function ExchangeOnHumanVendorRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : ExchangeOnHumanVendorRequestAction
        {
            var _loc_3:* = new ExchangeOnHumanVendorRequestAction;
            _loc_3.humanVendorId = param1;
            _loc_3.humanVendorCell = param2;
            return _loc_3;
        }// end function

    }
}
