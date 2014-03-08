package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.IHookLock;
   
   public class RealView extends ListView
   {
      
      public function RealView(param1:IHookLock) {
         super(param1);
      }
      
      override public function get name() : String {
         return "real";
      }
      
      override public function addItem(param1:ItemWrapper, param2:int) : void {
         super.addItem(param1,param2);
         _hookLock.addHook(InventoryHookList.ObjectAdded,[param1]);
         this.updateView();
      }
      
      override public function removeItem(param1:ItemWrapper, param2:int) : void {
         super.removeItem(param1,param2);
         _hookLock.addHook(InventoryHookList.ObjectDeleted,[param1]);
         this.updateView();
      }
      
      override public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void {
         super.modifyItem(param1,param2,param3);
         _hookLock.addHook(InventoryHookList.ObjectModified,[param1]);
         if(param1.quantity != param2.quantity)
         {
            _hookLock.addHook(InventoryHookList.ObjectQuantity,[param1,param1.quantity,param2.quantity]);
         }
         this.updateView();
      }
      
      override public function isListening(param1:ItemWrapper) : Boolean {
         return true;
      }
      
      override public function updateView() : void {
         _hookLock.addHook(InventoryHookList.InventoryContent,[content,InventoryManager.getInstance().inventory.kamas]);
      }
   }
}
