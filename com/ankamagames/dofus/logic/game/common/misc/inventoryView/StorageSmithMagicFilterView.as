package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   
   public class StorageSmithMagicFilterView extends StorageGenericView
   {
      
      public function StorageSmithMagicFilterView(param1:HookLock, param2:IStorageView, param3:Skill) {
         super(param1);
         this._skill = param3;
         this._parent = param2;
      }
      
      private static const SMITHMAGIC_RUNE_ID:int = 78;
      
      private static const SMITHMAGIC_POTION_ID:int = 26;
      
      private static const SIGNATURE_RUNE_ID:int = 7508;
      
      private var _skill:Skill;
      
      private var _parent:IStorageView;
      
      override public function get name() : String {
         return "storageSmithMagicFilter";
      }
      
      override public function isListening(param1:ItemWrapper) : Boolean {
         var _loc2_:Item = Item.getItemById(param1.objectGID);
         return (this._parent.isListening(param1)) && (super.isListening(param1)) && (_loc2_.typeId == this._skill.modifiableItemType || _loc2_.typeId == SMITHMAGIC_RUNE_ID || _loc2_.typeId == SMITHMAGIC_POTION_ID || param1.objectGID == SIGNATURE_RUNE_ID);
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
