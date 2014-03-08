package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   
   public class StorageBidHouseFilterView extends StorageGenericView
   {
      
      public function StorageBidHouseFilterView(param1:HookLock, param2:IStorageView, param3:Vector.<uint>, param4:uint) {
         super(param1);
         this._allowedTypes = param3;
         this._maxItemLevel = param4;
         this._parent = param2;
      }
      
      private var _allowedTypes:Vector.<uint>;
      
      private var _maxItemLevel:uint;
      
      private var _parent:IStorageView;
      
      override public function get name() : String {
         return "storageBidHouseFilter";
      }
      
      override public function isListening(param1:ItemWrapper) : Boolean {
         var _loc2_:Item = Item.getItemById(param1.objectGID);
         return (this._parent.isListening(param1)) && (super.isListening(param1)) && _loc2_.level <= this._maxItemLevel && !(this._allowedTypes.indexOf(_loc2_.typeId) == -1);
      }
      
      override public function updateView() : void {
         super.updateView();
         if(StorageOptionManager.getInstance().currentStorageView == this)
         {
            _hookLock.addHook(InventoryHookList.StorageViewContent,[content,InventoryManager.getInstance().inventory.localKamas]);
         }
      }
      
      public function set parent(param1:IStorageView) : void {
         this._parent = param1;
      }
      
      public function get parent() : IStorageView {
         return this._parent;
      }
   }
}
