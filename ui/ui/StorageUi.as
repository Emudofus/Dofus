package ui
{
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2hooks.StorageFilterUpdated;
   import ui.behavior.CraftBehavior;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import d2hooks.ShortcutsMovementAllowed;
   import d2hooks.StorageViewContent;
   import d2hooks.KamasUpdate;
   import d2hooks.InventoryWeight;
   import d2actions.ExchangeObjectTransfertAllFromInv;
   import d2actions.ExchangeObjectTransfertListFromInv;
   import d2actions.ExchangeObjectTransfertExistingFromInv;
   import d2enums.LocationEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   
   public class StorageUi extends AbstractStorageUi
   {
      
      public function StorageUi() {
         super();
      }
      
      public var btn_filter:ButtonContainer;
      
      public var btn_label_btn_filter:Label;
      
      private var _saveCategory:Boolean = true;
      
      public function set saveCategory(c:Boolean) : void {
         this._saveCategory = c;
      }
      
      public function get saveCategory() : Boolean {
         return this._saveCategory;
      }
      
      override public function set categoryFilter(category:int) : void {
         var button:ButtonContainer = this.getButtonFromCategory(category);
         if(this._saveCategory)
         {
            sysApi.setData("lastStorageTab",button.name);
         }
         super.categoryFilter = category;
         storageApi.setDisplayedCategory(categoryFilter);
         sysApi.dispatchHook(StorageFilterUpdated,grid.dataProvider,categoryFilter);
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
         storageApi.setStorageFilter(filter);
         if(this._saveCategory)
         {
            sysApi.setData("lastSubFilter",filter);
         }
         super.subFilter = filter;
      }
      
      override public function main(param:Object) : void {
         var lowerCategory:* = 0;
         var item:Object = null;
         var inventory:Object = storageApi.getViewContent("storage");
         var kamas:int = playerApi.characteristics().kamas;
         var weight:int = playerApi.inventoryWeight();
         var weightMax:int = playerApi.inventoryWeightMax();
         this.hideFilter();
         var lastSubFilter:int = sysApi.getData("lastSubFilter");
         var lastTab:String = sysApi.getData("lastStorageTab");
         if(lastTab)
         {
            this.categoryFilter = this.getCategoryFromButton(this[lastTab]);
         }
         else
         {
            lowerCategory = -1;
            for each(item in inventory)
            {
               if((item.position == 63) && ((item.category == EQUIPEMENT_CATEGORY) || (item.category == CONSUMABLES_CATEGORY) || (item.category == RESSOURCES_CATEGORY) || (item.category == QUEST_CATEGORY)) && ((item.category < lowerCategory) || (lowerCategory == -1)))
               {
                  lowerCategory = item.category;
                  if(lowerCategory == 0)
                  {
                     break;
                  }
               }
            }
            if(lowerCategory == -1)
            {
               lowerCategory = EQUIPEMENT_CATEGORY;
            }
            this.categoryFilter = lowerCategory;
         }
         super.main(param);
         super.updateSubFilter(this.getStorageTypes(categoryFilter));
         if(lastSubFilter != 0)
         {
            this.subFilter = lastSubFilter;
         }
         _tabFilter[categoryFilter] = subFilter;
         if((param.storageMod == "craft") && ((_storageBehavior as CraftBehavior).craftUi.skill.id == 209))
         {
            this.btn_filter.selected = false;
            this.btn_filter.disabled = true;
         }
         else
         {
            uiApi.addComponentHook(this.btn_filter,"onRelease");
         }
         if(!uiApi.getUi(UIEnum.SMILEY_UI))
         {
            sysApi.dispatchHook(ShortcutsMovementAllowed,true);
         }
         sysApi.addHook(StorageViewContent,this.onInventoryUpdate);
         sysApi.addHook(KamasUpdate,onKamasUpdate);
         sysApi.addHook(InventoryWeight,onInventoryWeight);
         this.onInventoryUpdate(inventory,kamas);
         onInventoryWeight(weight,weightMax);
         this.releaseHooks();
      }
      
      override public function unload() : void {
         sysApi.removeHook(StorageViewContent);
         sysApi.removeHook(KamasUpdate);
         sysApi.removeHook(InventoryWeight);
         if((!uiApi.getUi(UIEnum.SMILEY_UI)) && (sysApi.isFightContext()))
         {
            sysApi.dispatchHook(ShortcutsMovementAllowed,false);
         }
         super.unload();
      }
      
      private function transfertAll() : void {
         sysApi.sendAction(new ExchangeObjectTransfertAllFromInv());
      }
      
      private function transfertList() : void {
         sysApi.sendAction(new ExchangeObjectTransfertListFromInv(_itemsDisplayed));
      }
      
      private function transfertExisting() : void {
         sysApi.sendAction(new ExchangeObjectTransfertExistingFromInv());
      }
      
      override public function onRelease(target:Object) : void {
         var contextMenu:Array = null;
         switch(target)
         {
            case btnAll:
            case btnEquipable:
            case btnConsumables:
            case btnRessources:
               sysApi.setData("lastStorageTab",target.name);
               break;
            case btnQuest:
               sysApi.setData("lastStorageTab",target.name);
               onReleaseCategoryFilter(btnQuest);
               break;
            case btnMoveAll:
               contextMenu = new Array();
               contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getAll"),this.transfertAll,null,false,null,false,true));
               contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getVisible"),this.transfertList,null,false,null,false,true));
               contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getExisting"),this.transfertExisting,null,false,null,false,true));
               modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_filter:
               _storageBehavior.filterStatus(this.btn_filter.selected);
               break;
         }
         super.onRelease(target);
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
            case btnQuest:
               text = uiApi.getText("ui.common.quest.objects");
               break;
            case btnMoveAll:
               text = uiApi.getText("ui.storage.advancedTransferts");
               break;
         }
         if(text)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
         else
         {
            super.onRollOver(target);
         }
      }
      
      override public function getButtonFromCategory(category:int) : ButtonContainer {
         switch(category)
         {
            case QUEST_CATEGORY:
               return btnQuest;
            default:
               return super.getButtonFromCategory(category);
         }
      }
      
      override public function getCategoryFromButton(button:ButtonContainer) : int {
         switch(button)
         {
            case btnQuest:
               return QUEST_CATEGORY;
            default:
               return super.getCategoryFromButton(button);
         }
      }
      
      public function showFilter(buttonText:String, selected:Boolean) : void {
         if(this.btn_filter)
         {
            this.btn_filter.visible = true;
            commonCtr.y = -31;
            txBackground.height = 754;
            this.btn_label_btn_filter.text = buttonText;
            this.btn_filter.selected = selected;
         }
      }
      
      public function hideFilter() : void {
         if(this.btn_filter)
         {
            this.btn_filter.visible = false;
         }
      }
      
      override protected function onInventoryUpdate(pItems:Object, pKama:uint) : void {
         _ignoreQuestItems = !questVisible;
         super.onInventoryUpdate(pItems,pKama);
      }
      
      override protected function getStorageTypes(categoryFilter:int) : Object {
         return storageApi.getStorageTypes(categoryFilter);
      }
      
      override protected function releaseHooks() : void {
         storageApi.releaseHooks();
      }
      
      override protected function sortOn(property:int, numeric:Boolean = false) : void {
         storageApi.resetSort();
         this.addSort(property);
      }
      
      override protected function addSort(property:int) : void {
         storageApi.sort(property,false);
         this.releaseHooks();
      }
      
      override protected function getSortFields() : Object {
         return storageApi.getSortFields();
      }
      
      override protected function initSound() : void {
         btnQuest.soundId = SoundEnum.TAB;
         super.initSound();
      }
   }
}
