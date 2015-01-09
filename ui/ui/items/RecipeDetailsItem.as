package ui.items
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.ContextMenuApi;
    import d2api.AveragePricesApi;
    import d2components.Slot;
    import d2components.Texture;
    import d2components.Label;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2enums.LocationEnum;
    import d2hooks.ShowObjectLinked;
    import d2hooks.*;

    public class RecipeDetailsItem 
    {

        private static var uriMissingIngredients:Object;
        private static var uriNoIngredients:Object;
        private static var uriBagIngredients:Object;
        private static var uriMissingIngredientsSlot:Object;
        private static var uriNoIngredientsSlot:Object;
        private static var uriBagIngredientsSlot:Object;

        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var menuApi:ContextMenuApi;
        public var averagePriceApi:AveragePricesApi;
        private var _grid:Object;
        private var _data:Object;
        private var _selected:Boolean;
        private var _slotMax:int;
        private var _missingIngredients:Boolean;
        private var _uiClass:Object;
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
        public var lblName:Label;
        public var lblLevel:Label;
        public var lblAbility:Label;
        public var lblXp:Label;
        public var tx_background:Texture;
        public var mainCtr:GraphicContainer;
        public var btn_getItems:ButtonContainer;


        public function main(oParam:Object=null):void
        {
            var uriBase:String;
            if (!(uriMissingIngredients))
            {
                uriBase = this.uiApi.me().getConstant("assets");
                uriMissingIngredients = this.uiApi.createUri((uriBase + "tx_coloredWarning"));
                uriNoIngredients = this.uiApi.createUri((uriBase + "tx_coloredCross"));
                uriBagIngredients = this.uiApi.createUri((uriBase + "tx_coloredCheck"));
                uriBase = this.uiApi.me().getConstant("bitmap");
                uriMissingIngredientsSlot = this.uiApi.createUri((uriBase + "warningSlot.png"));
                uriNoIngredientsSlot = this.uiApi.createUri((uriBase + "refuseDrop.png"));
                uriBagIngredientsSlot = this.uiApi.createUri((uriBase + "validSlot.png"));
            };
            this._grid = oParam.grid;
            this._data = oParam.data;
            this._selected = oParam.selected;
            this._uiClass = this._grid.getUi().uiClass;
            this.slotCraftedItem.allowDrag = false;
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
            this.uiApi.addComponentHook(this.tx_background, "onRollOver");
            this.uiApi.addComponentHook(this.tx_background, "onRollOut");
            this.uiApi.addComponentHook(this.btn_getItems, "onRollOver");
            this.uiApi.addComponentHook(this.btn_getItems, "onRollOut");
            this.uiApi.addComponentHook(this.btn_getItems, "onRelease");
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
            var maxOccurence:int;
            var ingredients:Object;
            var xp:int;
            var i:int;
            var ii:int;
            var l:int;
            var ingredientQty:int;
            var hasItemsToTransfert:Boolean;
            var itemIsInBag:Boolean;
            this._data = data;
            if (data)
            {
                this.lblName.text = this._data.result.name;
                this.lblAbility.text = (("(" + this._data.skill.name) + ")");
                maxOccurence = this._uiClass.getActualMaxOccurence(this._data.resultId);
                if (maxOccurence)
                {
                    this.tx_background.alpha = 1;
                }
                else
                {
                    this.tx_background.alpha = 0.4;
                };
                this.lblLevel.text = ((this.uiApi.getText("ui.common.short.level") + " ") + this._data.result.level.toString());
                this._slotMax = this._uiClass.getMaxSlotsForJob(this._data.jobId);
                if (!(this._slotMax))
                {
                    this._slotMax = -1;
                };
                ingredients = this._data.ingredients;
                xp = 0;
                if ((((this._slotMax >= 0)) && (((this._slotMax - ingredients.length) < 4))))
                {
                    switch (ingredients.length)
                    {
                        case 2:
                            xp = 10;
                            break;
                        case 3:
                            xp = 25;
                            break;
                        case 4:
                            xp = 50;
                            break;
                        case 5:
                            xp = 100;
                            break;
                        case 6:
                            xp = 250;
                            break;
                        case 7:
                            xp = 500;
                            break;
                        case 8:
                            xp = 1000;
                            break;
                        default:
                            xp = 1;
                    };
                };
                if (this._slotMax == -1)
                {
                    this.lblXp.text = "";
                }
                else
                {
                    this.lblXp.text = this.uiApi.getText("ui.tooltip.monsterXpAlone", xp);
                };
                if (xp == 0)
                {
                    this.lblXp.cssClass = "rightdarkred";
                }
                else
                {
                    this.lblXp.cssClass = "right";
                };
                this.slotCraftedItem.data = this._data.result;
                this.slotCraftedItem.updateQuantity(maxOccurence);
                this._missingIngredients = false;
                i = 1;
                l = (ingredients.length + 1);
                hasItemsToTransfert = false;
                while (i < l)
                {
                    ii = (i - 1);
                    itemIsInBag = this._uiClass.itemIsInBag(this._data.ingredientIds[ii]);
                    ingredientQty = this._uiClass.getItemTotalQty(ingredients[ii].objectGID);
                    this[("slot" + i)].data = ingredients[ii];
                    this[("slot" + i)].mouseEnabled = true;
                    if (!(ingredientQty))
                    {
                        this[("tx_ingredientStateIcon" + i)].uri = uriNoIngredients;
                        this[("slot" + i)].customTexture = uriNoIngredientsSlot;
                        this[("slot" + i)].selectedTexture = uriNoIngredientsSlot;
                        this[("slot" + i)].highlightTexture = uriNoIngredientsSlot;
                        this._missingIngredients = true;
                    }
                    else
                    {
                        if (ingredientQty < this._data.quantities[ii])
                        {
                            this[("tx_ingredientStateIcon" + i)].uri = uriMissingIngredients;
                            this[("slot" + i)].customTexture = uriMissingIngredientsSlot;
                            this[("slot" + i)].selectedTexture = uriMissingIngredientsSlot;
                            this[("slot" + i)].highlightTexture = uriMissingIngredientsSlot;
                            this._missingIngredients = true;
                            if (!(itemIsInBag))
                            {
                                hasItemsToTransfert = true;
                            };
                        }
                        else
                        {
                            if (itemIsInBag)
                            {
                                this[("tx_ingredientStateIcon" + i)].uri = uriBagIngredients;
                                this[("slot" + i)].customTexture = uriBagIngredientsSlot;
                                this[("slot" + i)].selectedTexture = uriBagIngredientsSlot;
                                this[("slot" + i)].highlightTexture = uriBagIngredientsSlot;
                            }
                            else
                            {
                                this[("tx_ingredientStateIcon" + i)].uri = null;
                                this[("slot" + i)].customTexture = null;
                                this[("slot" + i)].selectedTexture = null;
                                this[("slot" + i)].highlightTexture = null;
                                hasItemsToTransfert = true;
                            };
                        };
                    };
                    i++;
                };
                while (i < 9)
                {
                    this[("tx_ingredientStateIcon" + i)].uri = null;
                    this[("slot" + i)].customTexture = null;
                    this[("slot" + i)].selectedTexture = null;
                    this[("slot" + i)].highlightTexture = null;
                    this[("slot" + i)].data = null;
                    this[("slot" + i)].mouseEnabled = false;
                    i++;
                };
                this.btn_getItems.visible = ((this._uiClass.canTransfertItems) && (hasItemsToTransfert));
            }
            else
            {
                i = 1;
                while (i < 9)
                {
                    this[("tx_ingredientStateIcon" + i)].uri = null;
                    this[("slot" + i)].customTexture = null;
                    this[("slot" + i)].selectedTexture = null;
                    this[("slot" + i)].highlightTexture = null;
                    this[("slot" + i)].data = null;
                    this[("slot" + i)].mouseEnabled = false;
                    i++;
                };
                this.tx_background.alpha = 0.2;
                this.slotCraftedItem.data = null;
                this.lblAbility.text = "";
                this.lblXp.text = "";
                this.lblLevel.text = "";
                this.lblName.text = "";
                this.btn_getItems.visible = false;
            };
        }

        public function select(b:Boolean):void
        {
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            switch (target)
            {
                case this.slot3:
                case this.slot2:
                case this.slot1:
                case this.slot8:
                case this.slot7:
                case this.slot6:
                case this.slot5:
                case this.slot4:
                    if (target.data)
                    {
                        this.uiApi.showTooltip(target.data, target, false, "standard", 6, 2, 3, "itemName", null, {
                            "showEffects":true,
                            "header":true
                        }, "ItemInfo");
                    };
                    return;
                case this.slotCraftedItem:
                    if (target.data)
                    {
                        this.uiApi.showTooltip(target.data, target, false, "standard", 8, 0, 0, "itemName", null, {
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
                            text = this.uiApi.getText("ui.craft.noIngredient");
                        }
                        else
                        {
                            if (target.uri.fileName == uriMissingIngredients.fileName)
                            {
                                text = this.uiApi.getText("ui.craft.ingredientNotEnough");
                            }
                            else
                            {
                                if (target.uri.fileName == uriBagIngredients.fileName)
                                {
                                    text = this.uiApi.getText("ui.craft.ingredientInBag");
                                };
                            };
                        };
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", LocationEnum.POINT_TOPLEFT, LocationEnum.POINT_BOTTOMRIGHT, 6);
                    };
                    break;
                case this.tx_background:
                    if (this._data)
                    {
                        text = (this.averagePriceApi.getItemAveragePriceString(this._data.result) + "\n\n");
                        if (this._slotMax < 0)
                        {
                            text = (text + this.uiApi.getText("ui.craft.noJobForRecipe"));
                        }
                        else
                        {
                            if (this._slotMax < this._data.ingredients.length)
                            {
                                text = (text + this.uiApi.getText("ui.jobs.difficulty3"));
                            }
                            else
                            {
                                if (this._missingIngredients)
                                {
                                    text = (text + this.uiApi.getText("ui.craft.dontHaveAllIngredient"));
                                }
                                else
                                {
                                    if ((this._slotMax - this._data.ingredients.length) >= 4)
                                    {
                                        text = (text + this.uiApi.getText("ui.jobs.difficulty1"));
                                    }
                                    else
                                    {
                                        text = (text + this.uiApi.getText("ui.jobs.difficulty2"));
                                    };
                                };
                            };
                        };
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    };
                    break;
                case this.btn_getItems:
                    if (this._data)
                    {
                        text = this.uiApi.getText("ui.craft.transfertIngredients", this._uiClass.getPotentialMaxOccurence(this._data.resultId));
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 8, 0, 0);
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
            if (target == this.btn_getItems)
            {
                this._grid.getUi().uiClass.requestIngredientsTransfert(this._data);
            }
            else
            {
                if (!(this.sysApi.getOption("displayTooltips", "dofus")))
                {
                    this.sysApi.dispatchHook(ShowObjectLinked, target.data);
                };
            };
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

