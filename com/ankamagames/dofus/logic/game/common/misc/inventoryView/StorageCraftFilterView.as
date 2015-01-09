package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
    import com.ankamagames.dofus.internalDatacenter.jobs.RecipeWithSkill;
    import com.ankamagames.dofus.datacenter.jobs.Recipe;
    import com.ankamagames.dofus.logic.game.common.misc.HookLock;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;

    public class StorageCraftFilterView extends StorageGenericView 
    {

        private var _ingredients:Dictionary;
        private var _skillId:int;
        private var _slotCount:int;
        private var _parent:IStorageView;

        public function StorageCraftFilterView(hookLock:HookLock, parentView:IStorageView, skillId:int, slotCount:int):void
        {
            var recipe:RecipeWithSkill;
            var selected:Boolean;
            var id:int;
            super(hookLock);
            var recipies:Array = Recipe.getAllRecipesForSkillId(skillId, slotCount);
            this._ingredients = new Dictionary();
            for each (recipe in recipies)
            {
                selected = false;
                for each (id in recipe.recipe.ingredientIds)
                {
                    this._ingredients[id] = true;
                };
            };
            this._ingredients[7508] = true;
            this._skillId = skillId;
            this._slotCount = slotCount;
            this._parent = parentView;
        }

        override public function get name():String
        {
            return ("storageCraftFilter");
        }

        override public function isListening(item:ItemWrapper):Boolean
        {
            return (((this._parent.isListening(item)) && (this._ingredients.hasOwnProperty(item.objectGID))));
        }

        override public function updateView():void
        {
            super.updateView();
            if (StorageOptionManager.getInstance().currentStorageView == this)
            {
                _hookLock.addHook(InventoryHookList.StorageViewContent, [content, InventoryManager.getInstance().inventory.localKamas]);
            };
        }

        public function set parent(view:IStorageView):void
        {
            this._parent = view;
        }

        public function get parent():IStorageView
        {
            return (this._parent);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.misc.inventoryView

