package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   
   public class BankRessourcesView extends StorageGenericView
   {
      
      public function BankRessourcesView(param1:HookLock)
      {
         super(param1);
      }
      
      override public function get name() : String
      {
         return "bankRessources";
      }
      
      override public function isListening(param1:ItemWrapper) : Boolean
      {
         return (super.isListening(param1)) && param1.category == StorageOptionManager.RESOURCES_CATEGORY;
      }
      
      override public function updateView() : void
      {
         super.updateView();
         if(StorageOptionManager.getInstance().bankCategory == StorageOptionManager.RESOURCES_CATEGORY && !StorageOptionManager.getInstance().hasBankFilter())
         {
            _hookLock.addHook(InventoryHookList.BankViewContent,[content,InventoryManager.getInstance().bankInventory.localKamas]);
         }
      }
      
      override public function sortFields() : Array
      {
         return StorageOptionManager.getInstance().sortBankFields;
      }
      
      override public function sortRevert() : Boolean
      {
         return StorageOptionManager.getInstance().sortBankRevert;
      }
   }
}
