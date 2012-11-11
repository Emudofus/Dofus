package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectTransfertExistingToInvAction extends Object implements Action
    {

        public function ExchangeObjectTransfertExistingToInvAction()
        {
            return;
        }// end function

        public static function create() : ExchangeObjectTransfertExistingToInvAction
        {
            return new ExchangeObjectTransfertExistingToInvAction;
        }// end function

    }
}
