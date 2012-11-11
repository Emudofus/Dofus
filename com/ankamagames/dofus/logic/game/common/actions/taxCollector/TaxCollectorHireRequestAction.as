package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TaxCollectorHireRequestAction extends Object implements Action
    {

        public function TaxCollectorHireRequestAction()
        {
            return;
        }// end function

        public static function create() : TaxCollectorHireRequestAction
        {
            var _loc_1:* = new TaxCollectorHireRequestAction;
            return _loc_1;
        }// end function

    }
}
