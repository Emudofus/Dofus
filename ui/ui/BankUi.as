package ui
{
   import d2components.GraphicContainer;
   import d2components.Texture;
   import d2components.EntityDisplayer;
   import d2actions.*;
   import d2hooks.*;
   import ui.enum.StorageState;
   import com.ankamagames.dofusModuleLibrary.enum.ExchangeTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.tooltip.LocationEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   
   public class BankUi extends AbstractStorageUi
   {
      
      public function BankUi() {
         super();
      }
      
      public var filterCtr:GraphicContainer;
      
      public var tx_icon:Texture;
      
      public var entityDisplayer:EntityDisplayer;
      
      private var _objectToExchange:Object;
      
      private var _exchangeType:int;
      
      private var _iconFrame:int;
      
      protected var _sortProperty2:int = -1;
      
      override public function main(param:Object) : void {
         var behavior:String = null;
         var mount:Object = null;
         param.storageMod = "bankUi";
         super.main(param);
         sysApi.addHook(BankViewContent,onInventoryUpdate);
         sysApi.addHook(StorageKamasUpdate,onKamasUpdate);
         sysApi.addHook(ExchangeLeave,this.onExchangeLeave);
         this.categoryFilter = ALL_CATEGORY;
         _hasSlot = false;
         this._exchangeType = param.exchangeType;
         switch(this._exchangeType)
         {
            case ExchangeTypeEnum.TAXCOLLECTOR:
               lblTitle.text = uiApi.getText("ui.common.taxCollector");
               this._iconFrame = 2;
               this.tx_icon.gotoAndStop = this._iconFrame;
               behavior = StorageState.TAXCOLLECTOR_MOD;
               break;
            case ExchangeTypeEnum.MOUNT:
               mount = playerApi.getMount();
               lblTitle.text = uiApi.getText("ui.common.inventory");
               this.tx_icon.visible = false;
               this.entityDisplayer.visible = true;
               this.entityDisplayer.look = mount.entityLook;
               kamaCtr.visible = false;
               txWeightBar.visible = true;
               sysApi.addHook(ExchangeWeight,onInventoryWeight);
               behavior = StorageState.MOUNT_MOD;
               break;
            case ExchangeTypeEnum.STORAGE:
               this._iconFrame = 4;
               this.tx_icon.gotoAndStop = this._iconFrame;
               lblTitle.text = uiApi.getText("ui.common.storage");
               _hasSlot = true;
               _slotsMax = !param.maxSlots?0:param.maxSlots;
               txWeightBar.visible = !(_slotsMax == 0);
               behavior = StorageState.BANK_MOD;
               break;
            default:
               lblTitle.text = uiApi.getText("ui.common.storage");
               behavior = StorageState.BANK_MOD;
         }
         mainCtr.x = 16;
         mainCtr.y = 1024 - (mainCtr.height + 155);
         if((param.inventory) && (param.kamas))
         {
            onInventoryUpdate(param.inventory,param.kamas);
         }
         this.subFilter = -1;
         storageApi.releaseBankHooks();
         sysApi.sendAction(new OpenInventory(behavior));
      }
      
      private function transfertAll() : void {
         sysApi.sendAction(new ExchangeObjectTransfertAllToInv());
      }
      
      private function transfertList() : void {
         sysApi.sendAction(new ExchangeObjectTransfertListToInv(_itemsDisplayed));
      }
      
      private function transfertExisting() : void {
         sysApi.sendAction(new ExchangeObjectTransfertExistingToInv());
      }
      
      override protected function getStorageTypes(categoryFilter:int) : Object {
         return storageApi.getBankStorageTypes(categoryFilter);
      }
      
      override public function set categoryFilter(category:int) : void {
         super.categoryFilter = category;
         storageApi.setDisplayedBankCategory(categoryFilter);
      }
      
      override public function set subFilter(filter:int) : void {
         var cbFilter:Object = null;
         updateSubFilter(this.getStorageTypes(categoryFilter));
         var hasFilter:Boolean = false;
         for each(cbFilter in super.cbFilter.dataProvider)
         {
            if(cbFilter.filterType == filter)
            {
               hasFilter = true;
               break;
            }
         }
         if(!hasFilter)
         {
            filter = -1;
         }
         storageApi.setBankStorageFilter(filter);
         super.subFilter = filter;
      }
      
      override public function onRollOver(target:Object) : void {
         var text:String = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         switch(target)
         {
            case btnMoveAll:
               text = uiApi.getText("ui.storage.advancedTransferts");
               if(text)
               {
                  uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
               }
               else
               {
                  super.onRollOver(target);
               }
               return;
            default:
               super.onRollOver(target);
               return;
         }
      }
      
      override public function onRelease(target:Object) : void {
         var contextMenu:Array = null;
         switch(target)
         {
            case btnMoveAll:
               contextMenu = new Array();
               contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getAll"),this.transfertAll,null,false,null,false,true));
               contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getVisible"),this.transfertList,null,false,null,false,true));
               contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getExisting"),this.transfertExisting,null,false,null,false,true));
               modContextMenu.createContextMenu(contextMenu);
               break;
         }
         super.onRelease(target);
      }
      
      override public function unload() : void {
         super.unload();
         sysApi.removeHook(BankViewContent);
         sysApi.removeHook(StorageKamasUpdate);
         sysApi.removeHook(ExchangeLeave);
         var mountInfo:Object = uiApi.getUi(UIEnum.MOUNT_INFO);
         if(mountInfo)
         {
            mountInfo.visible = true;
         }
         Api.system.sendAction(new LeaveDialogRequest());
         sysApi.sendAction(new CloseInventory());
      }
      
      override protected function releaseHooks() : void {
         storageApi.releaseBankHooks();
      }
      
      override protected function sortOn(property:int, numeric:Boolean = false) : void {
         storageApi.resetBankSort();
         this.addSort(property);
      }
      
      override protected function addSort(property:int) : void {
         storageApi.sortBank(property,false);
         this.releaseHooks();
      }
      
      override protected function getSortFields() : Object {
         return storageApi.getSortBankFields();
      }
      
      public function onExchangeLeave(success:Boolean) : void {
         uiApi.unloadUi(uiApi.me().name);
      }
   }
}
