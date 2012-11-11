package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PrismInfoJoinLeaveRequestAction extends Object implements Action
    {
        public var join:Boolean;

        public function PrismInfoJoinLeaveRequestAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : PrismInfoJoinLeaveRequestAction
        {
            var _loc_2:* = new PrismInfoJoinLeaveRequestAction;
            _loc_2.join = param1;
            return _loc_2;
        }// end function

    }
}
