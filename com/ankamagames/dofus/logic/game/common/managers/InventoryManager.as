package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.misc.Inventory;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankEquipementView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankConsumablesView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankRessourcesView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankQuestView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankFilteredView;
   import com.ankamagames.dofus.logic.game.common.misc.PlayerInventory;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.RealView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.EquipmentView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.RoleplayBuffView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.CertificateView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageEquipmentView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageConsumablesView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageResourcesView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageQuestCategory;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageFilteredView;
   
   public class InventoryManager extends Object
   {
      
      public function InventoryManager() {
         super();
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
      }
      
      private static var _self:InventoryManager;
      
      protected static const _log:Logger;
      
      public static function getInstance() : InventoryManager {
         if(!_self)
         {
            _self = new InventoryManager();
         }
         return _self;
      }
      
      private var _inventory:Inventory;
      
      private var _bankInventory:Inventory;
      
      private var _presets:Array;
      
      private var _shortcutBarSpells:Array;
      
      private var _shortcutBarItems:Array;
      
      public function init() : void {
         this._inventory.initialize(new Vector.<ItemWrapper>());
         this._presets = new Array(8);
         this._shortcutBarItems = new Array();
         this._shortcutBarSpells = new Array();
      }
      
      public function get inventory() : Inventory {
         return this._inventory;
      }
      
      public function get realInventory() : Vector.<ItemWrapper> {
         return this._inventory.getView("real").content;
      }
      
      public function get presets() : Array {
         return this._presets;
      }
      
      public function set presets(aPresets:Array) : void {
         this._presets = aPresets;
      }
      
      public function get bankInventory() : Inventory {
         if(!this._bankInventory)
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
      }
      
      public function get shortcutBarItems() : Array {
         return this._shortcutBarItems;
      }
      
      public function set shortcutBarItems(aItems:Array) : void {
         this._shortcutBarItems = aItems;
      }
      
      public function get shortcutBarSpells() : Array {
         return this._shortcutBarSpells;
      }
      
      public function set shortcutBarSpells(aSpells:Array) : void {
         this._shortcutBarSpells = aSpells;
      }
   }
}
