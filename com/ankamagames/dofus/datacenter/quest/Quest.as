package com.ankamagames.dofus.datacenter.quest
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import __AS3__.vec.*;

    public class Quest implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Quest));
        public static const MODULE:String = "Quests";

        public var id:uint;
        public var nameId:uint;
        public var stepIds:Vector.<uint>;
        public var categoryId:uint;
        public var isRepeatable:Boolean;
        public var repeatType:uint;
        public var repeatLimit:uint;
        public var isDungeonQuest:Boolean;
        public var levelMin:uint;
        public var levelMax:uint;
        private var _name:String;
        private var _steps:Vector.<QuestStep>;


        public static function getQuestById(id:int):Quest
        {
            return ((GameData.getObject(MODULE, id) as Quest));
        }

        public static function getQuests():Array
        {
            return (GameData.getObjects(MODULE));
        }

        public static function getFirstValidQuest(questFlag:GameRolePlayNpcQuestFlag):Quest
        {
            var validQuest:Quest;
            var quest:Quest;
            var questId:int;
            var res1:int;
            var res2:int;
            var validQuestRes:int;
            for each (questId in questFlag.questsToValidId)
            {
                quest = Quest.getQuestById(questId);
                if (quest != null)
                {
                    res1 = quest.getPriorityValue();
                    if ((((validQuestRes < res1)) || ((validQuest == null))))
                    {
                        validQuest = quest;
                        validQuestRes = res1;
                    };
                };
            };
            for each (questId in questFlag.questsToStartId)
            {
                quest = Quest.getQuestById(questId);
                if (quest != null)
                {
                    res2 = quest.getPriorityValue();
                    if ((((validQuestRes < res2)) || ((validQuest == null))))
                    {
                        validQuest = quest;
                        validQuestRes = res2;
                    };
                };
            };
            return (validQuest);
        }


        public function get name():String
        {
            if (!(this._name))
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get steps():Vector.<QuestStep>
        {
            var i:uint;
            if (!(this._steps))
            {
                this._steps = new Vector.<QuestStep>(this.stepIds.length, true);
                i = 0;
                while (i < this.steps.length)
                {
                    this._steps[i] = QuestStep.getQuestStepById(this.stepIds[i]);
                    i++;
                };
            };
            return (this._steps);
        }

        public function get category():QuestCategory
        {
            return (QuestCategory.getQuestCategoryById(this.categoryId));
        }

        public function getPriorityValue():int
        {
            var playerLvl:int = PlayedCharacterManager.getInstance().infos.level;
            var res:int;
            if ((((playerLvl >= this.levelMin)) && ((playerLvl <= this.levelMax))))
            {
                res = (res + 10000);
            };
            if (this.repeatType != 0)
            {
                res = (res + 1000);
            };
            return (res);
        }


    }
}//package com.ankamagames.dofus.datacenter.quest

