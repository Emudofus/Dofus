package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AddBehaviorToStackAction extends Object implements Action
    {
        public var behavior:Array;

        public function AddBehaviorToStackAction()
        {
            return;
        }// end function

        public static function create() : AddBehaviorToStackAction
        {
            var _loc_1:* = new AddBehaviorToStackAction;
            return _loc_1;
        }// end function

    }
}
