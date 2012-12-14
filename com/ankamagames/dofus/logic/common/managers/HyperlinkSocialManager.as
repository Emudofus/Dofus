package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.data.*;
    import flash.geom.*;

    public class HyperlinkSocialManager extends Object
    {

        public function HyperlinkSocialManager()
        {
            return;
        }// end function

        public static function openSocial(param1:int, param2:int) : void
        {
            KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial, param1, param2);
            return;
        }// end function

        public static function rollOver(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = new Rectangle(param1, param2, 10, 10);
            var _loc_6:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.taxCollectorUnderAttack"));
            TooltipManager.show(_loc_6, _loc_5, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
