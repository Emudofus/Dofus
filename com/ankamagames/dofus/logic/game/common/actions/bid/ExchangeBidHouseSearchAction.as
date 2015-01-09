package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeBidHouseSearchAction implements Action 
    {

        public var type:uint;
        public var genId:uint;


        public static function create(pType:uint, pGenId:uint):ExchangeBidHouseSearchAction
        {
            var a:ExchangeBidHouseSearchAction = new (ExchangeBidHouseSearchAction)();
            a.type = pType;
            a.genId = pGenId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.bid

