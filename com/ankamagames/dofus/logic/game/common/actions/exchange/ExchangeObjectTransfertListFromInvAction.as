package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class ExchangeObjectTransfertListFromInvAction implements Action 
    {

        public var ids:Vector.<uint>;


        public static function create(pIds:Vector.<uint>):ExchangeObjectTransfertListFromInvAction
        {
            var a:ExchangeObjectTransfertListFromInvAction = new (ExchangeObjectTransfertListFromInvAction)();
            a.ids = pIds;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.exchange

