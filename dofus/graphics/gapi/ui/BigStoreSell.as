// Action script...

// [Initial MovieClip Action of sprite 20585]
#initclip 106
if (!dofus.graphics.gapi.ui.BigStoreSell)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.BigStoreSell = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        //return (this.data());
    };
    _loc1.setMiddlePrice = function (nUnicID, nPrice)
    {
        if (this._itvItemViewer.itemData.unicID == nUnicID && this._itvItemViewer.itemData != undefined)
        {
            this._lblMiddlePrice.text = this.api.lang.getText("BIGSTORE_MIDDLEPRICE", [nPrice]);
        } // end if
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.BigStoreSell.CLASS_NAME);
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
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.populateComboBox});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.setAddMode, params: [false]});
        this.addToQueue({object: this, method: this.setRemoveMode, params: [false]});
        this.hideItemViewer(true);
    };
    _loc1.addListeners = function ()
    {
        this._livInventory.addEventListener("selectedItem", this);
        this._livInventory2.addEventListener("selectedItem", this);
        this._btnAdd.addEventListener("click", this);
        this._btnRemove.addEventListener("click", this);
        this._btnClose.addEventListener("click", this);
        this._btnSwitchToBuy.addEventListener("click", this);
        this._btnTypes.addEventListener("over", this);
        this._btnTypes.addEventListener("out", this);
        this._btnFilterSell.addEventListener("click", this);
        this._btnFilterSell.addEventListener("over", this);
        this._btnFilterSell.addEventListener("out", this);
        this._tiPrice.addEventListener("change", this);
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
        this._btnSwitchToBuy.label = this.api.lang.getText("BIGSTORE_MODE_BUY");
        this._lblQuantity.text = this.api.lang.getText("SET_QUANTITY") + " :";
        this._lblPrice.text = this.api.lang.getText("SET_PRICE") + " :";
        this._lblFilterSell.text = this.api.lang.getText("BIGSTORE_FILTER");
        this._winInventory.title = this.api.datacenter.Player.data.name;
        this._winInventory2.title = this.api.lang.getText("SHOP_STOCK");
    };
    _loc1.populateComboBox = function (nQuantity)
    {
        var _loc3 = new ank.utils.ExtendedArray();
        if (nQuantity >= this._oData.quantity1)
        {
            _loc3.push({label: "x" + this._oData.quantity1, index: 1});
        } // end if
        if (nQuantity >= this._oData.quantity2)
        {
            _loc3.push({label: "x" + this._oData.quantity2, index: 2});
        } // end if
        if (nQuantity >= this._oData.quantity3)
        {
            _loc3.push({label: "x" + this._oData.quantity3, index: 3});
        } // end if
        this._cbQuantity.dataProvider = _loc3;
    };
    _loc1.initData = function ()
    {
        this.enableFilter(this.api.kernel.OptionsManager.getOption("BigStoreSellFilter"));
        this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
        this._livInventory.kamasProvider = this.api.datacenter.Player;
        this.modelChanged();
    };
    _loc1.enableFilter = function (bEnable)
    {
        if (bEnable)
        {
            var _loc3 = new Array();
            for (var i in this._oData.typesObj)
            {
                _loc3.push(i);
            } // end of for...in
            this._livInventory.customInventoryFilter = new dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter(Number(this._oData.maxLevel), _loc3);
        }
        else
        {
            this._livInventory.customInventoryFilter = null;
        } // end else if
        this._btnFilterSell.selected = bEnable;
        this.api.kernel.OptionsManager.setOption("BigStoreSellFilter", bEnable);
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._itvItemViewer._visible = !bHide;
        this._winItemViewer._visible = !bHide;
        this._mcItemViewerDescriptionBack._visible = !bHide;
        this._srBottom._visible = !bHide;
        this._mcPrice._visible = !bHide;
        this._mcKamaSymbol._visible = !bHide;
        this._lblQuantity._visible = !bHide;
        this._lblQuantityValue._visible = !bHide;
        this._lblPrice._visible = !bHide;
        this._lblTaxTime._visible = !bHide;
        this._lblTaxTimeValue._visible = !bHide;
        this._cbQuantity._visible = !bHide;
        this._tiPrice._visible = !bHide;
        this._mcMiddlePrice._visible = !bHide;
        this._lblMiddlePrice._visible = !bHide;
        if (bHide)
        {
            this._oSelectedItem = undefined;
        } // end if
    };
    _loc1.setAddMode = function (bActive)
    {
        this._btnAdd._visible = bActive;
        this._mcSellArrow._visible = bActive;
        this._mcPrice._visible = bActive;
        this._cbQuantity._visible = bActive;
        this._lblQuantityValue._visible = false;
        this._tiPrice.tabIndex = 0;
        this._tiPrice.enabled = bActive;
        this._oDefaultButton = this._btnAdd;
        this._mcKamaSymbol._visible = bActive;
        this._lblTaxTime.text = this.api.lang.getText("BIGSTORE_TAX") + " :";
        if (this._lblTaxTimeValue.text != undefined)
        {
            this._lblTaxTimeValue.text = "";
        } // end if
        if (this._txtBadType.text != undefined)
        {
            this._txtBadType.text = "";
        } // end if
        this._lblTaxTime._visible = bActive;
        this._lblQuantity._visible = bActive;
        this._lblPrice._visible = bActive;
        this._srBottom._visible = bActive;
        this._lblTaxTimeValue._visible = bActive;
        this._tiPrice._visible = bActive;
    };
    _loc1.setRemoveMode = function (bActive)
    {
        this._btnRemove._visible = bActive;
        this._mcBuyArrow._visible = bActive;
        this._mcPrice._visible = false;
        this._cbQuantity._visible = false;
        this._lblQuantityValue._visible = bActive;
        this._tiPrice.tabIndex = 0;
        this._tiPrice.enabled = !bActive;
        this._oDefaultButton = this._btnRemove;
        this._mcKamaSymbol._visible = false;
        this._lblTaxTime.text = this.api.lang.getText("BIGSTORE_TIME") + " :";
        if (this._lblTaxTimeValue.text != undefined)
        {
            this._lblTaxTimeValue.text = "";
        } // end if
        if (this._txtBadType.text != undefined)
        {
            this._txtBadType.text = "";
        } // end if
        this._lblTaxTime._visible = bActive;
        this._lblQuantity._visible = bActive;
        this._lblPrice._visible = bActive;
        this._srBottom._visible = bActive;
        this._lblTaxTimeValue._visible = bActive;
        this._tiPrice._visible = bActive;
    };
    _loc1.setBadItemMode = function (sMessage)
    {
        this._btnRemove._visible = false;
        this._mcBuyArrow._visible = false;
        this._mcPrice._visible = false;
        this._cbQuantity._visible = false;
        this._lblQuantityValue._visible = false;
        this._tiPrice.tabIndex = 0;
        this._tiPrice.enabled = false;
        this._oDefaultButton = undefined;
        this._mcKamaSymbol._visible = false;
        this._txtBadType.text = sMessage;
        this._lblTaxTime._visible = false;
        this._lblQuantity._visible = false;
        this._lblPrice._visible = false;
        this._srBottom._visible = false;
        this._lblTaxTimeValue._visible = false;
        this._tiPrice._visible = false;
    };
    _loc1.remove = function (oItem)
    {
        this.api.network.Exchange.movementItem(false, oItem.ID, oItem.Quantity);
    };
    _loc1.calculateTax = function ()
    {
        if (this._oData.tax == 0)
        {
            this._lblTaxTimeValue.text = "0";
            return;
        } // end if
        var _loc2 = Number(this._tiPrice.text);
        var _loc3 = Math.max(1, Math.round(_loc2 * this._oData.tax / 100));
        this._lblTaxTimeValue.text = String(_global.isNaN(_loc3) ? (0) : (_loc3));
    };
    _loc1.updateItemCount = function ()
    {
        this._winInventory2.title = this.api.lang.getText("SHOP_STOCK") + " (" + this._oData.inventory.length + "/" + this._oData.maxItemCount + ")";
    };
    _loc1.askSell = function (oItem, nQuantityIndex, nPrice)
    {
        var _loc5 = this.gapi.loadUIComponent("AskYesNo", "AskYesNoSell", {title: this.api.lang.getText("BIGSTORE"), text: this.api.lang.getText("DO_U_SELL_ITEM_BIGSTORE", ["x" + this._oData["quantity" + nQuantityIndex] + " " + oItem.name, nPrice]), params: {id: oItem.ID, quantityIndex: nQuantityIndex, price: nPrice}});
        _loc5.addEventListener("yes", this);
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
                this.setRemoveMode(false);
                break;
            } 
            case "_btnAdd":
            {
                var _loc3 = _global.parseInt(this._tiPrice.text, 10);
                var _loc4 = Number(this._cbQuantity.selectedItem.index);
                if (_global.isNaN(_loc3) || _loc3 == 0)
                {
                    this.gapi.loadUIComponent("AskOk", "AksOkBadPrice", {title: this.api.lang.getText("ERROR_WORD"), text: this.api.lang.getText("ERROR_INVALID_PRICE")});
                }
                else if (_global.isNaN(_loc4) || _loc4 == 0)
                {
                    this.gapi.loadUIComponent("AskOk", "AksOkBadQuantity", {title: this.api.lang.getText("ERROR_WORD"), text: this.api.lang.getText("ERROR_INVALID_QUANTITY")});
                }
                else
                {
                    this.askSell(this._oSelectedItem, _loc4, _loc3);
                } // end else if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnSwitchToBuy":
            {
                this.api.network.Exchange.request(11, this._oData.npcID);
                break;
            } 
            case "_btnFilterSell":
            {
                this.enableFilter(this._btnFilterSell.selected);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnTypes:
            {
                var _loc3 = this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel;
                _loc3 = _loc3 + ("\n" + this.api.lang.getText("BIGSTORE_TAX") + " : " + this._oData.tax + "%");
                _loc3 = _loc3 + ("\n" + this.api.lang.getText("BIGSTORE_MAX_ITEM_PER_ACCOUNT") + " : " + this._oData.maxItemCount);
                _loc3 = _loc3 + ("\n" + this.api.lang.getText("BIGSTORE_MAX_SELL_TIME") + " : " + this._oData.maxSellTime + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"), "m", this._oData.maxSellTime < 2));
                _loc3 = _loc3 + ("\n\n" + this.api.lang.getText("BIGSTORE_TYPES") + " :");
                var _loc4 = this._oData.types;
                for (var k in _loc4)
                {
                    _loc3 = _loc3 + ("\n - " + this.api.lang.getItemTypeText(_loc4[k]).n);
                } // end of for...in
                this.gapi.showTooltip(_loc3, oEvent.target, 20);
                break;
            } 
            case this._btnFilterSell:
            {
                this.gapi.showTooltip(this.api.lang.getText("BIGSTORE_SELL_FILTER_OVER"), oEvent.target, 20);
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
            this.setRemoveMode(false);
        }
        else
        {
            this._oSelectedItem = oEvent.item;
            this.hideItemViewer(false);
            this._itvItemViewer.itemData = oEvent.item;
            this.populateComboBox(oEvent.item.Quantity);
            var _loc3 = oEvent.item.type;
            if (this._lblMiddlePrice.text != undefined)
            {
                this._lblMiddlePrice.text = "";
            } // end if
            if (!this._oData.typesObj[_loc3])
            {
                this.setAddMode(false);
                this.setRemoveMode(false);
                this.setBadItemMode(this.api.lang.getText("BIGSTORE_BAD_TYPE"));
            }
            else if (oEvent.item.level > this._oData.maxLevel)
            {
                this.setAddMode(false);
                this.setRemoveMode(false);
                this.setBadItemMode(this.api.lang.getText("BIGSTORE_BAD_LEVEL"));
            }
            else
            {
                switch (oEvent.target._name)
                {
                    case "_livInventory":
                    {
                        this._cbQuantity.selectedIndex = 0;
                        if (this._tiPrice.text != undefined)
                        {
                            this._tiPrice.text = "";
                        } // end if
                        this.setRemoveMode(false);
                        this.setAddMode(true);
                        this._livInventory2.setFilter(this._livInventory.currentFilterID);
                        this._tiPrice.setFocus();
                        break;
                    } 
                    case "_livInventory2":
                    {
                        this._lblQuantityValue.text = "x" + String(oEvent.item.Quantity);
                        this._tiPrice.text = oEvent.item.price;
                        this.setAddMode(false);
                        this.setRemoveMode(true);
                        this._livInventory.setFilter(this._livInventory2.currentFilterID);
                        this._lblTaxTimeValue.text = oEvent.item.remainingHours + "h";
                        break;
                    } 
                } // End of switch
                this.api.network.Exchange.getItemMiddlePriceInBigStore(oEvent.item.unicID);
            } // end else if
        } // end else if
    };
    _loc1.modelChanged = function (oEvent)
    {
        this._livInventory2.dataProvider = this._oData.inventory;
        this.updateItemCount();
    };
    _loc1.change = function (oEvent)
    {
        if (this._btnAdd._visible)
        {
            this.calculateTax();
        } // end if
    };
    _loc1.yes = function (oEvent)
    {
        this.api.network.Exchange.movementItem(true, oEvent.target.params.id, oEvent.target.params.quantityIndex, oEvent.target.params.price);
        this.setAddMode(false);
        this.hideItemViewer(true);
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.BigStoreSell = function ()
    {
        super();
    }).CLASS_NAME = "BigStoreSell";
} // end if
#endinitclip
