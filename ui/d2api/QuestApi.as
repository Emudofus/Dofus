package d2api
{
    import d2data.Achievement;

    public class QuestApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getQuestInformations(questId:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getAllQuests():Object
        {
            return (null);
        }

        [Untrusted]
        public function getActiveQuests():Object
        {
            return (null);
        }

        [Untrusted]
        public function getCompletedQuests():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAllQuestsOrderByCategory(withCompletedQuests:Boolean=false):Object
        {
            return (null);
        }

        [Untrusted]
        public function getTutorialReward():Object
        {
            return (null);
        }

        [Untrusted]
        public function getNotificationList():Object
        {
            return (null);
        }

        [Untrusted]
        public function getFinishedAchievementsIds():Object
        {
            return (null);
        }

        [Untrusted]
        public function isAchievementFinished(id:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getAchievementKamasReward(achievement:Achievement, level:int=0):Number
        {
            return (0);
        }

        [Untrusted]
        public function getAchievementExperienceReward(achievement:Achievement, level:int=0):Number
        {
            return (0);
        }

        [Untrusted]
        public function getRewardableAchievements():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAchievementObjectivesNames(achId:int):String
        {
            return (null);
        }

        [Untrusted]
        public function getTreasureHunt(typeId:int):Object
        {
            return (null);
        }


    }
}//package d2api

