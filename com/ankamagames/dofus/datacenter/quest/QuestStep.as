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
        private var _kamasReward:int;
        private var _xpReward:int;
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
            return this.getExperienceReward();
        }// end function

        public function get kamasReward() : uint
        {
            return this.getKamasReward();
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
            var _loc_1:uint = 0;
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
            var _loc_2:uint = 0;
            var _loc_3:QuestStepRewards = null;
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

        private function getKamasReward() : int
        {
            return Math.pow(this.kamasScaleWithPlayerLevel ? (PlayedCharacterManager.getInstance().infos.level) : (this.optimalLevel), 2) * 2 * this.duration * this.kamasRatio;
        }// end function

        private function getExperienceReward() : int
        {
            var _loc_3:int = 0;
            var _loc_1:* = PlayedCharacterManager.getInstance().infos.level;
            var _loc_2:* = 1 + PlayedCharacterManager.getInstance().experiencePercent / 100;
            if (_loc_1 > this.optimalLevel)
            {
                _loc_3 = Math.min(PlayedCharacterManager.getInstance().infos.level, this.optimalLevel * REWARD_SCALE_CAP);
                return ((1 - REWARD_REDUCED_SCALE) * this.getFixeExperienceReward(this.optimalLevel) + REWARD_REDUCED_SCALE * this.getFixeExperienceReward(_loc_3)) * _loc_2;
            }
            return this.getFixeExperienceReward(_loc_1) * _loc_2;
        }// end function

        private function getFixeExperienceReward(param1:int) : int
        {
            return param1 * Math.pow(100 + 2 * param1, 2) / 10 * this.duration * this.xpRatio;
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
