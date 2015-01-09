package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.ContextMenuApi;
    import d2api.PlayedCharacterApi;
    import d2api.StorageApi;
    import d2components.Texture;
    import d2components.Grid;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2components.GraphicContainer;
    import d2hooks.PaymentCraftList;
    import d2actions.ExchangeItemGoldAddAsPayment;
    import d2actions.ExchangeItemObjectAddAsPayment;
    import d2actions.*;
    import d2hooks.*;

    public class Payment 
    {

        private static const _slotWidth:int = 5;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var menuApi:ContextMenuApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var playerApi:PlayedCharacterApi;
        public var storageApi:StorageApi;
        public var tx_background:Texture;
        public var tx_blockBg:Texture;
        public var gd_items:Grid;
        public var lbl_kamas:Label;
        public var sb_topArrow:ButtonContainer;
        public var sb_bottomArrow:ButtonContainer;
        public var lbl_itemsTab:Label;
        public var ctr_bonus:GraphicContainer;
        public var gd_itemsBonus:Grid;
        public var lbl_kamasBonus:Label;
        public var sb_topArrowBonus:ButtonContainer;
        public var sb_bottomArrowBonus:ButtonContainer;
        public var lbl_itemsTabBonus:Label;
        public var btn_close:ButtonContainer;
        public var btn_valid:ButtonContainer;
        public var dropEnabled:Boolean = true;
        private var _items:Object;
        private var _itemsBonus:Object;
        private var _currentItemTab:int = 0;
        private var _currentItemTabBonus:int = 0;
        private var _waitingSlot:Object;
        private var _waitingData:Object;
        private var _waitingGrid:Object;

        public function Payment()
        {
            this._items = new Array();
            this._itemsBonus = new Array();
            super();
        }

        public function get kamas():int
        {
            return (parseInt(this.lbl_kamas.text));
        }

        public function set kamas(kamas:int):void
        {
            if (kamas != parseInt(this.lbl_kamas.text))
            {
                this.lbl_kamas.text = kamas.toString();
            };
        }

        public function get items():Object
        {
            return (this._items);
        }

        public function set items(items:Object):void
        {
            if ((((this._currentItemTab == (this._items.length / _slotWidth))) && (((items.length % _slotWidth) == 0))))
            {
                this._currentItemTab = (items.length / _slotWidth);
            };
            this._items = items;
            this._refillDataProvider();
        }

        public function get kamasBonus():int
        {
            return (parseInt(this.lbl_kamasBonus.text));
        }

        public function set kamasBonus(kamas:int):void
        {
            if (kamas != parseInt(this.lbl_kamasBonus.text))
            {
                this.lbl_kamasBonus.text = kamas.toString();
            };
        }

        public function get itemsBonus():Object
        {
            return (this._itemsBonus);
        }

        public function set itemsBonus(items:Object):void
        {
            if ((((this._currentItemTabBonus == (this._itemsBonus.length / _slotWidth))) && (((items.length % _slotWidth) == 0))))
            {
                this._currentItemTabBonus = (items.length / _slotWidth);
            };
            this._itemsBonus = items;
            this._refillBonusDataProvider();
        }

        public function reset():void
        {
            var item:Object;
            var item2:Object;
            for each (item in this._items)
            {
                this.itemRemovedPayAlwaysCallback(item, item.quantity);
            };
            for each (item2 in this._itemsBonus)
            {
                this.itemRemovedPaySuccessCallback(item2, item2.quantity);
            };
            this._items = new Array();
            this._itemsBonus = new Array();
            this._refillDataProvider();
            this.lbl_kamas.text = "0";
            this.lbl_kamasBonus.text = "0";
            this.kamasModifiedPayAlwaysCallback(0);
            this.kamasModifiedPaySuccessCallback(0);
        }

        public function disable(disable:Boolean):void
        {
            this.gd_items.disabled = disable;
            this.lbl_kamas.disabled = disable;
            this.sb_topArrow.disabled = disable;
            this.sb_bottomArrow.disabled = disable;
            this.gd_itemsBonus.disabled = disable;
            this.lbl_kamasBonus.disabled = disable;
            this.sb_topArrowBonus.disabled = disable;
            this.sb_bottomArrowBonus.disabled = disable;
        }

        public function main(param:Object):void
        {
            this.sysApi.addHook(PaymentCraftList, this.onPaymentCraftList);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            if (param.paymentData)
            {
                this._items = param.paymentData.objectsPayment;
                this._itemsBonus = param.paymentData.objectsPaymentOnlySuccess;
                this.lbl_kamas.text = param.paymentData.kamaPayment;
                this.lbl_kamasBonus.text = param.paymentData.kamaPaymentOnlySuccess;
            }
            else
            {
                this._items = new Array();
                this._itemsBonus = new Array();
                this.lbl_kamas.text = "0";
                this.lbl_kamasBonus.text = "0";
            };
            if (param.hasOwnProperty("disabled"))
            {
                this.disable(param.disabled);
                if (!(param.disabled))
                {
                    this.uiApi.addComponentHook(this.lbl_kamas, "onRelease");
                    this.uiApi.addComponentHook(this.lbl_kamasBonus, "onRelease");
                };
            };
            if (!(param.bonusNeeded))
            {
                this.ctr_bonus.visible = false;
                this.tx_background.height = (this.tx_background.height - 80);
                this.tx_blockBg.height = (this.tx_blockBg.height - 80);
            };
            this.gd_items.renderer.dropValidatorFunction = this.dropValidatorFunction;
            this.gd_items.renderer.processDropFunction = this.processDropFunction;
            this.gd_items.renderer.removeDropSourceFunction = this.removeDropSourceFunction;
            this.gd_itemsBonus.renderer.dropValidatorFunction = this.dropValidatorFunction;
            this.gd_itemsBonus.renderer.processDropFunction = this.processDropBonusFunction;
            this.gd_itemsBonus.renderer.removeDropSourceFunction = this.removeDropSourceBonusFunction;
            this._refillDataProvider();
            this._refillBonusDataProvider();
        }

        public function unload():void
        {
        }

        private function _refillDataProvider():void
        {
            var it:int;
            var max:int = (this._items.length / _slotWidth);
            if (this._currentItemTab > (this._items.length / max))
            {
                this._currentItemTab = (this._items.length / max);
            };
            this.lbl_itemsTab.text = (((this._currentItemTab + 1) + "/") + (max + 1));
            var dp:Object = new Array();
            var i:int;
            while (i < _slotWidth)
            {
                it = ((this._currentItemTab * _slotWidth) + i);
                if (this._items[it])
                {
                    dp.push(this._items[it]);
                }
                else
                {
                    break;
                };
                i++;
            };
            this.gd_items.dataProvider = dp;
        }

        private function _refillBonusDataProvider():void
        {
            var it:int;
            var max:int = (this._itemsBonus.length / _slotWidth);
            if (this._currentItemTabBonus > (this._itemsBonus.length / max))
            {
                this._currentItemTabBonus = (this._itemsBonus.length / max);
            };
            this.lbl_itemsTabBonus.text = (((this._currentItemTabBonus + 1) + "/") + (max + 1));
            var dp:Object = new Array();
            var i:int;
            while (i < _slotWidth)
            {
                it = ((this._currentItemTabBonus * _slotWidth) + i);
                if (this._itemsBonus[it])
                {
                    dp.push(this._itemsBonus[it]);
                }
                else
                {
                    break;
                };
                i++;
            };
            this.gd_itemsBonus.dataProvider = dp;
        }

        protected function maxKamas(bonus:Boolean):uint
        {
            return ((this.playerApi.characteristics().kamas - ((bonus) ? this.kamas : this.kamasBonus)));
        }

        public function kamasModifiedPayAlwaysCallback(value:int):void
        {
            this.sysApi.sendAction(new ExchangeItemGoldAddAsPayment(false, value));
        }

        public function itemRemovedPayAlwaysCallback(item:Object, quantity:int):void
        {
            this.sysApi.sendAction(new ExchangeItemObjectAddAsPayment(false, item.objectUID, false, quantity));
        }

        public function itemAddedPayAlwaysCallback(item:Object, quantity:int):void
        {
            this.sysApi.sendAction(new ExchangeItemObjectAddAsPayment(false, item.objectUID, true, quantity));
        }

        public function kamasModifiedPaySuccessCallback(value:int):void
        {
            this.sysApi.sendAction(new ExchangeItemGoldAddAsPayment(true, value));
        }

        public function itemRemovedPaySuccessCallback(item:Object, quantity:int):void
        {
            this.sysApi.sendAction(new ExchangeItemObjectAddAsPayment(true, item.objectUID, false, quantity));
        }

        public function itemAddedPaySuccessCallback(item:Object, quantity:int):void
        {
            this.sysApi.sendAction(new ExchangeItemObjectAddAsPayment(true, item.objectUID, true, quantity));
        }

        public function onPaymentCraftList(paymentList:Object, highlight:Boolean):void
        {
            var item:Object;
            this.storageApi.removeAllItemMasks("paymentAlways");
            this.storageApi.removeAllItemMasks("paymentSuccess");
            if (paymentList)
            {
                this.lbl_kamas.text = paymentList.kamaPayment;
                this.gd_items.dataProvider = paymentList.objectsPayment;
                for each (item in paymentList.objectsPayment)
                {
                    this.storageApi.addItemMask(item.objectUID, "paymentAlways", item.quantity);
                };
                this.lbl_kamasBonus.text = paymentList.kamaPaymentOnlySuccess;
                this.gd_itemsBonus.dataProvider = paymentList.objectsPaymentOnlySuccess;
                for each (item in paymentList.objectsPaymentOnlySuccess)
                {
                    this.storageApi.addItemMask(item.objectUID, "paymentSuccess", item.quantity);
                };
            }
            else
            {
                this.lbl_kamas.text = "0";
                this.gd_items.dataProvider = new Array();
                this.lbl_kamasBonus.text = "0";
                this.gd_itemsBonus.dataProvider = new Array();
            };
            this.storageApi.releaseHooks();
        }

        private function hasItem(list:Object, item:Object):Boolean
        {
            var i:Object;
            for each (i in list)
            {
                if (i.objectUID == item.objectUID)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function onRelease(target:Object):void
        {
            var _local_2:int;
            var _local_3:int;
            switch (target)
            {
                case this.sb_topArrow:
                    if (this._currentItemTab > 0)
                    {
                        this._currentItemTab--;
                        this._refillDataProvider();
                    };
                    break;
                case this.sb_bottomArrow:
                    _local_2 = (this._items.length / _slotWidth);
                    if (this._currentItemTab < _local_2)
                    {
                        this._currentItemTab++;
                        this._refillDataProvider();
                    };
                    break;
                case this.sb_topArrowBonus:
                    if (this._currentItemTabBonus > 0)
                    {
                        this._currentItemTabBonus--;
                        this._refillBonusDataProvider();
                    };
                    break;
                case this.sb_bottomArrowBonus:
                    _local_3 = (this._itemsBonus.length / _slotWidth);
                    if (this._currentItemTabBonus < _local_3)
                    {
                        this._currentItemTabBonus++;
                        this._refillBonusDataProvider();
                    };
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_valid:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.lbl_kamas:
                    this.modCommon.openQuantityPopup(0, this.maxKamas(false), 0, this.kamasModifiedPayAlwaysCallback);
                    break;
                case this.lbl_kamasBonus:
                    this.modCommon.openQuantityPopup(0, this.maxKamas(true), 0, this.kamasModifiedPaySuccessCallback);
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            switch (target)
            {
                case this.gd_items:
                    if (selectMethod == 1)
                    {
                        this.itemRemovedPayAlwaysCallback(target.selectedItem, 1);
                    };
                    break;
                case this.gd_itemsBonus:
                    if (selectMethod == 1)
                    {
                        this.itemRemovedPaySuccessCallback(target.selectedItem, 1);
                    };
                    break;
            };
        }

        public function dropValidatorFunction(target:Object, data:Object, source:Object):Boolean
        {
            if (this.dropEnabled == false)
            {
                return (false);
            };
            return (true);
        }

        public function processDropFunction(target:Object, data:Object, source:Object):void
        {
            if (this.dropEnabled == false)
            {
                return;
            };
            this._waitingSlot = target;
            this._waitingData = data;
            this._waitingGrid = this.gd_items;
            if (data.quantity > 1)
            {
                this.modCommon.openQuantityPopup(1, data.quantity, data.quantity, this.onValidQtyDropAddItem);
            }
            else
            {
                this.onValidQtyDropAddItem(1);
            };
        }

        public function processDropBonusFunction(target:Object, data:Object, source:Object):void
        {
            if (this.dropEnabled == false)
            {
                return;
            };
            this._waitingSlot = target;
            this._waitingData = data;
            this._waitingGrid = this.gd_itemsBonus;
            if (data.quantity > 1)
            {
                this.modCommon.openQuantityPopup(1, data.quantity, data.quantity, this.onValidQtyDropAddItem);
            }
            else
            {
                this.onValidQtyDropAddItem(1);
            };
        }

        public function removeDropSourceFunction(slot:Object):void
        {
            this._waitingSlot = slot;
            this._waitingGrid = this.gd_items;
            if (slot.data.quantity > 1)
            {
                this.modCommon.openQuantityPopup(1, slot.data.quantity, slot.data.quantity, this.onValidQtyDropRemoveItem);
            }
            else
            {
                this.onValidQtyDropRemoveItem(1);
            };
        }

        public function removeDropSourceBonusFunction(slot:Object):void
        {
            this._waitingSlot = slot;
            this._waitingGrid = this.gd_itemsBonus;
            if (slot.data.quantity > 1)
            {
                this.modCommon.openQuantityPopup(1, slot.data.quantity, slot.data.quantity, this.onValidQtyDropRemoveItem);
            }
            else
            {
                this.onValidQtyDropRemoveItem(1);
            };
        }

        public function onValidQtyDropAddItem(quantity:int):void
        {
            if (((this._waitingGrid) && ((this._waitingGrid == this.gd_items))))
            {
                if (((this._waitingSlot.data) && (!((this._waitingSlot.data.objectUID == this._waitingData.objectUID)))))
                {
                    this.itemRemovedPayAlwaysCallback(this._waitingSlot.data, this._waitingSlot.data.quantity);
                };
                this.itemAddedPayAlwaysCallback(this._waitingData, quantity);
            }
            else
            {
                if (((this._waitingGrid) && ((this._waitingGrid == this.gd_itemsBonus))))
                {
                    if (((this._waitingSlot.data) && (!((this._waitingSlot.data.objectUID == this._waitingData.objectUID)))))
                    {
                        this.itemRemovedPaySuccessCallback(this._waitingSlot.data, this._waitingSlot.data.quantity);
                    };
                    this.itemAddedPaySuccessCallback(this._waitingData, quantity);
                };
            };
        }

        public function onValidQtyDropRemoveItem(quantity:int):void
        {
            if (((this._waitingGrid) && ((this._waitingGrid == this.gd_items))))
            {
                this.itemRemovedPayAlwaysCallback(this._waitingSlot.data, this._waitingSlot.data.quantity);
            }
            else
            {
                if (((this._waitingGrid) && ((this._waitingGrid == this.gd_itemsBonus))))
                {
                    this.itemRemovedPaySuccessCallback(this._waitingSlot.data, quantity);
                };
            };
        }

        private function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.uiApi.showTooltip(item.data, item.container, false, "standard", 0);
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target == this.gd_items)
            {
                data = item.data;
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }


    }
}//package ui

