package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class NotificationUpdateFlagAction extends Object implements Action
    {
        public var index:uint;

        public function NotificationUpdateFlagAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : NotificationUpdateFlagAction
        {
            var _loc_2:* = new NotificationUpdateFlagAction;
            _loc_2.index = param1;
            return _loc_2;
        }// end function

    }
}
