package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   
   public class StorageConsumablesView extends StorageGenericView
   {
      
      public function StorageConsumablesView(param1:HookLock) {
         super(param1);
      }
      
      override public function get name() : String {
         return "storageConsumables";
      }
      
      override public function isListening(param1:ItemWrapper) : Boolean {
         return (super.isListening(param1)) && param1.category == StorageOptionManager.CONSUMABLES_CATEGORY;
      }
      
      override public function updateView() : void {
         super.updateView();
         if(StorageOptionManager.getInstance().currentStorageView == this)
         {
            _hookLock.addHook(InventoryHookList.StorageViewContent,[content,InventoryManager.getInstance().inventory.localKamas]);
         }
      }
   }
}
