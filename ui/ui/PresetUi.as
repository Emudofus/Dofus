package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.InventoryApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import d2api.StorageApi;
    import d2data.PresetWrapper;
    import d2components.GraphicContainer;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2hooks.PresetsUpdate;
    import d2hooks.PresetSelected;
    import d2hooks.PresetError;
    import __AS3__.vec.Vector;
    import d2actions.InventoryPresetSave;
    import d2data.ItemWrapper;
    import d2actions.InventoryPresetSaveCustom;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.tooltip.LocationEnum;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2actions.InventoryPresetUse;
    import d2hooks.ObjectSelected;
    import d2data.MountWrapper;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2actions.InventoryPresetDelete;
    import d2hooks.*;
    import d2actions.*;
    import __AS3__.vec.*;

    public class PresetUi 
    {

        private static const PRESET_NUMBER:int = 16;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var inventoryApi:InventoryApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var storageApi:StorageApi;
        private var _currentPreset:PresetWrapper;
        private var _presets:Array;
        private var _currentIndex:int = -1;
        private var _newItems:Boolean;
        private var _itemsAltered:Boolean;
        private var _popupName:String;
        public var ctr_bottom:GraphicContainer;
        public var gd_presets:Grid;
        public var gd_items:Grid;
        public var gd_icons:Grid;
        public var btn_save:ButtonContainer;
        public var btn_new:ButtonContainer;
        public var btn_delete:ButtonContainer;
        public var btn_update:ButtonContainer;
        public var btn_deleteItem:ButtonContainer;
        public var lbl_title:Label;
        public var lbl_explanation:Label;
        public var btn_lbl_btn_save:Label;


        public function main(pParam:Object=null):void
        {
            var icon:Object;
            this.sysApi.addHook(PresetsUpdate, this.onPresetsUpdate);
            this.sysApi.addHook(PresetSelected, this.onPresetSelected);
            this.sysApi.addHook(PresetError, this.onPresetError);
            this.uiApi.addComponentHook(this.btn_save, "onRollOver");
            this.uiApi.addComponentHook(this.btn_save, "onRollOut");
            this.uiApi.addComponentHook(this.btn_delete, "onRollOver");
            this.uiApi.addComponentHook(this.btn_delete, "onRollOut");
            this.uiApi.addComponentHook(this.btn_deleteItem, "onRollOver");
            this.uiApi.addComponentHook(this.btn_deleteItem, "onRollOut");
            this.uiApi.addComponentHook(this.btn_update, "onRollOver");
            this.uiApi.addComponentHook(this.btn_update, "onRollOut");
            this.gd_items.renderer.allowDrop = false;
            this.gd_items.renderer.hideQuantities = true;
            this.gd_presets.renderer.dropValidatorFunction = this.dropValidatorFunction;
            this.gd_presets.renderer.processDropFunction = this.processDrop;
            this.gd_presets.renderer.removeDropSourceFunction = this.removeDropSourceFunction;
            this.onPresetsUpdate();
            this.displayPreset(-2);
            var icons:Array = new Array();
            for each (icon in this.dataApi.getPresetIcons())
            {
                icons.push(icon);
            };
            this.gd_icons.dataProvider = icons;
        }

        public function unload():void
        {
            this.uiApi.unloadUi(this._popupName);
        }

        private function displayPreset(presetId:int=-2):void
        {
            var iconId:int;
            if (presetId == -2)
            {
                this.ctr_bottom.visible = false;
                this.lbl_explanation.visible = true;
                this.btn_deleteItem.visible = false;
                this._currentPreset = null;
                this._newItems = true;
                this.gd_presets.selectedIndex = -1;
            }
            else
            {
                this.ctr_bottom.visible = true;
                this.lbl_explanation.visible = false;
                if (presetId == -1)
                {
                    this._currentPreset = null;
                    this._newItems = true;
                    this.gd_items.dataProvider = this.getEquipment();
                    this.btn_delete.visible = false;
                    this.btn_update.visible = false;
                    this.btn_save.disabled = false;
                    this.btn_deleteItem.visible = false;
                    this.lbl_title.text = this.uiApi.getText("ui.preset.new");
                    this.btn_lbl_btn_save.text = this.uiApi.getText("ui.charcrea.create");
                    this.gd_icons.selectedIndex = 0;
                    this.gd_presets.selectedIndex = -1;
                }
                else
                {
                    this._newItems = false;
                    this._currentPreset = this._presets[presetId];
                    this.gd_items.dataProvider = this._currentPreset.objects;
                    this.btn_delete.visible = true;
                    this.btn_update.visible = true;
                    this.btn_save.disabled = true;
                    this.btn_deleteItem.visible = true;
                    this.lbl_title.text = this.uiApi.getText("ui.preset.show");
                    this.btn_lbl_btn_save.text = this.uiApi.getText("ui.common.save");
                    if (((((this._currentPreset) && ((this._currentPreset.gfxId > -1)))) && (this.dataApi.getPresetIcon(this._currentPreset.gfxId))))
                    {
                        iconId = this.dataApi.getPresetIcon(this._currentPreset.gfxId).order;
                        this.gd_icons.selectedIndex = iconId;
                    };
                };
            };
        }

        private function getEquipment():Array
        {
            var item:*;
            var equipment:Array = new Array();
            for each (item in this.inventoryApi.getEquipementForPreset())
            {
                equipment.push(item);
            };
            return (equipment);
        }

        public function updateIcon(data:*, components:*, selected:Boolean):void
        {
            if (data)
            {
                components.tx_icon.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("iconsUri") + "small_") + data.id));
                if (selected)
                {
                    components.tx_selected.visible = true;
                }
                else
                {
                    components.tx_selected.visible = false;
                };
            }
            else
            {
                components.tx_icon.uri = null;
                components.tx_selected.visible = false;
            };
        }

        private function dropValidatorFunction(target:Object, data:Object, source:Object):Boolean
        {
            return (false);
        }

        private function processDrop(target:Object, data:Object, source:Object):void
        {
        }

        private function removeDropSourceFunction(target:Object):void
        {
            trace("removeDropSourceFunction");
        }

        public function onRelease(target:Object):void
        {
            var _local_2:int;
            var voidId:int;
            var iconId:uint;
            var i:int;
            var uids:Vector.<uint>;
            var positions:Vector.<uint>;
            switch (target)
            {
                case this.btn_new:
                    this.displayPreset(-1);
                    break;
                case this.btn_save:
                    this.btn_save.disabled = true;
                    _local_2 = -1;
                    voidId = 0;
                    while (voidId < PRESET_NUMBER)
                    {
                        if (((!(this.gd_presets.dataProvider[voidId])) || ((this.gd_presets.dataProvider[voidId] == null))))
                        {
                            _local_2 = voidId;
                            break;
                        };
                        voidId++;
                    };
                    if (this._currentPreset)
                    {
                        _local_2 = this._currentPreset.id;
                    };
                    if (_local_2 != -1)
                    {
                        iconId = (((this.gd_icons.selectedIndex > -1)) ? this.gd_icons.dataProvider[this.gd_icons.selectedIndex].id : 0);
                        if (!(this._itemsAltered))
                        {
                            this.sysApi.sendAction(new InventoryPresetSave(_local_2, iconId, this._newItems));
                        }
                        else
                        {
                            uids = new Vector.<uint>();
                            positions = new Vector.<uint>();
                            i = 0;
                            while (i < 16)
                            {
                                if (((this.gd_items.dataProvider[i]) && ((this.gd_items.dataProvider[i] is ItemWrapper))))
                                {
                                    uids.push(this.gd_items.dataProvider[i].objectUID);
                                    positions.push(i);
                                };
                                i++;
                            };
                            this.sysApi.sendAction(new InventoryPresetSaveCustom(_local_2, iconId, uids, positions));
                            this._itemsAltered = false;
                        };
                        this.gd_icons.selectedIndex = -1;
                        if (this._newItems)
                        {
                            this._newItems = false;
                        };
                    }
                    else
                    {
                        this.sysApi.log(2, "plus de place !");
                    };
                    break;
                case this.btn_delete:
                    this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.preset.warningDelete", (this._currentPreset.id + 1)), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmDelete, this.onCancelDelete], this.onConfirmDelete, this.onCancelDelete);
                    break;
                case this.btn_update:
                    this.btn_save.disabled = false;
                    this._newItems = true;
                    this.gd_items.dataProvider = this.getEquipment();
                    break;
                case this.btn_deleteItem:
                    if (((((this.gd_items.selectedItem.hasOwnProperty("objectGID")) && (this.gd_items.selectedItem.objectGID))) && (!((this.dataApi.getItem(this.gd_items.selectedItem.objectGID).id == 666)))))
                    {
                        this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.preset.warningItemDelete", this.dataApi.getItem(this.gd_items.selectedItem.objectGID).name, (this._currentPreset.id + 1)), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmItemDelete, this.onCancelDelete], this.onConfirmItemDelete, this.onCancelDelete);
                    };
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var info:String;
            switch (target)
            {
                case this.btn_delete:
                    info = this.uiApi.getText("ui.preset.delete");
                    break;
                case this.btn_update:
                    info = this.uiApi.getText("ui.preset.importCurrentStuff");
                    break;
                case this.btn_deleteItem:
                    info = this.uiApi.getText("ui.preset.deleteItem");
                    break;
            };
            if (info)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info), target, false, "standard", LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod != GridItemSelectMethodEnum.AUTO)
            {
                switch (target)
                {
                    case this.gd_presets:
                        if (this.gd_presets.selectedItem != null)
                        {
                            if (selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
                            {
                                this.sysApi.sendAction(new InventoryPresetUse(this.gd_presets.selectedItem.id));
                            }
                            else
                            {
                                this._currentIndex = this.gd_presets.selectedItem.id;
                                this.displayPreset(this.gd_presets.selectedItem.id);
                            };
                        };
                        break;
                    case this.gd_items:
                        if (((((this.gd_items.selectedItem) && ((this.gd_items.selectedItem is ItemWrapper)))) && (this.gd_items.selectedItem.objectUID)))
                        {
                            this.sysApi.dispatchHook(ObjectSelected, {"data":this.gd_items.selectedItem});
                        }
                        else
                        {
                            if (((((this.gd_items.selectedItem) && ((this.gd_items.selectedItem is MountWrapper)))) && (this.playerApi.getMount())))
                            {
                                this.sysApi.dispatchHook(ObjectSelected, {"data":this.gd_items.selectedItem});
                            }
                            else
                            {
                                this.sysApi.dispatchHook(ObjectSelected, {"data":null});
                            };
                        };
                        break;
                    case this.gd_icons:
                        if (this._currentPreset)
                        {
                            if (this.dataApi.getPresetIcon(this._currentPreset.gfxId).order != this.gd_icons.selectedIndex)
                            {
                                this.btn_save.disabled = false;
                            }
                            else
                            {
                                this.btn_save.disabled = true;
                            };
                        };
                        break;
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            var uiObject:Object;
            var equipmentUi:EquipmentUi;
            if ((((((((target == this.gd_items)) && (item.data))) && ((item.data is ItemWrapper)))) && (item.data.name)))
            {
                if ((item.data is MountWrapper))
                {
                    text = item.data.name;
                    if (text)
                    {
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), item.container, false, "standard", 8, 0, 0, null, null, null, "TextInfo");
                    };
                }
                else
                {
                    uiObject = this.uiApi.getUi(UIEnum.STORAGE_UI);
                    if (!((uiObject.uiClass is EquipmentUi)))
                    {
                        throw (new Error("equipment UI Class is not a EquipmentUi"));
                    };
                    equipmentUi = (uiObject.uiClass as EquipmentUi);
                    this.uiApi.showTooltip(item.data, item.container, false, "standard", 8, 0, 0, "itemName", null, {
                        "ref":this.btn_update,
                        "showEffects":true,
                        "header":true
                    }, "ItemInfo");
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onConfirmDelete():void
        {
            this.sysApi.sendAction(new InventoryPresetDelete(this._currentPreset.id));
        }

        public function onConfirmItemDelete():void
        {
            var i:int;
            var tempArray:Array = new Array();
            i = 0;
            while (i < 16)
            {
                tempArray[i] = this.gd_items.dataProvider[i];
                i++;
            };
            if (((tempArray[this.gd_items.selectedIndex]) && ((tempArray[this.gd_items.selectedIndex] is ItemWrapper))))
            {
                tempArray[this.gd_items.selectedIndex] = this.inventoryApi.getVoidItemForPreset(this.gd_items.selectedIndex);
                this.gd_items.dataProvider = tempArray;
                this.btn_save.disabled = false;
                this._itemsAltered = true;
            };
        }

        public function onCancelDelete():void
        {
        }

        public function onPresetsUpdate():void
        {
            var preset:Object;
            this._presets = new Array();
            var presetCount:uint;
            for each (preset in this.inventoryApi.getPresets())
            {
                if (((preset) && ((preset is PresetWrapper))))
                {
                    this._presets[preset.id] = preset;
                    presetCount++;
                };
            };
            this.gd_presets.dataProvider = this._presets;
            if (presetCount >= PRESET_NUMBER)
            {
                this.btn_new.disabled = true;
            }
            else
            {
                this.btn_new.disabled = false;
            };
            if (this._currentIndex != -1)
            {
                this.gd_presets.selectedIndex = this._currentIndex;
            };
        }

        public function onPresetSelected(presetId:int):void
        {
            if (presetId > -1)
            {
                this._currentIndex = presetId;
            }
            else
            {
                this.displayPreset(-2);
            };
        }

        public function onPresetError(reason:String, param:Object=null):void
        {
            var text:String;
            if (reason == "unknown")
            {
                text = this.uiApi.getText("ui.common.unknownFail");
            }
            else
            {
                text = this.uiApi.getText(("ui.preset.error." + reason));
            };
            this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), text, [this.uiApi.getText("ui.common.ok")], null, null, null, null, false, true);
        }


    }
}//package ui

