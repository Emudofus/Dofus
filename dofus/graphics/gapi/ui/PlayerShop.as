// Action script...

// [Initial MovieClip Action of sprite 20650]
#initclip 171
if (!dofus.graphics.gapi.ui.PlayerShop)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.PlayerShop = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        this._oData = oData;
        //return (this.data());
    };
    _loc1.__set__colors = function (aColors)
    {
        this._colors = aColors;
        //return (this.colors());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.PlayerShop.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.api.network.Exchange.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this.hideItemViewer(true);
        this.setBuyMode(false);
    };
    _loc1.addListeners = function ()
    {
        this._livInventory.addEventListener("selectedItem", this);
        this._livInventory2.addEventListener("selectedItem", this);
        this._btnBuy.addEventListener("click", this);
        this._btnClose.addEventListener("click", this);
        this._ldrArtwork.addEventListener("complete", this);
        if (this._oData != undefined)
        {
            this._oData.addEventListener("modelChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[PlayerShop] il n\'y a pas de data");
        } // end else if
    };
    _loc1.initTexts = function ()
    {
        this._btnBuy.label = this.api.lang.getText("BUY");
        this._winInventory.title = this.api.datacenter.Player.data.name;
        this._winInventory2.title = this._oData.name;
    };
    _loc1.initData = function ()
    {
        this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
        this._livInventory.kamasProvider = this.api.datacenter.Player;
        this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._oData.gfx + ".swf";
        this.modelChanged();
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._itvItemViewer._visible = !bHide;
        this._winItemViewer._visible = !bHide;
        if (bHide)
        {
            this._oSelectedItem = undefined;
        } // end if
    };
    _loc1.setBuyMode = function (bActive)
    {
        this._btnBuy._visible = bActive;
        this._mcBuyArrow._visible = bActive;
    };
    _loc1.askQuantity = function (nQte, nPrice)
    {
        var _loc4 = Math.floor(this.api.datacenter.Player.Kama / nPrice);
        if (_loc4 > nQte)
        {
            _loc4 = nQte;
        } // end if
        var _loc5 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, max: _loc4, min: 1});
        _loc5.addEventListener("validate", this);
    };
    _loc1.validateBuy = function (nQuantity)
    {
        if (nQuantity <= 0)
        {
            return;
        } // end if
        nQuantity = Math.min(this._oSelectedItem.Quantity, nQuantity);
        if (this.api.datacenter.Player.Kama < this._oSelectedItem.price * nQuantity)
        {
            this.gapi.loadUIComponent("AskOk", "AskOkRich", {title: this.api.lang.getText("ERROR_WORD"), text: this.api.lang.getText("NOT_ENOUGH_RICH")});
            return;
        } // end if
        this.api.network.Exchange.buy(this._oSelectedItem.ID, nQuantity);
        this.hideItemViewer(true);
        this.setBuyMode(false);
    };
    _loc1.applyColor = function (mc, zone)
    {
        var _loc4 = this._colors[zone];
        if (_loc4 == -1 || _loc4 == undefined)
        {
            return;
        } // end if
        var _loc5 = (_loc4 & 16711680) >> 16;
        var _loc6 = (_loc4 & 65280) >> 8;
        var _loc7 = _loc4 & 255;
        var _loc8 = new Color(mc);
        var _loc9 = new Object();
        _loc9 = {ra: 0, ga: 0, ba: 0, rb: _loc5, gb: _loc6, bb: _loc7};
        _loc8.setTransform(_loc9);
    };
    _loc1.modelChanged = function (oEvent)
    {
        this._livInventory2.dataProvider = this._oData.inventory;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBuy":
            {
                if (this._oSelectedItem.Quantity > 1)
                {
                    this.askQuantity(this._oSelectedItem.Quantity, this._oSelectedItem.price);
                }
                else
                {
                    this.validateBuy(1);
                } // end else if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.selectedItem = function (oEvent)
    {
        if (oEvent.item == undefined)
        {
            this.hideItemViewer(true);
            this.setBuyMode(false);
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
                    this.setBuyMode(false);
                    this._livInventory2.setFilter(this._livInventory.currentFilterID);
                    break;
                } 
                case "_livInventory2":
                {
                    this.setBuyMode(true);
                    this._livInventory.setFilter(this._livInventory2.currentFilterID);
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.validate = function (oEvent)
    {
        this.validateBuy(oEvent.value);
        
    };
    _loc1.complete = function (oEvent)
    {
        var ref = this;
        this._ldrArtwork.content.stringCourseColor = function (mc, z)
        {
            ref.applyColor(mc, z);
        };
    };
    _loc1.addProperty("colors", function ()
    {
    }, _loc1.__set__colors);
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.PlayerShop = function ()
    {
        super();
    }).CLASS_NAME = "PlayerShop";
} // end if
#endinitclip
