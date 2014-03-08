package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.misc.Inventory;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import __AS3__.vec.*;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
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
         this._sortFields = [-1];
         this._sortBankFields = [-1];
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
      
      public static const SORT_FIELD_ITEM_TYPE:int = 8;
      
      private static const MAX_SORT_FIELDS:int = 2;
      
      private static var _singleton:StorageOptionManager;
      
      public static function getInstance() : StorageOptionManager {
         if(!_singleton)
         {
            _singleton = new StorageOptionManager();
         }
         return _singleton;
      }
      
      private var _inventory:Inventory;
      
      private var _categoryFilter:int = -1;
      
      private var _bankCategoryFilter:int = -1;
      
      private var _filterType:int = -1;
      
      private var _bankFilterType:int = -1;
      
      private var _sortFields:Array;
      
      private var _sortRevert:Boolean;
      
      private var _sortBankFields:Array;
      
      private var _sortBankRevert:Boolean;
      
      private var _newSort:Boolean;
      
      public function set category(param1:int) : void {
         this._categoryFilter = param1;
         this.updateStorageView();
      }
      
      public function get category() : int {
         return this._categoryFilter;
      }
      
      public function set bankCategory(param1:int) : void {
         this._bankCategoryFilter = param1;
         this.updateBankStorageView();
      }
      
      public function get bankCategory() : int {
         return this._bankCategoryFilter;
      }
      
      public function set filter(param1:int) : void {
         this._filterType = param1;
         if(this._filterType != -1)
         {
            InventoryManager.getInstance().inventory.refillView("storage","storageFiltered");
         }
         this.updateStorageView();
      }
      
      public function get filter() : int {
         return this._filterType;
      }
      
      public function hasFilter() : Boolean {
         return !(this._filterType == -1);
      }
      
      public function set bankFilter(param1:int) : void {
         this._bankFilterType = param1;
         if(this._bankFilterType != -1)
         {
            InventoryManager.getInstance().bankInventory.refillView("bank","bankFiltered");
         }
         this.updateBankStorageView();
      }
      
      public function get bankFilter() : int {
         return this._bankFilterType;
      }
      
      public function hasBankFilter() : Boolean {
         return !(this._bankFilterType == -1);
      }
      
      public function get newSort() : Boolean {
         return this._newSort;
      }
      
      public function set sortField(param1:int) : void {
         if(this._sortFields.indexOf(param1) == -1)
         {
            if(!(param1 == SORT_FIELD_NONE) && this._sortFields.length > 0)
            {
               this._newSort = false;
            }
            if(this._sortFields.length <= MAX_SORT_FIELDS-1)
            {
               this._sortFields.push(param1);
            }
            else
            {
               this._sortFields[MAX_SORT_FIELDS-1] = param1;
            }
         }
         else
         {
            this._newSort = true;
         }
         this.currentStorageView.updateView();
         this._newSort = false;
      }
      
      public function get sortFields() : Array {
         return this._sortFields;
      }
      
      public function hasSort() : Boolean {
         return !(this._sortFields[0] == SORT_FIELD_NONE);
      }
      
      public function resetSort() : void {
         this._newSort = true;
         this._sortFields = new Array();
      }
      
      public function set sortRevert(param1:Boolean) : void {
         this._sortRevert = param1;
      }
      
      public function get sortRevert() : Boolean {
         return this._sortRevert;
      }
      
      public function set sortBankField(param1:int) : void {
         var _loc2_:Vector.<ItemWrapper> = null;
         var _loc3_:Vector.<ItemWrapper> = null;
         var _loc4_:ItemWrapper = null;
         if(this._sortBankFields.indexOf(param1) == -1)
         {
            if(!(param1 == SORT_FIELD_NONE) && this._sortBankFields.length > 0)
            {
               this._newSort = false;
            }
            if(this._sortBankFields.length <= MAX_SORT_FIELDS-1)
            {
               this._sortBankFields.push(param1);
            }
            else
            {
               this._sortBankFields[MAX_SORT_FIELDS-1] = param1;
            }
         }
         else
         {
            this._newSort = true;
         }
         this.currentBankView.updateView();
         if(this.hasBankFilter())
         {
            _loc2_ = this.currentBankView.content;
            _loc3_ = new Vector.<ItemWrapper>(0);
            for each (_loc4_ in _loc2_)
            {
               if(_loc4_.typeId == this.bankFilter)
               {
                  _loc3_.push(_loc4_.clone());
               }
            }
            KernelEventsManager.getInstance().processCallback(InventoryHookList.BankViewContent,_loc3_,InventoryManager.getInstance().bankInventory.localKamas);
         }
         this._newSort = false;
      }
      
      public function get sortBankFields() : Array {
         return this._sortBankFields;
      }
      
      public function hasBankSort() : Boolean {
         return !(this._sortBankFields[0] == SORT_FIELD_NONE);
      }
      
      public function resetBankSort() : void {
         this._newSort = true;
         this._sortBankFields = new Array();
      }
      
      public function set sortBankRevert(param1:Boolean) : void {
         this._sortBankRevert = param1;
      }
      
      public function get sortBankRevert() : Boolean {
         return this._sortBankRevert;
      }
      
      public function get currentStorageView() : IStorageView {
         var _loc1_:IStorageView = null;
         _loc1_ = this.inventory.getView("storageBidHouseFilter") as IStorageView;
         if(_loc1_)
         {
            return _loc1_;
         }
         _loc1_ = this.inventory.getView("storageSmithMagicFilter") as IStorageView;
         if(_loc1_)
         {
            return _loc1_;
         }
         _loc1_ = this.inventory.getView("storageCraftFilter") as IStorageView;
         if(_loc1_)
         {
            return _loc1_;
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
      
      public function enableBidHouseFilter(param1:Vector.<uint>, param2:uint) : void {
         this.disableBidHouseFilter();
         var _loc3_:String = this.currentStorageView.name;
         this.inventory.addView(new StorageBidHouseFilterView(this.inventory.hookLock,this.currentStorageView,param1,param2));
         InventoryManager.getInstance().inventory.refillView(_loc3_,"storageBidHouseFilter");
      }
      
      public function disableBidHouseFilter() : void {
         if(this.inventory.getView("storageBidHouseFilter"))
         {
            this.inventory.removeView("storageBidHouseFilter");
         }
      }
      
      public function getIsBidHouseFilterEnabled() : Boolean {
         return !(this.inventory.getView("storageBidHouseFilter") == null);
      }
      
      public function enableSmithMagicFilter(param1:Skill) : void {
         var _loc3_:CraftFrame = null;
         this.disableSmithMagicFilter();
         if(!param1)
         {
            _loc3_ = Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
            if(!_loc3_)
            {
               _log.error("Activation des filtres de forgemagie alors que la craftFrame n\'est pas active");
               return;
            }
            param1 = Skill.getSkillById(_loc3_.skillId);
         }
         var _loc2_:String = this.currentStorageView.name;
         this.inventory.addView(new StorageSmithMagicFilterView(this.inventory.hookLock,this.currentStorageView,param1));
         InventoryManager.getInstance().inventory.refillView(_loc2_,"storageSmithMagicFilter");
      }
      
      public function disableSmithMagicFilter() : void {
         if(this.inventory.getView("storageSmithMagicFilter"))
         {
            this.inventory.removeView("storageSmithMagicFilter");
         }
      }
      
      public function enableCraftFilter(param1:Skill, param2:int) : void {
         var _loc4_:CraftFrame = null;
         this.disableCraftFilter();
         if(!param1)
         {
            _loc4_ = Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
            if(!_loc4_)
            {
               _log.error("Activation des filtres de forgemagie alors que la craftFrame n\'est pas active");
               return;
            }
            param1 = Skill.getSkillById(_loc4_.skillId);
         }
         var _loc3_:String = this.currentStorageView.name;
         this.inventory.addView(new StorageCraftFilterView(this.inventory.hookLock,this.currentStorageView,param1.id,param2));
         InventoryManager.getInstance().inventory.refillView(_loc3_,"storageCraftFilter");
      }
      
      public function disableCraftFilter() : void {
         if(this.inventory.getView("storageCraftFilter"))
         {
            this.inventory.removeView("storageCraftFilter");
         }
      }
      
      public function getIsSmithMagicFilterEnabled() : Boolean {
         return !(this.inventory.getView("storageSmithMagicFilter") == null);
      }
      
      public function getIsCraftFilterEnabled() : Boolean {
         return !(this.inventory.getView("storageCraftFilter") == null);
      }
      
      public function getStorageView(param1:int) : IStorageView {
         switch(param1)
         {
            case EQUIPMENT_CATEGORY:
               return this.inventory.getView("storageEquipment") as IStorageView;
            case CONSUMABLES_CATEGORY:
               return this.inventory.getView("storageConsumables") as IStorageView;
            case RESOURCES_CATEGORY:
               return this.inventory.getView("storageResources") as IStorageView;
            case QUEST_CATEGORY:
               return this.inventory.getView("storageQuest") as IStorageView;
            case ALL_CATEGORY:
            default:
               return this.inventory.getView("storage") as IStorageView;
         }
      }
      
      public function getBankView(param1:int) : IStorageView {
         switch(param1)
         {
            case EQUIPMENT_CATEGORY:
               return InventoryManager.getInstance().bankInventory.getView("bankEquipement") as IStorageView;
            case CONSUMABLES_CATEGORY:
               return InventoryManager.getInstance().bankInventory.getView("bankConsumables") as IStorageView;
            case RESOURCES_CATEGORY:
               return InventoryManager.getInstance().bankInventory.getView("bankRessources") as IStorageView;
            case QUEST_CATEGORY:
               return InventoryManager.getInstance().bankInventory.getView("bankQuest") as IStorageView;
            case ALL_CATEGORY:
            default:
               return InventoryManager.getInstance().bankInventory.getView("bank") as IStorageView;
         }
      }
      
      public function getCategoryTypes(param1:uint) : Dictionary {
         return this.getStorageView(param1).types;
      }
      
      public function getBankCategoryTypes(param1:uint) : Dictionary {
         return this.getBankView(param1).types;
      }
      
      public function updateStorageView() : void {
         this._newSort = false;
         this.refreshViews();
         this.currentStorageView.updateView();
      }
      
      public function updateBankStorageView() : void {
         this._newSort = false;
         this.getBankView(this.bankCategory).updateView();
      }
      
      private function get inventory() : Inventory {
         if(!this._inventory)
         {
            this._inventory = InventoryManager.getInstance().inventory;
         }
         return this._inventory;
      }
      
      private function refreshViews() : void {
         var _loc2_:StorageBidHouseFilterView = null;
         var _loc3_:StorageSmithMagicFilterView = null;
         var _loc4_:StorageCraftFilterView = null;
         var _loc1_:IStorageView = this.getStorageViewOrFilter();
         if(this.getIsBidHouseFilterEnabled())
         {
            _loc2_ = this.inventory.getView("storageBidHouseFilter") as StorageBidHouseFilterView;
            _loc2_.parent = _loc1_;
            this.refreshView("storageBidHouseFilter");
         }
         if(this.getIsSmithMagicFilterEnabled())
         {
            _loc3_ = this.inventory.getView("storageSmithMagicFilter") as StorageSmithMagicFilterView;
            _loc3_.parent = _loc1_;
            this.refreshView("storageSmithMagicFilter");
         }
         if(this.getIsCraftFilterEnabled())
         {
            _loc4_ = this.inventory.getView("storageCraftFilter") as StorageCraftFilterView;
            _loc4_.parent = _loc1_;
            this.refreshView("storageCraftFilter");
         }
      }
      
      private function refreshView(param1:String) : void {
         var _loc2_:IInventoryView = this.inventory.getView(param1);
         this.inventory.removeView(param1);
         var _loc3_:String = this.currentStorageView.name;
         this.inventory.addView(_loc2_);
         InventoryManager.getInstance().inventory.refillView(_loc3_,param1);
      }
   }
}
