package com.ankamagames.dofus.logic.game.common.actions.jobs
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class JobCrafterContactLookRequestAction extends Object implements Action
    {
        public var crafterId:uint;

        public function JobCrafterContactLookRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : JobCrafterContactLookRequestAction
        {
            var _loc_2:* = new JobCrafterContactLookRequestAction;
            _loc_2.crafterId = param1;
            return _loc_2;
        }// end function

    }
}
