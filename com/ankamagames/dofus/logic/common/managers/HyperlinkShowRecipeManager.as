package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.utils.pattern.*;

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

    }
}
