package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AddBehaviorToStackAction implements Action 
    {

        public var behavior:Array;

        public function AddBehaviorToStackAction(data:Array=null)
        {
            this.behavior = ((!((data == null))) ? data : new Array());
        }

        public static function create():AddBehaviorToStackAction
        {
            var s:AddBehaviorToStackAction = new (AddBehaviorToStackAction)(new Array());
            return (s);
        }


    }
}//package com.ankamagames.dofus.logic.common.actions

