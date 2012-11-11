package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;

    public class StorageSmithMagicFilterView extends StorageGenericView
    {
        private var _skill:Skill;
        private var _parent:IStorageView;
        private static const SMITHMAGIC_RUNE_ID:int = 78;
        private static const SMITHMAGIC_POTION_ID:int = 26;
        private static const SIGNATURE_RUNE_ID:int = 7508;

        public function StorageSmithMagicFilterView(param1:HookLock, param2:IStorageView, param3:Skill)
        {
            super(param1);
            this._skill = param3;
            this._parent = param2;
            return;
        }// end function

        override public function get name() : String
        {
            return "storageSmithMagicFilter";
        }// end function

        override public function isListening(param1:ItemWrapper) : Boolean
        {
            var _loc_2:* = Item.getItemById(param1.objectGID);
            return this._parent.isListening(param1) && super.isListening(param1) && (_loc_2.typeId == this._skill.modifiableItemType || _loc_2.typeId == SMITHMAGIC_RUNE_ID || _loc_2.typeId == SMITHMAGIC_POTION_ID || param1.objectGID == SIGNATURE_RUNE_ID);
        }// end function

        override public function updateView() : void
        {
            super.updateView();
            if (StorageOptionManager.getInstance().currentStorageView == this)
            {
                _hookLock.addHook(InventoryHookList.StorageViewContent, [content, InventoryManager.getInstance().inventory.localKamas]);
            }
            return;
        }// end function

        public function set parent(param1:IStorageView) : void
        {
            this._parent = param1;
            return;
        }// end function

        public function get parent() : IStorageView
        {
            return this._parent;
        }// end function

    }
}
