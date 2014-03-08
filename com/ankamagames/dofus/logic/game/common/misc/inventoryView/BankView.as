package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   
   public class BankView extends StorageGenericView
   {
      
      public function BankView(hookLock:HookLock) {
         super(hookLock);
      }
      
      override public function get name() : String {
         return "bank";
      }
      
      override public function updateView() : void {
         super.updateView();
         if((StorageOptionManager.getInstance().bankCategory == StorageOptionManager.ALL_CATEGORY) && (!StorageOptionManager.getInstance().hasBankFilter()))
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
