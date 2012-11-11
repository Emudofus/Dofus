package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeReplayStopAction extends Object implements Action
    {

        public function ExchangeReplayStopAction()
        {
            return;
        }// end function

        public static function create() : ExchangeReplayStopAction
        {
            var _loc_1:* = new ExchangeReplayStopAction;
            return _loc_1;
        }// end function

    }
}
