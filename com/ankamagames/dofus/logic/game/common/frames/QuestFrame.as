package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.quest.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.achievement.*;
    import com.ankamagames.dofus.network.messages.game.context.notification.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.*;
    import com.ankamagames.dofus.network.types.game.achievement.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class QuestFrame extends Object implements Frame
    {
        private var _nbAllAchievements:int;
        private var _activeQuests:Vector.<QuestActiveInformations>;
        private var _completedQuests:Vector.<uint>;
        private var _questsInformations:Dictionary;
        private var _finishedAchievementsIds:Vector.<uint>;
        private var _rewardableAchievements:Vector.<AchievementRewardable>;
        private var _rewardableAchievementsVisible:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestFrame));
        public static var notificationList:Array;

        public function QuestFrame()
        {
            this._questsInformations = new Dictionary();
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get finishedAchievementsIds() : Vector.<uint>
        {
            return this._finishedAchievementsIds;
        }// end function

        public function getActiveQuests() : Vector.<QuestActiveInformations>
        {
            return this._activeQuests;
        }// end function

        public function getCompletedQuests() : Vector.<uint>
        {
            return this._completedQuests;
        }// end function

        public function getQuestInformations(param1:uint) : Object
        {
            return this._questsInformations[param1];
        }// end function

        public function get rewardableAchievements() : Vector.<AchievementRewardable>
        {
            return this._rewardableAchievements;
        }// end function

        public function pushed() : Boolean
        {
            this._rewardableAchievements = new Vector.<AchievementRewardable>;
            this._finishedAchievementsIds = new Vector.<uint>;
            this._nbAllAchievements = Achievement.getAchievements().length;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
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
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = 0;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = null;
            var _loc_40:* = 0;
            var _loc_41:* = null;
            var _loc_42:* = null;
            var _loc_43:* = null;
            var _loc_44:* = null;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = 0;
            var _loc_48:* = 0;
            var _loc_49:* = 0;
            var _loc_50:* = null;
            var _loc_51:* = null;
            switch(true)
            {
                case param1 is QuestListRequestAction:
                {
                    _loc_2 = new QuestListRequestMessage();
                    _loc_2.initQuestListRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_2);
                    return true;
                }
                case param1 is QuestListMessage:
                {
                    _loc_3 = param1 as QuestListMessage;
                    this._activeQuests = _loc_3.activeQuests;
                    this._completedQuests = _loc_3.finishedQuestsIds;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestListUpdated);
                    return true;
                }
                case param1 is QuestInfosRequestAction:
                {
                    _loc_4 = param1 as QuestInfosRequestAction;
                    _loc_5 = new QuestStepInfoRequestMessage();
                    _loc_5.initQuestStepInfoRequestMessage(_loc_4.questId);
                    ConnectionsHandler.getConnection().send(_loc_5);
                    return true;
                }
                case param1 is QuestStepInfoMessage:
                {
                    _loc_6 = param1 as QuestStepInfoMessage;
                    if (_loc_6.infos is QuestActiveDetailedInformations)
                    {
                        _loc_42 = _loc_6.infos as QuestActiveDetailedInformations;
                        this._questsInformations[_loc_42.questId] = {questId:_loc_42.questId, stepId:_loc_42.stepId};
                        this._questsInformations[_loc_42.questId].objectives = new Array();
                        this._questsInformations[_loc_42.questId].objectivesData = new Array();
                        for each (_loc_43 in _loc_42.objectives)
                        {
                            
                            this._questsInformations[_loc_42.questId].objectives[_loc_43.objectiveId] = _loc_43.objectiveStatus;
                            if (_loc_43 is QuestObjectiveInformationsWithCompletion)
                            {
                                _loc_44 = new Object();
                                _loc_44.current = (_loc_43 as QuestObjectiveInformationsWithCompletion).curCompletion;
                                _loc_44.max = (_loc_43 as QuestObjectiveInformationsWithCompletion).maxCompletion;
                                this._questsInformations[_loc_42.questId].objectivesData[_loc_43.objectiveId] = _loc_44;
                            }
                        }
                        KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated, _loc_42.questId, true);
                    }
                    else if (_loc_6.infos is QuestActiveInformations)
                    {
                        KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated, (_loc_6.infos as QuestActiveInformations).questId, false);
                    }
                    return true;
                }
                case param1 is QuestStartRequestAction:
                {
                    _loc_7 = param1 as QuestStartRequestAction;
                    _loc_8 = new QuestStartRequestMessage();
                    _loc_8.initQuestStartRequestMessage(_loc_7.questId);
                    ConnectionsHandler.getConnection().send(_loc_8);
                    return true;
                }
                case param1 is QuestObjectiveValidationAction:
                {
                    _loc_9 = param1 as QuestObjectiveValidationAction;
                    _loc_10 = new QuestObjectiveValidationMessage();
                    _loc_10.initQuestObjectiveValidationMessage(_loc_9.questId, _loc_9.objectiveId);
                    ConnectionsHandler.getConnection().send(_loc_10);
                    return true;
                }
                case param1 is GuidedModeReturnRequestAction:
                {
                    _loc_11 = new GuidedModeReturnRequestMessage();
                    _loc_11.initGuidedModeReturnRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_11);
                    return true;
                }
                case param1 is GuidedModeQuitRequestAction:
                {
                    _loc_12 = new GuidedModeQuitRequestMessage();
                    _loc_12.initGuidedModeQuitRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_12);
                    return true;
                }
                case param1 is QuestStartedMessage:
                {
                    _loc_13 = param1 as QuestStartedMessage;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStarted, _loc_13.questId);
                    return true;
                }
                case param1 is QuestValidatedMessage:
                {
                    _loc_14 = param1 as QuestValidatedMessage;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestValidated, _loc_14.questId);
                    this._completedQuests.push(_loc_14.questId);
                    for each (_loc_45 in this._activeQuests)
                    {
                        
                        if (_loc_45.questId == _loc_14.questId)
                        {
                            break;
                        }
                        _loc_15++;
                    }
                    this._activeQuests.splice(_loc_15, 1);
                    _loc_16 = Quest.getQuestById(_loc_14.questId);
                    for each (_loc_46 in _loc_16.steps)
                    {
                        
                        for each (_loc_47 in _loc_46.objectiveIds)
                        {
                            
                            KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, "flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc_14.questId + "_" + _loc_47);
                        }
                    }
                    return true;
                }
                case param1 is QuestObjectiveValidatedMessage:
                {
                    _loc_17 = param1 as QuestObjectiveValidatedMessage;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestObjectiveValidated, _loc_17.questId, _loc_17.objectiveId);
                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, "flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc_17.questId + "_" + _loc_17.objectiveId);
                    return true;
                }
                case param1 is QuestStepValidatedMessage:
                {
                    _loc_18 = param1 as QuestStepValidatedMessage;
                    if (this._questsInformations[_loc_18.questId])
                    {
                        this._questsInformations[_loc_18.questId].stepId = _loc_18.stepId;
                    }
                    _loc_19 = QuestStep.getQuestStepById(_loc_18.stepId).objectiveIds;
                    for each (_loc_48 in _loc_19)
                    {
                        
                        KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, "flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc_18.questId + "_" + _loc_48);
                    }
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepValidated, _loc_18.questId, _loc_18.stepId);
                    return true;
                }
                case param1 is QuestStepStartedMessage:
                {
                    _loc_20 = param1 as QuestStepStartedMessage;
                    if (this._questsInformations[_loc_20.questId])
                    {
                        this._questsInformations[_loc_20.questId].stepId = _loc_20.stepId;
                    }
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepStarted, _loc_20.questId, _loc_20.stepId);
                    return true;
                }
                case param1 is NotificationUpdateFlagAction:
                {
                    _loc_21 = param1 as NotificationUpdateFlagAction;
                    _loc_22 = new NotificationUpdateFlagMessage();
                    _loc_22.initNotificationUpdateFlagMessage(_loc_21.index);
                    ConnectionsHandler.getConnection().send(_loc_22);
                    return true;
                }
                case param1 is NotificationResetAction:
                {
                    notificationList = new Array();
                    _loc_23 = new NotificationResetMessage();
                    _loc_23.initNotificationResetMessage();
                    ConnectionsHandler.getConnection().send(_loc_23);
                    KernelEventsManager.getInstance().processCallback(HookList.NotificationReset);
                    return true;
                }
                case param1 is AchievementListMessage:
                {
                    _loc_24 = param1 as AchievementListMessage;
                    this._finishedAchievementsIds = _loc_24.finishedAchievementsIds;
                    this._rewardableAchievements = _loc_24.rewardableAchievements;
                    for each (_loc_49 in this._finishedAchievementsIds)
                    {
                        
                        if (Achievement.getAchievementById(_loc_49))
                        {
                            _loc_25 = _loc_25 + Achievement.getAchievementById(_loc_49).points;
                            continue;
                        }
                        _log.warn("Succés " + _loc_49 + " non exporté");
                    }
                    for each (_loc_50 in this._rewardableAchievements)
                    {
                        
                        if (Achievement.getAchievementById(_loc_50.id))
                        {
                            _loc_25 = _loc_25 + Achievement.getAchievementById(_loc_50.id).points;
                            this._finishedAchievementsIds.push(_loc_50.id);
                            continue;
                        }
                        _log.warn("Succés " + _loc_50.id + " non exporté");
                    }
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementList, this._finishedAchievementsIds);
                    if (!this._rewardableAchievementsVisible && this._rewardableAchievements.length > 0)
                    {
                        this._rewardableAchievementsVisible = true;
                        KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible, this._rewardableAchievementsVisible);
                    }
                    PlayedCharacterManager.getInstance().achievementPercent = Math.floor(this._finishedAchievementsIds.length / this._nbAllAchievements * 100);
                    PlayedCharacterManager.getInstance().achievementPoints = _loc_25;
                    return true;
                }
                case param1 is AchievementDetailedListRequestAction:
                {
                    _loc_26 = param1 as AchievementDetailedListRequestAction;
                    _loc_27 = new AchievementDetailedListRequestMessage();
                    _loc_27.initAchievementDetailedListRequestMessage(_loc_26.categoryId);
                    ConnectionsHandler.getConnection().send(_loc_27);
                    return true;
                }
                case param1 is AchievementDetailedListMessage:
                {
                    _loc_28 = param1 as AchievementDetailedListMessage;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetailedList, _loc_28.finishedAchievements, _loc_28.startedAchievements);
                    return true;
                }
                case param1 is AchievementDetailsRequestAction:
                {
                    _loc_29 = param1 as AchievementDetailsRequestAction;
                    _loc_30 = new AchievementDetailsRequestMessage();
                    _loc_30.initAchievementDetailsRequestMessage(_loc_29.achievementId);
                    ConnectionsHandler.getConnection().send(_loc_30);
                    return true;
                }
                case param1 is AchievementDetailsMessage:
                {
                    _loc_31 = param1 as AchievementDetailsMessage;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetails, _loc_31.achievement);
                    return true;
                }
                case param1 is AchievementFinishedInformationMessage:
                {
                    _loc_32 = param1 as AchievementFinishedInformationMessage;
                    _loc_33 = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.characterUnlocksAchievement", ["{player," + _loc_32.name + "}"]), [_loc_32.name, _loc_32.id]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_33, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is AchievementFinishedMessage:
                {
                    _loc_34 = param1 as AchievementFinishedMessage;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementFinished, _loc_34.id);
                    this._finishedAchievementsIds.push(_loc_34.id);
                    _loc_35 = new AchievementRewardable();
                    this._rewardableAchievements.push(_loc_35.initAchievementRewardable(_loc_34.id, _loc_34.finishedlevel));
                    if (!this._rewardableAchievementsVisible)
                    {
                        this._rewardableAchievementsVisible = true;
                        KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible, this._rewardableAchievementsVisible);
                    }
                    _loc_36 = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.achievementUnlockWithLink"), [_loc_34.id]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_36, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    PlayedCharacterManager.getInstance().achievementPercent = Math.floor(this._finishedAchievementsIds.length / this._nbAllAchievements * 100);
                    PlayedCharacterManager.getInstance().achievementPoints = PlayedCharacterManager.getInstance().achievementPoints + Achievement.getAchievementById(_loc_34.id).points;
                    return true;
                }
                case param1 is AchievementRewardRequestAction:
                {
                    _loc_37 = param1 as AchievementRewardRequestAction;
                    _loc_38 = new AchievementRewardRequestMessage();
                    _loc_38.initAchievementRewardRequestMessage(_loc_37.achievementId);
                    ConnectionsHandler.getConnection().send(_loc_38);
                    return true;
                }
                case param1 is AchievementRewardSuccessMessage:
                {
                    _loc_39 = param1 as AchievementRewardSuccessMessage;
                    for each (_loc_51 in this._rewardableAchievements)
                    {
                        
                        if (_loc_51.id == _loc_39.achievementId)
                        {
                            _loc_40 = this._rewardableAchievements.indexOf(_loc_51);
                            break;
                        }
                    }
                    this._rewardableAchievements.splice(_loc_40, 1);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementRewardSuccess, _loc_39.achievementId);
                    if (this._rewardableAchievementsVisible && this._rewardableAchievements.length == 0)
                    {
                        this._rewardableAchievementsVisible = false;
                        KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible, this._rewardableAchievementsVisible);
                    }
                    return true;
                }
                case param1 is AchievementRewardErrorMessage:
                {
                    _loc_41 = param1 as AchievementRewardErrorMessage;
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

    }
}
