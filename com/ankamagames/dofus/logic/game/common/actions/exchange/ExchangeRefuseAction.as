package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeRefuseAction implements Action 
    {


        public static function create():ExchangeRefuseAction
        {
            var a:ExchangeRefuseAction = new (ExchangeRefuseAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.exchange

