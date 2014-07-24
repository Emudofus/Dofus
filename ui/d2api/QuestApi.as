package d2api
{
   import d2data.Achievement;
   
   public class QuestApi extends Object
   {
      
      public function QuestApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getQuestInformations(questId:int) : Object {
         return null;
      }
      
      public function getAllQuests() : Object {
         return null;
      }
      
      public function getActiveQuests() : Object {
         return null;
      }
      
      public function getCompletedQuests() : Object {
         return null;
      }
      
      public function getAllQuestsOrderByCategory(withCompletedQuests:Boolean = false) : Object {
         return null;
      }
      
      public function getTutorialReward() : Object {
         return null;
      }
      
      public function getNotificationList() : Object {
         return null;
      }
      
      public function getFinishedAchievementsIds() : Object {
         return null;
      }
      
      public function isAchievementFinished(id:int) : Boolean {
         return false;
      }
      
      public function getAchievementKamasReward(achievement:Achievement, level:int = 0) : Number {
         return 0;
      }
      
      public function getAchievementExperienceReward(achievement:Achievement, level:int = 0) : Number {
         return 0;
      }
      
      public function getRewardableAchievements() : Object {
         return null;
      }
      
      public function getAchievementObjectivesNames(achId:int) : String {
         return null;
      }
      
      public function getTreasureHunt(typeId:int) : Object {
         return null;
      }
   }
}
