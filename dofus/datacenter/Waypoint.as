// Action script...

// [Initial MovieClip Action of sprite 20961]
#initclip 226
if (!dofus.datacenter.Waypoint)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Waypoint = function (nID, bCurrent, bRespawn, nCost)
    {
        super();
        this.api = _global.API;
        this._nID = nID;
        this._bCurrent = bCurrent;
        this._bRespawn = bRespawn;
        this._nCost = nCost;
        this.fieldToSort = this.name + nID;
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__name = function ()
    {
        return (this.api.kernel.MapsServersManager.getMapName(this._nID));
    };
    _loc1.__get__coordinates = function ()
    {
        return (this.api.lang.getMapText(this._nID).x + ", " + this.api.lang.getMapText(this._nID).y);
    };
    _loc1.__get__isRespawn = function ()
    {
        return (this._bRespawn);
    };
    _loc1.__get__isCurrent = function ()
    {
        return (this._bCurrent);
    };
    _loc1.__get__cost = function ()
    {
        return (this._nCost);
    };
    _loc1.addProperty("cost", _loc1.__get__cost, function ()
    {
    });
    _loc1.addProperty("isCurrent", _loc1.__get__isCurrent, function ()
    {
    });
    _loc1.addProperty("isRespawn", _loc1.__get__isRespawn, function ()
    {
    });
    _loc1.addProperty("coordinates", _loc1.__get__coordinates, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
