// Action script...

// [Initial MovieClip Action of sprite 20923]
#initclip 188
if (!dofus.graphics.gapi.ui.bigstore.BigStorePriceItem)
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
    if (!dofus.graphics.gapi.ui.bigstore)
    {
        _global.dofus.graphics.gapi.ui.bigstore = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.bigstore.BigStorePriceItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.__set__row = function (mcRow)
    {
        this._mcRow = mcRow;
        //return (this.row());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        delete this._nSelectedSet;
        if (bUsed)
        {
            this._oItem = oItem;
            var _loc5 = this._mcList._parent._parent.isThisPriceSelected(oItem.id, 1);
            var _loc6 = this._mcList._parent._parent.isThisPriceSelected(oItem.id, 2);
            var _loc7 = this._mcList._parent._parent.isThisPriceSelected(oItem.id, 3);
            if (_loc5)
            {
                var _loc8 = this._btnPriceSet1;
            } // end if
            if (_loc6)
            {
                _loc8 = this._btnPriceSet2;
            } // end if
            if (_loc7)
            {
                _loc8 = this._btnPriceSet3;
            } // end if
            if (_loc5 || (_loc6 || _loc7))
            {
                var _loc9 = this._btnBuy;
            } // end if
            if (_loc9 != undefined)
            {
                this._mcList._parent._parent.setButtons(_loc8, _loc9);
            } // end if
            this._btnPriceSet1.selected = _loc5 && !_global.isNaN(oItem.priceSet1);
            this._btnPriceSet2.selected = _loc6 && !_global.isNaN(oItem.priceSet2);
            this._btnPriceSet3.selected = _loc7 && !_global.isNaN(oItem.priceSet3);
            if (_loc5)
            {
                this._nSelectedSet = 1;
            }
            else if (_loc6)
            {
                this._nSelectedSet = 2;
            }
            else if (_loc7)
            {
                this._nSelectedSet = 3;
            } // end else if
            this._btnBuy.enabled = this._nSelectedSet != undefined;
            this._btnBuy._visible = true;
            this._btnPriceSet1._visible = true;
            this._btnPriceSet2._visible = true;
            this._btnPriceSet3._visible = true;
            this._btnPriceSet1.enabled = !_global.isNaN(oItem.priceSet1);
            this._btnPriceSet2.enabled = !_global.isNaN(oItem.priceSet2);
            this._btnPriceSet3.enabled = !_global.isNaN(oItem.priceSet3);
            this._btnPriceSet1.label = _global.isNaN(oItem.priceSet1) ? ("-  ") : (new ank.utils.ExtendedString(oItem.priceSet1).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + "  ");
            this._btnPriceSet2.label = _global.isNaN(oItem.priceSet2) ? ("-  ") : (new ank.utils.ExtendedString(oItem.priceSet2).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + "  ");
            this._btnPriceSet3.label = _global.isNaN(oItem.priceSet3) ? ("-  ") : (new ank.utils.ExtendedString(oItem.priceSet3).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + "  ");
            this._ldrIcon.contentParams = oItem.item.params;
            this._ldrIcon.contentPath = oItem.item.iconFile;
        }
        else if (this._ldrIcon.contentPath != undefined)
        {
            this._btnPriceSet1._visible = false;
            this._btnPriceSet2._visible = false;
            this._btnPriceSet3._visible = false;
            this._btnBuy._visible = false;
            this._ldrIcon.contentPath = "";
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._btnPriceSet1._visible = false;
        this._btnPriceSet2._visible = false;
        this._btnPriceSet3._visible = false;
        this._btnBuy._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        this._btnPriceSet1.addEventListener("click", this);
        this._btnPriceSet2.addEventListener("click", this);
        this._btnPriceSet3.addEventListener("click", this);
        this._btnBuy.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        this._btnBuy.label = this._mcList.gapi.api.lang.getText("BUY");
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnPriceSet1":
            case "_btnPriceSet2":
            case "_btnPriceSet3":
            {
                var _loc3 = Number(oEvent.target._name.substr(12));
                this._mcList._parent._parent.selectPrice(this._oItem, _loc3, oEvent.target, this._btnBuy);
                if (oEvent.target.selected)
                {
                    this._nSelectedSet = _loc3;
                    this._mcRow.select();
                    this._btnBuy.enabled = true;
                }
                else
                {
                    delete this._nSelectedSet;
                    this._btnBuy.enabled = false;
                } // end else if
                break;
            } 
            case "_btnBuy":
            {
                if (!this._nSelectedSet || _global.isNaN(this._nSelectedSet))
                {
                    this._btnBuy.enabled = false;
                    return;
                } // end if
                this._mcList._parent._parent.askBuy(this._oItem.item, this._nSelectedSet, this._oItem["priceSet" + this._nSelectedSet]);
                this._mcList._parent._parent.askMiddlePrice(this._oItem.item);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("row", function ()
    {
    }, _loc1.__set__row);
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
