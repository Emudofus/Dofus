// Action script...

// [Initial MovieClip Action of sprite 20611]
#initclip 132
if (!dofus.datacenter.JobOptions)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.JobOptions = function (nParams, nMinSlot, nMaxSlot)
    {
        super();
        this._nParams = nParams;
        this._nMinSlot = nMinSlot > 1 ? (nMinSlot) : (2);
        this._nMaxSlot = nMaxSlot;
    }).prototype;
    _loc1.__get__isNotFree = function ()
    {
        return ((this._nParams & 1) == 1);
    };
    _loc1.__get__isFreeIfFailed = function ()
    {
        return ((this._nParams & 2) == 2);
    };
    _loc1.__get__ressourcesNeeded = function ()
    {
        return ((this._nParams & 4) == 4);
    };
    _loc1.__get__minSlots = function ()
    {
        return (this._nMinSlot);
    };
    _loc1.__get__maxSlots = function ()
    {
        return (this._nMaxSlot);
    };
    _loc1.addProperty("minSlots", _loc1.__get__minSlots, function ()
    {
    });
    _loc1.addProperty("ressourcesNeeded", _loc1.__get__ressourcesNeeded, function ()
    {
    });
    _loc1.addProperty("isNotFree", _loc1.__get__isNotFree, function ()
    {
    });
    _loc1.addProperty("maxSlots", _loc1.__get__maxSlots, function ()
    {
    });
    _loc1.addProperty("isFreeIfFailed", _loc1.__get__isFreeIfFailed, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
