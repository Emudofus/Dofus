package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementRewardable;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.jerakine.messages.Message;
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
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntRequestAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntMessage;
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
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformationsWithCompletion;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.enums.TreasureHuntRequestEnum;
   import com.ankamagames.dofus.network.enums.TreasureHuntDigRequestEnum;
   import com.ankamagames.dofus.network.enums.TreasureHuntTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeReturnRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeQuitRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationResetAction;
   
   public class QuestFrame extends Object implements Frame
   {
      
      public function QuestFrame() {
         this._questsInformations = new Dictionary();
         super();
      }
      
      protected static const _log:Logger;
      
      public static var notificationList:Array;
      
      private var _nbAllAchievements:int;
      
      private var _activeQuests:Vector.<QuestActiveInformations>;
      
      private var _completedQuests:Vector.<uint>;
      
      private var _questsInformations:Dictionary;
      
      private var _finishedAchievementsIds:Vector.<uint>;
      
      private var _rewardableAchievements:Vector.<AchievementRewardable>;
      
      private var _rewardableAchievementsVisible:Boolean;
      
      private var _treasureHunts:Array;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get finishedAchievementsIds() : Vector.<uint> {
         return this._finishedAchievementsIds;
      }
      
      public function getActiveQuests() : Vector.<QuestActiveInformations> {
         return this._activeQuests;
      }
      
      public function getCompletedQuests() : Vector.<uint> {
         return this._completedQuests;
      }
      
      public function getQuestInformations(questId:uint) : Object {
         return this._questsInformations[questId];
      }
      
      public function get rewardableAchievements() : Vector.<AchievementRewardable> {
         return this._rewardableAchievements;
      }
      
      public function getTreasureHuntById(typeId:uint) : Object {
         return this._treasureHunts[typeId];
      }
      
      public function pushed() : Boolean {
         this._rewardableAchievements = new Vector.<AchievementRewardable>();
         this._finishedAchievementsIds = new Vector.<uint>();
         this._treasureHunts = new Array();
         this._nbAllAchievements = Achievement.getAchievements().length;
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var qlrmsg:QuestListRequestMessage = null;
         var qlmsg:QuestListMessage = null;
         var qira:QuestInfosRequestAction = null;
         var qsirmsg:QuestStepInfoRequestMessage = null;
         var qsimsg:QuestStepInfoMessage = null;
         var qsra:QuestStartRequestAction = null;
         var qsrmsg:QuestStartRequestMessage = null;
         var qova:QuestObjectiveValidationAction = null;
         var qovmsg:QuestObjectiveValidationMessage = null;
         var gmrrmsg:GuidedModeReturnRequestMessage = null;
         var gmqrmsg:GuidedModeQuitRequestMessage = null;
         var qsmsg:QuestStartedMessage = null;
         var qvmsg:QuestValidatedMessage = null;
         var questValidated:Quest = null;
         var qovmsg2:QuestObjectiveValidatedMessage = null;
         var qsvmsg:QuestStepValidatedMessage = null;
         var objectivesIds:Object = null;
         var qssmsg:QuestStepStartedMessage = null;
         var nufa:NotificationUpdateFlagAction = null;
         var nufmsg:NotificationUpdateFlagMessage = null;
         var nrmsg:NotificationResetMessage = null;
         var almsg:AchievementListMessage = null;
         var points:* = 0;
         var adlra:AchievementDetailedListRequestAction = null;
         var adlrmsg:AchievementDetailedListRequestMessage = null;
         var adlmsg:AchievementDetailedListMessage = null;
         var adra:AchievementDetailsRequestAction = null;
         var adrmsg:AchievementDetailsRequestMessage = null;
         var admsg:AchievementDetailsMessage = null;
         var afimsg:AchievementFinishedInformationMessage = null;
         var info3:String = null;
         var afmsg:AchievementFinishedMessage = null;
         var rewardableAchievement:AchievementRewardable = null;
         var info:String = null;
         var arra:AchievementRewardRequestAction = null;
         var arrmsg:AchievementRewardRequestMessage = null;
         var arsmsg:AchievementRewardSuccessMessage = null;
         var rewardedAchievementIndex:* = 0;
         var aremsg:AchievementRewardErrorMessage = null;
         var thra:TreasureHuntRequestAction = null;
         var thrmsg:TreasureHuntRequestMessage = null;
         var thramsg:TreasureHuntRequestAnswerMessage = null;
         var treasureHuntRequestAnswerText:String = null;
         var thmsg:TreasureHuntMessage = null;
         var th:TreasureHuntWrapper = null;
         var tharcumsg:TreasureHuntAvailableRetryCountUpdateMessage = null;
         var thfmsg:TreasureHuntFinishedMessage = null;
         var thgura:TreasureHuntGiveUpRequestAction = null;
         var thgurmsg:TreasureHuntGiveUpRequestMessage = null;
         var thdra:TreasureHuntDigRequestAction = null;
         var thdrmsg:TreasureHuntDigRequestMessage = null;
         var thdramsg:TreasureHuntDigRequestAnswerMessage = null;
         var treasureHuntDigAnswerText:String = null;
         var stepsInfos:QuestActiveDetailedInformations = null;
         var obj:QuestObjectiveInformations = null;
         var dialogParams:Array = null;
         var nbParams:* = 0;
         var i:* = 0;
         var compl:Object = null;
         var index:* = 0;
         var activeQuest:QuestActiveInformations = null;
         var step:QuestStep = null;
         var questStepObjId:* = 0;
         var stepObjId:* = 0;
         var finishAchId:* = 0;
         var rewAch:AchievementRewardable = null;
         var achievementRewardable:AchievementRewardable = null;
         switch(true)
         {
            case msg is QuestListRequestAction:
               qlrmsg = new QuestListRequestMessage();
               qlrmsg.initQuestListRequestMessage();
               ConnectionsHandler.getConnection().send(qlrmsg);
               return true;
            case msg is QuestListMessage:
               qlmsg = msg as QuestListMessage;
               this._activeQuests = qlmsg.activeQuests;
               this._completedQuests = qlmsg.finishedQuestsIds;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestListUpdated);
               return true;
            case msg is QuestInfosRequestAction:
               qira = msg as QuestInfosRequestAction;
               qsirmsg = new QuestStepInfoRequestMessage();
               qsirmsg.initQuestStepInfoRequestMessage(qira.questId);
               ConnectionsHandler.getConnection().send(qsirmsg);
               return true;
            case msg is QuestStepInfoMessage:
               qsimsg = msg as QuestStepInfoMessage;
               if(qsimsg.infos is QuestActiveDetailedInformations)
               {
                  stepsInfos = qsimsg.infos as QuestActiveDetailedInformations;
                  this._questsInformations[stepsInfos.questId] = 
                     {
                        "questId":stepsInfos.questId,
                        "stepId":stepsInfos.stepId
                     };
                  this._questsInformations[stepsInfos.questId].objectives = new Array();
                  this._questsInformations[stepsInfos.questId].objectivesData = new Array();
                  this._questsInformations[stepsInfos.questId].objectivesDialogParams = new Array();
                  for each(obj in stepsInfos.objectives)
                  {
                     this._questsInformations[stepsInfos.questId].objectives[obj.objectiveId] = obj.objectiveStatus;
                     if((obj.dialogParams) && (obj.dialogParams.length > 0))
                     {
                        dialogParams = new Array();
                        nbParams = obj.dialogParams.length;
                        i = 0;
                        while(i < nbParams)
                        {
                           dialogParams.push(obj.dialogParams[i]);
                           i++;
                        }
                     }
                     this._questsInformations[stepsInfos.questId].objectivesDialogParams[obj.objectiveId] = dialogParams;
                     if(obj is QuestObjectiveInformationsWithCompletion)
                     {
                        compl = new Object();
                        compl.current = (obj as QuestObjectiveInformationsWithCompletion).curCompletion;
                        compl.max = (obj as QuestObjectiveInformationsWithCompletion).maxCompletion;
                        this._questsInformations[stepsInfos.questId].objectivesData[obj.objectiveId] = compl;
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated,stepsInfos.questId,true);
               }
               else if(qsimsg.infos is QuestActiveInformations)
               {
                  KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated,(qsimsg.infos as QuestActiveInformations).questId,false);
               }
               
               return true;
            case msg is QuestStartRequestAction:
               qsra = msg as QuestStartRequestAction;
               qsrmsg = new QuestStartRequestMessage();
               qsrmsg.initQuestStartRequestMessage(qsra.questId);
               ConnectionsHandler.getConnection().send(qsrmsg);
               return true;
            case msg is QuestObjectiveValidationAction:
               qova = msg as QuestObjectiveValidationAction;
               qovmsg = new QuestObjectiveValidationMessage();
               qovmsg.initQuestObjectiveValidationMessage(qova.questId,qova.objectiveId);
               ConnectionsHandler.getConnection().send(qovmsg);
               return true;
            case msg is GuidedModeReturnRequestAction:
               gmrrmsg = new GuidedModeReturnRequestMessage();
               gmrrmsg.initGuidedModeReturnRequestMessage();
               ConnectionsHandler.getConnection().send(gmrrmsg);
               return true;
            case msg is GuidedModeQuitRequestAction:
               gmqrmsg = new GuidedModeQuitRequestMessage();
               gmqrmsg.initGuidedModeQuitRequestMessage();
               ConnectionsHandler.getConnection().send(gmqrmsg);
               return true;
            case msg is QuestStartedMessage:
               qsmsg = msg as QuestStartedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStarted,qsmsg.questId);
               return true;
            case msg is QuestValidatedMessage:
               qvmsg = msg as QuestValidatedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestValidated,qvmsg.questId);
               if(!this._completedQuests)
               {
                  this._completedQuests = new Vector.<uint>();
               }
               else
               {
                  for each(activeQuest in this._activeQuests)
                  {
                     if(activeQuest.questId == qvmsg.questId)
                     {
                        break;
                     }
                     index++;
                  }
                  if((this._activeQuests) && (index < this._activeQuests.length))
                  {
                     this._activeQuests.splice(index,1);
                  }
               }
               this._completedQuests.push(qvmsg.questId);
               questValidated = Quest.getQuestById(qvmsg.questId);
               for each(step in questValidated.steps)
               {
                  for each(questStepObjId in step.objectiveIds)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + qvmsg.questId + "_" + questStepObjId,PlayedCharacterManager.getInstance().currentWorldMap.id);
                  }
               }
               return true;
            case msg is QuestObjectiveValidatedMessage:
               qovmsg2 = msg as QuestObjectiveValidatedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestObjectiveValidated,qovmsg2.questId,qovmsg2.objectiveId);
               KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + qovmsg2.questId + "_" + qovmsg2.objectiveId,PlayedCharacterManager.getInstance().currentWorldMap.id);
               return true;
            case msg is QuestStepValidatedMessage:
               qsvmsg = msg as QuestStepValidatedMessage;
               if(this._questsInformations[qsvmsg.questId])
               {
                  this._questsInformations[qsvmsg.questId].stepId = qsvmsg.stepId;
               }
               objectivesIds = QuestStep.getQuestStepById(qsvmsg.stepId).objectiveIds;
               for each(stepObjId in objectivesIds)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + qsvmsg.questId + "_" + stepObjId,PlayedCharacterManager.getInstance().currentWorldMap.id);
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepValidated,qsvmsg.questId,qsvmsg.stepId);
               return true;
            case msg is QuestStepStartedMessage:
               qssmsg = msg as QuestStepStartedMessage;
               if(this._questsInformations[qssmsg.questId])
               {
                  this._questsInformations[qssmsg.questId].stepId = qssmsg.stepId;
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepStarted,qssmsg.questId,qssmsg.stepId);
               return true;
            case msg is NotificationUpdateFlagAction:
               nufa = msg as NotificationUpdateFlagAction;
               nufmsg = new NotificationUpdateFlagMessage();
               nufmsg.initNotificationUpdateFlagMessage(nufa.index);
               ConnectionsHandler.getConnection().send(nufmsg);
               return true;
            case msg is NotificationResetAction:
               notificationList = new Array();
               nrmsg = new NotificationResetMessage();
               nrmsg.initNotificationResetMessage();
               ConnectionsHandler.getConnection().send(nrmsg);
               KernelEventsManager.getInstance().processCallback(HookList.NotificationReset);
               return true;
            case msg is AchievementListMessage:
               almsg = msg as AchievementListMessage;
               this._finishedAchievementsIds = almsg.finishedAchievementsIds;
               this._rewardableAchievements = almsg.rewardableAchievements;
               for each(finishAchId in this._finishedAchievementsIds)
               {
                  if(Achievement.getAchievementById(finishAchId))
                  {
                     points = points + Achievement.getAchievementById(finishAchId).points;
                  }
                  else
                  {
                     _log.warn("Succés " + finishAchId + " non exporté");
                  }
               }
               for each(rewAch in this._rewardableAchievements)
               {
                  if(Achievement.getAchievementById(rewAch.id))
                  {
                     points = points + Achievement.getAchievementById(rewAch.id).points;
                     this._finishedAchievementsIds.push(rewAch.id);
                  }
                  else
                  {
                     _log.warn("Succés " + rewAch.id + " non exporté");
                  }
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementList,this._finishedAchievementsIds);
               if((!this._rewardableAchievementsVisible) && (this._rewardableAchievements.length > 0))
               {
                  this._rewardableAchievementsVisible = true;
                  KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
               }
               PlayedCharacterManager.getInstance().achievementPercent = Math.floor(this._finishedAchievementsIds.length / this._nbAllAchievements * 100);
               PlayedCharacterManager.getInstance().achievementPoints = points;
               return true;
            case msg is AchievementDetailedListRequestAction:
               adlra = msg as AchievementDetailedListRequestAction;
               adlrmsg = new AchievementDetailedListRequestMessage();
               adlrmsg.initAchievementDetailedListRequestMessage(adlra.categoryId);
               ConnectionsHandler.getConnection().send(adlrmsg);
               return true;
            case msg is AchievementDetailedListMessage:
               adlmsg = msg as AchievementDetailedListMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetailedList,adlmsg.finishedAchievements,adlmsg.startedAchievements);
               return true;
            case msg is AchievementDetailsRequestAction:
               adra = msg as AchievementDetailsRequestAction;
               adrmsg = new AchievementDetailsRequestMessage();
               adrmsg.initAchievementDetailsRequestMessage(adra.achievementId);
               ConnectionsHandler.getConnection().send(adrmsg);
               return true;
            case msg is AchievementDetailsMessage:
               admsg = msg as AchievementDetailsMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetails,admsg.achievement);
               return true;
            case msg is AchievementFinishedInformationMessage:
               afimsg = msg as AchievementFinishedInformationMessage;
               info3 = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.characterUnlocksAchievement",["{player," + afimsg.name + "," + afimsg.playerId + "}"]),[afimsg.name,afimsg.id]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,info3,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is AchievementFinishedMessage:
               afmsg = msg as AchievementFinishedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementFinished,afmsg.id);
               this._finishedAchievementsIds.push(afmsg.id);
               rewardableAchievement = new AchievementRewardable();
               this._rewardableAchievements.push(rewardableAchievement.initAchievementRewardable(afmsg.id,afmsg.finishedlevel));
               if(!this._rewardableAchievementsVisible)
               {
                  this._rewardableAchievementsVisible = true;
                  KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
               }
               info = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.achievementUnlockWithLink"),[afmsg.id]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,info,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               PlayedCharacterManager.getInstance().achievementPercent = Math.floor(this._finishedAchievementsIds.length / this._nbAllAchievements * 100);
               PlayedCharacterManager.getInstance().achievementPoints = PlayedCharacterManager.getInstance().achievementPoints + Achievement.getAchievementById(afmsg.id).points;
               return true;
            case msg is AchievementRewardRequestAction:
               arra = msg as AchievementRewardRequestAction;
               arrmsg = new AchievementRewardRequestMessage();
               arrmsg.initAchievementRewardRequestMessage(arra.achievementId);
               ConnectionsHandler.getConnection().send(arrmsg);
               return true;
            case msg is AchievementRewardSuccessMessage:
               arsmsg = msg as AchievementRewardSuccessMessage;
               for each(achievementRewardable in this._rewardableAchievements)
               {
                  if(achievementRewardable.id == arsmsg.achievementId)
                  {
                     rewardedAchievementIndex = this._rewardableAchievements.indexOf(achievementRewardable);
                     break;
                  }
               }
               this._rewardableAchievements.splice(rewardedAchievementIndex,1);
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementRewardSuccess,arsmsg.achievementId);
               if((this._rewardableAchievementsVisible) && (this._rewardableAchievements.length == 0))
               {
                  this._rewardableAchievementsVisible = false;
                  KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
               }
               return true;
            case msg is AchievementRewardErrorMessage:
               aremsg = msg as AchievementRewardErrorMessage;
               return true;
            case msg is TreasureHuntRequestAction:
               thra = msg as TreasureHuntRequestAction;
               thrmsg = new TreasureHuntRequestMessage();
               thrmsg.initTreasureHuntRequestMessage(thra.level,thra.questType);
               ConnectionsHandler.getConnection().send(thrmsg);
               return true;
            case msg is TreasureHuntRequestAnswerMessage:
               thramsg = msg as TreasureHuntRequestAnswerMessage;
               if(thramsg.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_ALREADY_HAVE_QUEST)
               {
                  treasureHuntRequestAnswerText = I18n.getUiText("ui.treasureHunt.alreadyHaveQuest");
               }
               else if(thramsg.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_NO_QUEST_FOUND)
               {
                  treasureHuntRequestAnswerText = I18n.getUiText("ui.treasureHunt.noQuestFound");
               }
               else if(thramsg.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_UNDEFINED)
               {
                  treasureHuntRequestAnswerText = I18n.getUiText("ui.popup.impossible_action");
               }
               
               
               if(treasureHuntRequestAnswerText)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,treasureHuntRequestAnswerText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is TreasureHuntMessage:
               thmsg = msg as TreasureHuntMessage;
               th = TreasureHuntWrapper.create(thmsg.questType,thmsg.startMapId,thmsg.checkPointCurrent,thmsg.checkPointTotal,thmsg.availableRetryCount,thmsg.stepList);
               this._treasureHunts[thmsg.questType] = th;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntUpdate,th.questType);
               return true;
            case msg is TreasureHuntAvailableRetryCountUpdateMessage:
               tharcumsg = msg as TreasureHuntAvailableRetryCountUpdateMessage;
               this._treasureHunts[tharcumsg.questType].availableRetryCount = tharcumsg.availableRetryCount;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntAvailableRetryCountUpdate,tharcumsg.questType,tharcumsg.availableRetryCount);
               return true;
            case msg is TreasureHuntFinishedMessage:
               thfmsg = msg as TreasureHuntFinishedMessage;
               this._treasureHunts[thfmsg.questType] = null;
               delete this._treasureHunts[thfmsg.questType];
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntFinished,thfmsg.questType);
               return true;
            case msg is TreasureHuntGiveUpRequestAction:
               thgura = msg as TreasureHuntGiveUpRequestAction;
               thgurmsg = new TreasureHuntGiveUpRequestMessage();
               thgurmsg.initTreasureHuntGiveUpRequestMessage(thgura.questType);
               ConnectionsHandler.getConnection().send(thgurmsg);
               return true;
            case msg is TreasureHuntDigRequestAction:
               thdra = msg as TreasureHuntDigRequestAction;
               thdrmsg = new TreasureHuntDigRequestMessage();
               thdrmsg.initTreasureHuntDigRequestMessage(thdra.questType);
               ConnectionsHandler.getConnection().send(thdrmsg);
               return true;
            case msg is TreasureHuntDigRequestAnswerMessage:
               thdramsg = msg as TreasureHuntDigRequestAnswerMessage;
               if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_ERROR_IMPOSSIBLE)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.fight.wrongMap");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_ERROR_UNDEFINED)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.popup.impossible_action");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_LOST)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.huntFail");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_NEW_HINT)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.stepSuccess");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_WRONG)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.digFail");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_FINISHED)
               {
                  if(thdramsg.questType == TreasureHuntTypeEnum.TREASURE_HUNT_CLASSIC)
                  {
                     treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.huntSuccess");
                  }
                  else if(thdramsg.questType == TreasureHuntTypeEnum.TREASURE_HUNT_PORTAL)
                  {
                     treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.portalHuntSuccess",[PlayedCharacterManager.getInstance().currentMap.outdoorX,PlayedCharacterManager.getInstance().currentMap.outdoorY]);
                  }
                  
               }
               
               
               
               
               
               if(treasureHuntDigAnswerText)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,treasureHuntDigAnswerText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
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
