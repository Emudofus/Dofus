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
      
      public static function create(param1:uint, param2:uint, param3:Boolean, param4:Boolean, param5:Boolean) : JobCrafterDirectoryDefineSettingsAction {
         var _loc9_:KnownJob = null;
         var _loc6_:JobCrafterDirectoryDefineSettingsAction = new JobCrafterDirectoryDefineSettingsAction();
         _loc6_.jobId = param1;
         _loc6_.minSlot = param2;
         _loc6_.notFree = param3;
         _loc6_.notFreeExceptOnFail = param4;
         _loc6_.resourcesRequired = param5;
         _loc6_.settings = new JobCrafterDirectorySettings();
         var _loc7_:Array = PlayedCharacterManager.getInstance().jobs;
         var _loc8_:uint = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_];
            if((_loc9_) && _loc9_.jobDescription.jobId == param1)
            {
               _loc6_.settings.initJobCrafterDirectorySettings(_loc8_,param2,(param3?CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE:CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE) + (param4?CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL:CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE) + (param5?CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED:CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE));
            }
            _loc8_++;
         }
         return _loc6_;
      }
      
      public var jobId:uint;
      
      public var minSlot:uint;
      
      public var notFree:Boolean;
      
      public var notFreeExceptOnFail:Boolean;
      
      public var resourcesRequired:Boolean;
      
      public var settings:JobCrafterDirectorySettings;
   }
}
