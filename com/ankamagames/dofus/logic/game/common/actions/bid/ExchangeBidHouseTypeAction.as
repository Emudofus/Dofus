package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeBidHouseTypeAction implements Action 
    {

        public var type:uint;


        public static function create(pType:uint):ExchangeBidHouseTypeAction
        {
            var a:ExchangeBidHouseTypeAction = new (ExchangeBidHouseTypeAction)();
            a.type = pType;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.bid

