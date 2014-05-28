package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class QuestHookList extends Object
   {
      
      public function QuestHookList() {
         super();
      }
      
      public static const QuestListUpdated:Hook;
      
      public static const QuestInfosUpdated:Hook;
      
      public static const QuestStarted:Hook;
      
      public static const QuestValidated:Hook;
      
      public static const QuestObjectiveValidated:Hook;
      
      public static const QuestStepValidated:Hook;
      
      public static const QuestStepStarted:Hook;
      
      public static const AchievementList:Hook;
      
      public static const AchievementDetailedList:Hook;
      
      public static const AchievementDetails:Hook;
      
      public static const AchievementFinished:Hook;
      
      public static const AchievementRewardSuccess:Hook;
      
      public static const AchievementRewardError:Hook;
      
      public static const RewardableAchievementsVisible:Hook;
      
      public static const TitlesListUpdated:Hook;
      
      public static const OrnamentsListUpdated:Hook;
      
      public static const TitleUpdated:Hook;
      
      public static const OrnamentUpdated:Hook;
      
      public static const TreasureHuntUpdate:Hook;
      
      public static const TreasureHuntFinished:Hook;
      
      public static const TreasureHuntAvailableRetryCountUpdate:Hook;
      
      public static const AreaFightModificatorUpdate:Hook;
   }
}
