package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeReadyAction extends Object implements Action
    {
        public var isReady:Boolean;

        public function ExchangeReadyAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : ExchangeReadyAction
        {
            var _loc_2:* = new ExchangeReadyAction;
            _loc_2.isReady = param1;
            return _loc_2;
        }// end function

    }
}
