package ui.behavior
{
   import ui.StorageUi;
   import d2data.ItemWrapper;
   import ui.AbstractStorageUi;
   import d2actions.*;
   import d2hooks.*;
   import d2enums.SelectMethodEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import ui.enum.StorageState;
   
   public class HumanVendorBehavior extends Object implements IStorageBehavior
   {
      
      public function HumanVendorBehavior() {
         super();
      }
      
      private var _storage:StorageUi;
      
      private var _objectToExchange:Object;
      
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
         Api.system.dispatchHook(ClickItemInventory,data);
      }
      
      public function onValidQtyDrop(qty:Number) : void {
      }
      
      private function onValidQty(qty:Number) : void {
         Api.system.dispatchHook(AskExchangeMoveObject,this._objectToExchange.objectUID,qty);
         Api.system.sendAction(new ExchangeObjectMove(this._objectToExchange.objectUID,qty));
      }
      
      public function onRelease(target:Object) : void {
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var item:Object = null;
         var exchangeOk:* = false;
         var effect:* = undefined;
         switch(target)
         {
            case this._storage.grid:
               item = this._storage.grid.selectedItem;
               exchangeOk = true;
               if(item is ItemWrapper)
               {
                  for each(effect in item.effects)
                  {
                     if((effect.effectId == 982) || (effect.effectId == 983))
                     {
                        exchangeOk = false;
                     }
                  }
               }
               else
               {
                  exchangeOk = false;
               }
               switch(selectMethod)
               {
                  case SelectMethodEnum.CLICK:
                     if(exchangeOk)
                     {
                        Api.system.dispatchHook(ClickItemInventory,item);
                     }
                     else
                     {
                        Api.system.dispatchHook(ClickItemInventory,null);
                     }
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                     if(exchangeOk)
                     {
                        Api.ui.hideTooltip();
                     }
                     break;
               }
               break;
         }
      }
      
      public function attach(storageUi:AbstractStorageUi) : void {
         if(!(storageUi is StorageUi))
         {
            throw new Error("Can\'t attach a BidHouseBehavior to a non StorageUi storage");
         }
         else
         {
            this._storage = storageUi as StorageUi;
            if(this._storage.playerLook)
            {
               this._storage.playerLook.look = null;
            }
            this._storage.setDropAllowed(false,"behavior");
            this._storage.questVisible = false;
            this._storage.btnMoveAll.visible = false;
            return;
         }
      }
      
      public function detach() : void {
         this._storage.setDropAllowed(true,"behavior");
         this._storage.questVisible = true;
         this._storage.btnMoveAll.visible = true;
         Api.ui.unloadUi(UIEnum.HUMAN_VENDOR_STOCK);
      }
      
      public function onUnload() : void {
      }
      
      public function getStorageUiName() : String {
         return UIEnum.STORAGE_UI;
      }
      
      public function getName() : String {
         return StorageState.HUMAN_VENDOR_MOD;
      }
      
      public function get replacable() : Boolean {
         return false;
      }
   }
}
