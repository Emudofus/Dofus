package com.ankamagames.dofus.datacenter.quest
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.npcs.NpcMessage;
    import __AS3__.vec.*;

    public class QuestStep implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestStep));
        public static const MODULE:String = "QuestSteps";

        public var id:uint;
        public var questId:uint;
        public var nameId:uint;
        public var descriptionId:uint;
        public var dialogId:int;
        public var optimalLevel:uint;
        public var duration:Number;
        public var kamasScaleWithPlayerLevel:Boolean;
        public var kamasRatio:Number;
        public var xpRatio:Number;
        private var _currentLevelRewards:QuestStepRewards;
        public var objectiveIds:Vector.<uint>;
        public var rewardsIds:Vector.<uint>;
        private var _name:String;
        private var _description:String;
        private var _dialog:String;
        private var _objectives:Vector.<QuestObjective>;


        public static function getQuestStepById(id:int):QuestStep
        {
            return ((GameData.getObject(MODULE, id) as QuestStep));
        }

        public static function getQuestSteps():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get experienceReward():uint
        {
            return (RoleplayManager.getInstance().getExperienceReward(PlayedCharacterManager.getInstance().infos.level, PlayedCharacterManager.getInstance().experiencePercent, this.optimalLevel, this.xpRatio, this.duration));
        }

        public function get kamasReward():uint
        {
            return (RoleplayManager.getInstance().getKamasReward(this.kamasScaleWithPlayerLevel, this.optimalLevel, this.kamasRatio, this.duration));
        }

        public function get itemsReward():Vector.<Vector.<uint>>
        {
            this.initCurrentLevelRewards();
            return ((((this._currentLevelRewards == null)) ? null : this._currentLevelRewards.itemsReward));
        }

        public function get emotesReward():Vector.<uint>
        {
            this.initCurrentLevelRewards();
            return ((((this._currentLevelRewards == null)) ? null : this._currentLevelRewards.emotesReward));
        }

        public function get jobsReward():Vector.<uint>
        {
            this.initCurrentLevelRewards();
            return ((((this._currentLevelRewards == null)) ? null : this._currentLevelRewards.jobsReward));
        }

        public function get spellsReward():Vector.<uint>
        {
            this.initCurrentLevelRewards();
            return ((((this._currentLevelRewards == null)) ? null : this._currentLevelRewards.spellsReward));
        }

        public function get name():String
        {
            if (!(this._name))
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get description():String
        {
            if (!(this._description))
            {
                this._description = I18n.getText(this.descriptionId);
            };
            return (this._description);
        }

        public function get dialog():String
        {
            if (this.dialogId < 1)
            {
                return ("");
            };
            if (!(this._dialog))
            {
                this._dialog = NpcMessage.getNpcMessageById(this.dialogId).message;
            };
            return (this._dialog);
        }

        public function get objectives():Vector.<QuestObjective>
        {
            var i:uint;
            if (!(this._objectives))
            {
                this._objectives = new Vector.<QuestObjective>(this.objectiveIds.length, true);
                i = 0;
                while (i < this.objectiveIds.length)
                {
                    this._objectives[i] = QuestObjective.getQuestObjectiveById(this.objectiveIds[i]);
                    i++;
                };
            };
            return (this._objectives);
        }

        private function initCurrentLevelRewards():void
        {
            var rewardsId:uint;
            var rewards:QuestStepRewards;
            var playerLvl:uint = PlayedCharacterManager.getInstance().infos.level;
            if ((((((this._currentLevelRewards == null)) || ((((playerLvl < this._currentLevelRewards.levelMin)) && (!((this._currentLevelRewards.levelMin == -1))))))) || ((((playerLvl > this._currentLevelRewards.levelMax)) && (!((this._currentLevelRewards.levelMax == -1)))))))
            {
                this._currentLevelRewards = null;
                for each (rewardsId in this.rewardsIds)
                {
                    rewards = QuestStepRewards.getQuestStepRewardsById(rewardsId);
                    if ((((((playerLvl >= rewards.levelMin)) || ((rewards.levelMin == -1)))) && ((((playerLvl <= rewards.levelMax)) || ((rewards.levelMax == -1))))))
                    {
                        this._currentLevelRewards = rewards;
                        break;
                    };
                };
            };
        }

        public function getKamasReward(pPlayerLevel:int):Number
        {
            return (RoleplayManager.getInstance().getKamasReward(this.kamasScaleWithPlayerLevel, this.optimalLevel, this.kamasRatio, this.duration, pPlayerLevel));
        }

        public function getExperienceReward(pPlayerLevel:int, pXpBonus:int):Number
        {
            return (RoleplayManager.getInstance().getExperienceReward(pPlayerLevel, pXpBonus, this.optimalLevel, this.xpRatio, this.duration));
        }


    }
}//package com.ankamagames.dofus.datacenter.quest

