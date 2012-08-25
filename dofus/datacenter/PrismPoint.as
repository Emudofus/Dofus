// Action script...

// [Initial MovieClip Action of sprite 20839]
#initclip 104
if (!dofus.datacenter.PrismPoint)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.PrismPoint = function (map, cost, attackNear)
    {
        super();
        this.api = _global.API;
        this._nMapId = map;
        this._nCost = cost;
        this._atkNear = attackNear;
    }).prototype;
    _loc1.__get__cost = function ()
    {
        return (this._nCost);
    };
    _loc1.__get__mapID = function ()
    {
        return (this._nMapId);
    };
    _loc1.__get__attackNear = function ()
    {
        return (this._atkNear);
    };
    _loc1.__get__coordinates = function ()
    {
        return (this.x + ", " + this.y);
    };
    _loc1.__get__x = function ()
    {
        return (this.api.lang.getMapText(this._nMapId).x);
    };
    _loc1.__get__y = function ()
    {
        return (this.api.lang.getMapText(this._nMapId).y);
    };
    _loc1.__get__name = function ()
    {
        var _loc2 = Number(this.api.lang.getMapText(this._nMapId).sa);
        return (String(this.api.lang.getMapSubAreaText(_loc2).n).substr(0, 2) == "//" ? (String(this.api.lang.getMapSubAreaText(_loc2).n).substr(2)) : (this.api.lang.getMapSubAreaText(_loc2).n));
    };
    _loc1.addProperty("y", _loc1.__get__y, function ()
    {
    });
    _loc1.addProperty("attackNear", _loc1.__get__attackNear, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("cost", _loc1.__get__cost, function ()
    {
    });
    _loc1.addProperty("mapID", _loc1.__get__mapID, function ()
    {
    });
    _loc1.addProperty("coordinates", _loc1.__get__coordinates, function ()
    {
    });
    _loc1.addProperty("x", _loc1.__get__x, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
