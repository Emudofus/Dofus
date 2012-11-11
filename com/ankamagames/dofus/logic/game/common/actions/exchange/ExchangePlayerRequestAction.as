package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangePlayerRequestAction extends Object implements Action
    {
        public var exchangeType:int;
        public var target:int;

        public function ExchangePlayerRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:uint) : ExchangePlayerRequestAction
        {
            var _loc_3:* = new ExchangePlayerRequestAction;
            _loc_3.exchangeType = param1;
            _loc_3.target = param2;
            return _loc_3;
        }// end function

    }
}
