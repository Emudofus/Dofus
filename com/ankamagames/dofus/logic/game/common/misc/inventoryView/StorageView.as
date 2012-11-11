package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;

    public class StorageView extends StorageGenericView
    {

        public function StorageView(param1:HookLock)
        {
            super(param1);
            return;
        }// end function

        override public function get name() : String
        {
            return "storage";
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

        override public function sortField() : int
        {
            return StorageOptionManager.getInstance().sortField;
        }// end function

        override public function sortRevert() : Boolean
        {
            return StorageOptionManager.getInstance().sortRevert;
        }// end function

    }
}
