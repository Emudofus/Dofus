package ui.behavior
{
   import ui.EquipmentUi;
   import d2data.ItemWrapper;
   import ui.AbstractStorageUi;
   import d2actions.*;
   import d2hooks.*;
   import d2enums.SelectMethodEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import ui.enum.StorageState;
   
   public class StorageClassicBehavior extends Object implements IStorageBehavior
   {
      
      public function StorageClassicBehavior() {
         super();
      }
      
      private var _storage:EquipmentUi;
      
      private var _waitingObject:Object;
      
      public function filterStatus(enabled:Boolean) : void {
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean {
         if((data is ItemWrapper) && (!(this._storage.categoryFilter == AbstractStorageUi.QUEST_CATEGORY)))
         {
            if(data.position != 63)
            {
               return true;
            }
         }
         return false;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void {
         if(data.quantity == 1)
         {
            Api.system.sendAction(new ObjectSetPosition(data.objectUID,63,1));
         }
         else
         {
            this._waitingObject = data;
            Api.common.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQty);
         }
      }
      
      public function onRelease(target:Object) : void {
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var item:Object = null;
         if(target == this._storage.grid)
         {
            item = this._storage.grid.selectedItem;
            switch(selectMethod)
            {
               case SelectMethodEnum.CLICK:
                  break;
               case SelectMethodEnum.DOUBLE_CLICK:
                  Api.ui.hideTooltip();
                  this.doubleClickGridItem(item);
                  break;
               case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                  this.doubleClickGridItem(item);
                  break;
            }
         }
      }
      
      public function attach(storageUi:AbstractStorageUi) : void {
         if(!(storageUi is EquipmentUi))
         {
            throw new Error("Can\'t attach a StorageClassicBehavior to a non EquipmentUi storage");
         }
         else
         {
            this._storage = storageUi as EquipmentUi;
            if(this._storage.playerLook != null)
            {
               this._storage.playerLook.look = null;
            }
            return;
         }
      }
      
      public function detach() : void {
      }
      
      public function onUnload() : void {
      }
      
      public function getStorageUiName() : String {
         return UIEnum.EQUIPMENT_UI;
      }
      
      public function getName() : String {
         return StorageState.BAG_MOD;
      }
      
      public function get replacable() : Boolean {
         return true;
      }
      
      private function onValidQtyDrop(qty:Number) : void {
         if(!Api.player.isInExchange())
         {
            Api.system.sendAction(new ObjectDrop(this._waitingObject.objectUID,this._waitingObject.objectGID,qty));
         }
      }
      
      private function onValidQty(qty:Number) : void {
         Api.system.sendAction(new ObjectSetPosition(this._waitingObject.objectUID,63,qty));
      }
      
      public function doubleClickGridItem(pItem:Object) : void {
         var freeSlot:* = 0;
         if((pItem) && (pItem.category == 0))
         {
            freeSlot = Api.storage.getBestEquipablePosition(pItem);
            if(freeSlot > -1)
            {
               Api.system.sendAction(new ObjectSetPosition(pItem.objectUID,freeSlot,1));
            }
         }
         else if((pItem) && ((pItem.usable) || (pItem.targetable)))
         {
            this._storage.useItem(pItem);
         }
         
      }
   }
}
