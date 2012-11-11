package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectTransfertListFromInvAction extends Object implements Action
    {
        public var ids:Vector.<uint>;

        public function ExchangeObjectTransfertListFromInvAction()
        {
            return;
        }// end function

        public static function create(param1:Vector.<uint>) : ExchangeObjectTransfertListFromInvAction
        {
            var _loc_2:* = new ExchangeObjectTransfertListFromInvAction;
            _loc_2.ids = param1;
            return _loc_2;
        }// end function

    }
}
