package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeObjectMoveKamaAction implements Action 
    {

        public var kamas:uint;


        public static function create(pKamas:uint):ExchangeObjectMoveKamaAction
        {
            var a:ExchangeObjectMoveKamaAction = new (ExchangeObjectMoveKamaAction)();
            a.kamas = pKamas;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.exchange

