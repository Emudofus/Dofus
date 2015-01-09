package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeStartAsVendorRequestAction implements Action 
    {


        public static function create():ExchangeStartAsVendorRequestAction
        {
            var a:ExchangeStartAsVendorRequestAction = new (ExchangeStartAsVendorRequestAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.humanVendor

