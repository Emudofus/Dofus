package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.misc.Inventory;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageBidHouseFilterView;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.logic.game.common.frames.CraftFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageSmithMagicFilterView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageCraftFilterView;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;


   public class StorageOptionManager extends Object
   {
         

      public function StorageOptionManager() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StorageOptionManager));

      public static const ALL_CATEGORY:int = -1;

      public static const EQUIPMENT_CATEGORY:int = 0;

      public static const CONSUMABLES_CATEGORY:int = 1;

      public static const RESOURCES_CATEGORY:int = 2;

      public static const QUEST_CATEGORY:int = 3;

      public static const OTHER_CATEGORY:int = 4;

      public static const SORT_FIELD_NONE:int = -1;

      public static const SORT_FIELD_DEFAULT:int = 0;

      public static const SORT_FIELD_NAME:int = 1;

      public static const SORT_FIELD_WEIGHT:int = 2;

      public static const SORT_FIELD_QUANTITY:int = 3;

      public static const SORT_FIELD_LOT_WEIGHT:int = 4;

      public static const SORT_FIELD_AVERAGEPRICE:int = 5;

      public static const SORT_FIELD_LOT_AVERAGEPRICE:int = 6;

      public static const SORT_FIELD_LEVEL:int = 7;

      private static var _singleton:StorageOptionManager;

      public static function getInstance() : StorageOptionManager {
         if(!_singleton)
         {
            _singleton=new StorageOptionManager();
         }
         return _singleton;
      }

      private var _inventory:Inventory;

      private var _categoryFilter:int = -1;

      private var _bankCategoryFilter:int = -1;

      private var _filterType:int = -1;

      private var _bankFilterType:int = -1;

      private var _sortField:int = -1;

      private var _sortRevert:Boolean;

      private var _sortBankField:int = -1;

      private var _sortBankRevert:Boolean;

      private var _newSort:Boolean;

      public function set category(cat:int) : void {
         this._categoryFilter=cat;
         this.updateStorageView();
      }

      public function get category() : int {
         return this._categoryFilter;
      }

      public function set bankCategory(cat:int) : void {
         this._bankCategoryFilter=cat;
         this.updateBankStorageView();
      }

      public function get bankCategory() : int {
         return this._bankCategoryFilter;
      }

      public function set filter(filterType:int) : void {
         this._filterType=filterType;
         if(this._filterType!=-1)
         {
            InventoryManager.getInstance().inventory.refillView("storage","storageFiltered");
         }
         this.updateStorageView();
      }

      public function get filter() : int {
         return this._filterType;
      }

      public function hasFilter() : Boolean {
         return !(this._filterType==-1);
      }

      public function set bankFilter(bankFilterType:int) : void {
         this._bankFilterType=bankFilterType;
         if(this._bankFilterType!=-1)
         {
            InventoryManager.getInstance().bankInventory.refillView("bank","bankFiltered");
         }
         this.updateBankStorageView();
      }

      public function get bankFilter() : int {
         return this._bankFilterType;
      }

      public function hasBankFilter() : Boolean {
         return !(this._bankFilterType==-1);
      }

      public function get newSort() : Boolean {
         return this._newSort;
      }

      public function set sortField(fieldName:int) : void {
         this._newSort=true;
         this._sortField=fieldName;
         this.currentStorageView.updateView();
      }

      public function get sortField() : int {
         return this._sortField;
      }

      public function hasSort() : Boolean {
         return !(this._sortField==SORT_FIELD_NONE);
      }

      public function set sortRevert(revert:Boolean) : void {
         this._sortRevert=revert;
      }

      public function get sortRevert() : Boolean {
         return this._sortRevert;
      }

      public function set sortBankField(fieldName:int) : void {
         this._newSort=true;
         this._sortBankField=fieldName;
         this.currentBankView.updateView();
      }

      public function get sortBankField() : int {
         return this._sortBankField;
      }

      public function hasBankSort() : Boolean {
         return !(this._sortBankField==SORT_FIELD_NONE);
      }

      public function set sortBankRevert(revert:Boolean) : void {
         this._sortBankRevert=revert;
      }

      public function get sortBankRevert() : Boolean {
         return this._sortBankRevert;
      }

      public function get currentStorageView() : IStorageView {
         var view:IStorageView = null;
         view=this.inventory.getView("storageBidHouseFilter") as IStorageView;
         if(view)
         {
            return view;
         }
         view=this.inventory.getView("storageSmithMagicFilter") as IStorageView;
         if(view)
         {
            return view;
         }
         view=this.inventory.getView("storageCraftFilter") as IStorageView;
         if(view)
         {
            return view;
         }
         return this.getStorageViewOrFilter();
      }

      private function getStorageViewOrFilter() : IStorageView {
         if(this.hasFilter())
         {
            return this.inventory.getView("storageFiltered") as IStorageView;
         }
         return this.getStorageView(this.category);
      }

      public function get currentBankView() : IStorageView {
         return this.getBankView(this.bankCategory);
      }

      public function enableBidHouseFilter(allowedTypes:Vector.<uint>, maxItemLevel:uint) : void {
         this.disableBidHouseFilter();
         var name:String = this.currentStorageView.name;
         this.inventory.addView(new StorageBidHouseFilterView(this.inventory.hookLock,this.currentStorageView,allowedTypes,maxItemLevel));
         InventoryManager.getInstance().inventory.refillView(name,"storageBidHouseFilter");
      }

      public function disableBidHouseFilter() : void {
         if(this.inventory.getView("storageBidHouseFilter"))
         {
            this.inventory.removeView("storageBidHouseFilter");
         }
      }

      public function getIsBidHouseFilterEnabled() : Boolean {
         return !(this.inventory.getView("storageBidHouseFilter")==null);
      }

      public function enableSmithMagicFilter(skill:Skill) : void {
         var craftFrame:CraftFrame = null;
         this.disableSmithMagicFilter();
         if(!skill)
         {
            craftFrame=Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
            if(!craftFrame)
            {
               _log.error("Activation des filtres de forgemagie alors que la craftFrame n\'est pas active");
               return;
            }
            skill=Skill.getSkillById(craftFrame.skillId);
         }
         var name:String = this.currentStorageView.name;
         this.inventory.addView(new StorageSmithMagicFilterView(this.inventory.hookLock,this.currentStorageView,skill));
         InventoryManager.getInstance().inventory.refillView(name,"storageSmithMagicFilter");
      }

      public function disableSmithMagicFilter() : void {
         if(this.inventory.getView("storageSmithMagicFilter"))
         {
            this.inventory.removeView("storageSmithMagicFilter");
         }
      }

      public function enableCraftFilter(skill:Skill, slotCount:int) : void {
         var craftFrame:CraftFrame = null;
         this.disableCraftFilter();
         if(!skill)
         {
            craftFrame=Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
            if(!craftFrame)
            {
               _log.error("Activation des filtres de forgemagie alors que la craftFrame n\'est pas active");
               return;
            }
            skill=Skill.getSkillById(craftFrame.skillId);
         }
         var name:String = this.currentStorageView.name;
         this.inventory.addView(new StorageCraftFilterView(this.inventory.hookLock,this.currentStorageView,skill.id,slotCount));
         InventoryManager.getInstance().inventory.refillView(name,"storageCraftFilter");
      }

      public function disableCraftFilter() : void {
         if(this.inventory.getView("storageCraftFilter"))
         {
            this.inventory.removeView("storageCraftFilter");
         }
      }

      public function getIsSmithMagicFilterEnabled() : Boolean {
         return !(this.inventory.getView("storageSmithMagicFilter")==null);
      }

      public function getIsCraftFilterEnabled() : Boolean {
         return !(this.inventory.getView("storageCraftFilter")==null);
      }

      public function getStorageView(category:int) : IStorageView {
         switch(category)
         {
            case EQUIPMENT_CATEGORY:
               return this.inventory.getView("storageEquipment") as IStorageView;
               break;
            case CONSUMABLES_CATEGORY:
               return this.inventory.getView("storageConsumables") as IStorageView;
               break;
            case RESOURCES_CATEGORY:
               return this.inventory.getView("storageResources") as IStorageView;
               break;
            case QUEST_CATEGORY:
               return this.inventory.getView("storageQuest") as IStorageView;
               break;
            case ALL_CATEGORY:
         }
         return this.inventory.getView("storage") as IStorageView;
      }

      public function getBankView(category:int) : IStorageView {
         switch(category)
         {
            case EQUIPMENT_CATEGORY:
               return InventoryManager.getInstance().bankInventory.getView("bankEquipement") as IStorageView;
               break;
            case CONSUMABLES_CATEGORY:
               return InventoryManager.getInstance().bankInventory.getView("bankConsumables") as IStorageView;
               break;
            case RESOURCES_CATEGORY:
               return InventoryManager.getInstance().bankInventory.getView("bankRessources") as IStorageView;
               break;
            case QUEST_CATEGORY:
               return InventoryManager.getInstance().bankInventory.getView("bankQuest") as IStorageView;
               break;
            case ALL_CATEGORY:
         }
         return InventoryManager.getInstance().bankInventory.getView("bank") as IStorageView;
      }

      public function getCategoryTypes(category:uint) : Dictionary {
         return this.getStorageView(category).types;
      }

      public function getBankCategoryTypes(category:uint) : Dictionary {
         return this.getBankView(category).types;
      }

      public function updateStorageView() : void {
         this._newSort=false;
         this.refreshViews();
         this.currentStorageView.updateView();
      }

      public function updateBankStorageView() : void {
         this._newSort=false;
         this.getBankView(this.bankCategory).updateView();
      }

      private function get inventory() : Inventory {
         if(!this._inventory)
         {
            this._inventory=InventoryManager.getInstance().inventory;
         }
         return this._inventory;
      }

      private function refreshViews() : void {
         var bidHouseFilterView:StorageBidHouseFilterView = null;
         var smithMagicFilterView:StorageSmithMagicFilterView = null;
         var craftFilterView:StorageCraftFilterView = null;
         var parentView:IStorageView = this.getStorageViewOrFilter();
         if(this.getIsBidHouseFilterEnabled())
         {
            bidHouseFilterView=this.inventory.getView("storageBidHouseFilter") as StorageBidHouseFilterView;
            bidHouseFilterView.parent=parentView;
            this.refreshView("storageBidHouseFilter");
         }
         if(this.getIsSmithMagicFilterEnabled())
         {
            smithMagicFilterView=this.inventory.getView("storageSmithMagicFilter") as StorageSmithMagicFilterView;
            smithMagicFilterView.parent=parentView;
            this.refreshView("storageSmithMagicFilter");
         }
         if(this.getIsCraftFilterEnabled())
         {
            craftFilterView=this.inventory.getView("storageCraftFilter") as StorageCraftFilterView;
            craftFilterView.parent=parentView;
            this.refreshView("storageCraftFilter");
         }
      }

      private function refreshView(viewName:String) : void {
         var view:IInventoryView = this.inventory.getView(viewName);
         this.inventory.removeView(viewName);
         var name:String = this.currentStorageView.name;
         this.inventory.addView(view);
         InventoryManager.getInstance().inventory.refillView(name,viewName);
      }
   }

}