package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeRequestOnMountStockAction extends Object implements Action
    {

        public function ExchangeRequestOnMountStockAction()
        {
            return;
        }// end function

        public static function create() : ExchangeRequestOnMountStockAction
        {
            return new ExchangeRequestOnMountStockAction;
        }// end function

    }
}
