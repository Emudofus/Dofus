package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LeaveDialogAction extends Object implements Action
    {

        public function LeaveDialogAction()
        {
            return;
        }// end function

        public static function create() : LeaveDialogAction
        {
            var _loc_1:* = new LeaveDialogAction;
            return _loc_1;
        }// end function

    }
}
