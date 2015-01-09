package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.internalDatacenter.jobs.KnownJob;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
    import com.ankamagames.dofus.network.enums.CrafterDirectoryParamBitEnum;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
    import com.ankamagames.jerakine.types.enums.Priority;
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
    import com.ankamagames.jerakine.messages.Message;

    public class JobsFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(JobsFrame));

        private var _jobCrafterDirectoryListDialogFrame:JobCrafterDirectoryListDialogFrame;
        private var _settings:Array = null;


        private static function updateJobExperience(je:JobExperience):void
        {
            var kj:KnownJob = PlayedCharacterManager.getInstance().jobs[je.jobId];
            if (!(kj))
            {
                kj = new KnownJob();
                PlayedCharacterManager.getInstance().jobs[je.jobId] = kj;
            };
            kj.jobExperience = je;
        }

        private static function updateJob(pJobId:uint, pJobDescription:JobDescription):void
        {
            var kj:KnownJob = PlayedCharacterManager.getInstance().jobs[pJobId];
            kj.jobDescription = pJobDescription;
        }

        private static function createCrafterDirectorySettings(settings:JobCrafterDirectorySettings):Object
        {
            var obj:Object = new Object();
            obj.jobId = settings.jobId;
            obj.minSlots = settings.minSlot;
            obj.notFree = !(((settings.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE) == 0));
            obj.notFreeExceptOnFail = !(((settings.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL) == 0));
            obj.resourcesRequired = !(((settings.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED) == 0));
            return (obj);
        }


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get settings():Array
        {
            return (this._settings);
        }

        public function pushed():Boolean
        {
            this._jobCrafterDirectoryListDialogFrame = new JobCrafterDirectoryListDialogFrame();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:JobDescriptionMessage;
            var _local_3:int;
            var _local_4:JobCrafterDirectorySettingsMessage;
            var _local_5:JobCrafterDirectoryDefineSettingsAction;
            var _local_6:JobCrafterDirectoryDefineSettingsMessage;
            var _local_7:JobExperienceUpdateMessage;
            var _local_8:JobExperienceMultiUpdateMessage;
            var _local_9:JobUnlearntMessage;
            var _local_10:JobLevelUpMessage;
            var _local_11:String;
            var _local_12:String;
            var _local_13:JobListedUpdateMessage;
            var _local_14:String;
            var _local_15:Job;
            var _local_16:JobCrafterDirectoryListRequestAction;
            var _local_17:JobCrafterDirectoryListRequestMessage;
            var _local_18:JobCrafterDirectoryEntryRequestAction;
            var _local_19:JobCrafterDirectoryEntryRequestMessage;
            var _local_20:JobCrafterContactLookRequestAction;
            var _local_21:ExchangeStartOkJobIndexMessage;
            var _local_22:Array;
            var jd:JobDescription;
            var kj:KnownJob;
            var setting:JobCrafterDirectorySettings;
            var je:JobExperience;
            var _local_27:ContactLookRequestByIdMessage;
            var esojijob:uint;
            switch (true)
            {
                case (msg is JobDescriptionMessage):
                    _local_2 = (msg as JobDescriptionMessage);
                    PlayedCharacterManager.getInstance().jobs = [];
                    _local_3 = 0;
                    for each (jd in _local_2.jobsDescription)
                    {
                        kj = PlayedCharacterManager.getInstance().jobs[jd.jobId];
                        if (!(kj))
                        {
                            kj = new KnownJob();
                            PlayedCharacterManager.getInstance().jobs[jd.jobId] = kj;
                        };
                        kj.jobDescription = jd;
                        kj.jobPosition = _local_3;
                        _local_3++;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
                    return (true);
                case (msg is JobCrafterDirectorySettingsMessage):
                    _local_4 = (msg as JobCrafterDirectorySettingsMessage);
                    this._settings = new Array();
                    for each (setting in _local_4.craftersSettings)
                    {
                        this._settings.push(createCrafterDirectorySettings(setting));
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectorySettings, this._settings);
                    return (true);
                case (msg is JobCrafterDirectoryDefineSettingsAction):
                    _local_5 = (msg as JobCrafterDirectoryDefineSettingsAction);
                    _local_6 = new JobCrafterDirectoryDefineSettingsMessage();
                    _local_6.initJobCrafterDirectoryDefineSettingsMessage(_local_5.settings);
                    ConnectionsHandler.getConnection().send(_local_6);
                    return (true);
                case (msg is JobExperienceUpdateMessage):
                    _local_7 = (msg as JobExperienceUpdateMessage);
                    updateJobExperience(_local_7.experiencesUpdate);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated, _local_7.experiencesUpdate.jobId);
                    return (true);
                case (msg is JobExperienceMultiUpdateMessage):
                    _local_8 = (msg as JobExperienceMultiUpdateMessage);
                    for each (je in _local_8.experiencesUpdate)
                    {
                        updateJobExperience(je);
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated, 0);
                    return (true);
                case (msg is JobUnlearntMessage):
                    _local_9 = (msg as JobUnlearntMessage);
                    delete PlayedCharacterManager.getInstance().jobs[_local_9.jobId];
                    KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
                    return (true);
                case (msg is JobLevelUpMessage):
                    _local_10 = (msg as JobLevelUpMessage);
                    _local_11 = Job.getJobById(_local_10.jobsDescription.jobId).name;
                    _local_12 = I18n.getUiText("ui.craft.newJobLevel", [_local_11, _local_10.newLevel]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_12, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    updateJob(_local_10.jobsDescription.jobId, _local_10.jobsDescription);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobLevelUp, _local_11, _local_10.newLevel);
                    return (true);
                case (msg is JobListedUpdateMessage):
                    _local_13 = (msg as JobListedUpdateMessage);
                    _local_15 = Job.getJobById(_local_13.jobId);
                    if (_local_13.addedOrDeleted)
                    {
                        _local_14 = I18n.getUiText("ui.craft.referenceAdd", [_local_15.name]);
                    }
                    else
                    {
                        _local_14 = I18n.getUiText("ui.craft.referenceRemove", [_local_15.name]);
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is JobCrafterDirectoryListRequestAction):
                    _local_16 = (msg as JobCrafterDirectoryListRequestAction);
                    _local_17 = new JobCrafterDirectoryListRequestMessage();
                    _local_17.initJobCrafterDirectoryListRequestMessage(_local_16.jobId);
                    ConnectionsHandler.getConnection().send(_local_17);
                    return (true);
                case (msg is JobCrafterDirectoryEntryRequestAction):
                    _local_18 = (msg as JobCrafterDirectoryEntryRequestAction);
                    _local_19 = new JobCrafterDirectoryEntryRequestMessage();
                    _local_19.initJobCrafterDirectoryEntryRequestMessage(_local_18.playerId);
                    ConnectionsHandler.getConnection().send(_local_6);
                    return (true);
                case (msg is JobCrafterContactLookRequestAction):
                    _local_20 = (msg as JobCrafterContactLookRequestAction);
                    if (_local_20.crafterId == PlayedCharacterManager.getInstance().id)
                    {
                        KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook, _local_20.crafterId, PlayedCharacterManager.getInstance().infos.name, EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
                    }
                    else
                    {
                        _local_27 = new ContactLookRequestByIdMessage();
                        _local_27.initContactLookRequestByIdMessage(0, SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER, _local_20.crafterId);
                        ConnectionsHandler.getConnection().send(_local_27);
                    };
                    return (true);
                case (msg is ExchangeStartOkJobIndexMessage):
                    _local_21 = (msg as ExchangeStartOkJobIndexMessage);
                    _local_22 = new Array();
                    for each (esojijob in _local_21.jobs)
                    {
                        _local_22.push(esojijob);
                    };
                    Kernel.getWorker().addFrame(this._jobCrafterDirectoryListDialogFrame);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkJobIndex, _local_22);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

