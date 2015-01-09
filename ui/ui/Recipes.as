package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.StorageApi;
    import d2api.UtilApi;
    import d2api.DataApi;
    import d2api.JobsApi;
    import d2components.GraphicContainer;
    import d2components.Input;
    import d2components.ButtonContainer;
    import d2components.Grid;
    import d2components.Label;
    import __AS3__.vec.Vector;
    import d2data.Item;
    import d2hooks.InventoryContent;
    import d2hooks.KeyUp;
    import flash.utils.getTimer;
    import flash.utils.Dictionary;
    import d2hooks.RecipeSelected;
    import d2actions.*;
    import d2hooks.*;
    import __AS3__.vec.*;

    public class Recipes 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        public var storageApi:StorageApi;
        public var utilApi:UtilApi;
        public var dataApi:DataApi;
        public var jobApi:JobsApi;
        public var searchCtr:GraphicContainer;
        public var searchInput:Input;
        public var chk8:ButtonContainer;
        public var chk7:ButtonContainer;
        public var chk6:ButtonContainer;
        public var chk5:ButtonContainer;
        public var chk4:ButtonContainer;
        public var chk3:ButtonContainer;
        public var chk2:ButtonContainer;
        public var chk1:ButtonContainer;
        public var chk9:ButtonContainer;
        public var gdRecipes:Grid;
        public var lbl_title:Label;
        private var _searchCriteria:String;
        private var _recipes:Array;
        private var _defaultRecipes:Array;
        private var _maxSlots:Object;

        public function Recipes()
        {
            this._defaultRecipes = new Array();
            super();
        }

        public function main(params:Object):void
        {
            var tempSortedArray:Object;
            var recipeWithSkill:Object;
            var recipeId:uint;
            var chkChecked:int;
            var j:uint;
            var recipes:Vector.<uint> = new Vector.<uint>();
            for each (recipeWithSkill in params.recipes)
            {
                recipes.push(recipeWithSkill.recipe.resultId);
            };
            tempSortedArray = this.dataApi.querySort(Item, recipes, ["recipeSlots", "level", "name"], [false, false, true]);
            for each (recipeId in tempSortedArray)
            {
                this._defaultRecipes.push(this.jobApi.getRecipe(recipeId));
            };
            this.sysApi.addHook(InventoryContent, this.onInventoryUpdate);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            chkChecked = Common.getInstance().recipeSlotsNumber;
            j = 1;
            while (j < 10)
            {
                this.uiApi.addComponentHook(this[("chk" + j)], "onRelease");
                this.uiApi.addComponentHook(this[("chk" + j)], "onRollOver");
                this.uiApi.addComponentHook(this[("chk" + j)], "onRollOut");
                if (((chkChecked >> j) & 1))
                {
                    this[("chk" + j)].selected = true;
                };
                j++;
            };
            this.uiApi.addComponentHook(this.searchInput, "onRelease");
            this.uiApi.addComponentHook(this.searchInput, "onRollOver");
            this.uiApi.addComponentHook(this.searchInput, "onRollOut");
            this.lbl_title.text = this.uiApi.processText(this.uiApi.getText("ui.common.recipes"), "", false);
            var timer:int = getTimer();
            this.updateRecipes(params.maxSlots, this._defaultRecipes);
        }

        public function unload():void
        {
        }

        private function sortRecipe(pRecipeWithSkill1:Object, pRecipeWithSkill2:Object):Number
        {
            var slots1:uint = pRecipeWithSkill1.quantities.length;
            var slots2:uint = pRecipeWithSkill2.quantities.length;
            if (slots1 > slots2)
            {
                return (-1);
            };
            if (slots1 == slots2)
            {
                return (0);
            };
            return (1);
        }

        public function updateRecipes(maxSlots:int, recipes:Array):void
        {
            var i:uint;
            this._recipes = recipes;
            this._maxSlots = maxSlots;
            if (Common.getInstance().recipeSlotsNumber == 0)
            {
                i = 1;
                while (i < 9)
                {
                    this[("chk" + i)].selected = (i <= this._maxSlots);
                    i++;
                };
            };
            this.gdRecipes.dataProvider = this.filteredRecipes();
        }

        private function filteredRecipes():Array
        {
            var recipe:Object;
            var item:Object;
            var filter:Array = new Array();
            filter[1] = this.chk1.selected;
            filter[2] = this.chk2.selected;
            filter[3] = this.chk3.selected;
            filter[4] = this.chk4.selected;
            filter[5] = this.chk5.selected;
            filter[6] = this.chk6.selected;
            filter[7] = this.chk7.selected;
            filter[8] = this.chk8.selected;
            var result:Array = new Array();
            for each (recipe in this._recipes)
            {
                if (filter[recipe.ingredients.length])
                {
                    if (!(this._searchCriteria))
                    {
                        result.push(recipe);
                    }
                    else
                    {
                        if (this.utilApi.noAccent(recipe.result.name).toLowerCase().indexOf(this.utilApi.noAccent(this._searchCriteria)) != -1)
                        {
                            result.push(recipe);
                        }
                        else
                        {
                            for each (item in recipe.ingredients)
                            {
                                if (item.name.toLowerCase().indexOf(this._searchCriteria) != -1)
                                {
                                    result.push(recipe);
                                    break;
                                };
                            };
                        };
                    };
                };
            };
            return (result);
        }

        private function filterAvailableRecipes():Array
        {
            var item:Object;
            var recipe:Object;
            var recipeOk:Boolean;
            var i:int;
            var recipes:Array = this.filteredRecipes();
            var res:Array = new Array();
            if (!(this.chk9.selected))
            {
                return (recipes);
            };
            var inventory:Object = this.storageApi.getViewContent("storage");
            var invDict:Dictionary = new Dictionary();
            for each (item in inventory)
            {
                if (!(item.linked))
                {
                    if (invDict[item.objectGID] == null)
                    {
                        invDict[item.objectGID] = item.quantity;
                    }
                    else
                    {
                        invDict[item.objectGID] = (invDict[item.objectGID] + item.quantity);
                    };
                };
            };
            for each (recipe in recipes)
            {
                recipeOk = true;
                i = 0;
                while (i < recipe.ingredientIds.length)
                {
                    if (((!(invDict[recipe.ingredientIds[i]])) || ((invDict[recipe.ingredientIds[i]] < recipe.quantities[i]))))
                    {
                        recipeOk = false;
                        break;
                    };
                    i++;
                };
                if (recipeOk)
                {
                    res.push(recipe);
                };
            };
            return (res);
        }

        private function onInventoryUpdate(items:Object, kama:uint):void
        {
            if (this.chk9.selected)
            {
                this.gdRecipes.dataProvider = this.filterAvailableRecipes();
            };
        }

        public function onRelease(target:Object):void
        {
            var _local_2:int;
            switch (target)
            {
                case this.searchInput:
                    if (this.searchInput.text == this.uiApi.getText("ui.common.search.input"))
                    {
                        this.searchInput.text = "";
                    };
                    break;
                case this.chk8:
                case this.chk7:
                case this.chk6:
                case this.chk5:
                case this.chk4:
                case this.chk3:
                case this.chk2:
                case this.chk1:
                    if (this.chk9.selected)
                    {
                        this.gdRecipes.dataProvider = this.filterAvailableRecipes();
                    }
                    else
                    {
                        this.gdRecipes.dataProvider = this.filteredRecipes();
                    };
                    if (this.chk1.selected)
                    {
                        _local_2 = (_local_2 + Math.pow(2, 1));
                    };
                    if (this.chk2.selected)
                    {
                        _local_2 = (_local_2 + Math.pow(2, 2));
                    };
                    if (this.chk3.selected)
                    {
                        _local_2 = (_local_2 + Math.pow(2, 3));
                    };
                    if (this.chk4.selected)
                    {
                        _local_2 = (_local_2 + Math.pow(2, 4));
                    };
                    if (this.chk5.selected)
                    {
                        _local_2 = (_local_2 + Math.pow(2, 5));
                    };
                    if (this.chk6.selected)
                    {
                        _local_2 = (_local_2 + Math.pow(2, 6));
                    };
                    if (this.chk7.selected)
                    {
                        _local_2 = (_local_2 + Math.pow(2, 7));
                    };
                    if (this.chk8.selected)
                    {
                        _local_2 = (_local_2 + Math.pow(2, 8));
                    };
                    Common.getInstance().recipeSlotsNumber = _local_2;
                    break;
                case this.chk9:
                    this.gdRecipes.dataProvider = this.filterAvailableRecipes();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var ttData:String;
            var _local_3:uint;
            switch (target)
            {
                case this.searchInput:
                    ttData = this.uiApi.getText("ui.common.searchFilterTooltip");
                    break;
                case this.chk8:
                case this.chk7:
                case this.chk6:
                case this.chk5:
                case this.chk4:
                case this.chk3:
                case this.chk2:
                case this.chk1:
                    _local_3 = parseInt(target.name.substr(3, 1));
                    ttData = this.uiApi.processText(this.uiApi.getText("ui.common.hideShowRicepies", _local_3), "", (_local_3 == 1));
                    break;
            };
            if (ttData)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(ttData), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            switch (target)
            {
                case this.gdRecipes:
                    if (selectMethod == 1)
                    {
                        item = this.gdRecipes.selectedItem;
                        this.sysApi.dispatchHook(RecipeSelected, item);
                    };
                    break;
            };
        }

        public function set disabled(disable:Boolean):void
        {
            this.gdRecipes.disabled = disable;
        }

        public function get disabled():Boolean
        {
            return (this.gdRecipes.disabled);
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (((this.searchCtr.visible) && (this.searchInput.haveFocus)))
            {
                if (this.searchInput.text.length > 2)
                {
                    this._searchCriteria = this.searchInput.text.toLowerCase();
                    this.gdRecipes.dataProvider = this.filteredRecipes();
                }
                else
                {
                    if (this._searchCriteria)
                    {
                        this._searchCriteria = null;
                    };
                    if (this.searchInput.text == "")
                    {
                        this.gdRecipes.dataProvider = this._defaultRecipes;
                    }
                    else
                    {
                        this.gdRecipes.dataProvider = new Array();
                    };
                };
            };
        }


    }
}//package ui

