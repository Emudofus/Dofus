package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.utils.pattern.*;
    import flash.geom.*;

    public class HyperlinkShowRecipeManager extends Object
    {

        public function HyperlinkShowRecipeManager()
        {
            return;
        }// end function

        public static function showRecipe(param1:uint) : void
        {
            var _loc_2:* = ItemWrapper.create(0, 0, param1, 1, null, false);
            if (_loc_2)
            {
                KernelEventsManager.getInstance().processCallback(HookList.OpenRecipe, _loc_2);
            }
            return;
        }// end function

        public static function getRecipeName(param1:int) : String
        {
            var _loc_2:* = Item.getItemById(param1);
            if (_loc_2)
            {
                return "[" + PatternDecoder.combine(I18n.getUiText("ui.common.recipes"), "n", true) + I18n.getUiText("ui.common.colon") + _loc_2.name + "]";
            }
            return "[null]";
        }// end function

        public static function rollOver(param1:int, param2:int, param3:uint) : void
        {
            var _loc_4:* = new Rectangle(param1, param2, 10, 10);
            var _loc_5:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.recipe"));
            TooltipManager.show(_loc_5, _loc_4, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
