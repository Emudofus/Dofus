package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeAcceptAction extends Object implements Action
    {

        public function ExchangeAcceptAction()
        {
            return;
        }// end function

        public static function create() : ExchangeAcceptAction
        {
            var _loc_1:* = new ExchangeAcceptAction;
            return _loc_1;
        }// end function

    }
}
