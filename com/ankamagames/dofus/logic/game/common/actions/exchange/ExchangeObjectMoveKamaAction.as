package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeObjectMoveKamaAction extends Object implements Action
    {
        public var kamas:uint;

        public function ExchangeObjectMoveKamaAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ExchangeObjectMoveKamaAction
        {
            var _loc_2:* = new ExchangeObjectMoveKamaAction;
            _loc_2.kamas = param1;
            return _loc_2;
        }// end function

    }
}
