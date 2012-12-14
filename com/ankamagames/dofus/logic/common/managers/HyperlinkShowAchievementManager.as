package com.ankamagames.dofus.logic.common.managers
{
    import avmplus.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.geom.*;

    public class HyperlinkShowAchievementManager extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowAchievementManager));
        private static var _achList:Array = new Array();
        private static var _achId:uint = 0;

        public function HyperlinkShowAchievementManager()
        {
            return;
        }// end function

        public static function showAchievement(param1:uint) : void
        {
            var _loc_2:* = new Object();
            _loc_2.achievementId = param1;
            _loc_2.forceOpen = true;
            KernelEventsManager.getInstance().processCallback(HookList.OpenBook, "achievementTab", _loc_2);
            return;
        }// end function

        public static function addAchievement(param1:uint) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = Achievement.getAchievementById(param1);
            if (_loc_2)
            {
                _achList[_achId] = _loc_2;
                _loc_3 = "{chatachievement," + param1 + "::[" + _loc_2.name + "]}";
                var _loc_5:* = _achId + 1;
                _achId = _loc_5;
                return _loc_3;
            }
            return "[null]";
        }// end function

        public static function getAchievementName(param1:uint) : String
        {
            var _loc_2:* = Achievement.getAchievementById(param1);
            if (_loc_2)
            {
                return "[" + _loc_2.name + "]";
            }
            return "[null]";
        }// end function

        public static function rollOver(param1:int, param2:int, param3:uint, param4:uint = 0) : void
        {
            var _loc_5:* = new Rectangle(param1, param2, 10, 10);
            var _loc_6:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.achievement"));
            TooltipManager.show(_loc_6, _loc_5, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
