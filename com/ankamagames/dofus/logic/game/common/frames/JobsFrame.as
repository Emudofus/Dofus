package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJob;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
   import com.ankamagames.dofus.network.enums.CrafterDirectoryParamBitEnum;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobDescriptionMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectorySettingsMessage;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryDefineSettingsAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryDefineSettingsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobExperienceUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobExperienceMultiUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobUnlearntMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobLevelUpMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobListedUpdateMessage;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryListRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryListRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryEntryRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryEntryRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterContactLookRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkJobIndexMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookRequestByIdMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.enums.SocialContactCategoryEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   
   public class JobsFrame extends Object implements Frame
   {
      
      public function JobsFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(JobsFrame));
      
      private static function updateJobExperience(param1:JobExperience) : void {
         var _loc2_:KnownJob = PlayedCharacterManager.getInstance().jobs[param1.jobId];
         if(!_loc2_)
         {
            _loc2_ = new KnownJob();
            PlayedCharacterManager.getInstance().jobs[param1.jobId] = _loc2_;
         }
         _loc2_.jobExperience = param1;
      }
      
      private static function updateJob(param1:uint, param2:JobDescription) : void {
         var _loc3_:KnownJob = PlayedCharacterManager.getInstance().jobs[param1];
         _loc3_.jobDescription = param2;
      }
      
      private static function createCrafterDirectorySettings(param1:JobCrafterDirectorySettings) : Object {
         var _loc2_:Object = new Object();
         _loc2_.jobId = param1.jobId;
         _loc2_.minSlots = param1.minSlot;
         _loc2_.notFree = !((param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE) == 0);
         _loc2_.notFreeExceptOnFail = !((param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL) == 0);
         _loc2_.resourcesRequired = !((param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED) == 0);
         return _loc2_;
      }
      
      private var _jobCrafterDirectoryListDialogFrame:JobCrafterDirectoryListDialogFrame;
      
      private var _settings:Array = null;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get settings() : Array {
         return this._settings;
      }
      
      public function pushed() : Boolean {
         this._jobCrafterDirectoryListDialogFrame = new JobCrafterDirectoryListDialogFrame();
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:JobDescriptionMessage = null;
         var _loc3_:* = 0;
         var _loc4_:JobCrafterDirectorySettingsMessage = null;
         var _loc5_:JobCrafterDirectoryDefineSettingsAction = null;
         var _loc6_:JobCrafterDirectoryDefineSettingsMessage = null;
         var _loc7_:JobExperienceUpdateMessage = null;
         var _loc8_:JobExperienceMultiUpdateMessage = null;
         var _loc9_:JobUnlearntMessage = null;
         var _loc10_:JobLevelUpMessage = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:JobListedUpdateMessage = null;
         var _loc14_:String = null;
         var _loc15_:Job = null;
         var _loc16_:JobCrafterDirectoryListRequestAction = null;
         var _loc17_:JobCrafterDirectoryListRequestMessage = null;
         var _loc18_:JobCrafterDirectoryEntryRequestAction = null;
         var _loc19_:JobCrafterDirectoryEntryRequestMessage = null;
         var _loc20_:JobCrafterContactLookRequestAction = null;
         var _loc21_:ExchangeStartOkJobIndexMessage = null;
         var _loc22_:Array = null;
         var _loc23_:JobDescription = null;
         var _loc24_:KnownJob = null;
         var _loc25_:JobCrafterDirectorySettings = null;
         var _loc26_:JobExperience = null;
         var _loc27_:ContactLookRequestByIdMessage = null;
         var _loc28_:uint = 0;
         switch(true)
         {
            case param1 is JobDescriptionMessage:
               _loc2_ = param1 as JobDescriptionMessage;
               PlayedCharacterManager.getInstance().jobs = [];
               _loc3_ = 0;
               for each (_loc23_ in _loc2_.jobsDescription)
               {
                  _loc24_ = PlayedCharacterManager.getInstance().jobs[_loc23_.jobId];
                  if(!_loc24_)
                  {
                     _loc24_ = new KnownJob();
                     PlayedCharacterManager.getInstance().jobs[_loc23_.jobId] = _loc24_;
                  }
                  _loc24_.jobDescription = _loc23_;
                  _loc24_.jobPosition = _loc3_;
                  _loc3_++;
               }
               KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
               return true;
            case param1 is JobCrafterDirectorySettingsMessage:
               _loc4_ = param1 as JobCrafterDirectorySettingsMessage;
               this._settings = new Array();
               for each (_loc25_ in _loc4_.craftersSettings)
               {
                  this._settings.push(createCrafterDirectorySettings(_loc25_));
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectorySettings,this._settings);
               return true;
            case param1 is JobCrafterDirectoryDefineSettingsAction:
               _loc5_ = param1 as JobCrafterDirectoryDefineSettingsAction;
               _loc6_ = new JobCrafterDirectoryDefineSettingsMessage();
               _loc6_.initJobCrafterDirectoryDefineSettingsMessage(_loc5_.settings);
               ConnectionsHandler.getConnection().send(_loc6_);
               return true;
            case param1 is JobExperienceUpdateMessage:
               _loc7_ = param1 as JobExperienceUpdateMessage;
               updateJobExperience(_loc7_.experiencesUpdate);
               KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated,_loc7_.experiencesUpdate.jobId);
               return true;
            case param1 is JobExperienceMultiUpdateMessage:
               _loc8_ = param1 as JobExperienceMultiUpdateMessage;
               for each (_loc26_ in _loc8_.experiencesUpdate)
               {
                  updateJobExperience(_loc26_);
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated,0);
               return true;
            case param1 is JobUnlearntMessage:
               _loc9_ = param1 as JobUnlearntMessage;
               delete PlayedCharacterManager.getInstance().jobs[[_loc9_.jobId]];
               KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
               return true;
            case param1 is JobLevelUpMessage:
               _loc10_ = param1 as JobLevelUpMessage;
               _loc11_ = Job.getJobById(_loc10_.jobsDescription.jobId).name;
               _loc12_ = I18n.getUiText("ui.craft.newJobLevel",[_loc11_,_loc10_.newLevel]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc12_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               updateJob(_loc10_.jobsDescription.jobId,_loc10_.jobsDescription);
               KernelEventsManager.getInstance().processCallback(CraftHookList.JobLevelUp,_loc11_,_loc10_.newLevel);
               return true;
            case param1 is JobListedUpdateMessage:
               _loc13_ = param1 as JobListedUpdateMessage;
               _loc15_ = Job.getJobById(_loc13_.jobId);
               if(_loc13_.addedOrDeleted)
               {
                  _loc14_ = I18n.getUiText("ui.craft.referenceAdd",[_loc15_.name]);
               }
               else
               {
                  _loc14_ = I18n.getUiText("ui.craft.referenceRemove",[_loc15_.name]);
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc14_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is JobCrafterDirectoryListRequestAction:
               _loc16_ = param1 as JobCrafterDirectoryListRequestAction;
               _loc17_ = new JobCrafterDirectoryListRequestMessage();
               _loc17_.initJobCrafterDirectoryListRequestMessage(_loc16_.jobId);
               ConnectionsHandler.getConnection().send(_loc17_);
               return true;
            case param1 is JobCrafterDirectoryEntryRequestAction:
               _loc18_ = param1 as JobCrafterDirectoryEntryRequestAction;
               _loc19_ = new JobCrafterDirectoryEntryRequestMessage();
               _loc19_.initJobCrafterDirectoryEntryRequestMessage(_loc18_.playerId);
               ConnectionsHandler.getConnection().send(_loc6_);
               return true;
            case param1 is JobCrafterContactLookRequestAction:
               _loc20_ = param1 as JobCrafterContactLookRequestAction;
               if(_loc20_.crafterId == PlayedCharacterManager.getInstance().id)
               {
                  KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook,_loc20_.crafterId,PlayedCharacterManager.getInstance().infos.name,EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
               }
               else
               {
                  _loc27_ = new ContactLookRequestByIdMessage();
                  _loc27_.initContactLookRequestByIdMessage(0,SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER,_loc20_.crafterId);
                  ConnectionsHandler.getConnection().send(_loc27_);
               }
               return true;
            case param1 is ExchangeStartOkJobIndexMessage:
               _loc21_ = param1 as ExchangeStartOkJobIndexMessage;
               _loc22_ = new Array();
               for each (_loc28_ in _loc21_.jobs)
               {
                  _loc22_.push(_loc28_);
               }
               Kernel.getWorker().addFrame(this._jobCrafterDirectoryListDialogFrame);
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkJobIndex,_loc22_);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
