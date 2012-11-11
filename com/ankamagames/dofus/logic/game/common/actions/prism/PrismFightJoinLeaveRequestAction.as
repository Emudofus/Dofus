package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PrismFightJoinLeaveRequestAction extends Object implements Action
    {
        public var join:Boolean;

        public function PrismFightJoinLeaveRequestAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : PrismFightJoinLeaveRequestAction
        {
            var _loc_2:* = new PrismFightJoinLeaveRequestAction;
            _loc_2.join = param1;
            return _loc_2;
        }// end function

    }
}
