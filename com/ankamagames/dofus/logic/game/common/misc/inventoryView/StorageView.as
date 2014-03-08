package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   
   public class StorageView extends StorageGenericView
   {
      
      public function StorageView(param1:HookLock) {
         super(param1);
      }
      
      override public function get name() : String {
         return "storage";
      }
      
      override public function updateView() : void {
         super.updateView();
         if(StorageOptionManager.getInstance().currentStorageView == this)
         {
            _hookLock.addHook(InventoryHookList.StorageViewContent,[content,InventoryManager.getInstance().inventory.localKamas]);
         }
      }
      
      override public function sortFields() : Array {
         return StorageOptionManager.getInstance().sortFields;
      }
      
      override public function sortRevert() : Boolean {
         return StorageOptionManager.getInstance().sortRevert;
      }
   }
}
