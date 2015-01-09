package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementRewardable;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import com.ankamagames.dofus.network.enums.TreasureHuntFlagStateEnum;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestListRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestListMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.QuestInfosRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStepInfoRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStepInfoMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.QuestStartRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStartRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.QuestObjectiveValidationAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestObjectiveValidationMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.GuidedModeReturnRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.GuidedModeQuitRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStartedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestValidatedMessage;
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestObjectiveValidatedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStepValidatedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStepStartedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.NotificationUpdateFlagAction;
    import com.ankamagames.dofus.network.messages.game.context.notification.NotificationUpdateFlagMessage;
    import com.ankamagames.dofus.network.messages.game.context.notification.NotificationResetMessage;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementListMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailedListRequestAction;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementDetailedListRequestMessage;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementDetailedListMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailsRequestAction;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementDetailsRequestMessage;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementDetailsMessage;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementFinishedInformationMessage;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementFinishedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementRewardRequestAction;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementRewardRequestMessage;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementRewardSuccessMessage;
    import com.ankamagames.dofus.network.messages.game.achievement.AchievementRewardErrorMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntShowLegendaryUIMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntLegendaryRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntLegendaryRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntRequestAnswerMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntFlagRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntFlagRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntFlagRemoveRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntFlagRemoveRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntFlagRequestAnswerMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntMessage;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import com.ankamagames.dofus.internalDatacenter.quest.TreasureHuntWrapper;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntAvailableRetryCountUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntFinishedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntGiveUpRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntGiveUpRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntDigRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntDigRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntDigRequestAnswerMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveDetailedInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformations;
    import com.ankamagames.dofus.datacenter.quest.QuestStep;
    import com.ankamagames.dofus.internalDatacenter.quest.TreasureHuntStepWrapper;
    import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntFlag;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.common.actions.quest.QuestListRequestAction;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.QuestHookList;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformationsWithCompletion;
    import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeReturnRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeQuitRequestAction;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.network.enums.CompassTypeEnum;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.game.common.actions.NotificationResetAction;
    import com.ankamagames.dofus.misc.utils.ParamsDecoder;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.network.enums.TreasureHuntRequestEnum;
    import com.ankamagames.dofus.network.enums.TreasureHuntFlagRequestEnum;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntDigRequestAnswerFailedMessage;
    import com.ankamagames.dofus.network.enums.TreasureHuntDigRequestEnum;
    import com.ankamagames.dofus.network.enums.TreasureHuntTypeEnum;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.*;

    public class QuestFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestFrame));
        public static var notificationList:Array;

        private var _nbAllAchievements:int;
        private var _activeQuests:Vector.<QuestActiveInformations>;
        private var _completedQuests:Vector.<uint>;
        private var _questsInformations:Dictionary;
        private var _finishedAchievementsIds:Vector.<uint>;
        private var _rewardableAchievements:Vector.<AchievementRewardable>;
        private var _rewardableAchievementsVisible:Boolean;
        private var _treasureHunts:Dictionary;
        private var _flagColors:Array;

        public function QuestFrame()
        {
            this._questsInformations = new Dictionary();
            this._treasureHunts = new Dictionary();
            this._flagColors = new Array();
            super();
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get finishedAchievementsIds():Vector.<uint>
        {
            return (this._finishedAchievementsIds);
        }

        public function getActiveQuests():Vector.<QuestActiveInformations>
        {
            return (this._activeQuests);
        }

        public function getCompletedQuests():Vector.<uint>
        {
            return (this._completedQuests);
        }

        public function getQuestInformations(questId:uint):Object
        {
            return (this._questsInformations[questId]);
        }

        public function get rewardableAchievements():Vector.<AchievementRewardable>
        {
            return (this._rewardableAchievements);
        }

        public function getTreasureHuntById(typeId:uint):Object
        {
            return (this._treasureHunts[typeId]);
        }

        public function pushed():Boolean
        {
            this._rewardableAchievements = new Vector.<AchievementRewardable>();
            this._finishedAchievementsIds = new Vector.<uint>();
            this._treasureHunts = new Dictionary();
            this._nbAllAchievements = Achievement.getAchievements().length;
            this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_UNKNOWN] = 15636787;
            this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_OK] = 4521796;
            this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_WRONG] = 16729156;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:QuestListRequestMessage;
            var _local_3:QuestListMessage;
            var _local_4:QuestInfosRequestAction;
            var _local_5:QuestStepInfoRequestMessage;
            var _local_6:QuestStepInfoMessage;
            var _local_7:QuestStartRequestAction;
            var _local_8:QuestStartRequestMessage;
            var _local_9:QuestObjectiveValidationAction;
            var _local_10:QuestObjectiveValidationMessage;
            var _local_11:GuidedModeReturnRequestMessage;
            var _local_12:GuidedModeQuitRequestMessage;
            var _local_13:QuestStartedMessage;
            var _local_14:QuestValidatedMessage;
            var _local_15:Quest;
            var _local_16:QuestObjectiveValidatedMessage;
            var _local_17:QuestStepValidatedMessage;
            var _local_18:Object;
            var _local_19:QuestStepStartedMessage;
            var _local_20:NotificationUpdateFlagAction;
            var _local_21:NotificationUpdateFlagMessage;
            var _local_22:NotificationResetMessage;
            var _local_23:AchievementListMessage;
            var _local_24:int;
            var _local_25:AchievementDetailedListRequestAction;
            var _local_26:AchievementDetailedListRequestMessage;
            var _local_27:AchievementDetailedListMessage;
            var _local_28:AchievementDetailsRequestAction;
            var _local_29:AchievementDetailsRequestMessage;
            var _local_30:AchievementDetailsMessage;
            var _local_31:AchievementFinishedInformationMessage;
            var _local_32:String;
            var _local_33:AchievementFinishedMessage;
            var _local_34:AchievementRewardable;
            var _local_35:String;
            var _local_36:AchievementRewardRequestAction;
            var _local_37:AchievementRewardRequestMessage;
            var _local_38:AchievementRewardSuccessMessage;
            var _local_39:int;
            var _local_40:AchievementRewardErrorMessage;
            var _local_41:TreasureHuntShowLegendaryUIMessage;
            var _local_42:TreasureHuntRequestAction;
            var _local_43:TreasureHuntRequestMessage;
            var _local_44:TreasureHuntLegendaryRequestAction;
            var _local_45:TreasureHuntLegendaryRequestMessage;
            var _local_46:TreasureHuntRequestAnswerMessage;
            var _local_47:String;
            var _local_48:TreasureHuntFlagRequestAction;
            var _local_49:TreasureHuntFlagRequestMessage;
            var _local_50:TreasureHuntFlagRemoveRequestAction;
            var _local_51:TreasureHuntFlagRemoveRequestMessage;
            var _local_52:TreasureHuntFlagRequestAnswerMessage;
            var _local_53:String;
            var _local_54:TreasureHuntMessage;
            var _local_55:MapPosition;
            var _local_56:TreasureHuntWrapper;
            var _local_57:int;
            var _local_58:TreasureHuntAvailableRetryCountUpdateMessage;
            var _local_59:TreasureHuntFinishedMessage;
            var _local_60:TreasureHuntGiveUpRequestAction;
            var _local_61:TreasureHuntGiveUpRequestMessage;
            var _local_62:TreasureHuntDigRequestAction;
            var _local_63:TreasureHuntDigRequestMessage;
            var _local_64:TreasureHuntDigRequestAnswerMessage;
            var _local_65:int;
            var _local_66:String;
            var stepsInfos:QuestActiveDetailedInformations;
            var obj:QuestObjectiveInformations;
            var dialogParams:Array;
            var nbParams:int;
            var compl:Object;
            var _local_72:int;
            var _local_73:QuestActiveInformations;
            var step:QuestStep;
            var questStepObjId:int;
            var stepObjId:int;
            var finishAchId:int;
            var rewAch:AchievementRewardable;
            var achievementRewardable:AchievementRewardable;
            var j:int;
            var st:TreasureHuntStepWrapper;
            var fl:TreasureHuntFlag;
            switch (true)
            {
                case (msg is QuestListRequestAction):
                    _local_2 = new QuestListRequestMessage();
                    _local_2.initQuestListRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_2);
                    return (true);
                case (msg is QuestListMessage):
                    _local_3 = (msg as QuestListMessage);
                    this._activeQuests = _local_3.activeQuests;
                    this._completedQuests = _local_3.finishedQuestsIds;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestListUpdated);
                    return (true);
                case (msg is QuestInfosRequestAction):
                    _local_4 = (msg as QuestInfosRequestAction);
                    _local_5 = new QuestStepInfoRequestMessage();
                    _local_5.initQuestStepInfoRequestMessage(_local_4.questId);
                    ConnectionsHandler.getConnection().send(_local_5);
                    return (true);
                case (msg is QuestStepInfoMessage):
                    _local_6 = (msg as QuestStepInfoMessage);
                    if ((_local_6.infos is QuestActiveDetailedInformations))
                    {
                        stepsInfos = (_local_6.infos as QuestActiveDetailedInformations);
                        this._questsInformations[stepsInfos.questId] = {
                            "questId":stepsInfos.questId,
                            "stepId":stepsInfos.stepId
                        };
                        this._questsInformations[stepsInfos.questId].objectives = new Array();
                        this._questsInformations[stepsInfos.questId].objectivesData = new Array();
                        this._questsInformations[stepsInfos.questId].objectivesDialogParams = new Array();
                        for each (obj in stepsInfos.objectives)
                        {
                            this._questsInformations[stepsInfos.questId].objectives[obj.objectiveId] = obj.objectiveStatus;
                            if (((obj.dialogParams) && ((obj.dialogParams.length > 0))))
                            {
                                dialogParams = new Array();
                                nbParams = obj.dialogParams.length;
                                _local_57 = 0;
                                while (_local_57 < nbParams)
                                {
                                    dialogParams.push(obj.dialogParams[_local_57]);
                                    _local_57++;
                                };
                            };
                            this._questsInformations[stepsInfos.questId].objectivesDialogParams[obj.objectiveId] = dialogParams;
                            if ((obj is QuestObjectiveInformationsWithCompletion))
                            {
                                compl = new Object();
                                compl.current = (obj as QuestObjectiveInformationsWithCompletion).curCompletion;
                                compl.max = (obj as QuestObjectiveInformationsWithCompletion).maxCompletion;
                                this._questsInformations[stepsInfos.questId].objectivesData[obj.objectiveId] = compl;
                            };
                        };
                        KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated, stepsInfos.questId, true);
                    }
                    else
                    {
                        if ((_local_6.infos is QuestActiveInformations))
                        {
                            KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated, (_local_6.infos as QuestActiveInformations).questId, false);
                        };
                    };
                    return (true);
                case (msg is QuestStartRequestAction):
                    _local_7 = (msg as QuestStartRequestAction);
                    _local_8 = new QuestStartRequestMessage();
                    _local_8.initQuestStartRequestMessage(_local_7.questId);
                    ConnectionsHandler.getConnection().send(_local_8);
                    return (true);
                case (msg is QuestObjectiveValidationAction):
                    _local_9 = (msg as QuestObjectiveValidationAction);
                    _local_10 = new QuestObjectiveValidationMessage();
                    _local_10.initQuestObjectiveValidationMessage(_local_9.questId, _local_9.objectiveId);
                    ConnectionsHandler.getConnection().send(_local_10);
                    return (true);
                case (msg is GuidedModeReturnRequestAction):
                    _local_11 = new GuidedModeReturnRequestMessage();
                    _local_11.initGuidedModeReturnRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_11);
                    return (true);
                case (msg is GuidedModeQuitRequestAction):
                    _local_12 = new GuidedModeQuitRequestMessage();
                    _local_12.initGuidedModeQuitRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_12);
                    return (true);
                case (msg is QuestStartedMessage):
                    _local_13 = (msg as QuestStartedMessage);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStarted, _local_13.questId);
                    return (true);
                case (msg is QuestValidatedMessage):
                    _local_14 = (msg as QuestValidatedMessage);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestValidated, _local_14.questId);
                    if (!(this._completedQuests))
                    {
                        this._completedQuests = new Vector.<uint>();
                    }
                    else
                    {
                        for each (_local_73 in this._activeQuests)
                        {
                            if (_local_73.questId == _local_14.questId)
                            {
                                break;
                            };
                            _local_72++;
                        };
                        if (((this._activeQuests) && ((_local_72 < this._activeQuests.length))))
                        {
                            this._activeQuests.splice(_local_72, 1);
                        };
                    };
                    this._completedQuests.push(_local_14.questId);
                    _local_15 = Quest.getQuestById(_local_14.questId);
                    for each (step in _local_15.steps)
                    {
                        for each (questStepObjId in step.objectiveIds)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, ((((("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) + "_") + _local_14.questId) + "_") + questStepObjId), PlayedCharacterManager.getInstance().currentWorldMap.id);
                        };
                    };
                    return (true);
                case (msg is QuestObjectiveValidatedMessage):
                    _local_16 = (msg as QuestObjectiveValidatedMessage);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestObjectiveValidated, _local_16.questId, _local_16.objectiveId);
                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, ((((("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) + "_") + _local_16.questId) + "_") + _local_16.objectiveId), PlayedCharacterManager.getInstance().currentWorldMap.id);
                    return (true);
                case (msg is QuestStepValidatedMessage):
                    _local_17 = (msg as QuestStepValidatedMessage);
                    if (this._questsInformations[_local_17.questId])
                    {
                        this._questsInformations[_local_17.questId].stepId = _local_17.stepId;
                    };
                    _local_18 = QuestStep.getQuestStepById(_local_17.stepId).objectiveIds;
                    for each (stepObjId in _local_18)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, ((((("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) + "_") + _local_17.questId) + "_") + stepObjId), PlayedCharacterManager.getInstance().currentWorldMap.id);
                    };
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepValidated, _local_17.questId, _local_17.stepId);
                    return (true);
                case (msg is QuestStepStartedMessage):
                    _local_19 = (msg as QuestStepStartedMessage);
                    if (this._questsInformations[_local_19.questId])
                    {
                        this._questsInformations[_local_19.questId].stepId = _local_19.stepId;
                    };
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepStarted, _local_19.questId, _local_19.stepId);
                    return (true);
                case (msg is NotificationUpdateFlagAction):
                    _local_20 = (msg as NotificationUpdateFlagAction);
                    _local_21 = new NotificationUpdateFlagMessage();
                    _local_21.initNotificationUpdateFlagMessage(_local_20.index);
                    ConnectionsHandler.getConnection().send(_local_21);
                    return (true);
                case (msg is NotificationResetAction):
                    notificationList = new Array();
                    _local_22 = new NotificationResetMessage();
                    _local_22.initNotificationResetMessage();
                    ConnectionsHandler.getConnection().send(_local_22);
                    KernelEventsManager.getInstance().processCallback(HookList.NotificationReset);
                    return (true);
                case (msg is AchievementListMessage):
                    _local_23 = (msg as AchievementListMessage);
                    this._finishedAchievementsIds = _local_23.finishedAchievementsIds;
                    this._rewardableAchievements = _local_23.rewardableAchievements;
                    for each (finishAchId in this._finishedAchievementsIds)
                    {
                        if (Achievement.getAchievementById(finishAchId))
                        {
                            _local_24 = (_local_24 + Achievement.getAchievementById(finishAchId).points);
                        }
                        else
                        {
                            _log.warn((("Succés " + finishAchId) + " non exporté"));
                        };
                    };
                    for each (rewAch in this._rewardableAchievements)
                    {
                        if (Achievement.getAchievementById(rewAch.id))
                        {
                            _local_24 = (_local_24 + Achievement.getAchievementById(rewAch.id).points);
                            this._finishedAchievementsIds.push(rewAch.id);
                        }
                        else
                        {
                            _log.warn((("Succés " + rewAch.id) + " non exporté"));
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementList, this._finishedAchievementsIds);
                    if (((!(this._rewardableAchievementsVisible)) && ((this._rewardableAchievements.length > 0))))
                    {
                        this._rewardableAchievementsVisible = true;
                        KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible, this._rewardableAchievementsVisible);
                    };
                    PlayedCharacterManager.getInstance().achievementPercent = Math.floor(((this._finishedAchievementsIds.length / this._nbAllAchievements) * 100));
                    PlayedCharacterManager.getInstance().achievementPoints = _local_24;
                    return (true);
                case (msg is AchievementDetailedListRequestAction):
                    _local_25 = (msg as AchievementDetailedListRequestAction);
                    _local_26 = new AchievementDetailedListRequestMessage();
                    _local_26.initAchievementDetailedListRequestMessage(_local_25.categoryId);
                    ConnectionsHandler.getConnection().send(_local_26);
                    return (true);
                case (msg is AchievementDetailedListMessage):
                    _local_27 = (msg as AchievementDetailedListMessage);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetailedList, _local_27.finishedAchievements, _local_27.startedAchievements);
                    return (true);
                case (msg is AchievementDetailsRequestAction):
                    _local_28 = (msg as AchievementDetailsRequestAction);
                    _local_29 = new AchievementDetailsRequestMessage();
                    _local_29.initAchievementDetailsRequestMessage(_local_28.achievementId);
                    ConnectionsHandler.getConnection().send(_local_29);
                    return (true);
                case (msg is AchievementDetailsMessage):
                    _local_30 = (msg as AchievementDetailsMessage);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetails, _local_30.achievement);
                    return (true);
                case (msg is AchievementFinishedInformationMessage):
                    _local_31 = (msg as AchievementFinishedInformationMessage);
                    _local_32 = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.characterUnlocksAchievement", [(((("{player," + _local_31.name) + ",") + _local_31.playerId) + "}")]), [_local_31.name, _local_31.id]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_32, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is AchievementFinishedMessage):
                    _local_33 = (msg as AchievementFinishedMessage);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementFinished, _local_33.id);
                    this._finishedAchievementsIds.push(_local_33.id);
                    _local_34 = new AchievementRewardable();
                    this._rewardableAchievements.push(_local_34.initAchievementRewardable(_local_33.id, _local_33.finishedlevel));
                    if (!(this._rewardableAchievementsVisible))
                    {
                        this._rewardableAchievementsVisible = true;
                        KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible, this._rewardableAchievementsVisible);
                    };
                    _local_35 = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.achievementUnlockWithLink"), [_local_33.id]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_35, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    PlayedCharacterManager.getInstance().achievementPercent = Math.floor(((this._finishedAchievementsIds.length / this._nbAllAchievements) * 100));
                    PlayedCharacterManager.getInstance().achievementPoints = (PlayedCharacterManager.getInstance().achievementPoints + Achievement.getAchievementById(_local_33.id).points);
                    return (true);
                case (msg is AchievementRewardRequestAction):
                    _local_36 = (msg as AchievementRewardRequestAction);
                    _local_37 = new AchievementRewardRequestMessage();
                    _local_37.initAchievementRewardRequestMessage(_local_36.achievementId);
                    ConnectionsHandler.getConnection().send(_local_37);
                    return (true);
                case (msg is AchievementRewardSuccessMessage):
                    _local_38 = (msg as AchievementRewardSuccessMessage);
                    for each (achievementRewardable in this._rewardableAchievements)
                    {
                        if (achievementRewardable.id == _local_38.achievementId)
                        {
                            _local_39 = this._rewardableAchievements.indexOf(achievementRewardable);
                            break;
                        };
                    };
                    this._rewardableAchievements.splice(_local_39, 1);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementRewardSuccess, _local_38.achievementId);
                    if (((this._rewardableAchievementsVisible) && ((this._rewardableAchievements.length == 0))))
                    {
                        this._rewardableAchievementsVisible = false;
                        KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible, this._rewardableAchievementsVisible);
                    };
                    return (true);
                case (msg is AchievementRewardErrorMessage):
                    _local_40 = (msg as AchievementRewardErrorMessage);
                    return (true);
                case (msg is TreasureHuntShowLegendaryUIMessage):
                    _local_41 = (msg as TreasureHuntShowLegendaryUIMessage);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntLegendaryUiUpdate, _local_41.availableLegendaryIds);
                    return (true);
                case (msg is TreasureHuntRequestAction):
                    _local_42 = (msg as TreasureHuntRequestAction);
                    _local_43 = new TreasureHuntRequestMessage();
                    _local_43.initTreasureHuntRequestMessage(_local_42.level, _local_42.questType);
                    ConnectionsHandler.getConnection().send(_local_43);
                    return (true);
                case (msg is TreasureHuntLegendaryRequestAction):
                    _local_44 = (msg as TreasureHuntLegendaryRequestAction);
                    _local_45 = new TreasureHuntLegendaryRequestMessage();
                    _local_45.initTreasureHuntLegendaryRequestMessage(_local_44.legendaryId);
                    ConnectionsHandler.getConnection().send(_local_45);
                    return (true);
                case (msg is TreasureHuntRequestAnswerMessage):
                    _local_46 = (msg as TreasureHuntRequestAnswerMessage);
                    if (_local_46.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_ALREADY_HAVE_QUEST)
                    {
                        _local_47 = I18n.getUiText("ui.treasureHunt.alreadyHaveQuest");
                    }
                    else
                    {
                        if (_local_46.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_NO_QUEST_FOUND)
                        {
                            _local_47 = I18n.getUiText("ui.treasureHunt.noQuestFound");
                        }
                        else
                        {
                            if (_local_46.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_UNDEFINED)
                            {
                                _local_47 = I18n.getUiText("ui.popup.impossible_action");
                            }
                            else
                            {
                                if (_local_46.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_NOT_AVAILABLE)
                                {
                                    _local_47 = I18n.getUiText("ui.treasureHunt.huntNotAvailable");
                                };
                            };
                        };
                    };
                    if (_local_47)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_47, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is TreasureHuntFlagRequestAction):
                    _local_48 = (msg as TreasureHuntFlagRequestAction);
                    _local_49 = new TreasureHuntFlagRequestMessage();
                    _local_49.initTreasureHuntFlagRequestMessage(_local_48.questType, _local_48.index);
                    ConnectionsHandler.getConnection().send(_local_49);
                    return (true);
                case (msg is TreasureHuntFlagRemoveRequestAction):
                    _local_50 = (msg as TreasureHuntFlagRemoveRequestAction);
                    _local_51 = new TreasureHuntFlagRemoveRequestMessage();
                    _local_51.initTreasureHuntFlagRemoveRequestMessage(_local_50.questType, _local_50.index);
                    ConnectionsHandler.getConnection().send(_local_51);
                    return (true);
                case (msg is TreasureHuntFlagRequestAnswerMessage):
                    _local_52 = (msg as TreasureHuntFlagRequestAnswerMessage);
                    switch (_local_52.result)
                    {
                        case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_OK:
                            break;
                        case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_ERROR_UNDEFINED:
                        case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_WRONG:
                        case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_TOO_MANY:
                        case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_ERROR_IMPOSSIBLE:
                        case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_WRONG_INDEX:
                            _local_53 = I18n.getUiText("ui.treasureHunt.flagFail");
                            break;
                        case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_SAME_MAP:
                            _local_53 = I18n.getUiText("ui.treasureHunt.flagFailSameMap");
                            break;
                    };
                    if (_local_53)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_53, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is TreasureHuntMessage):
                    _local_54 = (msg as TreasureHuntMessage);
                    if (((this._treasureHunts[_local_54.questType]) && (this._treasureHunts[_local_54.questType].stepList.length)))
                    {
                        j = 0;
                        for each (st in this._treasureHunts[_local_54.questType].stepList)
                        {
                            if (st.flagState > -1)
                            {
                                j++;
                                if (!(_local_55))
                                {
                                    _local_55 = MapPosition.getMapPositionById(st.mapId);
                                };
                                if (_local_55.worldMap > -1)
                                {
                                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, ((("flag_hunt_" + _local_54.questType) + "_") + j), _local_55.worldMap);
                                };
                            };
                        };
                    };
                    _local_56 = TreasureHuntWrapper.create(_local_54.questType, _local_54.startMapId, _local_54.checkPointCurrent, _local_54.checkPointTotal, _local_54.totalStepCount, _local_54.availableRetryCount, _local_54.knownStepsList, _local_54.flags);
                    this._treasureHunts[_local_54.questType] = _local_56;
                    _local_57 = 0;
                    for each (fl in _local_54.flags)
                    {
                        _local_57++;
                        _local_55 = MapPosition.getMapPositionById(fl.mapId);
                        if (_local_55.worldMap > -1)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag, ((("flag_hunt_" + _local_54.questType) + "_") + _local_57), (((((((I18n.getUiText(("ui.treasureHunt.huntType" + _local_54.questType)) + " - Indice n°") + _local_57) + " [") + _local_55.posX) + ",") + _local_55.posY) + "]"), _local_55.worldMap, _local_55.posX, _local_55.posY, this._flagColors[fl.state], false, false, false);
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntUpdate, _local_56.questType);
                    return (true);
                case (msg is TreasureHuntAvailableRetryCountUpdateMessage):
                    _local_58 = (msg as TreasureHuntAvailableRetryCountUpdateMessage);
                    this._treasureHunts[_local_58.questType].availableRetryCount = _local_58.availableRetryCount;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntAvailableRetryCountUpdate, _local_58.questType, _local_58.availableRetryCount);
                    return (true);
                case (msg is TreasureHuntFinishedMessage):
                    _local_59 = (msg as TreasureHuntFinishedMessage);
                    if (this._treasureHunts[_local_59.questType])
                    {
                        if (this._treasureHunts[_local_59.questType].stepList.length)
                        {
                            j = 0;
                            for each (st in this._treasureHunts[_local_59.questType].stepList)
                            {
                                if (st.flagState > -1)
                                {
                                    j++;
                                    if (!(_local_55))
                                    {
                                        _local_55 = MapPosition.getMapPositionById(st.mapId);
                                    };
                                    if (_local_55.worldMap > -1)
                                    {
                                        KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, ((("flag_hunt_" + _local_59.questType) + "_") + j), _local_55.worldMap);
                                    };
                                };
                            };
                        };
                        this._treasureHunts[_local_59.questType] = null;
                        delete this._treasureHunts[_local_59.questType];
                        KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntFinished, _local_59.questType);
                    };
                    return (true);
                case (msg is TreasureHuntGiveUpRequestAction):
                    _local_60 = (msg as TreasureHuntGiveUpRequestAction);
                    _local_61 = new TreasureHuntGiveUpRequestMessage();
                    _local_61.initTreasureHuntGiveUpRequestMessage(_local_60.questType);
                    ConnectionsHandler.getConnection().send(_local_61);
                    return (true);
                case (msg is TreasureHuntDigRequestAction):
                    _local_62 = (msg as TreasureHuntDigRequestAction);
                    _local_63 = new TreasureHuntDigRequestMessage();
                    _local_63.initTreasureHuntDigRequestMessage(_local_62.questType);
                    ConnectionsHandler.getConnection().send(_local_63);
                    return (true);
                case (msg is TreasureHuntDigRequestAnswerMessage):
                    _local_64 = (msg as TreasureHuntDigRequestAnswerMessage);
                    if ((_local_64 is TreasureHuntDigRequestAnswerFailedMessage))
                    {
                        _local_65 = (_local_64 as TreasureHuntDigRequestAnswerFailedMessage).wrongFlagCount;
                    };
                    if (_local_64.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_ERROR_IMPOSSIBLE)
                    {
                        _local_66 = I18n.getUiText("ui.fight.wrongMap");
                    }
                    else
                    {
                        if (_local_64.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_ERROR_UNDEFINED)
                        {
                            _local_66 = I18n.getUiText("ui.popup.impossible_action");
                        }
                        else
                        {
                            if (_local_64.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_LOST)
                            {
                                _local_66 = I18n.getUiText("ui.treasureHunt.huntFail");
                            }
                            else
                            {
                                if (_local_64.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_NEW_HINT)
                                {
                                    _local_66 = I18n.getUiText("ui.treasureHunt.stepSuccess");
                                }
                                else
                                {
                                    if (_local_64.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_WRONG)
                                    {
                                        if (_local_65 > 1)
                                        {
                                            _local_66 = I18n.getUiText("ui.treasureHunt.digWrongFlags", [_local_65]);
                                        }
                                        else
                                        {
                                            if (_local_65 > 0)
                                            {
                                                _local_66 = I18n.getUiText("ui.treasureHunt.digWrongFlag");
                                            }
                                            else
                                            {
                                                _local_66 = I18n.getUiText("ui.treasureHunt.digFail");
                                            };
                                        };
                                    }
                                    else
                                    {
                                        if (_local_64.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_WRONG_AND_YOU_KNOW_IT)
                                        {
                                            _local_66 = I18n.getUiText("ui.treasureHunt.noNewFlag");
                                        }
                                        else
                                        {
                                            if (_local_64.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_FINISHED)
                                            {
                                                if (_local_64.questType == TreasureHuntTypeEnum.TREASURE_HUNT_CLASSIC)
                                                {
                                                    _local_66 = I18n.getUiText("ui.treasureHunt.huntSuccess");
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (_local_66)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_66, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
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

