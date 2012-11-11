package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class NotificationResetAction extends Object implements Action
    {

        public function NotificationResetAction()
        {
            return;
        }// end function

        public static function create() : NotificationResetAction
        {
            var _loc_1:* = new NotificationResetAction;
            return _loc_1;
        }// end function

    }
}
