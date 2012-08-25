// Action script...

// [Initial MovieClip Action of sprite 20603]
#initclip 124
if (!dofus.graphics.gapi.controls.GridInventoryViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.GridInventoryViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__showKamas = function (bShowKamas)
    {
        this._bShowKamas = bShowKamas;
        this._btnDragKama._visible = this._lblKama._visible = this._mcKamaSymbol._visible = this._mcKamaSymbol2._visible = bShowKamas;
        //return (this.showKamas());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.GridInventoryViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._oDataViewer = this._cgGrid;
        this.addToQueue({object: this, method: this.addListeners});
        super.createChildren();
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        super.addListeners();
        this._cgGrid.addEventListener("dropItem", this);
        this._cgGrid.addEventListener("dragItem", this);
        this._cgGrid.addEventListener("selectItem", this);
        this._cgGrid.addEventListener("overItem", this);
        this._cgGrid.addEventListener("outItem", this);
        this._cgGrid.addEventListener("dblClickItem", this);
        this._btnDragKama.onRelease = function ()
        {
            this._parent.askKamaQuantity();
        };
    };
    _loc1.initTexts = function ()
    {
        this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
    };
    _loc1.initData = function ()
    {
        this.modelChanged();
        this.kamaChanged({value: this._oKamasProvider.Kama});
    };
    _loc1.validateDrop = function (targetGrid, oItem, nQuantity)
    {
        nQuantity = Number(nQuantity);
        if (nQuantity < 1 || _global.isNaN(nQuantity))
        {
            return;
        } // end if
        if (nQuantity > oItem.Quantity)
        {
            nQuantity = oItem.Quantity;
        } // end if
        this.dispatchEvent({type: "dropItem", item: oItem, quantity: nQuantity});
    };
    _loc1.validateKama = function (nQuantity)
    {
        nQuantity = Number(nQuantity);
        if (nQuantity < 1 || _global.isNaN(nQuantity))
        {
            return;
        } // end if
        if (nQuantity > this._oKamasProvider.Kama)
        {
            nQuantity = this._oKamasProvider.Kama;
        } // end if
        this.dispatchEvent({type: "dragKama", quantity: nQuantity});
    };
    _loc1.askKamaQuantity = function ()
    {
        var _loc2 = this._oKamasProvider.Kama != undefined ? (Number(this._oKamasProvider.Kama)) : (0);
        var _loc3 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: _loc2, max: _loc2, params: {targetType: "kama"}});
        _loc3.addEventListener("validate", this);
    };
    _loc1.showOneItem = function (nUnicID)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._cgGrid.dataProvider.length)
        {
            if (nUnicID == this._cgGrid.dataProvider[_loc3].unicID)
            {
                this._cgGrid.setVPosition(_loc3 / this._cgGrid.visibleColumnCount);
                this._cgGrid.selectedIndex = _loc3;
                return (true);
            } // end if
        } // end while
        return (false);
    };
    _loc1.dragItem = function (oEvent)
    {
        if (oEvent.target.contentData == undefined)
        {
            return;
        } // end if
        this.gapi.removeCursor();
        this.gapi.setCursor(oEvent.target.contentData);
    };
    _loc1.dropItem = function (oEvent)
    {
        var _loc3 = this.gapi.getCursor();
        if (_loc3 == undefined)
        {
            return;
        } // end if
        this.gapi.removeCursor();
        if (_loc3.Quantity > 1)
        {
            var _loc4 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: 1, max: _loc3.Quantity, params: {targetType: "item", oItem: _loc3}});
            _loc4.addEventListener("validate", this);
        }
        else
        {
            this.validateDrop(this._cgGrid, _loc3, 1);
        } // end else if
    };
    _loc1.selectItem = function (oEvent)
    {
        if (Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.target.contentData != undefined)
        {
            this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
            return;
        } // end if
        this.dispatchEvent({type: "selectedItem", item: oEvent.target.contentData});
    };
    _loc1.overItem = function (oEvent)
    {
        this.gapi.showTooltip(oEvent.target.contentData.name, oEvent.target, -20, undefined, oEvent.target.contentData.style + "ToolTip");
    };
    _loc1.outItem = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.dblClickItem = function (oEvent)
    {
        this.dispatchEvent({type: oEvent.type, item: oEvent.target.contentData, target: this, index: oEvent.target.id});
    };
    _loc1.validate = function (oEvent)
    {
        switch (oEvent.params.targetType)
        {
            case "item":
            {
                this.validateDrop(this._cgGrid, oEvent.params.oItem, oEvent.value);
                break;
            } 
            case "kama":
            {
                this.validateKama(oEvent.value);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("showKamas", function ()
    {
    }, _loc1.__set__showKamas);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.GridInventoryViewer = function ()
    {
        super();
    }).CLASS_NAME = "GridInventoryViewer";
    _loc1._bShowKamas = true;
} // end if
#endinitclip
