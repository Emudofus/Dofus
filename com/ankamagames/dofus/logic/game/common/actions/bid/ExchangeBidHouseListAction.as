package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeBidHouseListAction implements Action 
    {

        public var id:uint;


        public static function create(pId:uint):ExchangeBidHouseListAction
        {
            var a:ExchangeBidHouseListAction = new (ExchangeBidHouseListAction)();
            a.id = pId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.bid

