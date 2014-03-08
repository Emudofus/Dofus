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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestFrame));
      
      public static var notificationList:Array;
      
      private var _nbAllAchievements:int;
      
      private var _activeQuests:Vector.<QuestActiveInformations>;
      
      private var _completedQuests:Vector.<uint>;
      
      private var _questsInformations:Dictionary;
      
      private var _finishedAchievementsIds:Vector.<uint>;
      
      private var _rewardableAchievements:Vector.<AchievementRewardable>;
      
      private var _rewardableAchievementsVisible:Boolean;
      
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
      
      public function getQuestInformations(param1:uint) : Object {
         return this._questsInformations[param1];
      }
      
      public function get rewardableAchievements() : Vector.<AchievementRewardable> {
         return this._rewardableAchievements;
      }
      
      public function pushed() : Boolean {
         this._rewardableAchievements = new Vector.<AchievementRewardable>();
         this._finishedAchievementsIds = new Vector.<uint>();
         this._nbAllAchievements = Achievement.getAchievements().length;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
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
         var _loc41_:QuestActiveDetailedInformations = null;
         var _loc42_:QuestObjectiveInformations = null;
         var _loc43_:Array = null;
         var _loc44_:* = 0;
         var _loc45_:* = 0;
         var _loc46_:Object = null;
         var _loc47_:* = 0;
         var _loc48_:QuestActiveInformations = null;
         var _loc49_:QuestStep = null;
         var _loc50_:* = 0;
         var _loc51_:* = 0;
         var _loc52_:* = 0;
         var _loc53_:AchievementRewardable = null;
         var _loc54_:AchievementRewardable = null;
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
                  _loc41_ = _loc6_.infos as QuestActiveDetailedInformations;
                  this._questsInformations[_loc41_.questId] = 
                     {
                        "questId":_loc41_.questId,
                        "stepId":_loc41_.stepId
                     };
                  this._questsInformations[_loc41_.questId].objectives = new Array();
                  this._questsInformations[_loc41_.questId].objectivesData = new Array();
                  this._questsInformations[_loc41_.questId].objectivesDialogParams = new Array();
                  for each (_loc42_ in _loc41_.objectives)
                  {
                     this._questsInformations[_loc41_.questId].objectives[_loc42_.objectiveId] = _loc42_.objectiveStatus;
                     if((_loc42_.dialogParams) && _loc42_.dialogParams.length > 0)
                     {
                        _loc43_ = new Array();
                        _loc44_ = _loc42_.dialogParams.length;
                        _loc45_ = 0;
                        while(_loc45_ < _loc44_)
                        {
                           _loc43_.push(_loc42_.dialogParams[_loc45_]);
                           _loc45_++;
                        }
                     }
                     this._questsInformations[_loc41_.questId].objectivesDialogParams[_loc42_.objectiveId] = _loc43_;
                     if(_loc42_ is QuestObjectiveInformationsWithCompletion)
                     {
                        _loc46_ = new Object();
                        _loc46_.current = (_loc42_ as QuestObjectiveInformationsWithCompletion).curCompletion;
                        _loc46_.max = (_loc42_ as QuestObjectiveInformationsWithCompletion).maxCompletion;
                        this._questsInformations[_loc41_.questId].objectivesData[_loc42_.objectiveId] = _loc46_;
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated,_loc41_.questId,true);
               }
               else
               {
                  if(_loc6_.infos is QuestActiveInformations)
                  {
                     KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated,(_loc6_.infos as QuestActiveInformations).questId,false);
                  }
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
                  for each (_loc48_ in this._activeQuests)
                  {
                     if(_loc48_.questId == _loc14_.questId)
                     {
                        break;
                     }
                     _loc47_++;
                  }
                  if((this._activeQuests) && _loc47_ < this._activeQuests.length)
                  {
                     this._activeQuests.splice(_loc47_,1);
                  }
               }
               this._completedQuests.push(_loc14_.questId);
               _loc15_ = Quest.getQuestById(_loc14_.questId);
               for each (_loc49_ in _loc15_.steps)
               {
                  for each (_loc50_ in _loc49_.objectiveIds)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc14_.questId + "_" + _loc50_,PlayedCharacterManager.getInstance().currentWorldMap.id);
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
               for each (_loc51_ in _loc18_)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + _loc17_.questId + "_" + _loc51_,PlayedCharacterManager.getInstance().currentWorldMap.id);
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
               for each (_loc52_ in this._finishedAchievementsIds)
               {
                  if(Achievement.getAchievementById(_loc52_))
                  {
                     _loc24_ = _loc24_ + Achievement.getAchievementById(_loc52_).points;
                  }
                  else
                  {
                     _log.warn("Succés " + _loc52_ + " non exporté");
                  }
               }
               for each (_loc53_ in this._rewardableAchievements)
               {
                  if(Achievement.getAchievementById(_loc53_.id))
                  {
                     _loc24_ = _loc24_ + Achievement.getAchievementById(_loc53_.id).points;
                     this._finishedAchievementsIds.push(_loc53_.id);
                  }
                  else
                  {
                     _log.warn("Succés " + _loc53_.id + " non exporté");
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
               for each (_loc54_ in this._rewardableAchievements)
               {
                  if(_loc54_.id == _loc38_.achievementId)
                  {
                     _loc39_ = this._rewardableAchievements.indexOf(_loc54_);
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
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
