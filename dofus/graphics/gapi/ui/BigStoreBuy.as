// Action script...

// [Initial MovieClip Action of sprite 20783]
#initclip 48
if (!dofus.graphics.gapi.ui.BigStoreBuy)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.BigStoreBuy = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        //return (this.data());
    };
    _loc1.__set__defaultSearch = function (sText)
    {
        this._sDefaultSearch = sText;
        //return (this.defaultSearch());
    };
    _loc1.setButtons = function (btnPrice, btnBuy)
    {
        this._btnSelectedPrice.selected = false;
        this._btnSelectedPrice = btnPrice;
        this._btnSelectedBuy.enabled = false;
        this._btnSelectedBuy = btnBuy;
    };
    _loc1.selectPrice = function (oItem, nQuantityIndex, btnPrice, btnBuy)
    {
        if (btnPrice != this._btnSelectedPrice)
        {
            this._nSelectedPriceItemID = oItem.id;
            this._nSelectedPriceIndex = nQuantityIndex;
            this.setButtons(btnPrice, btnBuy);
        }
        else
        {
            delete this._nSelectedPriceItemID;
            delete this._nSelectedPriceIndex;
            delete this._btnSelectedPrice;
            delete this._btnSelectedBuy;
        } // end else if
    };
    _loc1.isThisPriceSelected = function (nItemID, nQuantityIndex)
    {
        return (nItemID == this._nSelectedPriceItemID && this._nSelectedPriceIndex == nQuantityIndex);
    };
    _loc1.askBuy = function (oItem, nQuantityIndex, nPrice)
    {
        if (oItem != undefined && (nQuantityIndex != undefined && !_global.isNaN(nPrice)))
        {
            if (nPrice > this.api.datacenter.Player.Kama)
            {
                this.gapi.loadUIComponent("AskOk", "AskOkNotRich", {title: this.api.lang.getText("ERROR_WORD"), text: this.api.lang.getText("NOT_ENOUGH_RICH")});
            }
            else
            {
                var _loc5 = this.gapi.loadUIComponent("AskYesNo", "AskYesNoBuy", {title: this.api.lang.getText("BIGSTORE"), text: this.api.lang.getText("DO_U_BUY_ITEM_BIGSTORE", ["x" + this._oData["quantity" + nQuantityIndex] + " " + oItem.name, nPrice]), params: {id: oItem.ID, quantityIndex: nQuantityIndex, price: nPrice}});
                _loc5.addEventListener("yes", this);
            } // end if
        } // end else if
    };
    _loc1.setType = function (nType)
    {
        var _loc3 = this._oData.types;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            if (_loc3[_loc4] == nType)
            {
                this._cbTypes.selectedIndex = _loc4;
                return;
            } // end if
        } // end while
    };
    _loc1.setItem = function (nUnicID)
    {
        var _loc3 = this._oData.inventory;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            if (_loc3[_loc4].unicID == nUnicID)
            {
                if (this._lstItems.selectedIndex != _loc4)
                {
                    this._lstItems.selectedIndex = _loc4;
                    this._lstItems.setVPosition(_loc4);
                } // end if
                break;
            } // end if
        } // end while
        this.updateItem(new dofus.datacenter.Item(0, nUnicID), true);
    };
    _loc1.askMiddlePrice = function (oItem)
    {
        this.api.network.Exchange.getItemMiddlePriceInBigStore(oItem.unicID);
    };
    _loc1.setMiddlePrice = function (nUnicID, nPrice)
    {
        if (this._oCurrentItem.unicID == nUnicID && this._oCurrentItem != undefined)
        {
            this._lblPrices.text = this.api.lang.getText("BIGSTORE_MIDDLEPRICE", [nPrice]);
        } // end if
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.BigStoreBuy.CLASS_NAME);
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
        this.addToQueue({object: this, method: this.setQuantityHeader});
        this.addToQueue({object: this, method: this.updateData});
        this.hideItemViewer(true);
        this.addToQueue({object: this, method: this.showHelpSelectType, params: [true]});
        this.showArrowAnim(false);
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._btnSearch.addEventListener("click", this);
        this._btnTypes.addEventListener("over", this);
        this._btnTypes.addEventListener("out", this);
        this._btnSwitchToSell.addEventListener("click", this);
        this._cbTypes.addEventListener("itemSelected", this);
        this._lstItems.addEventListener("itemSelected", this);
        this._dgPrices.addEventListener("itemSelected", this);
        if (this._oData != undefined)
        {
            this._oData.addEventListener("modelChanged", this);
            this._oData.addEventListener("modelChanged2", this);
        }
        else
        {
            ank.utils.Logger.err("[BigStoreBuy] il n\'y a pas de data");
        } // end else if
        this.api.datacenter.Player.addEventListener("kamaChanged", this);
    };
    _loc1.initTexts = function ()
    {
        this._winBackground.title = this.api.lang.getText("BIGSTORE") + (this._oData == undefined ? ("") : (" (" + this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel + ")"));
        this._lblItems.text = this.api.lang.getText("BIGSTORE_ITEM_LIST");
        this._lblTypes.text = this.api.lang.getText("ITEM_TYPE");
        this._lblKamas.text = this.api.lang.getText("WALLET") + " :";
        this._btnClose2.label = this.api.lang.getText("CLOSE");
        this._btnSearch.label = this.api.lang.getText("SEARCH");
        this._btnSwitchToSell.label = this.api.lang.getText("BIGSTORE_MODE_SELL");
    };
    _loc1.updateData = function ()
    {
        this.modelChanged();
        this.modelChanged2();
        this.kamaChanged({value: this.api.datacenter.Player.Kama});
    };
    _loc1.populateComboBox = function ()
    {
        var _loc2 = this._oData.types;
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc2.length)
        {
            var _loc5 = Number(_loc2[_loc4]);
            _loc3.push({label: this.api.lang.getItemTypeText(_loc5).n, id: _loc5});
        } // end while
        _loc3.sortOn("label");
        this._oData.types = new Array();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc2.length)
        {
            this._oData.types.push(_loc3[_loc6].id);
        } // end while
        this._cbTypes.dataProvider = _loc3;
    };
    _loc1.setQuantityHeader = function ()
    {
        this._dgPrices.columnsNames = ["", "x" + this._oData.quantity1, "x" + this._oData.quantity2, "x" + this._oData.quantity3];
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._itvItemViewer._visible = !bHide;
        this._mcItemViewerDescriptionBack._visible = !bHide;
        this._mcSpacer._visible = !bHide;
        if (!bHide)
        {
            this.showHelpSelectType(false);
            this.showHelpSelectPrice(false);
            this.showHelpSelectPrice(false);
        } // end if
    };
    _loc1.updateType = function (nTypeID)
    {
        this._lstItems.selectedIndex = -1;
        this.updateItem();
        this.showHelpSelectItem(true);
        this.api.network.Exchange.bigStoreType(nTypeID);
    };
    _loc1.updateItem = function (oItem, bDoNotTouchList)
    {
        this._oCurrentItem = oItem;
        this.hideItemViewer(true);
        this.showHelpSelectPrice(true);
        this._dgPrices.selectedIndex = -1;
        delete this._nSelectedPriceItemID;
        delete this._nSelectedPriceIndex;
        delete this._btnSelectedPrice;
        delete this._btnSelectedBuy;
        if (bDoNotTouchList != true)
        {
            if (oItem != undefined)
            {
                this.api.network.Exchange.bigStoreItemList(oItem.unicID);
            }
            else
            {
                this._dgPrices.dataProvider = new ank.utils.ExtendedArray();
            } // end if
        } // end else if
    };
    _loc1.showHelpSelectType = function (bShow)
    {
        this._mcBottomArrow._visible = false;
        this._mcBottomArrow.stop();
        this._mcLeftArrow._visible = bShow;
        this._mcLeftArrow.play();
        this._mcLeft2Arrow._visible = false;
        this._mcLeft2Arrow.stop();
        this._lblNoItem.text = bShow ? (this.api.lang.getText("BIGSTORE_HELP_SELECT_TYPE")) : ("");
    };
    _loc1.showHelpSelectPrice = function (bShow)
    {
        this._mcBottomArrow._visible = bShow;
        this._mcBottomArrow.play();
        this._mcLeftArrow._visible = false;
        this._mcLeftArrow.stop();
        this._mcLeft2Arrow._visible = false;
        this._mcLeft2Arrow.stop();
        this._lblNoItem.text = bShow ? (this.api.lang.getText("BIGSTORE_HELP_SELECT_PRICE")) : ("");
    };
    _loc1.showHelpSelectItem = function (bShow)
    {
        this._mcBottomArrow._visible = false;
        this._mcBottomArrow.stop();
        this._mcLeftArrow._visible = false;
        this._mcLeftArrow.stop();
        this._mcLeft2Arrow._visible = bShow;
        this._mcLeft2Arrow.play();
        this._lblNoItem.text = bShow ? (this.api.lang.getText("BIGSTORE_HELP_SELECT_ITEM")) : ("");
    };
    _loc1.showArrowAnim = function (bShow)
    {
        if (bShow)
        {
            this._mcArrowAnim._visible = true;
            this._mcArrowAnim.play();
            ank.utils.Timer.setTimer(this, "bigstore", this, this.showArrowAnim, 800, [false]);
        }
        else
        {
            this._mcArrowAnim._visible = false;
            this._mcArrowAnim.stop();
        } // end else if
    };
    _loc1.onSearchResult = function (bSuccess)
    {
        if (bSuccess)
        {
            this.api.ui.unloadUIComponent("BigStoreSearch");
        }
        else
        {
            this.api.kernel.showMessage(this.api.lang.getText("BIGSTORE"), this.api.lang.getText("ITEM_NOT_IN_BIGSTORE"), "ERROR_BOX");
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
            case "_btnSearch":
            {
                this.api.ui.loadUIComponent("BigStoreSearch", "BigStoreSearch", {types: this._oData.types, defaultSearch: this._sDefaultSearch, oParent: this});
                break;
            } 
            case "_btnSwitchToSell":
            {
                this.api.network.Exchange.request(10, this._oData.npcID);
                break;
            } 
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_cbTypes":
            {
                this.updateType(this._cbTypes.selectedItem.id);
                break;
            } 
            case "_lstItems":
            {
                if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.row.item != undefined)
                {
                    this.api.kernel.GameManager.insertItemInChat(oEvent.row.item);
                    return;
                } // end if
                if (this._lblPrices.text != undefined)
                {
                    this._lblPrices.text = "";
                } // end if
                this.askMiddlePrice(oEvent.row.item);
                this.updateItem(oEvent.row.item);
                break;
            } 
            case "_dgPrices":
            {
                if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.row.item.item != undefined)
                {
                    this.api.kernel.GameManager.insertItemInChat(oEvent.row.item.item);
                    return;
                } // end if
                this._itvItemViewer.itemData = oEvent.row.item.item;
                this.hideItemViewer(false);
                this.showArrowAnim(true);
                break;
            } 
        } // End of switch
    };
    _loc1.modelChanged = function (oEvent)
    {
        var _loc3 = this._oData.inventory;
        _loc3.bubbleSortOn("level", Array.DESCENDING);
        _loc3.reverse();
        this._lstItems.dataProvider = _loc3;
        if (_loc3 != 0 && _loc3 != undefined)
        {
            this._lblItemsCount.text = _loc3.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"), "m", _loc3.length < 2);
        }
        else
        {
            this._lblItemsCount.text = this.api.lang.getText("NO_BIGSTORE_RESULT");
        } // end else if
    };
    _loc1.modelChanged2 = function (oEvent)
    {
        var _loc3 = oEvent.eventName == "updateOne" ? (this._nSelectedPriceItemID) : (null);
        var _loc4 = oEvent.eventName == "updateOne" ? (this._nSelectedPriceIndex) : (null);
        delete this._nSelectedPriceItemID;
        delete this._nSelectedPriceIndex;
        delete this._btnSelectedPrice;
        delete this._btnSelectedBuy;
        this._btnSelectedPrice.selected = false;
        this._btnSelectedBuy.enabled = false;
        if (_loc3 != undefined)
        {
            var _loc5 = this._oData.inventory2;
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5.length)
            {
                if (_loc5[_loc6].id == _loc3)
                {
                    this._nSelectedPriceItemID = _loc3;
                    this._nSelectedPriceIndex = _loc4;
                    break;
                } // end if
            } // end while
        } // end if
        if (this._nSelectedPriceItemID == undefined)
        {
            this.hideItemViewer(true);
        } // end if
        var _loc7 = this._oData.inventory2;
        _loc7.bubbleSortOn("priceSet1", Array.DESCENDING);
        _loc7.reverse();
        this._dgPrices.dataProvider = _loc7;
    };
    _loc1.yes = function (oEvent)
    {
        this.api.network.Exchange.bigStoreBuy(oEvent.target.params.id, oEvent.target.params.quantityIndex, oEvent.target.params.price);
        this.hideItemViewer(true);
        this.showHelpSelectPrice(true);
    };
    _loc1.kamaChanged = function (oEvent)
    {
        this._lblKamasValue.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3);
    };
    _loc1.over = function (oEvent)
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
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("defaultSearch", function ()
    {
    }, _loc1.__set__defaultSearch);
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.BigStoreBuy = function ()
    {
        super();
    }).CLASS_NAME = "BigStoreBuy";
    _loc1._sDefaultSearch = "";
} // end if
#endinitclip
