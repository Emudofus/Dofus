package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.quest.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.notification.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class QuestFrame extends Object implements Frame
    {
        private var _activeQuests:Vector.<QuestActiveInformations>;
        private var _completedQuests:Vector.<uint>;
        private var _questsInformations:Dictionary;
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

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:QuestListRequestMessage = null;
            var _loc_3:QuestListMessage = null;
            var _loc_4:QuestInfosRequestAction = null;
            var _loc_5:QuestStepInfoRequestMessage = null;
            var _loc_6:QuestStepInfoMessage = null;
            var _loc_7:QuestStartRequestAction = null;
            var _loc_8:QuestStartRequestMessage = null;
            var _loc_9:QuestObjectiveValidationAction = null;
            var _loc_10:QuestObjectiveValidationMessage = null;
            var _loc_11:GuidedModeReturnRequestMessage = null;
            var _loc_12:GuidedModeQuitRequestMessage = null;
            var _loc_13:QuestStartedMessage = null;
            var _loc_14:QuestValidatedMessage = null;
            var _loc_15:Quest = null;
            var _loc_16:QuestObjectiveValidatedMessage = null;
            var _loc_17:QuestStepValidatedMessage = null;
            var _loc_18:Object = null;
            var _loc_19:QuestStepStartedMessage = null;
            var _loc_20:NotificationUpdateFlagAction = null;
            var _loc_21:NotificationUpdateFlagMessage = null;
            var _loc_22:NotificationResetAction = null;
            var _loc_23:NotificationResetMessage = null;
            var _loc_24:QuestActiveDetailedInformations = null;
            var _loc_25:QuestObjectiveInformations = null;
            var _loc_26:Object = null;
            var _loc_27:QuestStep = null;
            var _loc_28:int = 0;
            var _loc_29:int = 0;
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
                        _loc_24 = _loc_6.infos as QuestActiveDetailedInformations;
                        this._questsInformations[_loc_24.questId] = {questId:_loc_24.questId, stepId:_loc_24.stepId};
                        this._questsInformations[_loc_24.questId].objectives = new Array();
                        this._questsInformations[_loc_24.questId].objectivesData = new Array();
                        for each (_loc_25 in _loc_24.objectives)
                        {
                            
                            this._questsInformations[_loc_24.questId].objectives[_loc_25.objectiveId] = _loc_25.objectiveStatus;
                            if (_loc_25 is QuestObjectiveInformationsWithCompletion)
                            {
                                _loc_26 = new Object();
                                _loc_26.current = (_loc_25 as QuestObjectiveInformationsWithCompletion).curCompletion;
                                _loc_26.max = (_loc_25 as QuestObjectiveInformationsWithCompletion).maxCompletion;
                                this._questsInformations[_loc_24.questId].objectivesData[_loc_25.objectiveId] = _loc_26;
                            }
                        }
                        KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated, _loc_24.questId, true);
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
                    _loc_15 = Quest.getQuestById(_loc_14.questId);
                    for each (_loc_27 in _loc_15.steps)
                    {
                        
                        for each (_loc_28 in _loc_27.objectiveIds)
                        {
                            
                            KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, "flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc_14.questId + "_" + _loc_28);
                        }
                    }
                    return true;
                }
                case param1 is QuestObjectiveValidatedMessage:
                {
                    _loc_16 = param1 as QuestObjectiveValidatedMessage;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestObjectiveValidated, _loc_16.questId, _loc_16.objectiveId);
                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, "flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc_16.questId + "_" + _loc_16.objectiveId);
                    return true;
                }
                case param1 is QuestStepValidatedMessage:
                {
                    _loc_17 = param1 as QuestStepValidatedMessage;
                    if (this._questsInformations[_loc_17.questId])
                    {
                        this._questsInformations[_loc_17.questId].stepId = _loc_17.stepId;
                    }
                    _loc_18 = QuestStep.getQuestStepById(_loc_17.stepId).objectiveIds;
                    for each (_loc_29 in _loc_18)
                    {
                        
                        KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, "flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc_17.questId + "_" + _loc_29);
                    }
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepValidated, _loc_17.questId, _loc_17.stepId);
                    return true;
                }
                case param1 is QuestStepStartedMessage:
                {
                    _loc_19 = param1 as QuestStepStartedMessage;
                    if (this._questsInformations[_loc_19.questId])
                    {
                        this._questsInformations[_loc_19.questId].stepId = _loc_19.stepId;
                    }
                    KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepStarted, _loc_19.questId, _loc_19.stepId);
                    return true;
                }
                case param1 is NotificationUpdateFlagAction:
                {
                    _loc_20 = param1 as NotificationUpdateFlagAction;
                    _loc_21 = new NotificationUpdateFlagMessage();
                    _loc_21.initNotificationUpdateFlagMessage(_loc_20.index);
                    ConnectionsHandler.getConnection().send(_loc_21);
                    return true;
                }
                case param1 is NotificationResetAction:
                {
                    _loc_22 = param1 as NotificationResetAction;
                    notificationList = new Array();
                    _loc_23 = new NotificationResetMessage();
                    _loc_23.initNotificationResetMessage();
                    ConnectionsHandler.getConnection().send(_loc_23);
                    KernelEventsManager.getInstance().processCallback(HookList.NotificationReset);
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

    }
}
