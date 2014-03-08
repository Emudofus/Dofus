package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.datacenter.items.Item;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkItemManager extends Object
   {
      
      public function HyperlinkItemManager() {
         super();
      }
      
      private static var _itemId:int = 0;
      
      private static var _itemList:Array = new Array();
      
      public static var lastItemTooltipId:int = -1;
      
      public static function showItem(param1:uint, param2:uint=0) : void {
         var _loc3_:ItemWrapper = InventoryManager.getInstance().inventory.getItem(param2);
         if(_loc3_)
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,_loc3_);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,ItemWrapper.create(0,0,param1,1,null));
         }
      }
      
      public static function showChatItem(param1:int) : void {
         if(param1 == lastItemTooltipId && (TooltipManager.isVisible("Hyperlink")))
         {
            TooltipManager.hide("Hyperlink");
            lastItemTooltipId = -1;
            return;
         }
         lastItemTooltipId = param1;
         HyperlinkSpellManager.lastSpellTooltipId = -1;
         KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,_itemList[param1]);
      }
      
      public static function duplicateChatHyperlink(param1:int) : void {
         KernelEventsManager.getInstance().processCallback(ChatHookList.AddItemHyperlink,_itemList[param1]);
      }
      
      public static function getItemName(param1:uint, param2:uint=0) : String {
         var _loc3_:Item = Item.getItemById(param1);
         if(_loc3_)
         {
            return "[" + _loc3_.name + "]";
         }
         return "[null]";
      }
      
      public static function newChatItem(param1:ItemWrapper) : String {
         _itemList[_itemId] = param1;
         var _loc2_:* = "{chatitem," + _itemId + "::[" + param1.realName + "]}";
         _itemId++;
         return _loc2_;
      }
      
      public static function rollOver(param1:int, param2:int, param3:uint, param4:uint=0) : void {
         var _loc5_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc6_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.object"));
         TooltipManager.show(_loc6_,_loc5_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
