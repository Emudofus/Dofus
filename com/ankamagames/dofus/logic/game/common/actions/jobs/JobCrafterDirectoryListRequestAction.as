package com.ankamagames.dofus.logic.game.common.actions.jobs
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobCrafterDirectoryListRequestAction extends Object implements Action
   {
      
      public function JobCrafterDirectoryListRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : JobCrafterDirectoryListRequestAction {
         var _loc2_:JobCrafterDirectoryListRequestAction = new JobCrafterDirectoryListRequestAction();
         _loc2_.jobId = param1;
         return _loc2_;
      }
      
      public var jobId:uint;
   }
}
