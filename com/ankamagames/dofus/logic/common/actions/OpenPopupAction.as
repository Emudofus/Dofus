package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenPopupAction extends Object implements Action
    {
        public var messageToShow:String;

        public function OpenPopupAction()
        {
            return;
        }// end function

        public static function create(param1:String = "") : OpenPopupAction
        {
            var _loc_2:* = new OpenPopupAction;
            _loc_2.messageToShow = param1;
            return _loc_2;
        }// end function

    }
}
