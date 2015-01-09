package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeBidHousePriceAction implements Action 
    {

        public var genId:uint;


        public static function create(pGid:uint):ExchangeBidHousePriceAction
        {
            var a:ExchangeBidHousePriceAction = new (ExchangeBidHousePriceAction)();
            a.genId = pGid;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.bid

