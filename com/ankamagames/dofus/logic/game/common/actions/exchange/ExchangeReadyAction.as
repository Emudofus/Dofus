package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeReadyAction implements Action 
    {

        public var isReady:Boolean;


        public static function create(pIsReady:Boolean):ExchangeReadyAction
        {
            var a:ExchangeReadyAction = new (ExchangeReadyAction)();
            a.isReady = pIsReady;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.exchange

