package com.ankamagames.dofus.logic.game.common.actions.jobs
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class JobCrafterDirectoryListRequestAction extends Object implements Action
    {
        public var jobId:uint;

        public function JobCrafterDirectoryListRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : JobCrafterDirectoryListRequestAction
        {
            var _loc_2:* = new JobCrafterDirectoryListRequestAction;
            _loc_2.jobId = param1;
            return _loc_2;
        }// end function

    }
}
