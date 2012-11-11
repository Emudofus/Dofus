package com.ankamagames.dofus.datacenter.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Quest extends Object implements IDataCenter
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Quest));
        private static const MODULE:String = "Quests";

        public function Quest()
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

        public function get steps() : Vector.<QuestStep>
        {
            var _loc_1:* = 0;
            if (!this._steps)
            {
                this._steps = new Vector.<QuestStep>(this.stepIds.length, true);
                _loc_1 = 0;
                while (_loc_1 < this.steps.length)
                {
                    
                    this._steps[_loc_1] = QuestStep.getQuestStepById(this.stepIds[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
            }
            return this._steps;
        }// end function

        public function get category() : QuestCategory
        {
            return QuestCategory.getQuestCategoryById(this.categoryId);
        }// end function

        public function getPriorityValue() : int
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().infos.level;
            var _loc_2:* = 0;
            if (_loc_1 >= this.levelMin && _loc_1 <= this.levelMax)
            {
                _loc_2 = _loc_2 + 10000;
            }
            if (this.repeatType != 0)
            {
                _loc_2 = _loc_2 + 1000;
            }
            return _loc_2;
        }// end function

        public static function getQuestById(param1:int) : Quest
        {
            return GameData.getObject(MODULE, param1) as Quest;
        }// end function

        public static function getQuests() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

        public static function getFirstValidQuest(param1:GameRolePlayNpcQuestFlag) : Quest
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_3:* = 0;
            for each (_loc_5 in param1.questsToValidId)
            {
                
                _loc_4 = Quest.getQuestById(_loc_5);
                if (_loc_4 != null)
                {
                    _loc_6 = _loc_4.getPriorityValue();
                    if (_loc_3 < _loc_6 || _loc_2 == null)
                    {
                        _loc_2 = _loc_4;
                        _loc_3 = _loc_6;
                    }
                }
            }
            for each (_loc_5 in param1.questsToStartId)
            {
                
                _loc_4 = Quest.getQuestById(_loc_5);
                if (_loc_4 != null)
                {
                    _loc_7 = _loc_4.getPriorityValue();
                    if (_loc_3 < _loc_7 || _loc_2 == null)
                    {
                        _loc_2 = _loc_4;
                        _loc_3 = _loc_7;
                    }
                }
            }
            return _loc_2;
        }// end function

    }
}
