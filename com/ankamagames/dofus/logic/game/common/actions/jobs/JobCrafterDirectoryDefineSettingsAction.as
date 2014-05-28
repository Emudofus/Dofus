package com.ankamagames.dofus.logic.game.common.actions.jobs
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJob;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.CrafterDirectoryParamBitEnum;
   
   public class JobCrafterDirectoryDefineSettingsAction extends Object implements Action
   {
      
      public function JobCrafterDirectoryDefineSettingsAction() {
         super();
      }
      
      public static function create(jobId:uint, minSlot:uint, notFree:Boolean, notFreeExceptOnFail:Boolean, resourcesRequired:Boolean) : JobCrafterDirectoryDefineSettingsAction {
         var job:KnownJob = null;
         var act:JobCrafterDirectoryDefineSettingsAction = new JobCrafterDirectoryDefineSettingsAction();
         act.jobId = jobId;
         act.minSlot = minSlot;
         act.notFree = notFree;
         act.notFreeExceptOnFail = notFreeExceptOnFail;
         act.resourcesRequired = resourcesRequired;
         act.settings = new JobCrafterDirectorySettings();
         var jobs:Array = PlayedCharacterManager.getInstance().jobs;
         var i:uint = 0;
         while(i < jobs.length)
         {
            job = jobs[i];
            if((job) && (job.jobDescription.jobId == jobId))
            {
               act.settings.initJobCrafterDirectorySettings(i,minSlot,(notFree?CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE:CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE) + (notFreeExceptOnFail?CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL:CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE) + (resourcesRequired?CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED:CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE));
            }
            i++;
         }
         return act;
      }
      
      public var jobId:uint;
      
      public var minSlot:uint;
      
      public var notFree:Boolean;
      
      public var notFreeExceptOnFail:Boolean;
      
      public var resourcesRequired:Boolean;
      
      public var settings:JobCrafterDirectorySettings;
   }
}
