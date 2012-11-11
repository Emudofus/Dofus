package com.ankamagames.dofus.datacenter.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class QuestCategory extends Object implements IDataCenter
    {
        public var id:uint;
        public var nameId:uint;
        public var order:uint;
        public var questIds:Vector.<uint>;
        private var _name:String;
        private var _quests:Vector.<Quest>;
        private static const MODULE:String = "QuestCategory";

        public function QuestCategory()
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

        public function get quests() : Vector.<Quest>
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (!this._quests)
            {
                _loc_2 = this.questIds.length;
                this._quests = new Vector.<Quest>(_loc_2, true);
                _loc_1 = 0;
                while (_loc_1 < _loc_2)
                {
                    
                    this._quests[_loc_1] = Quest.getQuestById(this.questIds[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
            }
            return this._quests;
        }// end function

        public static function getQuestCategoryById(param1:int) : QuestCategory
        {
            return GameData.getObject(MODULE, param1) as QuestCategory;
        }// end function

        public static function getQuestCategories() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
