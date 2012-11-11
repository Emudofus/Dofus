package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PrismUseRequestAction extends Object implements Action
    {

        public function PrismUseRequestAction()
        {
            return;
        }// end function

        public static function create() : PrismUseRequestAction
        {
            var _loc_1:* = new PrismUseRequestAction;
            return _loc_1;
        }// end function

    }
}
