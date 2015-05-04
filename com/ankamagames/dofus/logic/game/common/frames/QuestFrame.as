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
   import com.ankamagames.dofus.network.enums.TreasureHuntFlagStateEnum;
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
   import com.ankamagames.dofus.network.enums.TreasureHuntFlagRequestEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntDigRequestAnswerFailedMessage;
   import com.ankamagames.dofus.network.enums.TreasureHuntDigRequestEnum;
   import com.ankamagames.dofus.network.enums.TreasureHuntTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeReturnRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeQuitRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationResetAction;
   
   public class QuestFrame extends Object implements Frame
   {
      
      public function QuestFrame()
      {
         this._questsInformations = new Dictionary();
         this._treasureHunts = new Dictionary();
         this._flagColors = new Array();
         super();
      }
      
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
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get finishedAchievementsIds() : Vector.<uint>
      {
         return this._finishedAchievementsIds;
      }
      
      public function getActiveQuests() : Vector.<QuestActiveInformations>
      {
         return this._activeQuests;
      }
      
      public function getCompletedQuests() : Vector.<uint>
      {
         return this._completedQuests;
      }
      
      public function getQuestInformations(param1:uint) : Object
      {
         return this._questsInformations[param1];
      }
      
      public function get rewardableAchievements() : Vector.<AchievementRewardable>
      {
         return this._rewardableAchievements;
      }
      
      public function getTreasureHuntById(param1:uint) : Object
      {
         return this._treasureHunts[param1];
      }
      
      public function pushed() : Boolean
      {
         this._rewardableAchievements = new Vector.<AchievementRewardable>();
         this._finishedAchievementsIds = new Vector.<uint>();
         this._treasureHunts = new Dictionary();
         this._nbAllAchievements = Achievement.getAchievements().length;
         this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_UNKNOWN] = 15636787;
         this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_OK] = 4521796;
         this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_WRONG] = 16729156;
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:QuestListRequestMessage = null;
         var _loc3_:QuestListMessage = null;
         var _loc4_:QuestInfosRequestAction = null;
         var _loc5_:QuestStepInfoRequestMessage = null;
         var _loc6_:QuestStepInfoMessage = null;
         var _loc7_:QuestStartRequestAction = null;
         var _loc8_:QuestStartRequestMessage = null;
         var _loc9_:QuestObjectiveValidationAction = null;
         var _loc10_:QuestObjectiveValidationMessage = null;
         var _loc11_:GuidedModeReturnRequestMessage = null;
         var _loc12_:GuidedModeQuitRequestMessage = null;
         var _loc13_:QuestStartedMessage = null;
         var _loc14_:QuestValidatedMessage = null;
         var _loc15_:Quest = null;
         var _loc16_:QuestObjectiveValidatedMessage = null;
         var _loc17_:QuestStepValidatedMessage = null;
         var _loc18_:Object = null;
         var _loc19_:QuestStepStartedMessage = null;
         var _loc20_:NotificationUpdateFlagAction = null;
         var _loc21_:NotificationUpdateFlagMessage = null;
         var _loc22_:NotificationResetMessage = null;
         var _loc23_:AchievementListMessage = null;
         var _loc24_:* = 0;
         var _loc25_:AchievementDetailedListRequestAction = null;
         var _loc26_:AchievementDetailedListRequestMessage = null;
         var _loc27_:AchievementDetailedListMessage = null;
         var _loc28_:AchievementDetailsRequestAction = null;
         var _loc29_:AchievementDetailsRequestMessage = null;
         var _loc30_:AchievementDetailsMessage = null;
         var _loc31_:AchievementFinishedInformationMessage = null;
         var _loc32_:String = null;
         var _loc33_:AchievementFinishedMessage = null;
         var _loc34_:AchievementRewardable = null;
         var _loc35_:String = null;
         var _loc36_:AchievementRewardRequestAction = null;
         var _loc37_:AchievementRewardRequestMessage = null;
         var _loc38_:AchievementRewardSuccessMessage = null;
         var _loc39_:* = 0;
         var _loc40_:AchievementRewardErrorMessage = null;
         var _loc41_:TreasureHuntShowLegendaryUIMessage = null;
         var _loc42_:TreasureHuntRequestAction = null;
         var _loc43_:TreasureHuntRequestMessage = null;
         var _loc44_:TreasureHuntLegendaryRequestAction = null;
         var _loc45_:TreasureHuntLegendaryRequestMessage = null;
         var _loc46_:TreasureHuntRequestAnswerMessage = null;
         var _loc47_:String = null;
         var _loc48_:TreasureHuntFlagRequestAction = null;
         var _loc49_:TreasureHuntFlagRequestMessage = null;
         var _loc50_:TreasureHuntFlagRemoveRequestAction = null;
         var _loc51_:TreasureHuntFlagRemoveRequestMessage = null;
         var _loc52_:TreasureHuntFlagRequestAnswerMessage = null;
         var _loc53_:String = null;
         var _loc54_:TreasureHuntMessage = null;
         var _loc55_:MapPosition = null;
         var _loc56_:TreasureHuntWrapper = null;
         var _loc57_:* = 0;
         var _loc58_:TreasureHuntAvailableRetryCountUpdateMessage = null;
         var _loc59_:TreasureHuntFinishedMessage = null;
         var _loc60_:TreasureHuntGiveUpRequestAction = null;
         var _loc61_:TreasureHuntGiveUpRequestMessage = null;
         var _loc62_:TreasureHuntDigRequestAction = null;
         var _loc63_:TreasureHuntDigRequestMessage = null;
         var _loc64_:TreasureHuntDigRequestAnswerMessage = null;
         var _loc65_:* = 0;
         var _loc66_:String = null;
         var _loc67_:QuestActiveDetailedInformations = null;
         var _loc68_:QuestObjectiveInformations = null;
         var _loc69_:Array = null;
         var _loc70_:* = 0;
         var _loc71_:Object = null;
         var _loc72_:* = 0;
         var _loc73_:QuestActiveInformations = null;
         var _loc74_:QuestStep = null;
         var _loc75_:* = 0;
         var _loc76_:* = 0;
         var _loc77_:* = 0;
         var _loc78_:AchievementRewardable = null;
         var _loc79_:AchievementRewardable = null;
         var _loc80_:* = 0;
         var _loc81_:TreasureHuntStepWrapper = null;
         var _loc82_:TreasureHuntFlag = null;
         switch(true)
         {
            case param1 is QuestListRequestAction:
               _loc2_ = new QuestListRequestMessage();
               _loc2_.initQuestListRequestMessage();
               ConnectionsHandler.getConnection().send(_loc2_);
               return true;
            case param1 is QuestListMessage:
               _loc3_ = param1 as QuestListMessage;
               this._activeQuests = _loc3_.activeQuests;
               this._completedQuests = _loc3_.finishedQuestsIds;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestListUpdated);
               return true;
            case param1 is QuestInfosRequestAction:
               _loc4_ = param1 as QuestInfosRequestAction;
               _loc5_ = new QuestStepInfoRequestMessage();
               _loc5_.initQuestStepInfoRequestMessage(_loc4_.questId);
               ConnectionsHandler.getConnection().send(_loc5_);
               return true;
            case param1 is QuestStepInfoMessage:
               _loc6_ = param1 as QuestStepInfoMessage;
               if(_loc6_.infos is QuestActiveDetailedInformations)
               {
                  _loc67_ = _loc6_.infos as QuestActiveDetailedInformations;
                  this._questsInformations[_loc67_.questId] = {
                     "questId":_loc67_.questId,
                     "stepId":_loc67_.stepId
                  };
                  this._questsInformations[_loc67_.questId].objectives = new Array();
                  this._questsInformations[_loc67_.questId].objectivesData = new Array();
                  this._questsInformations[_loc67_.questId].objectivesDialogParams = new Array();
                  for each(_loc68_ in _loc67_.objectives)
                  {
                     this._questsInformations[_loc67_.questId].objectives[_loc68_.objectiveId] = _loc68_.objectiveStatus;
                     if((_loc68_.dialogParams) && _loc68_.dialogParams.length > 0)
                     {
                        _loc69_ = new Array();
                        _loc70_ = _loc68_.dialogParams.length;
                        _loc57_ = 0;
                        while(_loc57_ < _loc70_)
                        {
                           _loc69_.push(_loc68_.dialogParams[_loc57_]);
                           _loc57_++;
                        }
                     }
                     this._questsInformations[_loc67_.questId].objectivesDialogParams[_loc68_.objectiveId] = _loc69_;
                     if(_loc68_ is QuestObjectiveInformationsWithCompletion)
                     {
                        _loc71_ = new Object();
                        _loc71_.current = (_loc68_ as QuestObjectiveInformationsWithCompletion).curCompletion;
                        _loc71_.max = (_loc68_ as QuestObjectiveInformationsWithCompletion).maxCompletion;
                        this._questsInformations[_loc67_.questId].objectivesData[_loc68_.objectiveId] = _loc71_;
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated,_loc67_.questId,true);
               }
               else if(_loc6_.infos is QuestActiveInformations)
               {
                  KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated,(_loc6_.infos as QuestActiveInformations).questId,false);
               }
               
               return true;
            case param1 is QuestStartRequestAction:
               _loc7_ = param1 as QuestStartRequestAction;
               _loc8_ = new QuestStartRequestMessage();
               _loc8_.initQuestStartRequestMessage(_loc7_.questId);
               ConnectionsHandler.getConnection().send(_loc8_);
               return true;
            case param1 is QuestObjectiveValidationAction:
               _loc9_ = param1 as QuestObjectiveValidationAction;
               _loc10_ = new QuestObjectiveValidationMessage();
               _loc10_.initQuestObjectiveValidationMessage(_loc9_.questId,_loc9_.objectiveId);
               ConnectionsHandler.getConnection().send(_loc10_);
               return true;
            case param1 is GuidedModeReturnRequestAction:
               _loc11_ = new GuidedModeReturnRequestMessage();
               _loc11_.initGuidedModeReturnRequestMessage();
               ConnectionsHandler.getConnection().send(_loc11_);
               return true;
            case param1 is GuidedModeQuitRequestAction:
               _loc12_ = new GuidedModeQuitRequestMessage();
               _loc12_.initGuidedModeQuitRequestMessage();
               ConnectionsHandler.getConnection().send(_loc12_);
               return true;
            case param1 is QuestStartedMessage:
               _loc13_ = param1 as QuestStartedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStarted,_loc13_.questId);
               return true;
            case param1 is QuestValidatedMessage:
               _loc14_ = param1 as QuestValidatedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestValidated,_loc14_.questId);
               if(!this._completedQuests)
               {
                  this._completedQuests = new Vector.<uint>();
               }
               else
               {
                  for each(_loc73_ in this._activeQuests)
                  {
                     if(_loc73_.questId == _loc14_.questId)
                     {
                        break;
                     }
                     _loc72_++;
                  }
                  if((this._activeQuests) && _loc72_ < this._activeQuests.length)
                  {
                     this._activeQuests.splice(_loc72_,1);
                  }
               }
               this._completedQuests.push(_loc14_.questId);
               _loc15_ = Quest.getQuestById(_loc14_.questId);
               for each(_loc74_ in _loc15_.steps)
               {
                  for each(_loc75_ in _loc74_.objectiveIds)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc14_.questId + "_" + _loc75_,PlayedCharacterManager.getInstance().currentWorldMap.id);
                  }
               }
               return true;
            case param1 is QuestObjectiveValidatedMessage:
               _loc16_ = param1 as QuestObjectiveValidatedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestObjectiveValidated,_loc16_.questId,_loc16_.objectiveId);
               KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc16_.questId + "_" + _loc16_.objectiveId,PlayedCharacterManager.getInstance().currentWorldMap.id);
               return true;
            case param1 is QuestStepValidatedMessage:
               _loc17_ = param1 as QuestStepValidatedMessage;
               if(this._questsInformations[_loc17_.questId])
               {
                  this._questsInformations[_loc17_.questId].stepId = _loc17_.stepId;
               }
               _loc18_ = QuestStep.getQuestStepById(_loc17_.stepId).objectiveIds;
               for each(_loc76_ in _loc18_)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc17_.questId + "_" + _loc76_,PlayedCharacterManager.getInstance().currentWorldMap.id);
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepValidated,_loc17_.questId,_loc17_.stepId);
               return true;
            case param1 is QuestStepStartedMessage:
               _loc19_ = param1 as QuestStepStartedMessage;
               if(this._questsInformations[_loc19_.questId])
               {
                  this._questsInformations[_loc19_.questId].stepId = _loc19_.stepId;
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepStarted,_loc19_.questId,_loc19_.stepId);
               return true;
            case param1 is NotificationUpdateFlagAction:
               _loc20_ = param1 as NotificationUpdateFlagAction;
               _loc21_ = new NotificationUpdateFlagMessage();
               _loc21_.initNotificationUpdateFlagMessage(_loc20_.index);
               ConnectionsHandler.getConnection().send(_loc21_);
               return true;
            case param1 is NotificationResetAction:
               notificationList = new Array();
               _loc22_ = new NotificationResetMessage();
               _loc22_.initNotificationResetMessage();
               ConnectionsHandler.getConnection().send(_loc22_);
               KernelEventsManager.getInstance().processCallback(HookList.NotificationReset);
               return true;
            case param1 is AchievementListMessage:
               _loc23_ = param1 as AchievementListMessage;
               this._finishedAchievementsIds = _loc23_.finishedAchievementsIds;
               this._rewardableAchievements = _loc23_.rewardableAchievements;
               for each(_loc77_ in this._finishedAchievementsIds)
               {
                  if(Achievement.getAchievementById(_loc77_))
                  {
                     _loc24_ = _loc24_ + Achievement.getAchievementById(_loc77_).points;
                  }
                  else
                  {
                     _log.warn("Succés " + _loc77_ + " non exporté");
                  }
               }
               for each(_loc78_ in this._rewardableAchievements)
               {
                  if(Achievement.getAchievementById(_loc78_.id))
                  {
                     _loc24_ = _loc24_ + Achievement.getAchievementById(_loc78_.id).points;
                     this._finishedAchievementsIds.push(_loc78_.id);
                  }
                  else
                  {
                     _log.warn("Succés " + _loc78_.id + " non exporté");
                  }
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementList,this._finishedAchievementsIds);
               if(!this._rewardableAchievementsVisible && this._rewardableAchievements.length > 0)
               {
                  this._rewardableAchievementsVisible = true;
                  KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
               }
               PlayedCharacterManager.getInstance().achievementPercent = Math.floor(this._finishedAchievementsIds.length / this._nbAllAchievements * 100);
               PlayedCharacterManager.getInstance().achievementPoints = _loc24_;
               return true;
            case param1 is AchievementDetailedListRequestAction:
               _loc25_ = param1 as AchievementDetailedListRequestAction;
               _loc26_ = new AchievementDetailedListRequestMessage();
               _loc26_.initAchievementDetailedListRequestMessage(_loc25_.categoryId);
               ConnectionsHandler.getConnection().send(_loc26_);
               return true;
            case param1 is AchievementDetailedListMessage:
               _loc27_ = param1 as AchievementDetailedListMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetailedList,_loc27_.finishedAchievements,_loc27_.startedAchievements);
               return true;
            case param1 is AchievementDetailsRequestAction:
               _loc28_ = param1 as AchievementDetailsRequestAction;
               _loc29_ = new AchievementDetailsRequestMessage();
               _loc29_.initAchievementDetailsRequestMessage(_loc28_.achievementId);
               ConnectionsHandler.getConnection().send(_loc29_);
               return true;
            case param1 is AchievementDetailsMessage:
               _loc30_ = param1 as AchievementDetailsMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetails,_loc30_.achievement);
               return true;
            case param1 is AchievementFinishedInformationMessage:
               _loc31_ = param1 as AchievementFinishedInformationMessage;
               _loc32_ = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.characterUnlocksAchievement",["{player," + _loc31_.name + "," + _loc31_.playerId + "}"]),[_loc31_.name,_loc31_.id]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc32_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is AchievementFinishedMessage:
               _loc33_ = param1 as AchievementFinishedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementFinished,_loc33_.id);
               this._finishedAchievementsIds.push(_loc33_.id);
               _loc34_ = new AchievementRewardable();
               this._rewardableAchievements.push(_loc34_.initAchievementRewardable(_loc33_.id,_loc33_.finishedlevel));
               if(!this._rewardableAchievementsVisible)
               {
                  this._rewardableAchievementsVisible = true;
                  KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
               }
               _loc35_ = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.achievementUnlockWithLink"),[_loc33_.id]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc35_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               PlayedCharacterManager.getInstance().achievementPercent = Math.floor(this._finishedAchievementsIds.length / this._nbAllAchievements * 100);
               PlayedCharacterManager.getInstance().achievementPoints = PlayedCharacterManager.getInstance().achievementPoints + Achievement.getAchievementById(_loc33_.id).points;
               return true;
            case param1 is AchievementRewardRequestAction:
               _loc36_ = param1 as AchievementRewardRequestAction;
               _loc37_ = new AchievementRewardRequestMessage();
               _loc37_.initAchievementRewardRequestMessage(_loc36_.achievementId);
               ConnectionsHandler.getConnection().send(_loc37_);
               return true;
            case param1 is AchievementRewardSuccessMessage:
               _loc38_ = param1 as AchievementRewardSuccessMessage;
               for each(_loc79_ in this._rewardableAchievements)
               {
                  if(_loc79_.id == _loc38_.achievementId)
                  {
                     _loc39_ = this._rewardableAchievements.indexOf(_loc79_);
                     break;
                  }
               }
               this._rewardableAchievements.splice(_loc39_,1);
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementRewardSuccess,_loc38_.achievementId);
               if((this._rewardableAchievementsVisible) && this._rewardableAchievements.length == 0)
               {
                  this._rewardableAchievementsVisible = false;
                  KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
               }
               return true;
            case param1 is AchievementRewardErrorMessage:
               _loc40_ = param1 as AchievementRewardErrorMessage;
               return true;
            case param1 is TreasureHuntShowLegendaryUIMessage:
               _loc41_ = param1 as TreasureHuntShowLegendaryUIMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntLegendaryUiUpdate,_loc41_.availableLegendaryIds);
               return true;
            case param1 is TreasureHuntRequestAction:
               _loc42_ = param1 as TreasureHuntRequestAction;
               _loc43_ = new TreasureHuntRequestMessage();
               _loc43_.initTreasureHuntRequestMessage(_loc42_.level,_loc42_.questType);
               ConnectionsHandler.getConnection().send(_loc43_);
               return true;
            case param1 is TreasureHuntLegendaryRequestAction:
               _loc44_ = param1 as TreasureHuntLegendaryRequestAction;
               _loc45_ = new TreasureHuntLegendaryRequestMessage();
               _loc45_.initTreasureHuntLegendaryRequestMessage(_loc44_.legendaryId);
               ConnectionsHandler.getConnection().send(_loc45_);
               return true;
            case param1 is TreasureHuntRequestAnswerMessage:
               _loc46_ = param1 as TreasureHuntRequestAnswerMessage;
               if(_loc46_.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_ALREADY_HAVE_QUEST)
               {
                  _loc47_ = I18n.getUiText("ui.treasureHunt.alreadyHaveQuest");
               }
               else if(_loc46_.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_NO_QUEST_FOUND)
               {
                  _loc47_ = I18n.getUiText("ui.treasureHunt.noQuestFound");
               }
               else if(_loc46_.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_UNDEFINED)
               {
                  _loc47_ = I18n.getUiText("ui.popup.impossible_action");
               }
               else if(_loc46_.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_NOT_AVAILABLE)
               {
                  _loc47_ = I18n.getUiText("ui.treasureHunt.huntNotAvailable");
               }
               
               
               
               if(_loc47_)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc47_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case param1 is TreasureHuntFlagRequestAction:
               _loc48_ = param1 as TreasureHuntFlagRequestAction;
               _loc49_ = new TreasureHuntFlagRequestMessage();
               _loc49_.initTreasureHuntFlagRequestMessage(_loc48_.questType,_loc48_.index);
               ConnectionsHandler.getConnection().send(_loc49_);
               return true;
            case param1 is TreasureHuntFlagRemoveRequestAction:
               _loc50_ = param1 as TreasureHuntFlagRemoveRequestAction;
               _loc51_ = new TreasureHuntFlagRemoveRequestMessage();
               _loc51_.initTreasureHuntFlagRemoveRequestMessage(_loc50_.questType,_loc50_.index);
               ConnectionsHandler.getConnection().send(_loc51_);
               return true;
            case param1 is TreasureHuntFlagRequestAnswerMessage:
               _loc52_ = param1 as TreasureHuntFlagRequestAnswerMessage;
               switch(_loc52_.result)
               {
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_OK:
                     break;
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_ERROR_UNDEFINED:
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_WRONG:
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_TOO_MANY:
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_ERROR_IMPOSSIBLE:
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_WRONG_INDEX:
                     _loc53_ = I18n.getUiText("ui.treasureHunt.flagFail");
                     break;
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_SAME_MAP:
                     _loc53_ = I18n.getUiText("ui.treasureHunt.flagFailSameMap");
                     break;
               }
               if(_loc53_)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc53_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case param1 is TreasureHuntMessage:
               _loc54_ = param1 as TreasureHuntMessage;
               if((this._treasureHunts[_loc54_.questType]) && (this._treasureHunts[_loc54_.questType].stepList.length))
               {
                  _loc80_ = 0;
                  for each(_loc81_ in this._treasureHunts[_loc54_.questType].stepList)
                  {
                     if(_loc81_.flagState > -1)
                     {
                        _loc80_++;
                        if(!_loc55_)
                        {
                           _loc55_ = MapPosition.getMapPositionById(_loc81_.mapId);
                        }
                        if(_loc55_.worldMap > -1)
                        {
                           KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_hunt_" + _loc54_.questType + "_" + _loc80_,_loc55_.worldMap);
                        }
                     }
                  }
               }
               _loc56_ = TreasureHuntWrapper.create(_loc54_.questType,_loc54_.startMapId,_loc54_.checkPointCurrent,_loc54_.checkPointTotal,_loc54_.totalStepCount,_loc54_.availableRetryCount,_loc54_.knownStepsList,_loc54_.flags);
               this._treasureHunts[_loc54_.questType] = _loc56_;
               _loc57_ = 0;
               for each(_loc82_ in _loc54_.flags)
               {
                  _loc57_++;
                  _loc55_ = MapPosition.getMapPositionById(_loc82_.mapId);
                  if(_loc55_.worldMap > -1)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,"flag_hunt_" + _loc54_.questType + "_" + _loc57_,I18n.getUiText("ui.treasureHunt.huntType" + _loc54_.questType) + " - Indice n°" + _loc57_ + " [" + _loc55_.posX + "," + _loc55_.posY + "]",_loc55_.worldMap,_loc55_.posX,_loc55_.posY,this._flagColors[_loc82_.state],false,false,false);
                  }
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntUpdate,_loc56_.questType);
               return true;
            case param1 is TreasureHuntAvailableRetryCountUpdateMessage:
               _loc58_ = param1 as TreasureHuntAvailableRetryCountUpdateMessage;
               this._treasureHunts[_loc58_.questType].availableRetryCount = _loc58_.availableRetryCount;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntAvailableRetryCountUpdate,_loc58_.questType,_loc58_.availableRetryCount);
               return true;
            case param1 is TreasureHuntFinishedMessage:
               _loc59_ = param1 as TreasureHuntFinishedMessage;
               if(this._treasureHunts[_loc59_.questType])
               {
                  if(this._treasureHunts[_loc59_.questType].stepList.length)
                  {
                     _loc80_ = 0;
                     for each(_loc81_ in this._treasureHunts[_loc59_.questType].stepList)
                     {
                        if(_loc81_.flagState > -1)
                        {
                           _loc80_++;
                           if(!_loc55_)
                           {
                              _loc55_ = MapPosition.getMapPositionById(_loc81_.mapId);
                           }
                           if(_loc55_.worldMap > -1)
                           {
                              KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_hunt_" + _loc59_.questType + "_" + _loc80_,_loc55_.worldMap);
                           }
                        }
                     }
                  }
                  this._treasureHunts[_loc59_.questType] = null;
                  delete this._treasureHunts[_loc59_.questType];
                  true;
                  KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntFinished,_loc59_.questType);
               }
               return true;
            case param1 is TreasureHuntGiveUpRequestAction:
               _loc60_ = param1 as TreasureHuntGiveUpRequestAction;
               _loc61_ = new TreasureHuntGiveUpRequestMessage();
               _loc61_.initTreasureHuntGiveUpRequestMessage(_loc60_.questType);
               ConnectionsHandler.getConnection().send(_loc61_);
               return true;
            case param1 is TreasureHuntDigRequestAction:
               _loc62_ = param1 as TreasureHuntDigRequestAction;
               _loc63_ = new TreasureHuntDigRequestMessage();
               _loc63_.initTreasureHuntDigRequestMessage(_loc62_.questType);
               ConnectionsHandler.getConnection().send(_loc63_);
               return true;
            case param1 is TreasureHuntDigRequestAnswerMessage:
               _loc64_ = param1 as TreasureHuntDigRequestAnswerMessage;
               if(_loc64_ is TreasureHuntDigRequestAnswerFailedMessage)
               {
                  _loc65_ = (_loc64_ as TreasureHuntDigRequestAnswerFailedMessage).wrongFlagCount;
               }
               if(_loc64_.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_ERROR_IMPOSSIBLE)
               {
                  _loc66_ = I18n.getUiText("ui.fight.wrongMap");
               }
               else if(_loc64_.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_ERROR_UNDEFINED)
               {
                  _loc66_ = I18n.getUiText("ui.popup.impossible_action");
               }
               else if(_loc64_.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_LOST)
               {
                  _loc66_ = I18n.getUiText("ui.treasureHunt.huntFail");
               }
               else if(_loc64_.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_NEW_HINT)
               {
                  _loc66_ = I18n.getUiText("ui.treasureHunt.stepSuccess");
               }
               else if(_loc64_.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_WRONG)
               {
                  if(_loc65_ > 1)
                  {
                     _loc66_ = I18n.getUiText("ui.treasureHunt.digWrongFlags",[_loc65_]);
                  }
                  else if(_loc65_ > 0)
                  {
                     _loc66_ = I18n.getUiText("ui.treasureHunt.digWrongFlag");
                  }
                  else
                  {
                     _loc66_ = I18n.getUiText("ui.treasureHunt.digFail");
                  }
                  
               }
               else if(_loc64_.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_WRONG_AND_YOU_KNOW_IT)
               {
                  _loc66_ = I18n.getUiText("ui.treasureHunt.noNewFlag");
               }
               else if(_loc64_.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_FINISHED)
               {
                  if(_loc64_.questType == TreasureHuntTypeEnum.TREASURE_HUNT_CLASSIC)
                  {
                     _loc66_ = I18n.getUiText("ui.treasureHunt.huntSuccess");
                  }
               }
               
               
               
               
               
               
               if(_loc66_)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc66_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
   }
}
