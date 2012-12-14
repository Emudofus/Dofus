package com.ankamagames.dofus.datacenter.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class AchievementCategory extends Object implements IDataCenter
    {
        public var id:uint;
        public var nameId:uint;
        public var parentId:uint;
        public var icon:String;
        public var order:uint;
        public var color:String;
        public var achievementIds:Vector.<uint>;
        private var _name:String;
        private var _achievements:Vector.<Achievement>;
        private static const MODULE:String = "AchievementCategories";

        public function AchievementCategory()
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

        public function get achievements() : Vector.<Achievement>
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (!this._achievements)
            {
                _loc_2 = this.achievementIds.length;
                this._achievements = new Vector.<Achievement>(_loc_2, true);
                _loc_1 = 0;
                while (_loc_1 < _loc_2)
                {
                    
                    this._achievements[_loc_1] = Achievement.getAchievementById(this.achievementIds[_loc_1]);
                    _loc_1++;
                }
            }
            return this._achievements;
        }// end function

        public static function getAchievementCategoryById(param1:int) : AchievementCategory
        {
            return GameData.getObject(MODULE, param1) as AchievementCategory;
        }// end function

        public static function getAchievementCategories() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
