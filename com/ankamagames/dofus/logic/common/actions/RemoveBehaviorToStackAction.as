package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class RemoveBehaviorToStackAction implements Action 
    {

        public var behavior:String;


        public function create(name:String):RemoveBehaviorToStackAction
        {
            var s:RemoveBehaviorToStackAction = new RemoveBehaviorToStackAction();
            s.behavior = name;
            return (s);
        }


    }
}//package com.ankamagames.dofus.logic.common.actions

