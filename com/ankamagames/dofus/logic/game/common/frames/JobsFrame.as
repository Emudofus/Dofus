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
      
      private static function updateJobExperience(je:JobExperience) : void {
         var kj:KnownJob = PlayedCharacterManager.getInstance().jobs[je.jobId];
         if(!kj)
         {
            kj = new KnownJob();
            PlayedCharacterManager.getInstance().jobs[je.jobId] = kj;
         }
         kj.jobExperience = je;
      }
      
      private static function updateJob(pJobId:uint, pJobDescription:JobDescription) : void {
         var kj:KnownJob = PlayedCharacterManager.getInstance().jobs[pJobId];
         kj.jobDescription = pJobDescription;
      }
      
      private static function createCrafterDirectorySettings(settings:JobCrafterDirectorySettings) : Object {
         var obj:Object = new Object();
         obj.jobId = settings.jobId;
         obj.minSlots = settings.minSlot;
         obj.notFree = !((settings.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE) == 0);
         obj.notFreeExceptOnFail = !((settings.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL) == 0);
         obj.resourcesRequired = !((settings.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED) == 0);
         return obj;
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
      
      public function process(msg:Message) : Boolean {
         var jdmsg:JobDescriptionMessage = null;
         var n:* = 0;
         var jcdsmsg:JobCrafterDirectorySettingsMessage = null;
         var jcddsa:JobCrafterDirectoryDefineSettingsAction = null;
         var jcddsmsg:JobCrafterDirectoryDefineSettingsMessage = null;
         var jeumsg:JobExperienceUpdateMessage = null;
         var jemumsg:JobExperienceMultiUpdateMessage = null;
         var julmsg:JobUnlearntMessage = null;
         var jlumsg:JobLevelUpMessage = null;
         var jobName:String = null;
         var levelUpTextMessage:String = null;
         var jldumsg:JobListedUpdateMessage = null;
         var text:String = null;
         var job:Job = null;
         var jcdlra:JobCrafterDirectoryListRequestAction = null;
         var jcdlrmsg:JobCrafterDirectoryListRequestMessage = null;
         var jcdera:JobCrafterDirectoryEntryRequestAction = null;
         var jcdermsg:JobCrafterDirectoryEntryRequestMessage = null;
         var jcclra:JobCrafterContactLookRequestAction = null;
         var esokimsg:ExchangeStartOkJobIndexMessage = null;
         var array:Array = null;
         var jd:JobDescription = null;
         var kj:KnownJob = null;
         var setting:JobCrafterDirectorySettings = null;
         var je:JobExperience = null;
         var clrbimsg:ContactLookRequestByIdMessage = null;
         var esojijob:uint = 0;
         switch(true)
         {
            case msg is JobDescriptionMessage:
               jdmsg = msg as JobDescriptionMessage;
               PlayedCharacterManager.getInstance().jobs = [];
               n = 0;
               for each (jd in jdmsg.jobsDescription)
               {
                  kj = PlayedCharacterManager.getInstance().jobs[jd.jobId];
                  if(!kj)
                  {
                     kj = new KnownJob();
                     PlayedCharacterManager.getInstance().jobs[jd.jobId] = kj;
                  }
                  kj.jobDescription = jd;
                  kj.jobPosition = n;
                  n++;
               }
               KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
               return true;
            case msg is JobCrafterDirectorySettingsMessage:
               jcdsmsg = msg as JobCrafterDirectorySettingsMessage;
               this._settings = new Array();
               for each (setting in jcdsmsg.craftersSettings)
               {
                  this._settings.push(createCrafterDirectorySettings(setting));
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectorySettings,this._settings);
               return true;
            case msg is JobCrafterDirectoryDefineSettingsAction:
               jcddsa = msg as JobCrafterDirectoryDefineSettingsAction;
               jcddsmsg = new JobCrafterDirectoryDefineSettingsMessage();
               jcddsmsg.initJobCrafterDirectoryDefineSettingsMessage(jcddsa.settings);
               ConnectionsHandler.getConnection().send(jcddsmsg);
               return true;
            case msg is JobExperienceUpdateMessage:
               jeumsg = msg as JobExperienceUpdateMessage;
               updateJobExperience(jeumsg.experiencesUpdate);
               KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated,jeumsg.experiencesUpdate.jobId);
               return true;
            case msg is JobExperienceMultiUpdateMessage:
               jemumsg = msg as JobExperienceMultiUpdateMessage;
               for each (je in jemumsg.experiencesUpdate)
               {
                  updateJobExperience(je);
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated,0);
               return true;
            case msg is JobUnlearntMessage:
               julmsg = msg as JobUnlearntMessage;
               delete PlayedCharacterManager.getInstance().jobs[[julmsg.jobId]];
               KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
               return true;
            case msg is JobLevelUpMessage:
               jlumsg = msg as JobLevelUpMessage;
               jobName = Job.getJobById(jlumsg.jobsDescription.jobId).name;
               levelUpTextMessage = I18n.getUiText("ui.craft.newJobLevel",[jobName,jlumsg.newLevel]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,levelUpTextMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               updateJob(jlumsg.jobsDescription.jobId,jlumsg.jobsDescription);
               KernelEventsManager.getInstance().processCallback(CraftHookList.JobLevelUp,jobName,jlumsg.newLevel);
               return true;
            case msg is JobListedUpdateMessage:
               jldumsg = msg as JobListedUpdateMessage;
               job = Job.getJobById(jldumsg.jobId);
               if(jldumsg.addedOrDeleted)
               {
                  text = I18n.getUiText("ui.craft.referenceAdd",[job.name]);
               }
               else
               {
                  text = I18n.getUiText("ui.craft.referenceRemove",[job.name]);
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is JobCrafterDirectoryListRequestAction:
               jcdlra = msg as JobCrafterDirectoryListRequestAction;
               jcdlrmsg = new JobCrafterDirectoryListRequestMessage();
               jcdlrmsg.initJobCrafterDirectoryListRequestMessage(jcdlra.jobId);
               ConnectionsHandler.getConnection().send(jcdlrmsg);
               return true;
            case msg is JobCrafterDirectoryEntryRequestAction:
               jcdera = msg as JobCrafterDirectoryEntryRequestAction;
               jcdermsg = new JobCrafterDirectoryEntryRequestMessage();
               jcdermsg.initJobCrafterDirectoryEntryRequestMessage(jcdera.playerId);
               ConnectionsHandler.getConnection().send(jcddsmsg);
               return true;
            case msg is JobCrafterContactLookRequestAction:
               jcclra = msg as JobCrafterContactLookRequestAction;
               if(jcclra.crafterId == PlayedCharacterManager.getInstance().id)
               {
                  KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook,jcclra.crafterId,PlayedCharacterManager.getInstance().infos.name,EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
               }
               else
               {
                  clrbimsg = new ContactLookRequestByIdMessage();
                  clrbimsg.initContactLookRequestByIdMessage(0,SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER,jcclra.crafterId);
                  ConnectionsHandler.getConnection().send(clrbimsg);
               }
               return true;
            case msg is ExchangeStartOkJobIndexMessage:
               esokimsg = msg as ExchangeStartOkJobIndexMessage;
               array = new Array();
               for each (esojijob in esokimsg.jobs)
               {
                  array.push(esojijob);
               }
               Kernel.getWorker().addFrame(this._jobCrafterDirectoryListDialogFrame);
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkJobIndex,array);
               return true;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
