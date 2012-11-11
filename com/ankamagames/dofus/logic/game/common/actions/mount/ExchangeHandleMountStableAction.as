package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeHandleMountStableAction extends Object implements Action
    {
        public var rideId:uint;
        public var actionType:int;

        public function ExchangeHandleMountStableAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : ExchangeHandleMountStableAction
        {
            var _loc_3:* = new ExchangeHandleMountStableAction;
            _loc_3.actionType = param1;
            _loc_3.rideId = param2;
            return _loc_3;
        }// end function

    }
}
