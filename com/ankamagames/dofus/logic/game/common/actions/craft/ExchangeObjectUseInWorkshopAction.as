package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectUseInWorkshopAction extends Object implements Action
    {
        public var objectUID:uint;
        public var quantity:uint;

        public function ExchangeObjectUseInWorkshopAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : ExchangeObjectUseInWorkshopAction
        {
            var _loc_3:* = new ExchangeObjectUseInWorkshopAction;
            _loc_3.objectUID = param1;
            _loc_3.quantity = param2;
            return _loc_3;
        }// end function

    }
}
