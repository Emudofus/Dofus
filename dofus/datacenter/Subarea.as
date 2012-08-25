// Action script...

// [Initial MovieClip Action of sprite 20654]
#initclip 175
if (!dofus.datacenter.Subarea)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Subarea = function (nID, nAlignment)
    {
        super();
        this.api = _global.API;
        this.initialize(nID, nAlignment);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__alignment = function ()
    {
        return (this._oAlignment);
    };
    _loc1.__set__alignment = function (oAlignment)
    {
        this._oAlignment = oAlignment;
        //return (this.alignment());
    };
    _loc1.__get__name = function ()
    {
        return (String(this.api.lang.getMapSubAreaText(this._nID).n).substr(0, 2) == "//" ? (String(this.api.lang.getMapSubAreaText(this._nID).n).substr(2)) : (this.api.lang.getMapSubAreaText(this._nID).n));
    };
    _loc1.__get__color = function ()
    {
        return (dofus.Constants.AREA_ALIGNMENT_COLOR[this._oAlignment.index]);
    };
    _loc1.initialize = function (nID, nAlignment)
    {
        this._nID = nID;
        this._oAlignment = new dofus.datacenter.Alignment(nAlignment);
    };
    _loc1.addProperty("alignment", _loc1.__get__alignment, _loc1.__set__alignment);
    _loc1.addProperty("color", _loc1.__get__color, function ()
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
