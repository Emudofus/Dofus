// Action script...

// [Initial MovieClip Action of sprite 20914]
#initclip 179
if (!dofus.datacenter.ConquestWorldData)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ConquestWorldData = function ()
    {
        super();
    }).prototype;
    _loc1.__get__ownedAreas = function ()
    {
        return (this._nOwnedAreas);
    };
    _loc1.__set__ownedAreas = function (value)
    {
        this._nOwnedAreas = value;
        //return (this.ownedAreas());
    };
    _loc1.__get__totalAreas = function ()
    {
        return (this._nTotalAreas);
    };
    _loc1.__set__totalAreas = function (value)
    {
        this._nTotalAreas = value;
        //return (this.totalAreas());
    };
    _loc1.__get__possibleAreas = function ()
    {
        return (this._nPossibleAreas);
    };
    _loc1.__set__possibleAreas = function (value)
    {
        this._nPossibleAreas = value;
        //return (this.possibleAreas());
    };
    _loc1.__get__areas = function ()
    {
        return (this._aAreas);
    };
    _loc1.__set__areas = function (value)
    {
        this._aAreas = value;
        //return (this.areas());
    };
    _loc1.__get__ownedVillages = function ()
    {
        return (this._nOwnedVillages);
    };
    _loc1.__set__ownedVillages = function (value)
    {
        this._nOwnedVillages = value;
        //return (this.ownedVillages());
    };
    _loc1.__get__totalVillages = function ()
    {
        return (this._nTotalVillages);
    };
    _loc1.__set__totalVillages = function (value)
    {
        this._nTotalVillages = value;
        //return (this.totalVillages());
    };
    _loc1.__get__villages = function ()
    {
        return (this._aVillages);
    };
    _loc1.__set__villages = function (value)
    {
        this._aVillages = value;
        //return (this.villages());
    };
    _loc1.addProperty("villages", _loc1.__get__villages, _loc1.__set__villages);
    _loc1.addProperty("ownedVillages", _loc1.__get__ownedVillages, _loc1.__set__ownedVillages);
    _loc1.addProperty("ownedAreas", _loc1.__get__ownedAreas, _loc1.__set__ownedAreas);
    _loc1.addProperty("areas", _loc1.__get__areas, _loc1.__set__areas);
    _loc1.addProperty("totalAreas", _loc1.__get__totalAreas, _loc1.__set__totalAreas);
    _loc1.addProperty("possibleAreas", _loc1.__get__possibleAreas, _loc1.__set__possibleAreas);
    _loc1.addProperty("totalVillages", _loc1.__get__totalVillages, _loc1.__set__totalVillages);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
