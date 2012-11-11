package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeShopStockModifyObjectAction extends Object implements Action
    {
        public var objectUID:uint;
        public var quantity:int;
        public var price:int;

        public function ExchangeShopStockModifyObjectAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:int, param3:int) : ExchangeShopStockModifyObjectAction
        {
            var _loc_4:* = new ExchangeShopStockModifyObjectAction;
            new ExchangeShopStockModifyObjectAction.objectUID = param1;
            _loc_4.quantity = param2;
            _loc_4.price = param3;
            return _loc_4;
        }// end function

    }
}
