package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeRefuseAction extends Object implements Action
    {

        public function ExchangeRefuseAction()
        {
            return;
        }// end function

        public static function create() : ExchangeRefuseAction
        {
            var _loc_1:* = new ExchangeRefuseAction;
            return _loc_1;
        }// end function

    }
}
