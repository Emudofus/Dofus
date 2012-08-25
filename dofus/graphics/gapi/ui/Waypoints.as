// Action script...

// [Initial MovieClip Action of sprite 20520]
#initclip 41
if (!dofus.graphics.gapi.ui.Waypoints)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Waypoints = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (eaData)
    {
        this.addToQueue({object: this, method: function (d)
        {
            this._eaData = d;
            if (this.initialized)
            {
                this.initData();
            } // end if
        }, params: [eaData]});
        //return (this.data());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Waypoints.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.api.network.Waypoints.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = this.api.lang.getText("WAYPOINT_LIST");
        this._lblCoords.text = this.api.lang.getText("COORDINATES_SMALL");
        this._lblName.text = this.api.lang.getText("AREA") + " (" + this.api.lang.getText("SUBAREA") + ")";
        this._lblCost.text = this.api.lang.getText("COST");
        this._lblRespawn.text = this.api.lang.getText("RESPAWN_SMALL");
        this._lblDescription.text = this.api.lang.getText("CLICK_ON_WAYPOINT");
        this._btnClose2.label = this.api.lang.getText("CLOSE");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._lstWaypoints.addEventListener("itemSelected", this);
    };
    _loc1.initData = function ()
    {
        if (this._eaData != undefined)
        {
            this._eaData.sortOn("fieldToSort", Array.CASEINSENSITIVE);
            this._lstWaypoints.dataProvider = this._eaData;
        } // end if
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
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        var _loc3 = oEvent.row.item;
        if (_loc3.isCurrent)
        {
            return;
        } // end if
        var _loc4 = _loc3.cost;
        if (this.api.datacenter.Player.Kama >= _loc4)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("DO_U_USE_WAYPOINT", [_loc3.name, _loc3.coordinates, _loc4]), "CAUTION_YESNO", {name: "Waypoint", listener: this, params: {waypointID: _loc3.id}});
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGH_RICH"), "ERROR_BOX");
        } // end else if
    };
    _loc1.yes = function (oEvent)
    {
        this.api.network.Waypoints.use(oEvent.target.params.waypointID);
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Waypoints = function ()
    {
        super();
    }).CLASS_NAME = "Waypoints";
} // end if
#endinitclip
