package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class ExchangeObjectTransfertListWithQuantityToInvAction implements Action 
    {

        public var ids:Vector.<uint>;
        public var qtys:Vector.<uint>;


        public static function create(pIds:Vector.<uint>, pQtys:Vector.<uint>):ExchangeObjectTransfertListWithQuantityToInvAction
        {
            var a:ExchangeObjectTransfertListWithQuantityToInvAction = new (ExchangeObjectTransfertListWithQuantityToInvAction)();
            a.ids = pIds;
            a.qtys = pQtys;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.exchange

