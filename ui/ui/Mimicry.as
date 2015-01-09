package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.StorageApi;
    import d2api.DataApi;
    import d2api.ContextMenuApi;
    import d2api.InventoryApi;
    import d2data.ItemWrapper;
    import flash.utils.Timer;
    import d2components.Texture;
    import d2components.Label;
    import d2components.Slot;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2hooks.MimicryObjectPreview;
    import d2hooks.MimicryObjectAssociated;
    import d2hooks.DoubleClickItemInventory;
    import d2hooks.ObjectSelected;
    import d2enums.ShortcutHookListEnum;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import d2actions.LeaveDialogRequest;
    import d2actions.CloseInventory;
    import d2actions.MimicryObjectFeedAndAssociateRequest;
    import d2enums.LocationEnum;
    import d2hooks.*;
    import d2actions.*;

    public class Mimicry 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var storageApi:StorageApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var dataApi:DataApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var menuApi:ContextMenuApi;
        public var inventoryApi:InventoryApi;
        private var _itemMimicry:ItemWrapper;
        private var _itemHost:ItemWrapper;
        private var _itemFood:ItemWrapper;
        private var _itemResult:ItemWrapper;
        private var _waitingSlot:Object;
        private var _slotsIngredients:Array;
        private var _okButtonDisabled:Boolean;
        private var _updateTimer:Timer;
        public var tx_ingredients_selected:Texture;
        public var tx_ingredients_content:Texture;
        public var tx_backgroundItem:Texture;
        public var lbl_previewItem:Label;
        public var slot_ingredient_1:Slot;
        public var slot_ingredient_2:Slot;
        public var slot_ingredient_3:Slot;
        public var slot_item_preview:Slot;
        public var ctr_result:GraphicContainer;
        public var ctr_slot1:GraphicContainer;
        public var ctr_slot2:GraphicContainer;
        public var ctr_slot3:GraphicContainer;
        public var ctr_slot4:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var btn_ok:ButtonContainer;


        public function main(param:Object):void
        {
            var slot:*;
            var mimicryItem:ItemWrapper;
            var myItem:ItemWrapper;
            this.sysApi.disableWorldInteraction();
            this.sysApi.addHook(MimicryObjectPreview, this.onMimicryObjectPreview);
            this.sysApi.addHook(MimicryObjectAssociated, this.onMimicryObjectAssociated);
            this.sysApi.addHook(DoubleClickItemInventory, this.onDoubleClickItemInventory);
            this.sysApi.addHook(ObjectSelected, this.onObjectSelected);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this.uiApi.addComponentHook(this.btn_ok, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.slot_item_preview, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.slot_item_preview, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.slot_item_preview, ComponentHookList.ON_ITEM_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.slot_item_preview, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_slot1, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_slot1, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_slot2, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_slot2, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_slot3, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_slot3, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_slot4, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_slot4, ComponentHookList.ON_ROLL_OUT);
            this._updateTimer = new Timer(300, 1);
            this._updateTimer.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
            this._slotsIngredients = new Array(this.slot_ingredient_1, this.slot_ingredient_2, this.slot_ingredient_3);
            for each (slot in this._slotsIngredients)
            {
                this.registerSlot(slot);
            };
            this.btn_ok.disabled = true;
            this.lbl_previewItem.text = this.uiApi.getText("ui.common.selectItem");
            if (param)
            {
                mimicryItem = this.inventoryApi.getItem(int(param));
                if (mimicryItem)
                {
                    this._itemMimicry = mimicryItem;
                    myItem = this.dataApi.getItemWrapper(mimicryItem.objectGID, mimicryItem.position, mimicryItem.objectUID, 1, mimicryItem.effectsList);
                    this.fillSlot(this.slot_ingredient_1, myItem);
                };
            };
        }

        public function unload():void
        {
            this.uiApi.unloadUi("itemBoxMimicry");
            this._updateTimer.stop();
            this._updateTimer.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
            this._updateTimer = null;
            this.storageApi.releaseHooks();
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.sysApi.sendAction(new CloseInventory());
            this.sysApi.enableWorldInteraction();
        }

        public function processDropToInventory(target:Object, d:Object, source:Object):void
        {
            this.unfillSlot(this._waitingSlot);
        }

        public function fillAutoSlot(item:Object, force:Boolean=false):void
        {
            var slot:Object;
            for each (slot in this._slotsIngredients)
            {
                if (((slot.data) && ((slot.data.objectGID == item.objectGID))))
                {
                    this.fillSlot(slot, item);
                    return;
                };
                if (slot.data == null)
                {
                    this.fillSlot(slot, item);
                    return;
                };
            };
            if (force)
            {
                this.fillSlot(null, item);
            };
        }

        protected function registerSlot(slot:Slot):void
        {
            slot.dropValidator = (this.dropValidatorFunction as Function);
            slot.processDrop = (this.processDropFunction as Function);
            this.uiApi.addComponentHook(slot, "onRollOver");
            this.uiApi.addComponentHook(slot, "onRollOut");
            this.uiApi.addComponentHook(slot, "onDoubleClick");
            this.uiApi.addComponentHook(slot, "onRightClick");
            this.uiApi.addComponentHook(slot, "onRelease");
        }

        protected function switchOkButtonState():void
        {
            var slot:Object;
            this._okButtonDisabled = false;
            for each (slot in this._slotsIngredients)
            {
                if (slot.data == null)
                {
                    this._okButtonDisabled = true;
                };
            };
            this.btn_ok.disabled = this._okButtonDisabled;
        }

        private function fillSlot(slot:Object, item:Object):void
        {
            this._updateTimer.reset();
            this._updateTimer.start();
            if (((((((!((slot == null))) && (!((slot.data == null))))) && (item))) && ((slot.data.objectUID == item.objectUID))))
            {
                this.unfillSlot(slot);
            }
            else
            {
                slot.data = item;
                if (slot == this.slot_ingredient_1)
                {
                    this._itemMimicry = (item as ItemWrapper);
                }
                else
                {
                    if (slot == this.slot_ingredient_2)
                    {
                        this._itemHost = (item as ItemWrapper);
                    }
                    else
                    {
                        if (slot == this.slot_ingredient_3)
                        {
                            this._itemFood = (item as ItemWrapper);
                        };
                    };
                };
            };
        }

        private function unfillSlot(slot:Object):void
        {
            this._updateTimer.reset();
            this._updateTimer.start();
            if ((((slot == null)) || ((slot.data == null))))
            {
                return;
            };
            slot.data = null;
            if (slot == this.slot_ingredient_1)
            {
                this._itemMimicry = null;
            }
            else
            {
                if (slot == this.slot_ingredient_2)
                {
                    this._itemHost = null;
                }
                else
                {
                    if (slot == this.slot_ingredient_3)
                    {
                        this._itemFood = null;
                    };
                };
            };
        }

        private function dropValidatorFunction(target:Object, data:Object, source:Object):Boolean
        {
            if (!(data))
            {
                return (false);
            };
            switch (target)
            {
                case this.slot_ingredient_1:
                    if (data.typeId == 166)
                    {
                        return (true);
                    };
                    break;
                case this.slot_ingredient_2:
                case this.slot_ingredient_3:
                    if ((((data.category == 0)) && (!((data.typeId == 166)))))
                    {
                        return (true);
                    };
                    break;
            };
            return (false);
        }

        private function processDropFunction(target:Object, d:Object, source:Object):void
        {
            var myItem:ItemWrapper;
            var targetItem:ItemWrapper;
            if (this.dropValidatorFunction(target, d, source))
            {
                myItem = this.dataApi.getItemWrapper(d.objectGID, d.position, d.objectUID, 1, d.effectsList);
                targetItem = target.data;
                this.fillSlot(target, myItem);
                if ((((((source == this.slot_ingredient_1)) || ((source == this.slot_ingredient_2)))) || ((source == this.slot_ingredient_3))))
                {
                    this.fillSlot(source, targetItem);
                };
            };
        }

        private function validAssociation():void
        {
            if (((((((((this._itemMimicry) && (this._itemHost))) && (this._itemFood))) && (this._itemResult))) && ((this.btn_ok.disabled == false))))
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.mimicry.confirmPopup", this._itemHost.name, this._itemMimicry.name, this._itemFood.name), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmAssociate, this.onCancelAssociate], this.onConfirmAssociate, this.onCancelAssociate);
            };
        }

        private function onMimicryObjectPreview(item:ItemWrapper, errorText:String):void
        {
            this._itemResult = item;
            if (this._itemResult)
            {
                this.tx_backgroundItem.visible = true;
                this.lbl_previewItem.visible = false;
                this.btn_ok.disabled = false;
            }
            else
            {
                this.tx_backgroundItem.visible = false;
                this.lbl_previewItem.visible = true;
                if (errorText != "")
                {
                    this.lbl_previewItem.text = errorText;
                };
                this.btn_ok.disabled = true;
            };
            this.modCommon.createItemBox("itemBoxMimicry", this.ctr_result, this._itemResult);
            this.slot_item_preview.data = this._itemResult;
        }

        private function onMimicryObjectAssociated(item:ItemWrapper):void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        protected function onConfirmAssociate():void
        {
            this.sysApi.sendAction(new MimicryObjectFeedAndAssociateRequest(this._itemMimicry.objectUID, this._itemMimicry.position, this._itemFood.objectUID, this._itemFood.position, this._itemHost.objectUID, this._itemHost.position, false));
        }

        protected function onCancelAssociate():void
        {
        }

        public function onDoubleClickItemInventory(pItem:Object, pQuantity:int=1):void
        {
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_ok:
                    this.validAssociation();
                    break;
                default:
                    if (((!((target.name.indexOf("slot") == -1))) && (target.data)))
                    {
                        this.onObjectSelected(target);
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            if ((((target is Slot)) && (target.data)))
            {
                this.uiApi.showTooltip(target.data, target, false, "standard", 8, 0, 0, "itemName", null, {
                    "showEffects":true,
                    "header":true
                }, "ItemInfo");
            }
            else
            {
                switch (target)
                {
                    case this.ctr_slot1:
                        text = ((this.uiApi.getText("ui.mimicry.mimicry") + " ") + this.uiApi.getText("ui.mimicry.toBeDestroyed"));
                        break;
                    case this.ctr_slot2:
                        text = this.uiApi.getText("ui.mimicry.host");
                        break;
                    case this.ctr_slot3:
                        text = ((this.uiApi.getText("ui.mimicry.food") + " ") + this.uiApi.getText("ui.mimicry.toBeDestroyed"));
                        break;
                    case this.ctr_slot4:
                        text = this.uiApi.getText("ui.craft.itemCreated");
                        break;
                };
                if (text)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "TextInfo");
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onDoubleClick(target:Object):void
        {
            if (((target.data) && (!((target.data == this.slot_ingredient_1.data)))))
            {
                this.unfillSlot(target);
            };
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == ShortcutHookListEnum.CLOSE_UI)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            if (s == ShortcutHookListEnum.VALID_UI)
            {
                this.validAssociation();
                return (true);
            };
            return (false);
        }

        public function onObjectSelected(item:Object):void
        {
            if (!(this.sysApi.getOption("displayTooltips", "dofus")))
            {
                this.tx_backgroundItem.visible = true;
                this.lbl_previewItem.visible = false;
                this.modCommon.createItemBox("itemBoxMimicry", this.ctr_result, item.data);
            };
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

        private function onDropStart(src:Object):void
        {
            var slot:Object;
            this._waitingSlot = src;
            for each (slot in this._slotsIngredients)
            {
                if (this.dropValidatorFunction(slot, src.data, null))
                {
                    slot.selected = true;
                };
            };
        }

        private function onDropEnd(src:Object):void
        {
            var slot:Object;
            for each (slot in this._slotsIngredients)
            {
                slot.selected = false;
            };
        }

        protected function onTimerEvent(e:TimerEvent):void
        {
            if (((((!((this.slot_ingredient_1.data == null))) && (!((this.slot_ingredient_2.data == null))))) && (!((this.slot_ingredient_3.data == null)))))
            {
                this.sysApi.sendAction(new MimicryObjectFeedAndAssociateRequest(this._itemMimicry.objectUID, this._itemMimicry.position, this._itemFood.objectUID, this._itemFood.position, this._itemHost.objectUID, this._itemHost.position, true));
            }
            else
            {
                this.onMimicryObjectPreview(null, this.uiApi.getText("ui.common.selectItem"));
            };
        }

        public function set slotsIngredients(value:Array):void
        {
            this._slotsIngredients = value;
        }


    }
}//package ui

