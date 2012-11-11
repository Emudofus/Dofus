package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChangeWorldInteractionAction extends Object implements Action
    {
        public var enabled:Boolean;
        public var total:Boolean;

        public function ChangeWorldInteractionAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean, param2:Boolean = true) : ChangeWorldInteractionAction
        {
            var _loc_3:* = new ChangeWorldInteractionAction;
            _loc_3.enabled = param1;
            _loc_3.total = param2;
            return _loc_3;
        }// end function

    }
}
