package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.jobs.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import flash.utils.*;

    public class StorageCraftFilterView extends StorageGenericView
    {
        private var _ingredients:Dictionary;
        private var _skillId:int;
        private var _slotCount:int;
        private var _parent:IStorageView;

        public function StorageCraftFilterView(param1:HookLock, param2:IStorageView, param3:int, param4:int) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = 0;
            super(param1);
            var _loc_5:* = Recipe.getAllRecipesForSkillId(param3, param4);
            this._ingredients = new Dictionary();
            for each (_loc_6 in _loc_5)
            {
                
                _loc_7 = false;
                for each (_loc_8 in _loc_6.recipe.ingredientIds)
                {
                    
                    this._ingredients[_loc_8] = true;
                }
            }
            this._ingredients[7508] = true;
            this._skillId = param3;
            this._slotCount = param4;
            this._parent = param2;
            return;
        }// end function

        override public function get name() : String
        {
            return "storageCraftFilter";
        }// end function

        override public function isListening(param1:ItemWrapper) : Boolean
        {
            return this._parent.isListening(param1) && this._ingredients.hasOwnProperty(param1.objectGID);
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
