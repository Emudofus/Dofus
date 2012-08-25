// Action script...

// [Initial MovieClip Action of sprite 20722]
#initclip 243
if (!dofus.graphics.gapi.ui.PlayerShopModifier)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.PlayerShopModifier = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        //return (this.data());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.PlayerShopModifier.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.gapi.hideTooltip();
        this.api.network.Exchange.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this.hideItemViewer(true);
        this.setAddMode(false);
        this.setModifyMode(false);
        this._txtQuantity.restrict = "0-9";
        this._txtPrice.restrict = "0-9";
        this._txtQuantity.onSetFocus = function ()
        {
            this._parent.onSetFocus();
        };
        this._txtQuantity.onKillFocus = function ()
        {
            this._parent.onKillFocus();
        };
        this._txtPrice.onSetFocus = function ()
        {
            this._parent.onSetFocus();
        };
        this._txtPrice.onKillFocus = function ()
        {
            this._parent.onKillFocus();
        };
    };
    _loc1.addListeners = function ()
    {
        this._livInventory.addEventListener("selectedItem", this);
        this._livInventory2.addEventListener("selectedItem", this);
        this._btnAdd.addEventListener("click", this);
        this._btnRemove.addEventListener("click", this);
        this._btnModify.addEventListener("click", this);
        this._btnClose.addEventListener("click", this);
        this._btnOffline.addEventListener("click", this);
        this._btnOffline.addEventListener("over", this);
        this._btnOffline.addEventListener("out", this);
        if (this._oData != undefined)
        {
            this._oData.addEventListener("modelChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[PlayerShop] il n\'y a pas de data");
        } // end else if
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
    };
    _loc1.initTexts = function ()
    {
        this._btnAdd.label = this.api.lang.getText("PUT_ON_SELL");
        this._btnRemove.label = this.api.lang.getText("REMOVE");
        this._btnModify.label = this.api.lang.getText("MODIFY");
        this._lblQuantity.text = this.api.lang.getText("QUANTITY") + " :";
        this._lblPrice.text = this.api.lang.getText("UNIT_PRICE") + " :";
        this._winInventory.title = this.api.datacenter.Player.data.name;
        this._winInventory2.title = this.api.lang.getText("SHOP_STOCK");
    };
    _loc1.initData = function ()
    {
        this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
        this._livInventory.kamasProvider = this.api.datacenter.Player;
        this.modelChanged();
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._itvItemViewer._visible = !bHide;
        this._winItemViewer._visible = !bHide;
        this._mcQuantity._visible = !bHide;
        this._mcPrice._visible = !bHide;
        this._lblQuantity._visible = !bHide;
        this._lblPrice._visible = !bHide;
        this._txtQuantity._visible = !bHide;
        this._txtPrice._visible = !bHide;
        if (bHide)
        {
            this._oSelectedItem = undefined;
        } // end if
    };
    _loc1.setAddMode = function (bActive)
    {
        this._btnAdd._visible = bActive;
        this._mcSellArrow._visible = bActive;
        this._mcQuantity._visible = bActive;
        this._txtQuantity.editable = true;
        this._txtQuantity.selectable = true;
        this._txtPrice.tabIndex = 0;
        this._txtQuantity.tabIndex = 1;
        this._oDefaultButton = this._btnAdd;
    };
    _loc1.setModifyMode = function (bActive)
    {
        this._btnRemove._visible = bActive;
        this._btnModify._visible = bActive;
        this._mcBuyArrow._visible = bActive;
        this._mcQuantity._visible = false;
        this._txtQuantity.editable = false;
        this._txtQuantity.selectable = false;
        this._txtPrice.tabIndex = 0;
        this._txtQuantity.tabIndex = undefined;
        this._oDefaultButton = this._btnModify;
    };
    _loc1.addToShop = function (oItem, nQuantity, nPrice)
    {
        this.api.network.Exchange.movementItem(true, oItem.ID, nQuantity, nPrice);
    };
    _loc1.remove = function (oItem)
    {
        this.api.network.Exchange.movementItem(false, oItem.ID, oItem.Quantity);
    };
    _loc1.modify = function (oItem, nPrice)
    {
        this.api.network.Exchange.movementItem(true, oItem.ID, 0, nPrice);
    };
    _loc1.onShortcut = function (sShortcut)
    {
        if (sShortcut == "ACCEPT_CURRENT_DIALOG" && this._oSelectedItem != undefined)
        {
            this.click({target: this._oDefaultButton});
            return (false);
        } // end if
        return (true);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnRemove":
            {
                this.remove(this._oSelectedItem);
                this.hideItemViewer(true);
                this.setModifyMode(false);
                break;
            } 
            case "_btnModify":
            {
                var _loc3 = Number(this._txtPrice.text);
                if (_global.isNaN(_loc3))
                {
                    this.gapi.loadUIComponent("AskOk", "AksOkBadPrice", {title: this.api.lang.getText("ERROR_WORD"), text: this.api.lang.getText("ERROR_INVALID_PRICE")});
                }
                else
                {
                    this.modify(this._oSelectedItem, _loc3);
                    this.hideItemViewer(true);
                    this.setModifyMode(false);
                } // end else if
                break;
            } 
            case "_btnAdd":
            {
                var _loc4 = Number(this._txtPrice.text);
                var _loc5 = Number(this._txtQuantity.text);
                if (_global.isNaN(_loc4))
                {
                    this.gapi.loadUIComponent("AskOk", "AksOkBadPrice", {title: this.api.lang.getText("ERROR_WORD"), text: this.api.lang.getText("ERROR_INVALID_PRICE")});
                }
                else if (_global.isNaN(_loc5) || _loc5 == 0)
                {
                    this.gapi.loadUIComponent("AskOk", "AksOkBadQuantity", {title: this.api.lang.getText("ERROR_WORD"), text: this.api.lang.getText("ERROR_INVALID_QUANTITY")});
                }
                else
                {
                    _loc5 = Math.min(this._oSelectedItem.Quantity, _loc5);
                    this.addToShop(this._oSelectedItem, _loc5, _loc4);
                    this.hideItemViewer(true);
                    this.setAddMode(false);
                } // end else if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnOffline":
            {
                this.callClose();
                this.api.kernel.GameManager.offlineExchange();
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOffline":
            {
                this.gapi.showTooltip(this.api.lang.getText("MERCHANT_MODE"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.selectedItem = function (oEvent)
    {
        if (oEvent.item == undefined)
        {
            this.hideItemViewer(true);
            this.setAddMode(false);
            this.setModifyMode(false);
        }
        else
        {
            this._oSelectedItem = oEvent.item;
            this.hideItemViewer(false);
            this._itvItemViewer.itemData = oEvent.item;
            switch (oEvent.target._name)
            {
                case "_livInventory":
                {
                    this._txtQuantity.text = oEvent.item.Quantity;
                    this._txtPrice.text = "";
                    this.setModifyMode(false);
                    this.setAddMode(true);
                    this._livInventory2.setFilter(this._livInventory.currentFilterID);
                    break;
                } 
                case "_livInventory2":
                {
                    this._txtQuantity.text = oEvent.item.Quantity;
                    this._txtPrice.text = oEvent.item.price;
                    this.setAddMode(false);
                    this.setModifyMode(true);
                    this._livInventory.setFilter(this._livInventory2.currentFilterID);
                    break;
                } 
            } // End of switch
            Selection.setFocus(this._txtPrice);
        } // end else if
    };
    _loc1.modelChanged = function (oEvent)
    {
        this._livInventory2.dataProvider = this._oData.inventory;
    };
    _loc1.onSetFocus = function ()
    {
        getURL("FSCommand:" add "trapallkeys", "false");
    };
    _loc1.onKillFocus = function ()
    {
        getURL("FSCommand:" add "trapallkeys", "true");
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.PlayerShopModifier = function ()
    {
        super();
    }).CLASS_NAME = "PlayerShopModifier";
} // end if
#endinitclip
