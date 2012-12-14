package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.data.*;
    import flash.geom.*;

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
            var _loc_3:* = null;
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
            var _loc_3:* = null;
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

        public static function rollOver(param1:int, param2:int, param3:uint, param4:uint = 0) : void
        {
            var _loc_5:* = new Rectangle(param1, param2, 10, 10);
            var _loc_6:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.quest"));
            TooltipManager.show(_loc_6, _loc_5, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
