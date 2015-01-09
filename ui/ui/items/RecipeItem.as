package ui.items
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.JobsApi;
    import d2api.ContextMenuApi;
    import d2api.InventoryApi;
    import d2components.Slot;
    import d2components.Texture;
    import d2components.Label;
    import d2components.GraphicContainer;
    import d2enums.LocationEnum;
    import d2hooks.ObjectSelected;
    import d2hooks.*;

    public class RecipeItem 
    {

        private static var uriMissingIngredients:Object;
        private static var uriNoIngredients:Object;
        private static var uriMissingIngredientsSlot:Object;
        private static var uriNoIngredientsSlot:Object;

        public var output:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var jobApi:JobsApi;
        public var menuApi:ContextMenuApi;
        public var inventoryApi:InventoryApi;
        private var _grid:Object;
        private var _data;
        private var _selected:Boolean;
        private var _currentJob:Object;
        public var slotCraftedItem:Slot;
        public var slot1:Slot;
        public var slot2:Slot;
        public var slot3:Slot;
        public var slot4:Slot;
        public var slot5:Slot;
        public var slot6:Slot;
        public var slot7:Slot;
        public var slot8:Slot;
        public var tx_ingredientStateIcon1:Texture;
        public var tx_ingredientStateIcon2:Texture;
        public var tx_ingredientStateIcon3:Texture;
        public var tx_ingredientStateIcon4:Texture;
        public var tx_ingredientStateIcon5:Texture;
        public var tx_ingredientStateIcon6:Texture;
        public var tx_ingredientStateIcon7:Texture;
        public var tx_ingredientStateIcon8:Texture;
        public var lblAbility:Label;
        public var lblLevel:Label;
        public var lblName:Label;
        public var mainCtr:GraphicContainer;


        public function main(oParam:Object=null):void
        {
            var uriBase:String;
            if (!(uriMissingIngredients))
            {
                uriBase = this.uiApi.me().getConstant("assets");
                uriMissingIngredients = this.uiApi.createUri((uriBase + "tx_coloredWarning"));
                uriNoIngredients = this.uiApi.createUri((uriBase + "tx_coloredCross"));
                uriBase = this.uiApi.me().getConstant("bitmap");
                uriMissingIngredientsSlot = this.uiApi.createUri((uriBase + "warningSlot.png"));
                uriNoIngredientsSlot = this.uiApi.createUri((uriBase + "refuseDrop.png"));
            };
            this._grid = oParam.grid;
            this._data = oParam.data;
            this._selected = oParam.selected;
            var i:uint = 1;
            while (i < 9)
            {
                this.uiApi.addComponentHook(this[("slot" + i)], "onRollOver");
                this.uiApi.addComponentHook(this[("slot" + i)], "onRollOut");
                this.uiApi.addComponentHook(this[("slot" + i)], "onRightClick");
                this.uiApi.addComponentHook(this[("slot" + i)], "onRelease");
                this.uiApi.addComponentHook(this[("tx_ingredientStateIcon" + i)], "onRollOver");
                this.uiApi.addComponentHook(this[("tx_ingredientStateIcon" + i)], "onRollOut");
                i++;
            };
            this.uiApi.addComponentHook(this.slotCraftedItem, "onRollOver");
            this.uiApi.addComponentHook(this.slotCraftedItem, "onRollOut");
            this.uiApi.addComponentHook(this.slotCraftedItem, "onRightClick");
            this.uiApi.addComponentHook(this.slotCraftedItem, "onRelease");
            this.update(this._data, this._selected);
        }

        public function get data()
        {
            return (this._data);
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function update(data:*, selected:Boolean):void
        {
            var i:int;
            var ii:int;
            var ingredients:Object;
            var l:int;
            var ownedQty:uint;
            var requiredQty:uint;
            var uriSlot:Object;
            var uriIcon:Object;
            if (data)
            {
                this._data = data;
                this.lblName.text = this._data.result.name;
                this.lblLevel.text = ((this.uiApi.getText("ui.common.short.level") + " ") + this._data.result.level.toString());
                this.slotCraftedItem.data = this._data.result;
                i = 1;
                ingredients = this._data.ingredients;
                l = (ingredients.length + 1);
                while (i < l)
                {
                    ii = (i - 1);
                    this[("slot" + i)].data = ingredients[ii];
                    ownedQty = this.inventoryApi.getItemQty(ingredients[ii].id);
                    requiredQty = ingredients[ii].quantity;
                    uriSlot = null;
                    uriIcon = null;
                    if (ownedQty == 0)
                    {
                        uriSlot = uriNoIngredientsSlot;
                        uriIcon = uriNoIngredients;
                    }
                    else
                    {
                        if (ownedQty < requiredQty)
                        {
                            uriSlot = uriMissingIngredientsSlot;
                            uriIcon = uriMissingIngredients;
                        };
                    };
                    this[("tx_ingredientStateIcon" + i)].uri = uriIcon;
                    this[("slot" + i)].customTexture = uriSlot;
                    this[("slot" + i)].selectedTexture = uriSlot;
                    this[("slot" + i)].highlightTexture = uriSlot;
                    i++;
                };
                while (i < 9)
                {
                    this[("slot" + i)].data = null;
                    this[("tx_ingredientStateIcon" + i)].uri = null;
                    this[("slot" + i)].customTexture = null;
                    this[("slot" + i)].selectedTexture = null;
                    this[("slot" + i)].highlightTexture = null;
                    i++;
                };
            }
            else
            {
                this.slotCraftedItem.data = null;
                i = 1;
                while (i < 9)
                {
                    this[("tx_ingredientStateIcon" + i)].uri = null;
                    this[("slot" + i)].customTexture = null;
                    this[("slot" + i)].selectedTexture = null;
                    this[("slot" + i)].highlightTexture = null;
                    this[("slot" + i)].data = null;
                    i++;
                };
                this.lblAbility.text = "";
                this.lblLevel.text = "";
                this.lblName.text = "";
                this.mainCtr.softDisabled = false;
            };
        }

        public function select(b:Boolean):void
        {
        }

        public function onRollOver(target:Object):void
        {
            var txt:String;
            switch (target)
            {
                case this.slot1:
                case this.slot2:
                case this.slot3:
                case this.slot4:
                case this.slot5:
                case this.slot6:
                case this.slot7:
                case this.slot8:
                    if (target.data)
                    {
                        this.uiApi.showTooltip(target.data, target, false, "standard", 6, 2, 3, "itemName", null, {
                            "showEffects":true,
                            "header":true
                        }, "ItemInfo");
                    };
                    break;
                case this.tx_ingredientStateIcon1:
                case this.tx_ingredientStateIcon2:
                case this.tx_ingredientStateIcon3:
                case this.tx_ingredientStateIcon4:
                case this.tx_ingredientStateIcon5:
                case this.tx_ingredientStateIcon6:
                case this.tx_ingredientStateIcon7:
                case this.tx_ingredientStateIcon8:
                    if (target.uri)
                    {
                        if (target.uri.fileName == uriNoIngredients.fileName)
                        {
                            txt = this.uiApi.getText("ui.craft.noIngredient");
                        }
                        else
                        {
                            if (target.uri.fileName == uriMissingIngredients.fileName)
                            {
                                txt = this.uiApi.getText("ui.craft.ingredientNotEnough");
                            };
                        };
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt), target, false, "standard", LocationEnum.POINT_TOPLEFT, LocationEnum.POINT_BOTTOMRIGHT, 6);
                    };
                    break;
                case this.slotCraftedItem:
                    if (target.data)
                    {
                        this.uiApi.showTooltip(target.data, target, false, "standard", 8, 0, 0, "itemName", null, {
                            "showEffects":true,
                            "header":true
                        }, "ItemInfo");
                    };
                    break;
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            this.sysApi.dispatchHook(ObjectSelected, {"data":target.data});
        }

        public function onRightClick(target:Object):void
        {
            var contextMenu:Object;
            if (target.data)
            {
                contextMenu = this.menuApi.create(target.data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }


    }
}//package ui.items

