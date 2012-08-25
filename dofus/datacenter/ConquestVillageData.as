// Action script...

// [Initial MovieClip Action of sprite 20860]
#initclip 125
if (!dofus.datacenter.ConquestVillageData)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ConquestVillageData = function (id, alignment, door, prism)
    {
        super();
        this._nSubAreaId = id;
        this._nAlignment = alignment;
        this._bDoor = door;
        this._bPrism = prism;
        this.areaName = String(_global.API.lang.getMapAreaText(Number(_global.API.lang.getMapSubAreaText(this._nSubAreaId).a)).n);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nSubAreaId);
    };
    _loc1.__get__areaId = function ()
    {
        return (Number(_global.API.lang.getMapSubAreaText(this._nSubAreaId).a));
    };
    _loc1.__get__alignment = function ()
    {
        return (this._nAlignment);
    };
    _loc1.__get__door = function ()
    {
        return (this._bDoor);
    };
    _loc1.__get__prism = function ()
    {
        return (this._bPrism);
    };
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("prism", _loc1.__get__prism, function ()
    {
    });
    _loc1.addProperty("areaId", _loc1.__get__areaId, function ()
    {
    });
    _loc1.addProperty("door", _loc1.__get__door, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
