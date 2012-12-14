package com.ankamagames.dofus.logic.common.managers
{
    import avmplus.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.appearance.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.geom.*;

    public class HyperlinkShowTitleManager extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowTitleManager));
        private static var _titleList:Array = new Array();
        private static var _titleId:uint = 0;

        public function HyperlinkShowTitleManager()
        {
            return;
        }// end function

        public static function showTitle(param1:uint) : void
        {
            var _loc_2:* = new Object();
            _loc_2.id = _titleList[param1].id;
            _loc_2.idIsTitle = true;
            _loc_2.forceOpen = true;
            KernelEventsManager.getInstance().processCallback(HookList.OpenBook, "titleTab", _loc_2);
            return;
        }// end function

        public static function addTitle(param1:uint) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = Title.getTitleById(param1);
            if (_loc_2)
            {
                _titleList[_titleId] = _loc_2;
                _loc_3 = "{chattitle," + _titleId + "::[" + _loc_2.name + "]}";
                var _loc_5:* = _titleId + 1;
                _titleId = _loc_5;
                return _loc_3;
            }
            return "[null]";
        }// end function

        public static function rollOver(param1:int, param2:int, param3:uint, param4:uint = 0) : void
        {
            var _loc_5:* = new Rectangle(param1, param2, 10, 10);
            var _loc_6:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.title"));
            TooltipManager.show(_loc_6, _loc_5, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
