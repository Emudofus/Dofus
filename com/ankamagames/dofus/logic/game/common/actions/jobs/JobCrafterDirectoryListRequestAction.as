package com.ankamagames.dofus.logic.game.common.actions.jobs
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobCrafterDirectoryListRequestAction extends Object implements Action
   {
      
      public function JobCrafterDirectoryListRequestAction() {
         super();
      }
      
      public static function create(jobId:uint) : JobCrafterDirectoryListRequestAction {
         var act:JobCrafterDirectoryListRequestAction = new JobCrafterDirectoryListRequestAction();
         act.jobId = jobId;
         return act;
      }
      
      public var jobId:uint;
   }
}
