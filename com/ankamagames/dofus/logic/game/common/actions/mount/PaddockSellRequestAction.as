package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PaddockSellRequestAction implements Action 
    {

        public var price:uint;


        public static function create(price:uint):PaddockSellRequestAction
        {
            var o:PaddockSellRequestAction = new (PaddockSellRequestAction)();
            o.price = price;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

