package com.ankamagames.dofus.logic.game.common.actions.jobs
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class JobCrafterDirectoryListRequestAction implements Action 
    {

        public var jobId:uint;


        public static function create(jobId:uint):JobCrafterDirectoryListRequestAction
        {
            var act:JobCrafterDirectoryListRequestAction = new (JobCrafterDirectoryListRequestAction)();
            act.jobId = jobId;
            return (act);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.jobs

