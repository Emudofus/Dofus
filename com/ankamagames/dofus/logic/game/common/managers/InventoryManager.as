package com.ankamagames.dofus.logic.game.common.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.common.misc.inventoryView.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class InventoryManager extends Object
    {
        private var _inventory:Inventory;
        private var _bankInventory:Inventory;
        private var _presets:Array;
        private var _shortcutBarSpells:Array;
        private var _shortcutBarItems:Array;
        private static var _self:InventoryManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryManager));

        public function InventoryManager()
        {
            this._inventory = new PlayerInventory();
            this._presets = new Array(8);
            this._shortcutBarItems = new Array();
            this._shortcutBarSpells = new Array();
            this.inventory.addView(new RealView(this.inventory.hookLock));
            this.inventory.addView(new EquipmentView(this.inventory.hookLock));
            this.inventory.addView(new RoleplayBuffView(this.inventory.hookLock));
            this.inventory.addView(new CertificateView(this.inventory.hookLock));
            this.inventory.addView(new StorageView(this.inventory.hookLock));
            this.inventory.addView(new StorageEquipmentView(this.inventory.hookLock));
            this.inventory.addView(new StorageConsumablesView(this.inventory.hookLock));
            this.inventory.addView(new StorageResourcesView(this.inventory.hookLock));
            this.inventory.addView(new StorageQuestCategory(this.inventory.hookLock));
            this.inventory.addView(new StorageFilteredView(this.inventory.hookLock));
            return;
        }// end function

        public function get inventory() : Inventory
        {
            return this._inventory;
        }// end function

        public function get realInventory() : Vector.<ItemWrapper>
        {
            return this._inventory.getView("real").content;
        }// end function

        public function get presets() : Array
        {
            return this._presets;
        }// end function

        public function set presets(param1:Array) : void
        {
            this._presets = param1;
            return;
        }// end function

        public function get bankInventory() : Inventory
        {
            if (!this._bankInventory)
            {
                this._bankInventory = new Inventory();
                this._bankInventory.addView(new BankView(this._bankInventory.hookLock));
                this._bankInventory.addView(new BankEquipementView(this._bankInventory.hookLock));
                this._bankInventory.addView(new BankConsumablesView(this._bankInventory.hookLock));
                this._bankInventory.addView(new BankRessourcesView(this._bankInventory.hookLock));
                this._bankInventory.addView(new BankQuestView(this._bankInventory.hookLock));
                this._bankInventory.addView(new BankFilteredView(this._bankInventory.hookLock));
            }
            return this._bankInventory;
        }// end function

        public function get shortcutBarItems() : Array
        {
            return this._shortcutBarItems;
        }// end function

        public function set shortcutBarItems(param1:Array) : void
        {
            this._shortcutBarItems = param1;
            return;
        }// end function

        public function get shortcutBarSpells() : Array
        {
            return this._shortcutBarSpells;
        }// end function

        public function set shortcutBarSpells(param1:Array) : void
        {
            this._shortcutBarSpells = param1;
            return;
        }// end function

        public static function getInstance() : InventoryManager
        {
            if (!_self)
            {
                _self = new InventoryManager;
            }
            return _self;
        }// end function

    }
}
