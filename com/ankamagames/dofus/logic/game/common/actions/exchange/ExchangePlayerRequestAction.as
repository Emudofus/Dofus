package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangePlayerRequestAction implements Action 
    {

        public var exchangeType:int;
        public var target:int;


        public static function create(exchangeType:int, target:uint):ExchangePlayerRequestAction
        {
            var a:ExchangePlayerRequestAction = new (ExchangePlayerRequestAction)();
            a.exchangeType = exchangeType;
            a.target = target;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.exchange

