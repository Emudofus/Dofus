package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.data.*;
    import flash.geom.*;

    public class HyperlinkItemManager extends Object
    {
        private static var _itemId:int = 0;
        private static var _itemList:Array = new Array();
        public static var lastItemTooltipId:int = -1;

        public function HyperlinkItemManager()
        {
            return;
        }// end function

        public static function showItem(param1:uint, param2:uint = 0) : void
        {
            var _loc_3:* = InventoryManager.getInstance().inventory.getItem(param2);
            if (_loc_3)
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked, _loc_3);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked, ItemWrapper.create(0, 0, param1, 1, null));
            }
            return;
        }// end function

        public static function showChatItem(param1:int) : void
        {
            if (param1 == lastItemTooltipId && TooltipManager.isVisible("Hyperlink"))
            {
                TooltipManager.hide("Hyperlink");
                lastItemTooltipId = -1;
                return;
            }
            lastItemTooltipId = param1;
            HyperlinkSpellManager.lastSpellTooltipId = -1;
            KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked, _itemList[param1]);
            return;
        }// end function

        public static function duplicateChatHyperlink(param1:int) : void
        {
            KernelEventsManager.getInstance().processCallback(ChatHookList.AddItemHyperlink, _itemList[param1]);
            return;
        }// end function

        public static function getItemName(param1:uint, param2:uint = 0) : String
        {
            var _loc_3:* = Item.getItemById(param1);
            if (_loc_3)
            {
                return "[" + _loc_3.name + "]";
            }
            return "[null]";
        }// end function

        public static function newChatItem(param1:ItemWrapper) : String
        {
            _itemList[_itemId] = param1;
            var _loc_2:* = "{chatitem," + _itemId + "::[" + param1.realName + "]}";
            var _loc_4:* = _itemId + 1;
            _itemId = _loc_4;
            return _loc_2;
        }// end function

        public static function rollOver(param1:int, param2:int, param3:uint, param4:uint = 0) : void
        {
            var _loc_5:* = new Rectangle(param1, param2, 10, 10);
            var _loc_6:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.object"));
            TooltipManager.show(_loc_6, _loc_5, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
