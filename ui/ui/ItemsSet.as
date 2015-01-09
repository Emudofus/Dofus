package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.ContextMenuApi;
    import d2api.DataApi;
    import d2api.InventoryApi;
    import d2api.PlayedCharacterApi;
    import d2data.ItemSet;
    import d2components.GraphicContainer;
    import d2components.Grid;
    import d2components.ComboBox;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.Slot;
    import d2components.Texture;
    import d2hooks.SetUpdate;
    import d2data.EffectInstance;
    import d2hooks.*;
    import d2actions.*;

    public class ItemsSet 
    {

        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var menuApi:ContextMenuApi;
        public var dataApi:DataApi;
        public var inventoryApi:InventoryApi;
        public var playerApi:PlayedCharacterApi;
        private var _set:ItemSet;
        private var _serverSet:Object;
        private var _items:Array;
        private var _selectedItems:Array;
        private var _filterType:int = -1;
        private var _nbItemsToDisplay:int;
        public var ctr_item:GraphicContainer;
        public var gd_bonus:Grid;
        public var cb_filter:ComboBox;
        public var btn_close:ButtonContainer;
        public var btn_bonusObjects:ButtonContainer;
        public var lbl_name:Label;
        public var slot_0:Slot;
        public var slot_1:Slot;
        public var slot_2:Slot;
        public var slot_3:Slot;
        public var slot_4:Slot;
        public var slot_5:Slot;
        public var slot_6:Slot;
        public var slot_7:Slot;
        public var tx_itemEquipped_0:Texture;
        public var tx_itemEquipped_1:Texture;
        public var tx_itemEquipped_2:Texture;
        public var tx_itemEquipped_3:Texture;
        public var tx_itemEquipped_4:Texture;
        public var tx_itemEquipped_5:Texture;
        public var tx_itemEquipped_6:Texture;
        public var tx_itemEquipped_7:Texture;


        public function main(param:Object):void
        {
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.sysApi.addHook(SetUpdate, this.onSetUpdate);
            this.uiApi.addComponentHook(this.btn_close, "onRelease");
            this.uiApi.addComponentHook(this.btn_bonusObjects, "onRelease");
            this.uiApi.addComponentHook(this.btn_bonusObjects, "onRollOver");
            this.uiApi.addComponentHook(this.btn_bonusObjects, "onRollOut");
            this.uiApi.addComponentHook(this.cb_filter, "onSelectItem");
            this.uiApi.addComponentHook(this.tx_itemEquipped_0, "onRollOver");
            this.uiApi.addComponentHook(this.tx_itemEquipped_0, "onRollOut");
            this.uiApi.addComponentHook(this.tx_itemEquipped_1, "onRollOver");
            this.uiApi.addComponentHook(this.tx_itemEquipped_1, "onRollOut");
            this.uiApi.addComponentHook(this.tx_itemEquipped_2, "onRollOver");
            this.uiApi.addComponentHook(this.tx_itemEquipped_2, "onRollOut");
            this.uiApi.addComponentHook(this.tx_itemEquipped_3, "onRollOver");
            this.uiApi.addComponentHook(this.tx_itemEquipped_3, "onRollOut");
            this.uiApi.addComponentHook(this.tx_itemEquipped_4, "onRollOver");
            this.uiApi.addComponentHook(this.tx_itemEquipped_4, "onRollOut");
            this.uiApi.addComponentHook(this.tx_itemEquipped_5, "onRollOver");
            this.uiApi.addComponentHook(this.tx_itemEquipped_5, "onRollOut");
            this.uiApi.addComponentHook(this.tx_itemEquipped_6, "onRollOver");
            this.uiApi.addComponentHook(this.tx_itemEquipped_6, "onRollOut");
            this.uiApi.addComponentHook(this.tx_itemEquipped_7, "onRollOver");
            this.uiApi.addComponentHook(this.tx_itemEquipped_7, "onRollOut");
            this.uiApi.addComponentHook(this.slot_0, "onRelease");
            this.uiApi.addComponentHook(this.slot_1, "onRelease");
            this.uiApi.addComponentHook(this.slot_2, "onRelease");
            this.uiApi.addComponentHook(this.slot_3, "onRelease");
            this.uiApi.addComponentHook(this.slot_4, "onRelease");
            this.uiApi.addComponentHook(this.slot_5, "onRelease");
            this.uiApi.addComponentHook(this.slot_6, "onRelease");
            this.uiApi.addComponentHook(this.slot_7, "onRelease");
            this.displaySet(this.dataApi.getItem(param.item.objectGID).itemSetId);
        }

        public function unload():void
        {
            this.uiApi.unloadUi("itemBoxSet");
        }

        public function updateEffectLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var cssClass:String;
            if (data)
            {
                cssClass = "p";
                if (data.indexOf("-") == 0)
                {
                    cssClass = "malus";
                };
                componentsRef.lbl_effect.cssClass = cssClass;
                componentsRef.lbl_effect.text = data;
            }
            else
            {
                componentsRef.lbl_effect.text = "";
            };
        }

        private function displaySet(setId:int):void
        {
            var eqItem:*;
            var name:String;
            var num:int;
            var i:int;
            var setItem:*;
            var item1:*;
            var item2:*;
            var equip:*;
            this._items = new Array();
            this._selectedItems = [-1, -1, -1, -1, -1, -1, -1, -1];
            this._set = this.dataApi.getItemSet(setId);
            var equipment:Array = new Array();
            for each (eqItem in this.playerApi.getEquipment())
            {
                for each (setItem in this._set.items)
                {
                    if (setItem == eqItem.objectGID)
                    {
                        equipment.push(eqItem);
                    };
                };
            };
            if (equipment.length > 0)
            {
                this._serverSet = this.playerApi.getPlayerSet(equipment[0].objectGID);
            };
            if (this._serverSet != null)
            {
                name = this._serverSet.setName;
                for each (item1 in this._serverSet.allItems)
                {
                    this._items.push(item1);
                };
            }
            else
            {
                name = this._set.name;
                for each (item2 in this._set.items)
                {
                    this._items.push(item2);
                };
            };
            this.lbl_name.text = name;
            num = this._items.length;
            i = 0;
            while (i < num)
            {
                this.uiApi.addComponentHook(this[("slot_" + i)], "onRollOver");
                this.uiApi.addComponentHook(this[("slot_" + i)], "onRollOut");
                this.uiApi.addComponentHook(this[("slot_" + i)], "onRightClick");
                this.uiApi.addComponentHook(this[("slot_" + i)], "onRelease");
                this[("slot_" + i)].data = this.dataApi.getItemWrapper(this._items[i]);
                this.modCommon.createItemBox("itemBoxSet", this.ctr_item, this.dataApi.getItemWrapper(this._items[0]));
                this[("tx_itemEquipped_" + i)].visible = false;
                for each (equip in equipment)
                {
                    if (equip.objectGID == this._items[i])
                    {
                        this[("tx_itemEquipped_" + i)].visible = true;
                        this._selectedItems[i] = equip.objectGID;
                        this[("slot_" + i)].data = this.inventoryApi.getItem(equip.objectUID);
                    };
                };
                i++;
            };
            while (i < 8)
            {
                this[("slot_" + i)].data = null;
                i++;
            };
            var cbProvider:Array = new Array();
            var k:int = 1;
            while (k <= num)
            {
                cbProvider.push({
                    "label":((k + " ") + this.uiApi.getText("ui.common.objects")),
                    "filterType":k
                });
                k++;
            };
            this.cb_filter.dataProvider = cbProvider;
            if (equipment.length > 0)
            {
                this.cb_filter.selectedIndex = (equipment.length - 1);
            }
            else
            {
                this.cb_filter.selectedIndex = (num - 1);
            };
        }

        private function filteredBonus(addObjects:Boolean=false):Array
        {
            var bonusLineS:*;
            var i:int;
            var bonusPack:Object;
            var bonusLine:EffectInstance;
            var objectsEffects:Array;
            var objectsGID:Array;
            var selObject:*;
            var objEffect:*;
            var bonusText:Array;
            var effect:*;
            var bonus:Array = new Array();
            if (this._serverSet)
            {
                if (this._serverSet.setObjects.length == this._filterType)
                {
                    for each (bonusLineS in this._serverSet.setEffects)
                    {
                        bonus.push(bonusLineS);
                    };
                };
            };
            if (bonus.length == 0)
            {
                if (this._set.bonusIsSecret)
                {
                    bonus.push(this.uiApi.getText("ui.set.secretBonus"));
                }
                else
                {
                    i = 1;
                    for each (bonusPack in this._set.effects)
                    {
                        if (i == this._filterType)
                        {
                            if (bonusPack == null)
                            {
                                bonus.push("");
                            }
                            else
                            {
                                for each (bonusLine in bonusPack)
                                {
                                    if (bonusLine != null)
                                    {
                                        bonus.push(bonusLine);
                                    };
                                };
                            };
                        };
                        i++;
                    };
                };
            };
            if (addObjects)
            {
                objectsEffects = new Array();
                objectsGID = new Array();
                for each (selObject in this._selectedItems)
                {
                    if (selObject != -1)
                    {
                        objectsGID.push(selObject);
                    };
                };
                for each (objEffect in this.dataApi.getSetEffects(objectsGID, bonus))
                {
                    if (((objEffect.description) && (!((objEffect.description == "")))))
                    {
                        objectsEffects.push(objEffect.description);
                    };
                };
                return (objectsEffects);
            };
            bonusText = new Array();
            for each (effect in bonus)
            {
                if (((((!((effect is String))) && (effect.description))) && (!((effect.description == "")))))
                {
                    bonusText.push(effect.description);
                };
            };
            return (bonusText);
        }

        private function switchObjectsMode(showObjects:Boolean):void
        {
            var i:uint;
            var j:uint;
            var nbItem:uint;
            if (showObjects)
            {
                this.cb_filter.disabled = true;
                i = 0;
                while (i < 8)
                {
                    if (((this[("tx_itemEquipped_" + i)].visible) || (((this._selectedItems[i]) && (!((this._selectedItems[i] == -1)))))))
                    {
                        this[("slot_" + i)].selected = true;
                        this._selectedItems[i] = this._items[i];
                        nbItem++;
                    }
                    else
                    {
                        this._selectedItems[i] = -1;
                        this[("slot_" + i)].selected = false;
                    };
                    i++;
                };
                this._filterType = nbItem;
                this.cb_filter.selectedIndex = (nbItem - 1);
                this.gd_bonus.dataProvider = this.filteredBonus(true);
            }
            else
            {
                this.cb_filter.disabled = false;
                j = 0;
                while (j < 8)
                {
                    this[("slot_" + j)].selected = false;
                    if (this._selectedItems[i] != -1)
                    {
                        nbItem++;
                    };
                    j++;
                };
                this.gd_bonus.dataProvider = this.filteredBonus();
            };
        }

        private function onSetUpdate(setId:int):void
        {
            if (this._set.id == setId)
            {
                this.displaySet(setId);
                if (this.btn_bonusObjects.selected)
                {
                    this.switchObjectsMode(true);
                };
            };
        }

        public function onRollOver(target:Object):void
        {
            if (target == this.btn_bonusObjects)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.set.addObjectBonusText")), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            }
            else
            {
                if (target.name.substr(0, 16) == "tx_itemEquipped_")
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.set.objectEquipped")), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                }
                else
                {
                    if (target.data)
                    {
                        this.uiApi.showTooltip(target.data, target, false, "standard", 8, 0, 3, "itemName", null, {
                            "showEffects":true,
                            "header":true
                        }, "ItemInfo");
                    };
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            var index:int;
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_bonusObjects:
                    this.switchObjectsMode(this.btn_bonusObjects.selected);
                    break;
                default:
                    if ((((target.name.substr(0, 4) == "slot")) && (target.data)))
                    {
                        this.modCommon.createItemBox("itemBoxSet", this.ctr_item, target.data);
                        if (this.btn_bonusObjects.selected)
                        {
                            index = int(target.name.substr(5, 1));
                            if (this._selectedItems[index] == -1)
                            {
                                this.sysApi.log(2, ("selection de " + target.data.objectGID));
                                this._selectedItems[index] = target.data.objectGID;
                                target.selected = true;
                                this._filterType++;
                            }
                            else
                            {
                                this._selectedItems[index] = -1;
                                target.selected = false;
                                this._filterType--;
                            };
                            this.cb_filter.selectedIndex = (((this._filterType >= 1)) ? (this._filterType - 1) : -1);
                            this.gd_bonus.dataProvider = this.filteredBonus(true);
                        };
                    };
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if ((((target == this.cb_filter)) && (!(this.cb_filter.disabled))))
            {
                this.sysApi.log(2, ("selectitem cbx : " + this.cb_filter.value.filterType));
                this._filterType = this.cb_filter.value.filterType;
                this.gd_bonus.dataProvider = this.filteredBonus();
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target.data)
            {
                data = target.data;
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }


    }
}//package ui

