package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.misc.lists.*;

    public class HyperlinkShowQuestManager extends Object
    {
        private static var _questList:Array = new Array();
        private static var _questId:uint = 0;

        public function HyperlinkShowQuestManager()
        {
            return;
        }// end function

        public static function showQuest(param1:uint) : void
        {
            var _loc_3:Object = null;
            var _loc_2:* = Quest.getQuestById(_questList[param1].id);
            if (_loc_2)
            {
                _loc_3 = new Object();
                _loc_3.quest = _loc_2;
                _loc_3.forceOpen = true;
                KernelEventsManager.getInstance().processCallback(HookList.OpenBook, "questTab", _loc_3);
            }
            return;
        }// end function

        public static function addQuest(param1:uint) : String
        {
            var _loc_3:String = null;
            var _loc_2:* = Quest.getQuestById(param1);
            if (_loc_2)
            {
                _questList[_questId] = _loc_2;
                _loc_3 = "{chatquest," + _questId + "::[" + _loc_2.name + "]}";
                var _loc_5:* = _questId + 1;
                _questId = _loc_5;
                return _loc_3;
            }
            return "[null]";
        }// end function

    }
}
