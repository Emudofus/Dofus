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
      
      public function StorageSmithMagicFilterView(hookLock:HookLock, parentView:IStorageView, skill:Skill) {
         super(hookLock);
         this._skill = skill;
         this._parent = parentView;
      }
      
      private static const SMITHMAGIC_RUNE_ID:int = 78;
      
      private static const SMITHMAGIC_POTION_ID:int = 26;
      
      private static const SIGNATURE_RUNE_ID:int = 7508;
      
      private var _skill:Skill;
      
      private var _parent:IStorageView;
      
      override public function get name() : String {
         return "storageSmithMagicFilter";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean {
         var data:Item = Item.getItemById(item.objectGID);
         return (this._parent.isListening(item)) && (super.isListening(item)) && ((data.typeId == this._skill.modifiableItemType) || (data.typeId == SMITHMAGIC_RUNE_ID) || (data.typeId == SMITHMAGIC_POTION_ID) || (item.objectGID == SIGNATURE_RUNE_ID));
      }
      
      override public function updateView() : void {
         super.updateView();
         if(StorageOptionManager.getInstance().currentStorageView == this)
         {
            _hookLock.addHook(InventoryHookList.StorageViewContent,[content,InventoryManager.getInstance().inventory.localKamas]);
         }
      }
      
      public function set parent(view:IStorageView) : void {
         this._parent = view;
      }
      
      public function get parent() : IStorageView {
         return this._parent;
      }
   }
}
