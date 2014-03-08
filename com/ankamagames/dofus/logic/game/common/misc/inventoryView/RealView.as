package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.IHookLock;
   
   public class RealView extends ListView
   {
      
      public function RealView(hookLock:IHookLock) {
         super(hookLock);
      }
      
      override public function get name() : String {
         return "real";
      }
      
      override public function addItem(item:ItemWrapper, invisible:int) : void {
         super.addItem(item,invisible);
         _hookLock.addHook(InventoryHookList.ObjectAdded,[item]);
         this.updateView();
      }
      
      override public function removeItem(item:ItemWrapper, invisible:int) : void {
         super.removeItem(item,invisible);
         _hookLock.addHook(InventoryHookList.ObjectDeleted,[item]);
         this.updateView();
      }
      
      override public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void {
         super.modifyItem(item,oldItem,invisible);
         _hookLock.addHook(InventoryHookList.ObjectModified,[item]);
         if(item.quantity != oldItem.quantity)
         {
            _hookLock.addHook(InventoryHookList.ObjectQuantity,[item,item.quantity,oldItem.quantity]);
         }
         this.updateView();
      }
      
      override public function isListening(item:ItemWrapper) : Boolean {
         return true;
      }
      
      override public function updateView() : void {
         _hookLock.addHook(InventoryHookList.InventoryContent,[content,InventoryManager.getInstance().inventory.kamas]);
      }
   }
}
