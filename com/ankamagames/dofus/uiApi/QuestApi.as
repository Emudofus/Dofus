package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementRewardable;
    import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.kernel.Kernel;
    import __AS3__.vec.*;

    [InstanciedApi]
    public class QuestApi implements IApi 
    {

        protected var _log:Logger;
        private var _module:UiModule;

        public function QuestApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(QuestApi));
            super();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Untrusted]
        public function getQuestInformations(questId:int):Object
        {
            return (this.getQuestFrame().getQuestInformations(questId));
        }

        [Untrusted]
        public function getAllQuests():Vector.<Object>
        {
            var activeQuest:QuestActiveInformations;
            var completedQuests:Vector.<uint>;
            var completedQuest:uint;
            var r:Vector.<Object> = new Vector.<Object>(0, false);
            var activeQuests:Vector.<QuestActiveInformations> = this.getQuestFrame().getActiveQuests();
            for each (activeQuest in activeQuests)
            {
                r.push({
                    "id":activeQuest.questId,
                    "status":true
                });
            };
            completedQuests = this.getQuestFrame().getCompletedQuests();
            for each (completedQuest in completedQuests)
            {
                r.push({
                    "id":completedQuest,
                    "status":false
                });
            };
            return (r);
        }

        [Untrusted]
        public function getActiveQuests():Vector.<uint>
        {
            var activeQuest:QuestActiveInformations;
            var data:Vector.<uint> = new Vector.<uint>();
            var activeQuests:Vector.<QuestActiveInformations> = this.getQuestFrame().getActiveQuests();
            for each (activeQuest in activeQuests)
            {
                data.push(activeQuest.questId);
            };
            return (data);
        }

        [Untrusted]
        public function getCompletedQuests():Vector.<uint>
        {
            return (this.getQuestFrame().getCompletedQuests());
        }

        [Untrusted]
        public function getAllQuestsOrderByCategory(withCompletedQuests:Boolean=false):Array
        {
            var quest:Quest;
            var questInfos:QuestActiveInformations;
            var category:Object;
            var questId:uint;
            var completedQuests:Vector.<uint>;
            var catsListWithQuests:Array = new Array();
            var totalQuest:int;
            var tabIndex:uint;
            var activeQuests:Vector.<QuestActiveInformations> = this.getQuestFrame().getActiveQuests();
            totalQuest = (totalQuest + activeQuests.length);
            for each (questInfos in activeQuests)
            {
                quest = Quest.getQuestById(questInfos.questId);
                tabIndex = quest.category.order;
                if ((((tabIndex > catsListWithQuests.length)) || (!(catsListWithQuests[tabIndex]))))
                {
                    category = new Object();
                    category.data = new Array();
                    category.id = quest.categoryId;
                    catsListWithQuests[tabIndex] = category;
                };
                catsListWithQuests[tabIndex].data.push({
                    "id":questInfos.questId,
                    "status":true
                });
            };
            if (withCompletedQuests)
            {
                completedQuests = this.getQuestFrame().getCompletedQuests();
                totalQuest = (totalQuest + completedQuests.length);
                for each (questId in completedQuests)
                {
                    quest = Quest.getQuestById(questId);
                    tabIndex = quest.category.order;
                    if ((((tabIndex > catsListWithQuests.length)) || (!(catsListWithQuests[tabIndex]))))
                    {
                        category = new Object();
                        category.data = new Array();
                        category.id = quest.categoryId;
                        catsListWithQuests[tabIndex] = category;
                    };
                    catsListWithQuests[tabIndex].data.push({
                        "id":questId,
                        "status":false
                    });
                };
            };
            return (catsListWithQuests);
        }

        [Untrusted]
        public function getTutorialReward():Vector.<ItemWrapper>
        {
            var itemWrapperList:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
            itemWrapperList.push(ItemWrapper.create(0, 0, 10785, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 0x2A2A, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10797, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10798, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10799, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10784, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10800, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10801, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10792, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10793, 2, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10795, 1, null, false));
            itemWrapperList.push(ItemWrapper.create(0, 0, 10796, 1, null, false));
            return (itemWrapperList);
        }

        [Untrusted]
        public function getNotificationList():Array
        {
            return (QuestFrame.notificationList);
        }

        [Untrusted]
        public function getFinishedAchievementsIds():Vector.<uint>
        {
            return (this.getQuestFrame().finishedAchievementsIds);
        }

        [Untrusted]
        public function isAchievementFinished(id:int):Boolean
        {
            return (!((this.getQuestFrame().finishedAchievementsIds.indexOf(id) == -1)));
        }

        [Untrusted]
        public function getAchievementKamasReward(achievement:Achievement, level:int=0):Number
        {
            if (level == 0)
            {
                level = PlayedCharacterManager.getInstance().infos.level;
            };
            return (achievement.getKamasReward(level));
        }

        [Untrusted]
        public function getAchievementExperienceReward(achievement:Achievement, level:int=0):Number
        {
            if (level == 0)
            {
                level = PlayedCharacterManager.getInstance().infos.level;
            };
            return (achievement.getExperienceReward(level, PlayedCharacterManager.getInstance().experiencePercent));
        }

        [Untrusted]
        public function getRewardableAchievements():Vector.<AchievementRewardable>
        {
            return (this.getQuestFrame().rewardableAchievements);
        }

        [Untrusted]
        public function getAchievementObjectivesNames(achId:int):String
        {
            var objId:int;
            var objAch:AchievementObjective;
            var text:String = "-";
            var a:Achievement = Achievement.getAchievementById(achId);
            for each (objId in a.objectiveIds)
            {
                objAch = AchievementObjective.getAchievementObjectiveById(objId);
                if (((objAch) && (objAch.name)))
                {
                    text = (text + (" " + StringUtils.noAccent(objAch.name).toLowerCase()));
                };
            };
            return (text);
        }

        [Untrusted]
        public function getTreasureHunt(typeId:int):Object
        {
            return (this.getQuestFrame().getTreasureHuntById(typeId));
        }

        private function getQuestFrame():QuestFrame
        {
            return ((Kernel.getWorker().getFrame(QuestFrame) as QuestFrame));
        }


    }
}//package com.ankamagames.dofus.uiApi

