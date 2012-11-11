package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PrismWorldInformationRequestAction extends Object implements Action
    {
        public var join:Boolean;

        public function PrismWorldInformationRequestAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : PrismWorldInformationRequestAction
        {
            var _loc_2:* = new PrismWorldInformationRequestAction;
            _loc_2.join = param1;
            return _loc_2;
        }// end function

    }
}
