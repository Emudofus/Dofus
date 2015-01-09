package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.PlayedCharacterApi;
    import d2api.DataApi;
    import d2api.UtilApi;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.Input;
    import d2components.TextArea;
    import d2components.Texture;
    import d2hooks.LeaveDialog;
    import d2enums.ShortcutHookListEnum;
    import d2actions.LeaveDialog;
    import d2actions.HouseSellFromInside;
    import d2actions.HouseSell;
    import d2actions.HouseBuy;
    import d2hooks.*;
    import d2actions.*;

    public class HouseSale 
    {

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var playerApi:PlayedCharacterApi;
        public var dataApi:DataApi;
        public var utilApi:UtilApi;
        private var _price:uint;
        private var _inside:Boolean;
        private var _buyMode:Boolean;
        private var _houseWrapper:Object;
        private var _houseName:String;
        public var btnClose:ButtonContainer;
        public var lbl_title:Label;
        public var btnValidate:ButtonContainer;
        public var btnCancelTheSale:ButtonContainer;
        public var inputPrice:Input;
        public var lblOwnerName:Label;
        public var lblHouseInfo:TextArea;
        public var tx_houseIcon:Texture;


        public function main(param:Object):void
        {
            this.sysApi.addHook(LeaveDialog, this.onLeaveDialog);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this._price = param.price;
            this._inside = param.inside;
            this._buyMode = param.buyMode;
            this._houseWrapper = House.currentHouse;
            if (this._buyMode)
            {
                this.lbl_title.text = this.uiApi.getText("ui.common.housePurchase");
            }
            else
            {
                this.lbl_title.text = this.uiApi.getText("ui.common.houseSale");
            };
            this.inputPrice.restrict = "0-9";
            this.inputPrice.maxChars = 13;
            this.inputPrice.numberMax = 0x77359400;
            if (this._price == 0)
            {
                this.btnCancelTheSale.disabled = true;
                this.inputPrice.text = this._houseWrapper.defaultPrice;
            }
            else
            {
                this.inputPrice.text = String(this._price);
                if (this._buyMode)
                {
                    this.inputPrice.mouseChildren = false;
                    this.btnCancelTheSale.disabled = true;
                    this.btnValidate.disabled = (this._price > this.playerApi.characteristics().kamas);
                }
                else
                {
                    this.btnCancelTheSale.disabled = false;
                    this.inputPrice.focus();
                };
            };
            if (this._houseWrapper.ownerName == "?")
            {
                this._houseName = this.uiApi.getText("ui.common.houseWithNoOwner");
            }
            else
            {
                if (this._houseWrapper.ownerName == "")
                {
                    this._houseName = this.uiApi.getText("ui.common.houseForSale");
                }
                else
                {
                    this._houseName = this.uiApi.getText("ui.common.houseOwnerName", this._houseWrapper.ownerName);
                };
            };
            this.lblOwnerName.text = this._houseName;
            var info:String = this._houseWrapper.name;
            if (this._houseWrapper.description)
            {
                info = (info + ("\n\n" + this._houseWrapper.description));
            };
            this.lblHouseInfo.text = info;
            this.lblHouseInfo.wordWrap = true;
            this.tx_houseIcon.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("houses") + this._houseWrapper.gfxId) + ".png"));
            this.uiApi.addComponentHook(this.btnClose, "onRelease");
            this.uiApi.addComponentHook(this.btnValidate, "onRelease");
            this.uiApi.addComponentHook(this.btnCancelTheSale, "onRelease");
            this.sysApi.disableWorldInteraction();
        }

        public function onRelease(target:Object):void
        {
            var _local_2:int;
            switch (target)
            {
                case this.btnClose:
                    if (!(this._inside))
                    {
                        this.sysApi.sendAction(new LeaveDialog());
                    };
                    this.uiApi.unloadUi("houseSale");
                    return;
                case this.btnValidate:
                    _local_2 = this.utilApi.stringToKamas(this.inputPrice.text, "");
                    if (this._buyMode)
                    {
                        this._price = _local_2;
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.housePurchase"), this.uiApi.getText("ui.common.doUBuyHouse", this._houseName, this.utilApi.kamasToString(_local_2, "")), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmHouseBuy, null]);
                    }
                    else
                    {
                        if (_local_2 == 0)
                        {
                            if (this._inside)
                            {
                                this.sysApi.sendAction(new HouseSellFromInside(_local_2));
                            }
                            else
                            {
                                this.sysApi.sendAction(new HouseSell(_local_2));
                            };
                            this.uiApi.unloadUi("houseSale");
                        }
                        else
                        {
                            if (this._inside)
                            {
                                this.sysApi.sendAction(new HouseSellFromInside(_local_2));
                            }
                            else
                            {
                                this.sysApi.sendAction(new HouseSell(_local_2));
                            };
                            this.uiApi.unloadUi("houseSale");
                        };
                    };
                    return;
                case this.btnCancelTheSale:
                    if (this._inside)
                    {
                        this.sysApi.sendAction(new HouseSellFromInside(_local_2));
                    }
                    else
                    {
                        this.sysApi.sendAction(new HouseSell(_local_2));
                    };
                    this.uiApi.unloadUi("houseSale");
                    return;
            };
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == ShortcutHookListEnum.CLOSE_UI)
            {
                if (!(this._inside))
                {
                    this.sysApi.sendAction(new LeaveDialog());
                };
                this.uiApi.unloadUi("houseSale");
                return (true);
            };
            return (false);
        }

        private function onConfirmHouseBuy():void
        {
            this.sysApi.sendAction(new HouseBuy(this._price));
            this.uiApi.unloadUi("houseSale");
        }

        public function unload():void
        {
            this.sysApi.enableWorldInteraction();
        }

        private function onLeaveDialog():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }


    }
}//package ui

