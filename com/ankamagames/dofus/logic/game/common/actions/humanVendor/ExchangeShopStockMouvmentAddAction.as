package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeShopStockMouvmentAddAction extends Object implements Action
    {
        public var objectUID:uint;
        public var quantity:uint;
        public var price:uint;

        public function ExchangeShopStockMouvmentAddAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint) : ExchangeShopStockMouvmentAddAction
        {
            var _loc_4:* = new ExchangeShopStockMouvmentAddAction;
            new ExchangeShopStockMouvmentAddAction.objectUID = param1;
            _loc_4.quantity = param2;
            _loc_4.price = param3;
            return _loc_4;
        }// end function

    }
}
