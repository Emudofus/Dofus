package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeShopStockMouvmentAddAction implements Action 
    {

        public var objectUID:uint;
        public var quantity:uint;
        public var price:uint;


        public static function create(pObjectUID:uint, pQuantity:uint, pPrice:uint):ExchangeShopStockMouvmentAddAction
        {
            var a:ExchangeShopStockMouvmentAddAction = new (ExchangeShopStockMouvmentAddAction)();
            a.objectUID = pObjectUID;
            a.quantity = pQuantity;
            a.price = pPrice;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.humanVendor

