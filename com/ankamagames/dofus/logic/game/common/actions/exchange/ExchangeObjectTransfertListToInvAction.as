package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectTransfertListToInvAction extends Object implements Action
    {
        public var ids:Vector.<uint>;

        public function ExchangeObjectTransfertListToInvAction()
        {
            return;
        }// end function

        public static function create(param1:Vector.<uint>) : ExchangeObjectTransfertListToInvAction
        {
            var _loc_2:* = new ExchangeObjectTransfertListToInvAction;
            _loc_2.ids = param1;
            return _loc_2;
        }// end function

    }
}
