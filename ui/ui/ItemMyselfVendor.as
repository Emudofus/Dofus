package ui
{
    import d2api.SoundApi;
    import d2api.InventoryApi;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.ClickItemInventory;
    import d2hooks.ClickItemShopHV;
    import d2hooks.ObjectDeleted;
    import d2hooks.ExchangeShopStockUpdate;
    import d2enums.ShortcutHookListEnum;
    import d2actions.ExchangeShopStockMouvmentAdd;
    import d2actions.ExchangeObjectModifyPriced;
    import d2actions.ExchangeShopStockMouvmentRemove;
    import d2components.GraphicContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;

    public class ItemMyselfVendor extends BasicItemCard 
    {

        public static const SELL_MOD:String = "sell_mod";
        public static const MODIFY_REMOVE_MOD:String = "modify_remove_mod";
        private static var _self:ItemMyselfVendor;

        public var soundApi:SoundApi;
        public var inventoryApi:InventoryApi;
        private var _currentMod:String;


        public static function getInstance():ItemMyselfVendor
        {
            if (_self == null)
            {
                return (null);
            };
            return (_self);
        }


        override public function main(params:Object=null):void
        {
            super.main(params);
            btn_valid.soundId = SoundEnum.MERCHANT_SELL_BUTTON;
            btn_remove.soundId = SoundEnum.MERCHANT_REMOVE_SELL_BUTTON;
            sysApi.addHook(ClickItemInventory, this.onClickItemInventory);
            sysApi.addHook(ClickItemShopHV, this.onClickItemShopHV);
            sysApi.addHook(ObjectDeleted, this.onObjectDeleted);
            sysApi.addHook(ExchangeShopStockUpdate, this.onExchangeShopStockUpdate);
            uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI, this.onShortcut);
            _self = this;
            lbl_price.visible = false;
            btn_lbl_btn_valid.text = uiApi.getText("ui.common.putOnSell");
        }

        private function switchMode(value:Boolean):void
        {
            btn_valid.visible = value;
            btn_modify.visible = !(value);
            btn_remove.visible = !(value);
        }

        private function displayObject(item:Object):void
        {
            onObjectSelected(item);
            if (item)
            {
                if (_currentPrice > 0)
                {
                    input_price.text = utilApi.kamasToString(_currentPrice, "");
                }
                else
                {
                    input_price.text = "0";
                };
                input_quantity.text = utilApi.kamasToString(_currentObject.quantity, "");
                input_price.setSelection(0, 8388607);
                input_price.focus();
                lbl_totalPrice.text = utilApi.kamasToString((_currentPrice * item.quantity));
            };
        }

        private function checkQuantity():Boolean
        {
            var r:RegExp = /^\s*(.*?)\s*$/g;
            input_quantity.text = input_quantity.text.replace(r, "$1");
            input_price.text = input_price.text.replace(r, "$1");
            if ((((input_quantity.text == "")) || ((input_price.text == ""))))
            {
                modCommon.openPopup(uiApi.getText("ui.common.error"), uiApi.getText("ui.error.allFieldsRequired"), [uiApi.getText("ui.common.ok")]);
                return (false);
            };
            if (utilApi.stringToKamas(input_quantity.text, "") <= 0)
            {
                modCommon.openPopup(uiApi.getText("ui.common.error"), uiApi.getText("ui.error.invalidQuantity"), [uiApi.getText("ui.common.ok")]);
                return (false);
            };
            if (utilApi.stringToKamas(input_price.text, "") <= 0)
            {
                modCommon.openPopup(uiApi.getText("ui.common.error"), uiApi.getText("ui.error.invalidPrice"), [uiApi.getText("ui.common.ok")]);
                return (false);
            };
            return (true);
        }

        override public function onRelease(target:Object):void
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            switch (target)
            {
                case btn_valid:
                    if (this.checkQuantity())
                    {
                        sysApi.sendAction(new ExchangeShopStockMouvmentAdd(_currentObject.objectUID, utilApi.stringToKamas(input_quantity.text, ""), utilApi.stringToKamas(input_price.text, "")));
                    };
                    break;
                case btn_modify:
                    _local_2 = !((int(input_quantity.text) == _currentObject.quantity));
                    _local_3 = !((utilApi.stringToKamas(input_price.text, "") == _currentObject.price));
                    if (this.checkQuantity())
                    {
                        if (((_local_2) && (_local_3)))
                        {
                            sysApi.sendAction(new ExchangeObjectModifyPriced(_currentObject.objectUID, int(input_quantity.text), utilApi.stringToKamas(input_price.text, "")));
                        }
                        else
                        {
                            if (_local_2)
                            {
                                sysApi.sendAction(new ExchangeObjectModifyPriced(_currentObject.objectUID, int(input_quantity.text), 0));
                            };
                            if (_local_3)
                            {
                                sysApi.sendAction(new ExchangeObjectModifyPriced(_currentObject.objectUID, 0, utilApi.stringToKamas(input_price.text, "")));
                            };
                        };
                    };
                    break;
                case btn_remove:
                    sysApi.sendAction(new ExchangeShopStockMouvmentRemove(_currentObject.objectUID, utilApi.stringToKamas(input_quantity.text, "")));
                    break;
            };
        }

        override public function unload():void
        {
            super.unload();
        }

        override public function onChange(target:GraphicContainer):void
        {
            var itemQuantityInInventory:uint;
            var itemQuantityInStock:uint;
            var maxValue:uint;
            if (target == input_quantity)
            {
                itemQuantityInInventory = this.inventoryApi.getItemQty(_currentObject.objectGID);
                itemQuantityInStock = _currentObject.quantity;
                switch (this._currentMod)
                {
                    case SELL_MOD:
                        if (utilApi.stringToKamas(input_quantity.text, "") > itemQuantityInStock)
                        {
                            input_quantity.text = utilApi.kamasToString(itemQuantityInStock, "");
                        };
                        break;
                    case MODIFY_REMOVE_MOD:
                        if (utilApi.stringToKamas(input_quantity.text, "") > (itemQuantityInInventory + itemQuantityInStock))
                        {
                            input_quantity.text = utilApi.kamasToString((itemQuantityInInventory + itemQuantityInStock), "");
                        };
                        break;
                };
                lbl_totalPrice.text = utilApi.kamasToString((utilApi.stringToKamas(input_price.text, "") * utilApi.stringToKamas(input_quantity.text, "")));
            }
            else
            {
                if (target == input_price)
                {
                    lbl_totalPrice.text = utilApi.kamasToString((utilApi.stringToKamas(input_price.text, "") * utilApi.stringToKamas(input_quantity.text, "")));
                };
            };
        }

        public function onObjectDeleted(pObject:Object):void
        {
            if (_currentObject.objectUID == pObject.objectUID)
            {
                hideCard();
            };
        }

        public function onClickItemShopHV(pItem:Object, pPrice:uint=0):void
        {
            if (!(uiVisible))
            {
                this.soundApi.playSound(SoundTypeEnum.MERCHANT_TRANSFERT_OPEN);
            };
            this._currentMod = MODIFY_REMOVE_MOD;
            _currentPrice = pPrice;
            this.switchMode(false);
            this.displayObject(pItem);
        }

        public function onClickItemInventory(pItem:Object):void
        {
            if (!(uiVisible))
            {
                this.soundApi.playSound(SoundTypeEnum.MERCHANT_TRANSFERT_OPEN);
            };
            this._currentMod = SELL_MOD;
            _currentPrice = 0;
            this.switchMode(true);
            this.displayObject(pItem);
        }

        protected function onExchangeShopStockUpdate(itemList:Object, newItem:Object=null):void
        {
            if (((((newItem) && ((newItem.objectGID == _currentObject.objectGID)))) && ((newItem.objectUID == _currentObject.objectUID))))
            {
                _currentObject = newItem;
            };
        }

        public function onShortcut(pShortcut:String):Boolean
        {
            switch (pShortcut)
            {
                case ShortcutHookListEnum.CLOSE_UI:
                    break;
                case ShortcutHookListEnum.VALID_UI:
                    if (this._currentMod == SELL_MOD)
                    {
                        this.onRelease(btn_valid);
                    }
                    else
                    {
                        if (((input_price.haveFocus) || (input_quantity.haveFocus)))
                        {
                            this.onRelease(btn_modify);
                        };
                    };
                    return (true);
            };
            return (false);
        }


    }
}//package ui

