package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeBuyAction extends Object implements Action
    {
        public var objectUID:uint;
        public var quantity:uint;

        public function ExchangeBuyAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : ExchangeBuyAction
        {
            var _loc_3:* = new ExchangeBuyAction;
            _loc_3.objectUID = param1;
            _loc_3.quantity = param2;
            return _loc_3;
        }// end function

    }
}
