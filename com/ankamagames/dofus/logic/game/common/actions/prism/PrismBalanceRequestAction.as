package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PrismBalanceRequestAction extends Object implements Action
    {

        public function PrismBalanceRequestAction()
        {
            return;
        }// end function

        public static function create() : PrismBalanceRequestAction
        {
            var _loc_1:* = new PrismBalanceRequestAction;
            return _loc_1;
        }// end function

    }
}
