package ui
{
    import d2api.ContextMenuApi;
    import d2hooks.ClickItemShopHV;
    import d2enums.ShortcutHookListEnum;
    import d2hooks.BuyOk;
    import d2actions.ExchangeBuy;
    import d2components.GraphicContainer;

    public class ItemHumanVendor extends BasicItemCard 
    {

        private static var _self:ItemHumanVendor;

        public var menuApi:ContextMenuApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _popup:String;


        public static function getInstance():ItemHumanVendor
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
            sysApi.addHook(ClickItemShopHV, this.onClickItemShopHV);
            uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI, this.onShortcut);
            sysApi.addHook(BuyOk, this.onBuyOk);
            _self = this;
            ctr_inputPrice.visible = false;
            btn_lbl_btn_valid.text = uiApi.getText("ui.common.buy");
        }

        override public function unload():void
        {
            if (this._popup)
            {
                uiApi.unloadUi(this._popup);
            };
            super.unload();
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case btn_valid:
                    if ((((utilApi.stringToKamas(input_quantity.text, "") > _currentObject.quantity)) || ((utilApi.stringToKamas(input_quantity.text, "") == 0))))
                    {
                        this._popup = modCommon.openPopup(uiApi.getText("ui.common.error"), uiApi.getText("ui.error.invalidQuantity"), [uiApi.getText("ui.common.ok")], [this.onCancel], this.onCancel, this.onCancel);
                        break;
                    };
                    this._popup = modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.bidhouse.doUBuyItemBigStore", ((input_quantity.text + " x ") + _currentObject.name), utilApi.kamasToString(_currentPrice), utilApi.kamasToString((_currentPrice * utilApi.stringToKamas(input_quantity.text, "")))), [uiApi.getText("ui.common.yes"), uiApi.getText("ui.common.no")], [this.onConfirmBuyObject, this.onCancel], this.onConfirmBuyObject, this.onCancel);
                    break;
            };
        }

        private function onConfirmBuyObject():void
        {
            this._popup = null;
            sysApi.sendAction(new ExchangeBuy(_currentObject.objectUID, utilApi.stringToKamas(input_quantity.text, "")));
        }

        private function onCancel():void
        {
            this._popup = null;
        }

        public function onClickItemShopHV(pItem:Object, pPrice:uint=0):void
        {
            _currentPrice = pPrice;
            onObjectSelected(pItem);
            lbl_price.text = utilApi.kamasToString(_currentPrice, "");
            input_quantity.text = "1";
            input_quantity.setSelection(0, 8388607);
            input_quantity.focus();
            lbl_totalPrice.text = utilApi.kamasToString(_currentPrice, "");
        }

        public function onShortcut(pShortcut:String):Boolean
        {
            switch (pShortcut)
            {
                case ShortcutHookListEnum.VALID_UI:
                    if (input_quantity.haveFocus)
                    {
                        this.onRelease(btn_valid);
                        return (true);
                    };
                    break;
            };
            return (false);
        }

        override public function onChange(target:GraphicContainer):void
        {
            if (target == input_quantity)
            {
                if (utilApi.stringToKamas(input_quantity.text, "") > _currentObject.quantity)
                {
                    lbl_totalPrice.text = utilApi.kamasToString((_currentPrice * _currentObject.quantity), "");
                    input_quantity.text = utilApi.kamasToString(_currentObject.quantity, "");
                }
                else
                {
                    lbl_totalPrice.text = utilApi.kamasToString((_currentPrice * utilApi.stringToKamas(input_quantity.text, "")), "");
                };
                super.checkPlayerFund(utilApi.stringToKamas(input_quantity.text));
            };
        }

        private function onBuyOk():void
        {
            hideCard();
        }


    }
}//package ui

