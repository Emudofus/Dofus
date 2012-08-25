// Action script...

// [Initial MovieClip Action of sprite 20750]
#initclip 15
if (!dofus.graphics.gapi.controls.ListInventoryViewer)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.ListInventoryViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__displayKamas = function (bDisplayKama)
    {
        this._bDisplayKama = bDisplayKama;
        if (this.initialized)
        {
            this.showKamas(bDisplayKama);
        } // end if
        //return (this.displayKamas());
    };
    _loc1.__set__displayPrices = function (bDisplayPrices)
    {
        if (this.initialized)
        {
            ank.utils.Logger.err("[displayPrices] impossible après init");
            return;
        } // end if
        this._bDisplayPrices = bDisplayPrices;
        //return (this.displayPrices());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ListInventoryViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        var _loc3 = this._bDisplayPrices ? ("ListInventoryViewerItem") : ("ListInventoryViewerItemNoPrice");
        this.attachMovie("List", "_lstInventory", 10, {styleName: "LightBrownList", cellRenderer: _loc3, rowHeight: 20});
        this._lstInventory.move(this._mcLstPlacer._x, this._mcLstPlacer._y);
        this._lstInventory.setSize(this._mcLstPlacer._width, this._mcLstPlacer._height);
        this._oDataViewer = this._lstInventory;
        this.showKamas(this._bDisplayKama);
        this.addToQueue({object: this, method: this.addListeners});
        super.createChildren();
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        super.addListeners();
        this._lstInventory.addEventListener("itemSelected", this);
        this._lstInventory.addEventListener("itemdblClick", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
    };
    _loc1.initData = function ()
    {
        this.kamaChanged({value: this._oKamasProvider.Kama});
    };
    _loc1.showKamas = function (bShow)
    {
        this._lblKama._visible = bShow;
        this._mcKamaSymbol._visible = bShow;
    };
    _loc1.itemSelected = function (oEvent)
    {
        super.itemSelected(oEvent);
        if (oEvent.target != this._cbTypes)
        {
            if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.row.item != undefined)
            {
                this.api.kernel.GameManager.insertItemInChat(oEvent.row.item);
                return;
            } // end if
            this.dispatchEvent({type: "selectedItem", item: oEvent.row.item});
        } // end if
    };
    _loc1.itemdblClick = function (oEvent)
    {
        this.dispatchEvent({type: "itemdblClick", item: oEvent.row.item});
    };
    _loc1.addProperty("displayPrices", function ()
    {
    }, _loc1.__set__displayPrices);
    _loc1.addProperty("displayKamas", function ()
    {
    }, _loc1.__set__displayKamas);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ListInventoryViewer = function ()
    {
        super();
    }).CLASS_NAME = "ListInventoryViewer";
    _loc1._bDisplayKama = true;
    _loc1._bDisplayPrices = true;
} // end if
#endinitclip
