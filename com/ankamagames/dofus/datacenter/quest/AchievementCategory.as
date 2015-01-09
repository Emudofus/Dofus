package com.ankamagames.dofus.datacenter.quest
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;
    import __AS3__.vec.*;

    public class AchievementCategory implements IDataCenter 
    {

        public static const MODULE:String = "AchievementCategories";

        public var id:uint;
        public var nameId:uint;
        public var parentId:uint;
        public var icon:String;
        public var order:uint;
        public var color:String;
        public var achievementIds:Vector.<uint>;
        private var _name:String;
        private var _achievements:Vector.<Achievement>;


        public static function getAchievementCategoryById(id:int):AchievementCategory
        {
            return ((GameData.getObject(MODULE, id) as AchievementCategory));
        }

        public static function getAchievementCategories():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get name():String
        {
            if (!(this._name))
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get achievements():Vector.<Achievement>
        {
            var i:int;
            var len:int;
            if (!(this._achievements))
            {
                len = this.achievementIds.length;
                this._achievements = new Vector.<Achievement>(len, true);
                i = 0;
                while (i < len)
                {
                    this._achievements[i] = Achievement.getAchievementById(this.achievementIds[i]);
                    i++;
                };
            };
            return (this._achievements);
        }


    }
}//package com.ankamagames.dofus.datacenter.quest

