package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class RemoveBehaviorToStackAction extends Object implements Action
    {
        public var behavior:String;

        public function RemoveBehaviorToStackAction()
        {
            return;
        }// end function

        public function create(param1:String) : RemoveBehaviorToStackAction
        {
            var _loc_2:* = new RemoveBehaviorToStackAction();
            _loc_2.behavior = param1;
            return _loc_2;
        }// end function

    }
}
