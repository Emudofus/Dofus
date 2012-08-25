package com.ankamagames.dofus.logic.game.common.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.common.misc.inventoryView.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class StorageOptionManager extends Object
    {
        private var _inventory:Inventory;
        private var _categoryFilter:int = -1;
        private var _bankCategoryFilter:int = -1;
        private var _filterType:int = -1;
        private var _bankFilterType:int = -1;
        private var _sortField:int = -1;
        private var _sortRevert:Boolean;
        private var _sortBankField:int = -1;
        private var _sortBankRevert:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(StorageOptionManager));
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
        private static var _singleton:StorageOptionManager;

        public function StorageOptionManager()
        {
            return;
        }// end function

        public function set category(param1:int) : void
        {
            this._categoryFilter = param1;
            this.updateStorageView();
            return;
        }// end function

        public function get category() : int
        {
            return this._categoryFilter;
        }// end function

        public function set bankCategory(param1:int) : void
        {
            this._bankCategoryFilter = param1;
            this.updateBankStorageView();
            return;
        }// end function

        public function get bankCategory() : int
        {
            return this._bankCategoryFilter;
        }// end function

        public function set filter(param1:int) : void
        {
            this._filterType = param1;
            if (this._filterType != -1)
            {
                InventoryManager.getInstance().inventory.refillView("storage", "storageFiltered");
            }
            this.updateStorageView();
            return;
        }// end function

        public function get filter() : int
        {
            return this._filterType;
        }// end function

        public function hasFilter() : Boolean
        {
            return this._filterType != -1;
        }// end function

        public function set bankFilter(param1:int) : void
        {
            this._bankFilterType = param1;
            if (this._bankFilterType != -1)
            {
                InventoryManager.getInstance().bankInventory.refillView("bank", "bankFiltered");
            }
            this.updateBankStorageView();
            return;
        }// end function

        public function get bankFilter() : int
        {
            return this._bankFilterType;
        }// end function

        public function hasBankFilter() : Boolean
        {
            return this._bankFilterType != -1;
        }// end function

        public function set sortField(param1:int) : void
        {
            this._sortField = param1;
            this.currentStorageView.updateView();
            return;
        }// end function

        public function get sortField() : int
        {
            return this._sortField;
        }// end function

        public function hasSort() : Boolean
        {
            return this._sortField != SORT_FIELD_NONE;
        }// end function

        public function set sortRevert(param1:Boolean) : void
        {
            this._sortRevert = param1;
            return;
        }// end function

        public function get sortRevert() : Boolean
        {
            return this._sortRevert;
        }// end function

        public function set sortBankField(param1:int) : void
        {
            this._sortBankField = param1;
            this.currentBankView.updateView();
            return;
        }// end function

        public function get sortBankField() : int
        {
            return this._sortBankField;
        }// end function

        public function hasBankSort() : Boolean
        {
            return this._sortBankField != SORT_FIELD_NONE;
        }// end function

        public function set sortBankRevert(param1:Boolean) : void
        {
            this._sortBankRevert = param1;
            return;
        }// end function

        public function get sortBankRevert() : Boolean
        {
            return this._sortBankRevert;
        }// end function

        public function get currentStorageView() : IStorageView
        {
            var _loc_1:IStorageView = null;
            _loc_1 = this.inventory.getView("storageBidHouseFilter") as IStorageView;
            if (_loc_1)
            {
                return _loc_1;
            }
            _loc_1 = this.inventory.getView("storageSmithMagicFilter") as IStorageView;
            if (_loc_1)
            {
                return _loc_1;
            }
            _loc_1 = this.inventory.getView("storageCraftFilter") as IStorageView;
            if (_loc_1)
            {
                return _loc_1;
            }
            return this.getStorageViewOrFilter();
        }// end function

        private function getStorageViewOrFilter() : IStorageView
        {
            if (this.hasFilter())
            {
                return this.inventory.getView("storageFiltered") as IStorageView;
            }
            return this.getStorageView(this.category);
        }// end function

        public function get currentBankView() : IStorageView
        {
            return this.getBankView(this.bankCategory);
        }// end function

        public function enableBidHouseFilter(param1:Vector.<uint>, param2:uint) : void
        {
            this.disableBidHouseFilter();
            var _loc_3:* = this.currentStorageView.name;
            this.inventory.addView(new StorageBidHouseFilterView(this.inventory.hookLock, this.currentStorageView, param1, param2));
            InventoryManager.getInstance().inventory.refillView(_loc_3, "storageBidHouseFilter");
            return;
        }// end function

        public function disableBidHouseFilter() : void
        {
            if (this.inventory.getView("storageBidHouseFilter"))
            {
                this.inventory.removeView("storageBidHouseFilter");
            }
            return;
        }// end function

        public function getIsBidHouseFilterEnabled() : Boolean
        {
            return this.inventory.getView("storageBidHouseFilter") != null;
        }// end function

        public function enableSmithMagicFilter(param1:Skill) : void
        {
            var _loc_3:CraftFrame = null;
            this.disableSmithMagicFilter();
            if (!param1)
            {
                _loc_3 = Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
                if (!_loc_3)
                {
                    _log.error("Activation des filtres de forgemagie alors que la craftFrame n\'est pas active");
                    return;
                }
                param1 = Skill.getSkillById(_loc_3.skillId);
            }
            var _loc_2:* = this.currentStorageView.name;
            this.inventory.addView(new StorageSmithMagicFilterView(this.inventory.hookLock, this.currentStorageView, param1));
            InventoryManager.getInstance().inventory.refillView(_loc_2, "storageSmithMagicFilter");
            return;
        }// end function

        public function disableSmithMagicFilter() : void
        {
            if (this.inventory.getView("storageSmithMagicFilter"))
            {
                this.inventory.removeView("storageSmithMagicFilter");
            }
            return;
        }// end function

        public function enableCraftFilter(param1:Skill, param2:int) : void
        {
            var _loc_4:CraftFrame = null;
            this.disableCraftFilter();
            if (!param1)
            {
                _loc_4 = Kernel.getWorker().getFrame(CraftFrame) as CraftFrame;
                if (!_loc_4)
                {
                    _log.error("Activation des filtres de forgemagie alors que la craftFrame n\'est pas active");
                    return;
                }
                param1 = Skill.getSkillById(_loc_4.skillId);
            }
            var _loc_3:* = this.currentStorageView.name;
            this.inventory.addView(new StorageCraftFilterView(this.inventory.hookLock, this.currentStorageView, param1.id, param2));
            InventoryManager.getInstance().inventory.refillView(_loc_3, "storageCraftFilter");
            return;
        }// end function

        public function disableCraftFilter() : void
        {
            if (this.inventory.getView("storageCraftFilter"))
            {
                this.inventory.removeView("storageCraftFilter");
            }
            return;
        }// end function

        public function getIsSmithMagicFilterEnabled() : Boolean
        {
            return this.inventory.getView("storageSmithMagicFilter") != null;
        }// end function

        public function getIsCraftFilterEnabled() : Boolean
        {
            return this.inventory.getView("storageCraftFilter") != null;
        }// end function

        public function getStorageView(param1:int) : IStorageView
        {
            switch(param1)
            {
                case EQUIPMENT_CATEGORY:
                {
                    return this.inventory.getView("storageEquipment") as IStorageView;
                }
                case CONSUMABLES_CATEGORY:
                {
                    return this.inventory.getView("storageConsumables") as IStorageView;
                }
                case RESOURCES_CATEGORY:
                {
                    return this.inventory.getView("storageResources") as IStorageView;
                }
                case QUEST_CATEGORY:
                {
                    return this.inventory.getView("storageQuest") as IStorageView;
                }
                case ALL_CATEGORY:
                {
                }
                default:
                {
                    return this.inventory.getView("storage") as IStorageView;
                    break;
                }
            }
        }// end function

        public function getBankView(param1:int) : IStorageView
        {
            switch(param1)
            {
                case EQUIPMENT_CATEGORY:
                {
                    return InventoryManager.getInstance().bankInventory.getView("bankEquipement") as IStorageView;
                }
                case CONSUMABLES_CATEGORY:
                {
                    return InventoryManager.getInstance().bankInventory.getView("bankConsumables") as IStorageView;
                }
                case RESOURCES_CATEGORY:
                {
                    return InventoryManager.getInstance().bankInventory.getView("bankRessources") as IStorageView;
                }
                case QUEST_CATEGORY:
                {
                    return InventoryManager.getInstance().bankInventory.getView("bankQuest") as IStorageView;
                }
                case ALL_CATEGORY:
                {
                }
                default:
                {
                    return InventoryManager.getInstance().bankInventory.getView("bank") as IStorageView;
                    break;
                }
            }
        }// end function

        public function getCategoryTypes(param1:uint) : Dictionary
        {
            return this.getStorageView(param1).types;
        }// end function

        public function getBankCategoryTypes(param1:uint) : Dictionary
        {
            return this.getBankView(param1).types;
        }// end function

        public function updateStorageView() : void
        {
            this.refreshViews();
            this.currentStorageView.updateView();
            return;
        }// end function

        public function updateBankStorageView() : void
        {
            this.getBankView(this.bankCategory).updateView();
            return;
        }// end function

        private function get inventory() : Inventory
        {
            if (!this._inventory)
            {
                this._inventory = InventoryManager.getInstance().inventory;
            }
            return this._inventory;
        }// end function

        private function refreshViews() : void
        {
            var _loc_2:StorageBidHouseFilterView = null;
            var _loc_3:StorageSmithMagicFilterView = null;
            var _loc_4:StorageCraftFilterView = null;
            var _loc_1:* = this.getStorageViewOrFilter();
            if (this.getIsBidHouseFilterEnabled())
            {
                _loc_2 = this.inventory.getView("storageBidHouseFilter") as StorageBidHouseFilterView;
                _loc_2.parent = _loc_1;
                this.refreshView("storageBidHouseFilter");
            }
            if (this.getIsSmithMagicFilterEnabled())
            {
                _loc_3 = this.inventory.getView("storageSmithMagicFilter") as StorageSmithMagicFilterView;
                _loc_3.parent = _loc_1;
                this.refreshView("storageSmithMagicFilter");
            }
            if (this.getIsCraftFilterEnabled())
            {
                _loc_4 = this.inventory.getView("storageCraftFilter") as StorageCraftFilterView;
                _loc_4.parent = _loc_1;
                this.refreshView("storageCraftFilter");
            }
            return;
        }// end function

        private function refreshView(param1:String) : void
        {
            var _loc_2:* = this.inventory.getView(param1);
            this.inventory.removeView(param1);
            var _loc_3:* = this.currentStorageView.name;
            this.inventory.addView(_loc_2);
            InventoryManager.getInstance().inventory.refillView(_loc_3, param1);
            return;
        }// end function

        public static function getInstance() : StorageOptionManager
        {
            if (!_singleton)
            {
                _singleton = new StorageOptionManager;
            }
            return _singleton;
        }// end function

    }
}
