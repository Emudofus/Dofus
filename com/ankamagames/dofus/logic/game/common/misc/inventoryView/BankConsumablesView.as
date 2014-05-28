package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   
   public class BankConsumablesView extends StorageGenericView
   {
      
      public function BankConsumablesView(hookLock:HookLock) {
         super(hookLock);
      }
      
      override public function get name() : String {
         return "bankConsumables";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean {
         return (super.isListening(item)) && (item.category == StorageOptionManager.CONSUMABLES_CATEGORY);
      }
      
      override public function updateView() : void {
         super.updateView();
         if((StorageOptionManager.getInstance().bankCategory == StorageOptionManager.CONSUMABLES_CATEGORY) && (!StorageOptionManager.getInstance().hasBankFilter()))
         {
            _hookLock.addHook(InventoryHookList.BankViewContent,[content,InventoryManager.getInstance().bankInventory.localKamas]);
         }
      }
      
      override public function sortFields() : Array {
         return StorageOptionManager.getInstance().sortBankFields;
      }
      
      override public function sortRevert() : Boolean {
         return StorageOptionManager.getInstance().sortBankRevert;
      }
   }
}
