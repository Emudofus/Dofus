package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;

    public class StorageBidHouseFilterView extends StorageGenericView
    {
        private var _allowedTypes:Vector.<uint>;
        private var _maxItemLevel:uint;
        private var _parent:IStorageView;

        public function StorageBidHouseFilterView(param1:HookLock, param2:IStorageView, param3:Vector.<uint>, param4:uint)
        {
            super(param1);
            this._allowedTypes = param3;
            this._maxItemLevel = param4;
            this._parent = param2;
            return;
        }// end function

        override public function get name() : String
        {
            return "storageBidHouseFilter";
        }// end function

        override public function isListening(param1:ItemWrapper) : Boolean
        {
            var _loc_2:* = Item.getItemById(param1.objectGID);
            return this._parent.isListening(param1) && super.isListening(param1) && _loc_2.level <= this._maxItemLevel && this._allowedTypes.indexOf(_loc_2.typeId) != -1;
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
