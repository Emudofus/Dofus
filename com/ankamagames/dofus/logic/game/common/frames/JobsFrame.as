package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.internalDatacenter.jobs.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.jobs.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.messages.game.social.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class JobsFrame extends Object implements Frame
    {
        private var _jobCrafterDirectoryListDialogFrame:JobCrafterDirectoryListDialogFrame;
        private var _settings:Array = null;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(JobsFrame));

        public function JobsFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get settings() : Array
        {
            return this._settings;
        }// end function

        public function pushed() : Boolean
        {
            this._jobCrafterDirectoryListDialogFrame = new JobCrafterDirectoryListDialogFrame();
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = 0;
            switch(true)
            {
                case param1 is JobDescriptionMessage:
                {
                    _loc_2 = param1 as JobDescriptionMessage;
                    PlayedCharacterManager.getInstance().jobs = [];
                    _loc_3 = 0;
                    for each (_loc_23 in _loc_2.jobsDescription)
                    {
                        
                        _loc_24 = PlayedCharacterManager.getInstance().jobs[_loc_23.jobId];
                        if (!_loc_24)
                        {
                            _loc_24 = new KnownJob();
                            PlayedCharacterManager.getInstance().jobs[_loc_23.jobId] = _loc_24;
                        }
                        _loc_24.jobDescription = _loc_23;
                        _loc_24.jobPosition = _loc_3;
                        _loc_3++;
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
                    return true;
                }
                case param1 is JobCrafterDirectorySettingsMessage:
                {
                    _loc_4 = param1 as JobCrafterDirectorySettingsMessage;
                    this._settings = new Array();
                    for each (_loc_25 in _loc_4.craftersSettings)
                    {
                        
                        this._settings.push(createCrafterDirectorySettings(_loc_25));
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectorySettings, this._settings);
                    return true;
                }
                case param1 is JobCrafterDirectoryDefineSettingsAction:
                {
                    _loc_5 = param1 as JobCrafterDirectoryDefineSettingsAction;
                    _loc_6 = new JobCrafterDirectoryDefineSettingsMessage();
                    _loc_6.initJobCrafterDirectoryDefineSettingsMessage(_loc_5.settings);
                    ConnectionsHandler.getConnection().send(_loc_6);
                    return true;
                }
                case param1 is JobExperienceUpdateMessage:
                {
                    _loc_7 = param1 as JobExperienceUpdateMessage;
                    updateJobExperience(_loc_7.experiencesUpdate);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated, _loc_7.experiencesUpdate.jobId);
                    return true;
                }
                case param1 is JobExperienceMultiUpdateMessage:
                {
                    _loc_8 = param1 as JobExperienceMultiUpdateMessage;
                    for each (_loc_26 in _loc_8.experiencesUpdate)
                    {
                        
                        updateJobExperience(_loc_26);
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated, 0);
                    return true;
                }
                case param1 is JobUnlearntMessage:
                {
                    _loc_9 = param1 as JobUnlearntMessage;
                    delete PlayedCharacterManager.getInstance().jobs[_loc_9.jobId];
                    KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
                    return true;
                }
                case param1 is JobLevelUpMessage:
                {
                    _loc_10 = param1 as JobLevelUpMessage;
                    _loc_11 = Job.getJobById(_loc_10.jobsDescription.jobId).name;
                    _loc_12 = I18n.getUiText("ui.craft.newJobLevel", [_loc_11, _loc_10.newLevel]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_12, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    updateJob(_loc_10.jobsDescription.jobId, _loc_10.jobsDescription);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobLevelUp, _loc_11, _loc_10.newLevel);
                    return true;
                }
                case param1 is JobListedUpdateMessage:
                {
                    _loc_13 = param1 as JobListedUpdateMessage;
                    _loc_15 = Job.getJobById(_loc_13.jobId);
                    if (_loc_13.addedOrDeleted)
                    {
                        _loc_14 = I18n.getUiText("ui.craft.referenceAdd", [_loc_15.name]);
                    }
                    else
                    {
                        _loc_14 = I18n.getUiText("ui.craft.referenceRemove", [_loc_15.name]);
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is JobCrafterDirectoryListRequestAction:
                {
                    _loc_16 = param1 as JobCrafterDirectoryListRequestAction;
                    _loc_17 = new JobCrafterDirectoryListRequestMessage();
                    _loc_17.initJobCrafterDirectoryListRequestMessage(_loc_16.jobId);
                    ConnectionsHandler.getConnection().send(_loc_17);
                    return true;
                }
                case param1 is JobCrafterDirectoryEntryRequestAction:
                {
                    _loc_18 = param1 as JobCrafterDirectoryEntryRequestAction;
                    _loc_19 = new JobCrafterDirectoryEntryRequestMessage();
                    _loc_19.initJobCrafterDirectoryEntryRequestMessage(_loc_18.playerId);
                    ConnectionsHandler.getConnection().send(_loc_6);
                    return true;
                }
                case param1 is JobCrafterContactLookRequestAction:
                {
                    _loc_20 = param1 as JobCrafterContactLookRequestAction;
                    if (_loc_20.crafterId == PlayedCharacterManager.getInstance().infos.id)
                    {
                        KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook, _loc_20.crafterId, PlayedCharacterManager.getInstance().infos.name, EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
                    }
                    else
                    {
                        _loc_27 = new ContactLookRequestByIdMessage();
                        _loc_27.initContactLookRequestByIdMessage(0, SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER, _loc_20.crafterId);
                        ConnectionsHandler.getConnection().send(_loc_27);
                    }
                    return true;
                }
                case param1 is ExchangeStartOkJobIndexMessage:
                {
                    _loc_21 = param1 as ExchangeStartOkJobIndexMessage;
                    _loc_22 = new Array();
                    for each (_loc_28 in _loc_21.jobs)
                    {
                        
                        _loc_22.push(_loc_28);
                    }
                    Kernel.getWorker().addFrame(this._jobCrafterDirectoryListDialogFrame);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkJobIndex, _loc_22);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        private static function updateJobExperience(param1:JobExperience) : void
        {
            var _loc_2:* = PlayedCharacterManager.getInstance().jobs[param1.jobId];
            if (!_loc_2)
            {
                _loc_2 = new KnownJob();
                PlayedCharacterManager.getInstance().jobs[param1.jobId] = _loc_2;
            }
            _loc_2.jobExperience = param1;
            return;
        }// end function

        private static function updateJob(param1:uint, param2:JobDescription) : void
        {
            var _loc_3:* = PlayedCharacterManager.getInstance().jobs[param1];
            _loc_3.jobDescription = param2;
            return;
        }// end function

        private static function createCrafterDirectorySettings(param1:JobCrafterDirectorySettings) : Object
        {
            var _loc_2:* = new Object();
            _loc_2.jobId = param1.jobId;
            _loc_2.minSlots = param1.minSlot;
            _loc_2.notFree = (param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE) != 0;
            _loc_2.notFreeExceptOnFail = (param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL) != 0;
            _loc_2.resourcesRequired = (param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED) != 0;
            return _loc_2;
        }// end function

    }
}
