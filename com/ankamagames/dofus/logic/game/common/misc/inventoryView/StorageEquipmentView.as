package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;

    public class StorageEquipmentView extends StorageGenericView
    {

        public function StorageEquipmentView(param1:HookLock)
        {
            super(param1);
            return;
        }// end function

        override public function get name() : String
        {
            return "storageEquipment";
        }// end function

        override public function isListening(param1:ItemWrapper) : Boolean
        {
            return super.isListening(param1) && param1.category == StorageOptionManager.EQUIPMENT_CATEGORY;
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

    }
}
