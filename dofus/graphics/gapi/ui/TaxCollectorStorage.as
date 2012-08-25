// Action script...

// [Initial MovieClip Action of sprite 20840]
#initclip 105
if (!dofus.graphics.gapi.ui.TaxCollectorStorage)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.TaxCollectorStorage = function ()
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
        super.init(false, dofus.graphics.gapi.ui.TaxCollectorStorage.CLASS_NAME);
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
        this.setGetItemMode(false);
    };
    _loc1.addListeners = function ()
    {
        this._livInventory.addEventListener("selectedItem", this);
        this._livInventory2.addEventListener("selectedItem", this);
        this._livInventory2.addEventListener("itemdblClick", this);
        this._btnGetItem.addEventListener("click", this);
        this._btnGetKamas.addEventListener("click", this);
        this._btnClose.addEventListener("click", this);
        if (this._oData != undefined)
        {
            this._oData.addEventListener("modelChanged", this);
            this._oData.addEventListener("kamaChanged", this);
        }
        else
        {
            ank.utils.Logger.err("[TaxCollectorShop] il n\'y a pas de data");
        } // end else if
    };
    _loc1.initTexts = function ()
    {
        this._btnGetItem.label = this.api.lang.getText("GET_ITEM");
        this._winInventory.title = this.api.datacenter.Player.data.name;
        this._winInventory2.title = this._oData.name;
    };
    _loc1.initData = function ()
    {
        this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
        this._livInventory.kamasProvider = this.api.datacenter.Player;
        this._livInventory2.kamasProvider = this._oData;
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
    _loc1.setGetItemMode = function (bActive)
    {
        var _loc3 = false;
        var _loc4 = this.api.datacenter.Player.guildInfos.playerRights;
        switch (this._oSelectedItem.superType)
        {
            case 9:
            {
                _loc3 = _loc4.canCollectResources;
                break;
            } 
            default:
            {
                _loc3 = _loc4.canCollectObjects;
                break;
            } 
        } // End of switch
        this._btnGetItem._visible = bActive && _loc3;
        this._mcBuyArrow._visible = bActive;
    };
    _loc1.askQuantity = function (nQuantity, oParams)
    {
        var _loc4 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: nQuantity, max: nQuantity, params: oParams});
        _loc4.addEventListener("validate", this);
    };
    _loc1.validateGetItem = function (nQuantity)
    {
        if (nQuantity <= 0)
        {
            return;
        } // end if
        nQuantity = Math.min(this._oSelectedItem.Quantity, nQuantity);
        this.api.network.Exchange.movementItem(false, this._oSelectedItem.ID, nQuantity);
        this.hideItemViewer(true);
        this.setGetItemMode(false);
    };
    _loc1.validateKamas = function (nQuantity)
    {
        if (nQuantity <= 0)
        {
            return;
        } // end if
        nQuantity = Math.min(this._oData.Kama, nQuantity);
        this.api.network.Exchange.movementKama(-nQuantity);
        this.hideItemViewer(true);
        this.setGetItemMode(false);
    };
    _loc1.getItems = function ()
    {
        if (this._oSelectedItem.Quantity > 1)
        {
            this.askQuantity(this._oSelectedItem.Quantity, {type: "item"});
        }
        else
        {
            this.validateGetItem(1);
        } // end else if
    };
    _loc1.modelChanged = function (oEvent)
    {
        this._livInventory2.dataProvider = this._oData.inventory;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnGetItem":
            {
                if (this._oSelectedItem.Quantity > 1)
                {
                    this.askQuantity(this._oSelectedItem.Quantity, {type: "item"});
                }
                else
                {
                    this.validateGetItem(1);
                } // end else if
                break;
            } 
            case "_btnGetKamas":
            {
                if (this.api.datacenter.Player.guildInfos.playerRights.canCollect)
                {
                    if (this._oData.Kama > 0)
                    {
                        this.askQuantity(this._oData.Kama, {type: "kamas"});
                    } // end if
                } // end if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.itemdblClick = function (oEvent)
    {
        if (!Key.isDown(Key.CONTROL))
        {
            if (this._oSelectedItem.Quantity > 1)
            {
                this.askQuantity(this._oSelectedItem.Quantity, {type: "item"});
            }
            else
            {
                this.validateGetItem(1);
            } // end else if
        }
        else
        {
            this.validateGetItem(this._oSelectedItem.Quantity);
        } // end else if
    };
    _loc1.selectedItem = function (oEvent)
    {
        if (oEvent.item == undefined)
        {
            this.hideItemViewer(true);
            this.setGetItemMode(false);
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
                    this.setGetItemMode(false);
                    this._livInventory2.setFilter(this._livInventory.currentFilterID);
                    break;
                } 
                case "_livInventory2":
                {
                    this.setGetItemMode(true);
                    this._livInventory.setFilter(this._livInventory2.currentFilterID);
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.validate = function (oEvent)
    {
        switch (oEvent.target.params.type)
        {
            case "item":
            {
                this.validateGetItem(oEvent.value);
                break;
            } 
            case "kamas":
            {
                this.validateKamas(oEvent.value);
                break;
            } 
        } // End of switch
        
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.TaxCollectorStorage = function ()
    {
        super();
    }).CLASS_NAME = "TaxCollectorStorage";
} // end if
#endinitclip
