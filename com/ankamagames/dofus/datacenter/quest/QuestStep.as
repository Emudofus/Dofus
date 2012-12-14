package com.ankamagames.dofus.datacenter.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class QuestStep extends Object implements IDataCenter
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestStep));
        private static const MODULE:String = "QuestSteps";
        private static const REWARD_SCALE_CAP:Number = 1.5;
        private static const REWARD_REDUCED_SCALE:Number = 0.7;

        public function QuestStep()
        {
            return;
        }// end function

        public function get experienceReward() : uint
        {
            return this.getExperienceReward(PlayedCharacterManager.getInstance().infos.level, PlayedCharacterManager.getInstance().experiencePercent);
        }// end function

        public function get kamasReward() : uint
        {
            return this.getKamasReward(PlayedCharacterManager.getInstance().infos.level);
        }// end function

        public function get itemsReward() : Vector.<Vector.<uint>>
        {
            this.initCurrentLevelRewards();
            return this._currentLevelRewards == null ? (null) : (this._currentLevelRewards.itemsReward);
        }// end function

        public function get emotesReward() : Vector.<uint>
        {
            this.initCurrentLevelRewards();
            return this._currentLevelRewards == null ? (null) : (this._currentLevelRewards.emotesReward);
        }// end function

        public function get jobsReward() : Vector.<uint>
        {
            this.initCurrentLevelRewards();
            return this._currentLevelRewards == null ? (null) : (this._currentLevelRewards.jobsReward);
        }// end function

        public function get spellsReward() : Vector.<uint>
        {
            this.initCurrentLevelRewards();
            return this._currentLevelRewards == null ? (null) : (this._currentLevelRewards.spellsReward);
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public function get dialog() : String
        {
            if (this.dialogId < 1)
            {
                return "";
            }
            if (!this._dialog)
            {
                this._dialog = NpcMessage.getNpcMessageById(this.dialogId).message;
            }
            return this._dialog;
        }// end function

        public function get objectives() : Vector.<QuestObjective>
        {
            var _loc_1:* = 0;
            if (!this._objectives)
            {
                this._objectives = new Vector.<QuestObjective>(this.objectiveIds.length, true);
                _loc_1 = 0;
                while (_loc_1 < this.objectiveIds.length)
                {
                    
                    this._objectives[_loc_1] = QuestObjective.getQuestObjectiveById(this.objectiveIds[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
            }
            return this._objectives;
        }// end function

        private function initCurrentLevelRewards() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = PlayedCharacterManager.getInstance().infos.level;
            if (this._currentLevelRewards == null || _loc_1 < this._currentLevelRewards.levelMin && this._currentLevelRewards.levelMin != -1 || _loc_1 > this._currentLevelRewards.levelMax && this._currentLevelRewards.levelMax != -1)
            {
                this._currentLevelRewards = null;
                for each (_loc_2 in this.rewardsIds)
                {
                    
                    _loc_3 = QuestStepRewards.getQuestStepRewardsById(_loc_2);
                    if ((_loc_1 >= _loc_3.levelMin || _loc_3.levelMin == -1) && (_loc_1 <= _loc_3.levelMax || _loc_3.levelMax == -1))
                    {
                        this._currentLevelRewards = _loc_3;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function getKamasReward(param1:int) : int
        {
            var _loc_2:* = this.kamasScaleWithPlayerLevel ? (param1) : (this.optimalLevel);
            return (Math.pow(_loc_2, 2) + 20 * _loc_2 - 20) * this.kamasRatio * this.duration;
        }// end function

        public function getExperienceReward(param1:int, param2:int) : int
        {
            var _loc_4:* = 0;
            var _loc_3:* = 1 + param2 / 100;
            if (param1 > this.optimalLevel)
            {
                _loc_4 = Math.min(param1, this.optimalLevel * REWARD_SCALE_CAP);
                return ((1 - REWARD_REDUCED_SCALE) * this.getFixeExperienceReward(this.optimalLevel) + REWARD_REDUCED_SCALE * this.getFixeExperienceReward(_loc_4)) * _loc_3;
            }
            return this.getFixeExperienceReward(param1) * _loc_3;
        }// end function

        private function getFixeExperienceReward(param1:int) : int
        {
            return param1 * Math.pow(100 + 2 * param1, 2) / 20 * this.duration * this.xpRatio;
        }// end function

        public static function getQuestStepById(param1:int) : QuestStep
        {
            return GameData.getObject(MODULE, param1) as QuestStep;
        }// end function

        public static function getQuestSteps() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
