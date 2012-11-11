package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LeaveExchangeMountAction extends Object implements Action
    {

        public function LeaveExchangeMountAction()
        {
            return;
        }// end function

        public static function create() : LeaveExchangeMountAction
        {
            return new LeaveExchangeMountAction;
        }// end function

    }
}
