package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PrismFightSwapRequestAction extends Object implements Action
    {
        public var targetId:uint;

        public function PrismFightSwapRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : PrismFightSwapRequestAction
        {
            var _loc_2:* = new PrismFightSwapRequestAction;
            _loc_2.targetId = param1;
            return _loc_2;
        }// end function

    }
}
