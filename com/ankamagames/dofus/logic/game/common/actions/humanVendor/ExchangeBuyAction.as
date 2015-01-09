package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeBuyAction implements Action 
    {

        public var objectUID:uint;
        public var quantity:uint;


        public static function create(pObjectUID:uint, pQuantity:uint):ExchangeBuyAction
        {
            var a:ExchangeBuyAction = new (ExchangeBuyAction)();
            a.objectUID = pObjectUID;
            a.quantity = pQuantity;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.humanVendor

