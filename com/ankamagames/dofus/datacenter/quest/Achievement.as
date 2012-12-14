package com.ankamagames.dofus.datacenter.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Achievement extends Object implements IDataCenter
    {
        public var id:uint;
        public var nameId:uint;
        public var categoryId:uint;
        public var descriptionId:uint;
        public var iconId:uint;
        public var points:uint;
        public var level:uint;
        public var order:uint;
        public var kamasRatio:Number;
        public var experienceRatio:Number;
        public var kamasScaleWithPlayerLevel:Boolean;
        public var objectiveIds:Vector.<int>;
        public var rewardIds:Vector.<int>;
        private var _name:String;
        private var _desc:String;
        private var _category:AchievementCategory;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Achievement));
        private static const MODULE:String = "Achievements";
        private static const REWARD_SCALE_CAP:Number = 1.5;
        private static const REWARD_REDUCED_SCALE:Number = 0.7;

        public function Achievement()
        {
            return;
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
            if (!this._desc)
            {
                this._desc = I18n.getText(this.descriptionId);
            }
            return this._desc;
        }// end function

        public function get category() : AchievementCategory
        {
            if (!this._category)
            {
                this._category = AchievementCategory.getAchievementCategoryById(this.categoryId);
            }
            return this._category;
        }// end function

        public function getKamasReward(param1:int) : Number
        {
            var _loc_2:* = this.kamasScaleWithPlayerLevel ? (param1) : (this.level);
            return (Math.pow(_loc_2, 2) + 20 * _loc_2 - 20) * this.kamasRatio;
        }// end function

        public function getExperienceReward(param1:int, param2:int) : Number
        {
            var _loc_4:* = 0;
            var _loc_3:* = 1 + param2 / 100;
            if (param1 > this.level)
            {
                _loc_4 = Math.min(param1, this.level * REWARD_SCALE_CAP);
                return ((1 - REWARD_REDUCED_SCALE) * this.getFixeExperienceReward(this.level) + REWARD_REDUCED_SCALE * this.getFixeExperienceReward(_loc_4)) * _loc_3;
            }
            return this.getFixeExperienceReward(param1) * _loc_3;
        }// end function

        private function getFixeExperienceReward(param1:int) : int
        {
            return param1 * Math.pow(100 + 2 * param1, 2) / 20 * this.experienceRatio;
        }// end function

        public static function getAchievementById(param1:int) : Achievement
        {
            return GameData.getObject(MODULE, param1) as Achievement;
        }// end function

        public static function getAchievements() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
