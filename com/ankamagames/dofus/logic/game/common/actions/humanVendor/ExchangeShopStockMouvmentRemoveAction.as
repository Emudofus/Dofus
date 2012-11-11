package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeShopStockMouvmentRemoveAction extends Object implements Action
    {
        public var objectUID:uint;
        public var quantity:int;

        public function ExchangeShopStockMouvmentRemoveAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:int) : ExchangeShopStockMouvmentRemoveAction
        {
            var _loc_3:* = new ExchangeShopStockMouvmentRemoveAction;
            _loc_3.objectUID = param1;
            _loc_3.quantity = -Math.abs(param2);
            return _loc_3;
        }// end function

    }
}
