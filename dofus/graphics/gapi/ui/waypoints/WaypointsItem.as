// Action script...

// [Initial MovieClip Action of sprite 20655]
#initclip 176
if (!dofus.graphics.gapi.ui.waypoints.WaypointsItem)
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
    if (!dofus.graphics.gapi.ui.waypoints)
    {
        _global.dofus.graphics.gapi.ui.waypoints = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.waypoints.WaypointsItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._oItem = oItem;
            this._lblCost.text = oItem.cost == 0 ? ("-") : (oItem.cost + "k");
            this._lblCoords.text = oItem.coordinates;
            this._lblName.text = oItem.name;
            this._mcRespawn._visible = oItem.isRespawn;
            this._mcCurrent._visible = oItem.isCurrent;
            this._btnLocate._visible = true;
        }
        else if (this._lblCost.text != undefined)
        {
            this._lblCost.text = "";
            this._lblCoords.text = "";
            this._lblName.text = "";
            this._mcRespawn._visible = false;
            this._mcCurrent._visible = false;
            this._btnLocate._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcRespawn._visible = false;
        this._mcCurrent._visible = false;
        this._btnLocate._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnLocate.addEventListener("click", this);
    };
    _loc1.click = function (oEvent)
    {
        this._mcList.gapi.loadUIAutoHideComponent("MapExplorer", "MapExplorer", {mapID: this._oItem.id});
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
