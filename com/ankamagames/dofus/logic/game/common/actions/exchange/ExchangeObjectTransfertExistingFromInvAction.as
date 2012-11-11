package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectTransfertExistingFromInvAction extends Object implements Action
    {

        public function ExchangeObjectTransfertExistingFromInvAction()
        {
            return;
        }// end function

        public static function create() : ExchangeObjectTransfertExistingFromInvAction
        {
            return new ExchangeObjectTransfertExistingFromInvAction;
        }// end function

    }
}
