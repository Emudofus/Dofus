package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class QuestHookList extends Object
   {
      
      public function QuestHookList() {
         super();
      }
      
      public static const QuestListUpdated:Hook = new Hook("QuestListUpdated",false);
      
      public static const QuestInfosUpdated:Hook = new Hook("QuestInfosUpdated",false);
      
      public static const QuestStarted:Hook = new Hook("QuestStarted",false);
      
      public static const QuestValidated:Hook = new Hook("QuestValidated",false);
      
      public static const QuestObjectiveValidated:Hook = new Hook("QuestObjectiveValidated",false);
      
      public static const QuestStepValidated:Hook = new Hook("QuestStepValidated",false);
      
      public static const QuestStepStarted:Hook = new Hook("QuestStepStarted",false);
      
      public static const AchievementList:Hook = new Hook("AchievementList",false);
      
      public static const AchievementDetailedList:Hook = new Hook("AchievementDetailedList",false);
      
      public static const AchievementDetails:Hook = new Hook("AchievementDetails",false);
      
      public static const AchievementFinished:Hook = new Hook("AchievementFinished",false);
      
      public static const AchievementRewardSuccess:Hook = new Hook("AchievementRewardSuccess",false);
      
      public static const AchievementRewardError:Hook = new Hook("AchievementRewardError",false);
      
      public static const RewardableAchievementsVisible:Hook = new Hook("RewardableAchievementsVisible",false);
      
      public static const TitlesListUpdated:Hook = new Hook("TitlesListUpdated",false);
      
      public static const OrnamentsListUpdated:Hook = new Hook("OrnamentsListUpdated",false);
      
      public static const TitleUpdated:Hook = new Hook("TitleUpdated",false);
      
      public static const OrnamentUpdated:Hook = new Hook("OrnamentUpdated",false);
      
      public static const TreasureHuntUpdate:Hook = new Hook("TreasureHuntUpdate",false);
      
      public static const TreasureHuntFinished:Hook = new Hook("TreasureHuntFinished",false);
      
      public static const TreasureHuntAvailableRetryCountUpdate:Hook = new Hook("TreasureHuntAvailableRetryCountUpdate",false);
      
      public static const AreaFightModificatorUpdate:Hook = new Hook("AreaFightModificatorUpdate",false);
   }
}
