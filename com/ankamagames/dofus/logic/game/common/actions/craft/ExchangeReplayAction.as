package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeReplayAction extends Object implements Action
    {
        public var count:int;

        public function ExchangeReplayAction()
        {
            return;
        }// end function

        public static function create(param1:int) : ExchangeReplayAction
        {
            var _loc_2:* = new ExchangeReplayAction;
            _loc_2.count = param1;
            return _loc_2;
        }// end function

    }
}
