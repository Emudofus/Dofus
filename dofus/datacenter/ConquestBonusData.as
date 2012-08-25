// Action script...

// [Initial MovieClip Action of sprite 20616]
#initclip 137
if (!dofus.datacenter.ConquestBonusData)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ConquestBonusData = function (xp, drop, recolte)
    {
        super();
        this._nXp = xp;
        this._nDrop = drop;
        this._nRecolte = recolte;
    }).prototype;
    _loc1.__get__xp = function ()
    {
        return (this._nXp);
    };
    _loc1.__set__xp = function (value)
    {
        this._nXp = value;
        //return (this.xp());
    };
    _loc1.__get__drop = function ()
    {
        return (this._nDrop);
    };
    _loc1.__set__drop = function (value)
    {
        this._nDrop = value;
        //return (this.drop());
    };
    _loc1.__get__recolte = function ()
    {
        return (this._nRecolte);
    };
    _loc1.__set__recolte = function (value)
    {
        this._nRecolte = value;
        //return (this.recolte());
    };
    _loc1.addProperty("drop", _loc1.__get__drop, _loc1.__set__drop);
    _loc1.addProperty("xp", _loc1.__get__xp, _loc1.__set__xp);
    _loc1.addProperty("recolte", _loc1.__get__recolte, _loc1.__set__recolte);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
