package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AddBehaviorToStackAction extends Object implements Action
    {
        public var behavior:Array;

        public function AddBehaviorToStackAction(param1:Array = null)
        {
            this.behavior = param1 != null ? (param1) : (new Array());
            return;
        }// end function

        public static function create() : AddBehaviorToStackAction
        {
            var _loc_1:* = new AddBehaviorToStackAction(new Array());
            return _loc_1;
        }// end function

    }
}
