package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectTransfertAllToInvAction extends Object implements Action
    {

        public function ExchangeObjectTransfertAllToInvAction()
        {
            return;
        }// end function

        public static function create() : ExchangeObjectTransfertAllToInvAction
        {
            return new ExchangeObjectTransfertAllToInvAction;
        }// end function

    }
}
