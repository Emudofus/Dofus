package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeAcceptAction implements Action 
    {


        public static function create():ExchangeAcceptAction
        {
            var a:ExchangeAcceptAction = new (ExchangeAcceptAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.exchange

