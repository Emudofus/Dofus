// Action script...

// [Initial MovieClip Action of sprite 20749]
#initclip 14
if (!dofus.graphics.gapi.controls.InventoryViewerWithAllFilter)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.InventoryViewerWithAllFilter = function ()
    {
        super();
    }).prototype;
    _loc1.setFilter = function (nFilter)
    {
        if (nFilter == this._nCurrentFilterID)
        {
            return;
        } // end if
        if (nFilter == dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ID_ALL)
        {
            this.click({target: this._btnFilterAll});
            this._btnFilterAll.selected = true;
        }
        else
        {
            super.setFilter(nFilter);
        } // end else if
    };
    _loc1.createChildren = function ()
    {
        super.createChildren();
    };
    _loc1.addListeners = function ()
    {
        super.addListeners();
        this._btnFilterAll.addEventListener("click", this);
        this._btnFilterAll.addEventListener("over", this);
        this._btnFilterAll.addEventListener("out", this);
    };
    _loc1.getDefaultFilter = function ()
    {
        return (dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ID_ALL);
    };
    _loc1.setPreferedFilter = function ()
    {
        this.setFilter(this.getDefaultFilter());
    };
    _loc1.click = function (oEvent)
    {
        if (oEvent.target == this._btnFilterAll)
        {
            if (oEvent.target != this._btnSelectedFilterButton)
            {
                this._btnSelectedFilterButton.selected = false;
                this._btnSelectedFilterButton = oEvent.target;
                this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ALL;
                this._lblFilter.text = this.api.lang.getText("ALL");
                this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ID_ALL;
                this.updateData();
            }
            else
            {
                oEvent.target.selected = true;
            } // end else if
        }
        else
        {
            super.click(oEvent);
        } // end else if
    };
    _loc1.over = function (oEvent)
    {
        if (oEvent.target == this._btnFilterAll)
        {
            this.api.ui.showTooltip(this.api.lang.getText("ALL"), oEvent.target, -20);
        }
        else
        {
            super.over(oEvent);
        } // end else if
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.InventoryViewerWithAllFilter = function ()
    {
        super();
    }).DEFAULT_FILTER = 3;
    (_global.dofus.graphics.gapi.controls.InventoryViewerWithAllFilter = function ()
    {
        super();
    }).FILTER_ID_ALL = 3;
    (_global.dofus.graphics.gapi.controls.InventoryViewerWithAllFilter = function ()
    {
        super();
    }).FILTER_ALL = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, false];
} // end if
#endinitclip
