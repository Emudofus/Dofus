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

    public class HyperlinkShowOrnamentManager extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowOrnamentManager));
        private static var _ornList:Array = new Array();
        private static var _ornId:uint = 0;

        public function HyperlinkShowOrnamentManager()
        {
            return;
        }// end function

        public static function showOrnament(param1:uint) : void
        {
            var _loc_2:* = new Object();
            _loc_2.id = _ornList[param1].id;
            _loc_2.idIsTitle = false;
            _loc_2.forceOpen = true;
            KernelEventsManager.getInstance().processCallback(HookList.OpenBook, "titleTab", _loc_2);
            return;
        }// end function

        public static function addOrnament(param1:uint) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = Ornament.getOrnamentById(param1);
            if (_loc_2)
            {
                _ornList[_ornId] = _loc_2;
                _loc_3 = "{chatornament," + _ornId + "::[" + _loc_2.name + "]}";
                var _loc_5:* = _ornId + 1;
                _ornId = _loc_5;
                return _loc_3;
            }
            return "[null]";
        }// end function

        public static function rollOver(param1:int, param2:int, param3:uint, param4:uint = 0) : void
        {
            var _loc_5:* = new Rectangle(param1, param2, 10, 10);
            var _loc_6:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.ornament"));
            TooltipManager.show(_loc_6, _loc_5, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
