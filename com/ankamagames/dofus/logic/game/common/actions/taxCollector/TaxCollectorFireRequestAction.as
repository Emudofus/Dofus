package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TaxCollectorFireRequestAction extends Object implements Action
    {
        public var taxCollectorId:uint;

        public function TaxCollectorFireRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : TaxCollectorFireRequestAction
        {
            var _loc_2:* = new TaxCollectorFireRequestAction;
            _loc_2.taxCollectorId = param1;
            return _loc_2;
        }// end function

    }
}
