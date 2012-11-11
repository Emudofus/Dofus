package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ResetGameAction extends Object implements Action
    {
        public var messageToShow:String;

        public function ResetGameAction()
        {
            return;
        }// end function

        public static function create(param1:String = "") : ResetGameAction
        {
            var _loc_2:* = new ResetGameAction;
            _loc_2.messageToShow = param1;
            return _loc_2;
        }// end function

    }
}
