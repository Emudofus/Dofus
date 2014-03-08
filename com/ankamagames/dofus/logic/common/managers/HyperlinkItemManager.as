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
      
      public static function showItem(objectGID:uint, objectUID:uint=0) : void {
         var itemWrapper:ItemWrapper = InventoryManager.getInstance().inventory.getItem(objectUID);
         if(itemWrapper)
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,itemWrapper);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,ItemWrapper.create(0,0,objectGID,1,null));
         }
      }
      
      public static function showChatItem(id:int) : void {
         if((id == lastItemTooltipId) && (TooltipManager.isVisible("Hyperlink")))
         {
            TooltipManager.hide("Hyperlink");
            lastItemTooltipId = -1;
            return;
         }
         lastItemTooltipId = id;
         HyperlinkSpellManager.lastSpellTooltipId = -1;
         KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,_itemList[id]);
      }
      
      public static function duplicateChatHyperlink(id:int) : void {
         KernelEventsManager.getInstance().processCallback(ChatHookList.AddItemHyperlink,_itemList[id]);
      }
      
      public static function getItemName(objectGID:uint, objectUID:uint=0) : String {
         var item:Item = Item.getItemById(objectGID);
         if(item)
         {
            return "[" + item.name + "]";
         }
         return "[null]";
      }
      
      public static function newChatItem(item:ItemWrapper) : String {
         _itemList[_itemId] = item;
         var code:String = "{chatitem," + _itemId + "::[" + item.realName + "]}";
         _itemId++;
         return code;
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, objectUID:uint=0) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.object"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
