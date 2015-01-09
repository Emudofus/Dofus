package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeOnHumanVendorRequestAction implements Action 
    {

        public var humanVendorId:int;
        public var humanVendorCell:int;


        public static function create(pHumanVendorId:uint, pHumanVendorCell:uint):ExchangeOnHumanVendorRequestAction
        {
            var a:ExchangeOnHumanVendorRequestAction = new (ExchangeOnHumanVendorRequestAction)();
            a.humanVendorId = pHumanVendorId;
            a.humanVendorCell = pHumanVendorCell;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.humanVendor

