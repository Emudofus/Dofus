package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeRequestOnTaxCollectorAction implements Action 
    {

        public var taxCollectorId:int;


        public static function create(taxCollectorId:int):ExchangeRequestOnTaxCollectorAction
        {
            var a:ExchangeRequestOnTaxCollectorAction = new (ExchangeRequestOnTaxCollectorAction)();
            a.taxCollectorId = taxCollectorId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.exchange

