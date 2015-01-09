package ui
{
    import flash.utils.Timer;
    import d2components.Slot;
    import d2data.ItemWrapper;
    import d2components.Label;
    import d2components.Texture;
    import d2components.ButtonContainer;
    import d2components.EntityDisplayer;
    import d2components.GraphicContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2hooks.DropStart;
    import d2hooks.DropEnd;
    import d2hooks.PlayedCharacterLookChange;
    import d2hooks.EquipmentObjectMove;
    import d2hooks.ObjectModified;
    import d2hooks.ObjectSelected;
    import d2hooks.ObjectDeleted;
    import d2hooks.MountRiding;
    import flash.events.TimerEvent;
    import d2enums.SelectMethodEnum;
    import ui.behavior.StorageClassicBehavior;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.tooltip.LocationEnum;
    import d2data.MountWrapper;
    import d2data.Pet;
    import d2data.EffectInstance;
    import d2actions.ObjectSetPosition;
    import d2enums.CharacterInventoryPositionEnum;
    import d2actions.MountToggleRidingRequest;
    import d2actions.ObjectUse;
    import d2data.ItemType;
    import d2data.ShortcutWrapper;
    import d2actions.DeleteObject;
    import d2actions.OpenBook;
    import d2hooks.*;
    import d2actions.*;

    public class EquipmentUi extends StorageUi 
    {

        private var _slotCollection:Array;
        private var _availableEquipmentPositions:Array;
        private var _direction:int = 2;
        private var _currentStuff:Array;
        private var _stuffInit:Boolean;
        private var _storageMod:uint;
        private var _isUnloading:Boolean;
        private var _delayUseObject:Boolean = false;
        private var _delayUseObjectTimer:Timer;
        private var _waitingObject:Object;
        private var _waitingObjectQty:uint;
        private var _slot:Slot;
        private var _delayDoubleClickTimer:Timer;
        private var _grid_default_height:Number;
        private var _tx_foreground_grid_default_height:Number;
        private var _tx_background_grid_default_height:Number;
        private var _kamasCtr_default_y:Number;
        private var _txWeightBar_default_y:Number;
        private var _popupName:String;
        private var _selectedItem:ItemWrapper;
        public var lbl_selectItem:Label;
        public var lbl_title:Label;
        public var tx_breedSymbol:Texture;
        public var tx_background:Texture;
        public var tx_backgroundItem:Texture;
        public var tx_cross:Texture;
        public var tx_background_grid:Texture;
        public var tx_foreground_grid:Texture;
        public var btn_leftArrow:ButtonContainer;
        public var btn_rightArrow:ButtonContainer;
        public var slot_0:Slot;
        public var slot_15:Slot;
        public var slot_4:Slot;
        public var slot_3:Slot;
        public var slot_5:Slot;
        public var slot_28:Slot;
        public var slot_6:Slot;
        public var slot_1:Slot;
        public var slot_2:Slot;
        public var slot_7:Slot;
        public var slot_8:Slot;
        public var slot_9:Slot;
        public var slot_10:Slot;
        public var slot_11:Slot;
        public var slot_12:Slot;
        public var slot_13:Slot;
        public var slot_14:Slot;
        public var entityDisplayer:EntityDisplayer;
        public var btnMinimize:ButtonContainer;
        public var btnSet:ButtonContainer;
        public var ctr_item:GraphicContainer;
        public var ctr_equipment:GraphicContainer;
        public var ctr_preset:GraphicContainer;


        public function get equipmentVisible():Boolean
        {
            return (this.ctr_equipment.visible);
        }

        override public function main(params:Object):void
        {
            super.main(params);
            this._currentStuff = new Array();
            this._stuffInit = false;
            soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_OPEN);
            sysApi.addHook(DropStart, this.onEquipementDropStart);
            sysApi.addHook(DropEnd, this.onEquipementDropEnd);
            sysApi.addHook(PlayedCharacterLookChange, this.updateLook);
            sysApi.addHook(EquipmentObjectMove, this.onEquipmentObjectMove);
            sysApi.addHook(ObjectModified, this.onObjectModified);
            sysApi.addHook(ObjectSelected, this.onObjectSelected);
            sysApi.addHook(ObjectDeleted, this.onObjectDeleted);
            sysApi.addHook(MountRiding, this.onMountRiding);
            uiApi.addComponentHook(this.btnMinimize, "onRelease");
            uiApi.addComponentHook(this.btnMinimize, "onRollOver");
            uiApi.addComponentHook(this.btnMinimize, "onRollOut");
            uiApi.addComponentHook(this.btnSet, "onRollOver");
            uiApi.addComponentHook(this.btnSet, "onRollOut");
            uiApi.addShortcutHook("closeUi", onShortCut);
            this.equipementSlotInit();
            var characterInfos:Object = playerApi.getPlayedCharacterInfo();
            this.tx_backgroundItem.visible = false;
            this.lbl_selectItem.visible = true;
            this.tx_breedSymbol.gotoAndStop = characterInfos.breed.toString();
            var equipment:Object = storageApi.getViewContent("equipment");
            this.fillEquipement(equipment);
            this._delayUseObjectTimer = new Timer(500, 1);
            this._delayUseObjectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayUseObjectTimer);
            this._delayDoubleClickTimer = new Timer(500, 1);
            this._delayDoubleClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayDoubleClickTimer);
            this._direction = 1;
            var look:Object = utilApi.getRealTiphonEntityLook(characterInfos.id, true);
            if (look.getBone() == 2)
            {
                look.setBone(1);
            };
            this.updateLook(look);
            this.equipmentVisible = sysApi.getSetData("equipmentVisible", true);
            this._grid_default_height = grid.height;
            this._tx_background_grid_default_height = this.tx_background_grid.height;
            this._tx_foreground_grid_default_height = this.tx_foreground_grid.height;
            this._kamasCtr_default_y = kamaCtr.y;
            this._txWeightBar_default_y = txWeightBar.y;
        }

        override public function unload():void
        {
            this._delayDoubleClickTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayDoubleClickTimer);
            this._delayDoubleClickTimer = null;
            uiApi.unloadUi("itemBox");
            uiApi.unloadUi(this._popupName);
            uiApi.unloadUi("quantityPopup");
            uiApi.unloadUi("preset");
            super.unload();
        }

        private function presetVisibleUpdate():void
        {
            if (this.ctr_preset.visible)
            {
                grid.height = (this._grid_default_height + grid.slotHeight);
                this.tx_background_grid.height = (this._tx_background_grid_default_height + grid.slotHeight);
                this.tx_foreground_grid.height = (this._tx_foreground_grid_default_height + grid.slotHeight);
                kamaCtr.y = (estimatedValueCtr.y + grid.slotHeight);
                txWeightBar.y = 702;
                txKamaBackground.visible = (estimatedValueCtr.visible = false);
            }
            else
            {
                grid.height = this._grid_default_height;
                this.tx_background_grid.height = this._tx_background_grid_default_height;
                this.tx_foreground_grid.height = this._tx_foreground_grid_default_height;
                kamaCtr.y = this._kamasCtr_default_y;
                txWeightBar.y = this._txWeightBar_default_y;
                txKamaBackground.visible = (estimatedValueCtr.visible = true);
            };
        }

        private function wheelChara(sens:int):void
        {
            this._direction = (((this._direction + sens) + 8) % 8);
            this.entityDisplayer.direction = this._direction;
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case btnAll:
                case btnEquipable:
                case btnConsumables:
                case btnRessources:
                case btnQuest:
                    this.ctr_preset.visible = false;
                    this.presetVisibleUpdate();
                    break;
                case this.btnSet:
                    this.ctr_preset.visible = true;
                    if (!(uiApi.getUi("preset")))
                    {
                        uiApi.loadUiInside("preset", this.ctr_preset, "preset");
                    };
                    this.presetVisibleUpdate();
                    break;
                case this.btnMinimize:
                    this.equipmentVisible = !(this.equipmentVisible);
                    break;
                case this.btn_leftArrow:
                    this.wheelChara(1);
                    break;
                case this.btn_rightArrow:
                    this.wheelChara(-1);
                    break;
            };
            if ((target is Slot))
            {
                this.itemSelected(target);
            };
            super.onRelease(target);
        }

        public function onDrop(target:Object, source:Object):void
        {
            if (((((((target) && (source))) && ((source.data is ItemWrapper)))) && ((source.data as ItemWrapper).isLivingObject)))
            {
                this.itemSelected(target);
            };
        }

        override public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod != SelectMethodEnum.AUTO)
            {
                switch (target)
                {
                    case cbFilter:
                        super.onSelectItem(target, selectMethod, isNewSelection);
                        break;
                    default:
                        if (selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                        {
                            if (_storageBehavior)
                            {
                                Api.ui.hideTooltip();
                                if (!(this._delayDoubleClickTimer.running))
                                {
                                    (_storageBehavior as StorageClassicBehavior).doubleClickGridItem(grid.selectedItem);
                                    if (grid != null)
                                    {
                                        this.blockDragDropOnSlot((grid.selectedSlot as Slot));
                                    };
                                };
                            };
                        }
                        else
                        {
                            if (((target) && ((target == grid))))
                            {
                                this.itemSelected({"data":grid.selectedItem});
                            }
                            else
                            {
                                this.lbl_selectItem.visible = true;
                                this.tx_backgroundItem.visible = false;
                            };
                        };
                        return;
                };
            };
        }

        override protected function displayItemTooltip(target:Object, item:Object, settings:Object=null):void
        {
            if (!(settings))
            {
                settings = new Object();
            };
            super.displayItemTooltip(target, item, settings);
        }

        override public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            if ((((target is Slot)) && (target.data)))
            {
                if ((target.data is MountWrapper))
                {
                    text = target.data.name;
                }
                else
                {
                    this.displayItemTooltip(target, target.data);
                    return;
                };
            };
            if (!(text))
            {
                switch (target)
                {
                    case this.btnSet:
                        text = uiApi.getText("ui.common.presets");
                        break;
                    case this.btnMinimize:
                        text = uiApi.getText("ui.storage.minimize");
                        break;
                    case this.slot_0:
                        text = uiApi.getText("ui.common.inventoryType1");
                        break;
                    case this.slot_15:
                        if (this.tx_cross.visible)
                        {
                            text = uiApi.getText("ui.common.inventoryTwoHandsWarning");
                        }
                        else
                        {
                            text = uiApi.getText("ui.common.inventoryType7");
                        };
                        break;
                    case this.slot_4:
                    case this.slot_2:
                        text = uiApi.getText("ui.common.inventoryType3");
                        break;
                    case this.slot_3:
                        text = uiApi.getText("ui.common.inventoryType4");
                        break;
                    case this.slot_5:
                        text = uiApi.getText("ui.common.inventoryType5");
                        break;
                    case this.slot_28:
                        text = uiApi.getText("ui.common.inventoryType23");
                        break;
                    case this.slot_6:
                        text = uiApi.getText("ui.common.inventoryType10");
                        break;
                    case this.slot_1:
                        text = uiApi.getText("ui.common.inventoryType2");
                        break;
                    case this.slot_7:
                        text = uiApi.getText("ui.common.inventoryType11");
                        break;
                    case this.slot_8:
                        text = uiApi.getText("ui.common.inventoryType8");
                        break;
                    case this.slot_14:
                    case this.slot_13:
                    case this.slot_12:
                    case this.slot_11:
                    case this.slot_10:
                    case this.slot_9:
                        text = uiApi.getText("ui.common.inventoryType13");
                        break;
                    default:
                        super.onRollOver(target);
                        return;
                };
            };
            if (text)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        override protected function fillContextMenu(contextMenu:Object, data:Object, disabled:Boolean):void
        {
            if (data)
            {
                if ((((data.category == 1)) && ((data.type.id == 157))))
                {
                    contextMenu.content.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.krosmaster.collection"), this.goToKrosmasterUi, null, disabled));
                };
                if (((((data.usable) && ((data.quantity > 1)))) && (data.isOkForMultiUse)))
                {
                    contextMenu.content.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.multipleUse"), this.useItemQuantity, [data], disabled));
                };
                if (data.usable)
                {
                    contextMenu.content.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.use"), this.useItem, [data], disabled));
                };
                if (((data.targetable) && (!(data.nonUsableOnAnother))))
                {
                    contextMenu.content.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.target"), this.useItemOnCell, [data], disabled));
                };
                if (data.isEquipment)
                {
                    contextMenu.content.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.equip"), this.equipItem, [data], disabled));
                };
                contextMenu.content.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.destroyThisItem"), this.askDeleteItem, [data], disabled));
            };
            super.fillContextMenu(contextMenu, data, disabled);
        }

        private function dropValidatorFunction(target:Object, data:Object, source:Object):Boolean
        {
            var superType:uint;
            var pet:Pet;
            var effect:EffectInstance;
            var position:Number = Number(target.name.split("slot_")[1]);
            if (((target.data) && ((target.data.type.superTypeId == 12))))
            {
                if (((((data) && (data.type))) && ((data.type.superTypeId == 12))))
                {
                    return (true);
                };
                pet = dataApi.getPet(target.data.objectGID);
                if (((pet) && (((!((pet.foodTypes.indexOf(data.typeId) == -1))) || (!((pet.foodItems.indexOf(data.objectGID) == -1)))))))
                {
                    return (true);
                };
                for each (effect in data.effects)
                {
                    if ((((effect.effectId == 1005)) || ((effect.effectId == 1006))))
                    {
                        return (true);
                    };
                    if ((((effect.effectId == 939)) && ((effect.parameter2 == target.data.objectGID))))
                    {
                        return (true);
                    };
                };
            };
            var superTypeId:int = this.getItemSuperType(data);
            if (superTypeId == 0)
            {
                return (false);
            };
            var possibilities:Object = storageApi.itemSuperTypeToServerPosition(superTypeId);
            for each (superType in possibilities)
            {
                if (superType == position)
                {
                    return (true);
                };
            };
            return (false);
        }

        private function processDropFunction(target:Object, data:Object, source:Object):void
        {
            var position:Number;
            if (this.dropValidatorFunction(target, data, source))
            {
                position = Number(target.name.split("slot_")[1]);
                sysApi.sendAction(new ObjectSetPosition(data.objectUID, position, 1));
            };
        }

        override public function onDoubleClick(target:Object):void
        {
            var position:uint;
            if ((((((target is Slot)) && (target.data))) && (!(this._delayDoubleClickTimer.running))))
            {
                this.blockDragDropOnSlot((target as Slot));
                position = uint(target.name.split("slot_")[1]);
                if ((((((position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS)) && ((target.data.objectUID == 0)))) && ((target.data.type.name == uiApi.getText("ui.common.ride")))))
                {
                    sysApi.sendAction(new MountToggleRidingRequest());
                }
                else
                {
                    sysApi.sendAction(new ObjectSetPosition(target.data.objectUID, 63, 1));
                };
            };
            super.onDoubleClick(target);
        }

        private function blockDragDropOnSlot(slot:Slot):void
        {
            this._slot = slot;
            if (this._slot != null)
            {
                this._slot.allowDrag = false;
                this._delayDoubleClickTimer.start();
            };
        }

        private function onDelayDoubleClickTimer(pEvt:TimerEvent):void
        {
            this._delayDoubleClickTimer.stop();
            if (this._slot != null)
            {
                this._slot.allowDrag = true;
                this._slot = null;
            };
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if ((target is Slot))
            {
                data = target.data;
                if (data)
                {
                    contextMenu = menuApi.create(data);
                    if (contextMenu.content.length > 0)
                    {
                        modContextMenu.createContextMenu(contextMenu);
                    };
                };
            };
        }

        private function onEquipementDropStart(src:Object):void
        {
            var slot:Object;
            if (((!(src.data)) || (!((src.data is ItemWrapper)))))
            {
                return;
            };
            if (src.getUi() == uiApi.me())
            {
                sysApi.disableWorldInteraction();
            };
            for each (slot in this._slotCollection)
            {
                if (this.dropValidatorFunction(slot, src.data, null))
                {
                    slot.selected = true;
                };
            };
        }

        private function onEquipementDropEnd(src:Object):void
        {
            var slot:Object;
            if (src.getUi() == uiApi.me())
            {
                sysApi.enableWorldInteraction();
            };
            for each (slot in this._slotCollection)
            {
                slot.selected = false;
            };
        }

        public function onObjectModified(item:Object):void
        {
            var slot:Object;
            var pos:uint;
            if (this._availableEquipmentPositions.indexOf(item.position) != -1)
            {
                this._currentStuff[item.position] = item;
                for each (slot in this._slotCollection)
                {
                    pos = uint(slot.name.split("_")[1]);
                    slot.data = this._currentStuff[pos];
                };
            };
        }

        public function onObjectSelected(item:Object):void
        {
            this.itemSelected(item);
        }

        public function onObjectDeleted(item:Object):void
        {
            if (((this._selectedItem) && ((this._selectedItem.objectUID == item.objectUID))))
            {
                if (grid.selectedItem)
                {
                    this.itemSelected(grid.selectedItem);
                }
                else
                {
                    this.itemSelected(null);
                };
            };
        }

        public function onEquipmentObjectMove(pItemWrapper:Object, oldPosition:int):void
        {
            if (((!((oldPosition == -1))) && (((!(this._slotCollection[oldPosition])) || (!(this._slotCollection[oldPosition].data))))))
            {
                return;
            };
            if (((((!((oldPosition == -1))) && (!((this._availableEquipmentPositions.indexOf(oldPosition) == -1))))) && (((((!(pItemWrapper)) || (!(this._slotCollection[oldPosition].data)))) || ((pItemWrapper.objectUID == this._slotCollection[oldPosition].data.objectUID))))))
            {
                this._slotCollection[oldPosition].data = null;
                this._currentStuff[oldPosition] = null;
            };
            if (((!(pItemWrapper)) && ((oldPosition == 1))))
            {
                this.tx_cross.visible = false;
                this.slot_15.alpha = 1;
                return;
            };
            if (((!(pItemWrapper)) || ((this._availableEquipmentPositions.indexOf(pItemWrapper.position) == -1))))
            {
                return;
            };
            if ((((pItemWrapper.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS)) && (playerApi.isRidding())))
            {
                this._slotCollection[pItemWrapper.position].data = storageApi.getFakeItemMount();
                this._currentStuff[pItemWrapper.position] = storageApi.getFakeItemMount();
            }
            else
            {
                this._slotCollection[pItemWrapper.position].data = pItemWrapper;
                this._currentStuff[pItemWrapper.position] = pItemWrapper;
            };
            if (pItemWrapper.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
            {
                if (pItemWrapper.twoHanded)
                {
                    this.tx_cross.visible = true;
                    this.tx_cross.alpha = 0.5;
                }
                else
                {
                    this.tx_cross.visible = false;
                    this.tx_cross.alpha = 1;
                };
            };
        }

        public function onMountRiding(isRidding:Boolean):void
        {
            this._slotCollection[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = null;
            this._currentStuff[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = null;
            if (isRidding)
            {
                this._slotCollection[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = storageApi.getFakeItemMount();
                this._currentStuff[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = storageApi.getFakeItemMount();
            };
        }

        public function useItem(item:Object):void
        {
            if (((!(item.usable)) && (item.targetable)))
            {
                sysApi.sendAction(new ObjectUse(item.objectUID, 1, true));
                uiApi.unloadUi(uiApi.me().name);
            }
            else
            {
                if (!(this._delayUseObject))
                {
                    this._delayUseObjectTimer.start();
                    sysApi.sendAction(new ObjectUse(item.objectUID, 1, false));
                };
            };
        }

        public function useItemQuantity(item:Object):void
        {
            if (!(this._delayUseObject))
            {
                this._waitingObject = item;
                modCommon.openQuantityPopup(1, item.quantity, 1, this.onValidItemQuantityUse);
            };
        }

        public function onValidItemQuantityUse(qty:Number):void
        {
            sysApi.sendAction(new ObjectUse(this._waitingObject.objectUID, qty, false));
            this._waitingObject = null;
        }

        public function equipItem(item:Object):void
        {
            var equipement:Object;
            var freeSlot:int;
            var pos:int;
            var possiblePosition:Object = storageApi.itemSuperTypeToServerPosition(item.type.superTypeId);
            if (((possiblePosition) && (possiblePosition.length)))
            {
                equipement = storageApi.getViewContent("equipment");
                freeSlot = -1;
                for each (pos in possiblePosition)
                {
                    if (!(equipement[pos]))
                    {
                        freeSlot = pos;
                        break;
                    };
                };
                if (freeSlot == -1)
                {
                    freeSlot = possiblePosition[0];
                };
                sysApi.sendAction(new ObjectSetPosition(item.objectUID, freeSlot, 1));
            };
        }

        public function useItemOnCell(item:Object):void
        {
            sysApi.sendAction(new ObjectUse(item.objectUID, 1, true));
            uiApi.unloadUi(uiApi.me().name);
        }

        public function askDeleteItem(item:Object):void
        {
            this._waitingObject = item;
            if (item.quantity == 1)
            {
                this.askDeleteConfirm(1);
            }
            else
            {
                modCommon.openQuantityPopup(1, item.quantity, item.quantity, this.askDeleteConfirm);
            };
        }

        private function equipementSlotInit():void
        {
            var slot:Slot;
            this._slotCollection = new Array();
            this._availableEquipmentPositions = new Array();
            this._slotCollection[0] = this.slot_0;
            this._slotCollection[1] = this.slot_1;
            this._slotCollection[2] = this.slot_2;
            this._slotCollection[3] = this.slot_3;
            this._slotCollection[4] = this.slot_4;
            this._slotCollection[5] = this.slot_5;
            this._slotCollection[6] = this.slot_6;
            this._slotCollection[7] = this.slot_7;
            this._slotCollection[8] = this.slot_8;
            this._slotCollection[9] = this.slot_9;
            this._slotCollection[10] = this.slot_10;
            this._slotCollection[11] = this.slot_11;
            this._slotCollection[12] = this.slot_12;
            this._slotCollection[13] = this.slot_13;
            this._slotCollection[14] = this.slot_14;
            this._slotCollection[15] = this.slot_15;
            this._slotCollection[28] = this.slot_28;
            for each (slot in this._slotCollection)
            {
                slot.dropValidator = (this.dropValidatorFunction as Function);
                slot.processDrop = (this.processDropFunction as Function);
                uiApi.addComponentHook(slot, "onRollOver");
                uiApi.addComponentHook(slot, "onRollOut");
                uiApi.addComponentHook(slot, "onDoubleClick");
                uiApi.addComponentHook(slot, "onRightClick");
                uiApi.addComponentHook(slot, "onRelease");
                uiApi.addComponentHook(slot, "onDrop");
                this._availableEquipmentPositions.push(int(slot.name.split("_")[1]));
            };
        }

        private function getItemSuperType(item:Object):int
        {
            var cat:int;
            var type:ItemType;
            if (((item) && (((item.isLivingObject) || (item.isWrapperObject)))))
            {
                cat = 0;
                if (item.isLivingObject)
                {
                    cat = item.livingObjectCategory;
                }
                else
                {
                    cat = item.wrapperObjectCategory;
                };
                type = dataApi.getItemType(cat);
                if (type)
                {
                    return (type.superTypeId);
                };
                return (0);
            };
            if ((((item is ItemWrapper)) && (!((item.type == null)))))
            {
                return ((item as ItemWrapper).type.superTypeId);
            };
            if ((item is ShortcutWrapper))
            {
                if ((item as ShortcutWrapper).type == 0)
                {
                    return ((item as ShortcutWrapper).realItem.type.superTypeId);
                };
            };
            return (0);
        }

        public function set equipmentVisible(visible:Boolean):void
        {
            if (visible)
            {
                sysApi.setData("equipmentVisible", true);
                this.ctr_equipment.visible = true;
                this.tx_background.x = 0;
                this.tx_background.width = 799;
                this.lbl_title.x = 276;
                this.lbl_title.y = 15;
                if (this.btnMinimize.selected)
                {
                    this.btnMinimize.selected = false;
                };
            }
            else
            {
                sysApi.setData("equipmentVisible", false);
                this.ctr_equipment.visible = false;
                this.tx_backgroundItem.visible = false;
                this.lbl_selectItem.visible = true;
                modCommon.createItemBox("itemBox", this.ctr_item, null);
                this.tx_background.x = 494;
                this.tx_background.width = 305;
                this.lbl_title.x = 520;
                this.lbl_title.y = 15;
                if (!(this.btnMinimize.selected))
                {
                    this.btnMinimize.selected = true;
                };
            };
        }

        private function updateLook(pLook:Object):void
        {
            var look:Object = utilApi.getRealTiphonEntityLook(playerApi.getPlayedCharacterInfo().id, true);
            if (look.getBone() == 2)
            {
                look.setBone(1);
            };
            this.entityDisplayer.direction = this._direction;
            this.entityDisplayer.look = look;
        }

        private function itemSelected(item:Object):void
        {
            var itemW:ItemWrapper;
            if (((item) && (item.hasOwnProperty("data"))))
            {
                itemW = item.data;
            }
            else
            {
                itemW = (item as ItemWrapper);
            };
            if (itemW)
            {
                modCommon.createItemBox("itemBox", this.ctr_item, itemW);
                this.lbl_selectItem.visible = false;
                this.tx_backgroundItem.visible = true;
                this._selectedItem = itemW;
            }
            else
            {
                modCommon.createItemBox("itemBox", this.ctr_item, null);
                this.lbl_selectItem.visible = true;
                this.tx_backgroundItem.visible = false;
                this._selectedItem = null;
            };
        }

        private function fillEquipement(equipment:Object):void
        {
            var item:Object;
            var slot:Slot;
            var pos:uint;
            this._currentStuff = new Array();
            for each (item in equipment)
            {
                if (item)
                {
                    this._currentStuff[item.position] = item;
                };
            };
            if (((((!(this._currentStuff[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS])) || ((this._currentStuff[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] == null)))) && (playerApi.isRidding())))
            {
                this._currentStuff[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = storageApi.getFakeItemMount();
            };
            if (((this._currentStuff[CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON]) && (this._currentStuff[CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON].twoHanded)))
            {
                this.tx_cross.visible = true;
                this.tx_cross.alpha = 0.5;
            };
            for each (slot in this._slotCollection)
            {
                pos = uint(slot.name.split("_")[1]);
                slot.data = this._currentStuff[pos];
            };
        }

        private function onDelayUseObjectTimer(e:TimerEvent):void
        {
            this._delayUseObject = false;
        }

        private function askDeleteConfirm(qty:uint):void
        {
            this._waitingObjectQty = qty;
            this._popupName = modCommon.openPopup(uiApi.getText("ui.common.delete.item"), uiApi.getText("ui.common.doYouDestroy", qty, this._waitingObject.name), [uiApi.getText("ui.common.ok"), uiApi.getText("ui.common.cancel")], [this.deleteItem, this.emptyFct], this.deleteItem);
        }

        private function deleteItem():void
        {
            sysApi.sendAction(new DeleteObject(this._waitingObject.objectUID, this._waitingObjectQty));
        }

        private function goToKrosmasterUi():void
        {
            sysApi.sendAction(new OpenBook("krosmasterTab"));
        }

        private function emptyFct(... args):void
        {
        }


    }
}//package ui

