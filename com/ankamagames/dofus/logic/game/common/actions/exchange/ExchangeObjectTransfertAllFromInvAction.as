package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectTransfertAllFromInvAction extends Object implements Action
    {

        public function ExchangeObjectTransfertAllFromInvAction()
        {
            return;
        }// end function

        public static function create() : ExchangeObjectTransfertAllFromInvAction
        {
            return new ExchangeObjectTransfertAllFromInvAction;
        }// end function

    }
}
