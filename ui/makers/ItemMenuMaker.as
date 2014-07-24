package makers
{
   import d2data.ItemWrapper;
   import d2hooks.*;
   import d2actions.*;
   import d2data.PresetWrapper;
   
   public class ItemMenuMaker extends Object
   {
      
      public function ItemMenuMaker() {
         super();
      }
      
      public static var disabled:Boolean = false;
      
      private var _itemToFree:ItemWrapper;
      
      private function askRecipesItem(item:Object) : void {
         Api.system.dispatchHook(OpenRecipe,item);
      }
      
      private function askBestiary(item:Object) : void {
         var data:Object = new Object();
         data.monsterId = 0;
         data.monsterSearch = item.name;
         data.monsterIdsList = item.dropMonsterIds;
         data.forceOpen = true;
         Api.system.dispatchHook(OpenBook,"bestiaryTab",data);
      }
      
      private function askSetItem(item:Object) : void {
         Api.system.dispatchHook(OpenSet,item);
      }
      
      private function askLivingObjectItem(item:Object) : void {
         Api.system.dispatchHook(OpenLivingObject,item);
      }
      
      private function dissociateMimicryObjectItem(item:Object) : void {
         this._itemToFree = item as ItemWrapper;
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.mimicry.confirmFreePopup",item.name),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onConfirmFree,this.onCancel],this.onConfirmFree,this.onCancel);
      }
      
      private function displayChatItem(item:Object) : void {
         Api.system.dispatchHook(InsertHyperlink,item);
      }
      
      private function displayChatRecipe(item:Object) : void {
         Api.system.dispatchHook(InsertRecipeHyperlink,item.objectGID);
      }
      
      private function viewMountDetails(item:Object) : void {
         Api.system.sendAction(new MountInfoRequest(item));
      }
      
      public function feedItem(item:Object) : void {
         Api.system.dispatchHook(OpenFeed,item);
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var menu:Array = new Array();
         var uiName:String = param?(param.length > 0) && (param[0] is String)?param[0]:null:null;
         if((data.hasOwnProperty("isEquipment")) && (data.isEquipment) && (data.hasOwnProperty("type")) && (data.type.superTypeId == 12))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.feed"),this.feedItem,[data],disabled));
         }
         if((!(data is PresetWrapper)) && (data is ItemWrapper))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.craft.associateReceipts"),this.askRecipesItem,[data],disabled));
         }
         if((data.hasOwnProperty("dropMonsterIds")) && (data.dropMonsterIds) && (data.dropMonsterIds.length > 0))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.bestiary"),this.askBestiary,[data],disabled));
         }
         if((data.hasOwnProperty("belongsToSet")) && (data.belongsToSet))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.set"),this.askSetItem,[data],disabled));
         }
         if((data.hasOwnProperty("isLivingObject")) && (data.isLivingObject))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.item.manageItem"),this.askLivingObjectItem,[data],disabled));
         }
         if((data.hasOwnProperty("isMimicryObject")) && (data.isMimicryObject) && (!(uiName == "itemBoxPop")))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mimicry.free"),this.dissociateMimicryObjectItem,[data],disabled));
         }
         if((Api.ui.getUi("chat")) && (!(data is PresetWrapper)) && (data is ItemWrapper))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.craft.displayChatItem"),this.displayChatItem,[data],disabled));
         }
         if((Api.ui.getUi("chat")) && (!(data is PresetWrapper)) && (data is ItemWrapper))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.craft.displayChatRecipe"),this.displayChatRecipe,[data],disabled));
         }
         if((data.hasOwnProperty("isCertificate")) && (data.isCertificate))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.viewMountDetails"),this.viewMountDetails,[data],disabled));
         }
         return menu;
      }
      
      protected function onConfirmFree() : void {
         Api.system.sendAction(new MimicryObjectEraseRequest(this._itemToFree.objectUID,this._itemToFree.position));
      }
      
      protected function onCancel() : void {
      }
   }
}
