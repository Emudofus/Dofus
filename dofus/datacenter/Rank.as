// Action script...

// [Initial MovieClip Action of sprite 20739]
#initclip 4
if (!dofus.datacenter.Rank)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Rank = function (nValue, nHonour, nDisgrace, bEnabled)
    {
        super();
        this.api = _global.API;
        this.initialize(nValue, nHonour, nDisgrace, bEnabled);
    }).prototype;
    _loc1.__get__value = function ()
    {
        return (this._nValue);
    };
    _loc1.__set__value = function (v)
    {
        this._nValue = v;
        //return (this.value());
    };
    _loc1.__get__honour = function ()
    {
        return (this._nHonour);
    };
    _loc1.__set__honour = function (v)
    {
        this._nHonour = v;
        //return (this.honour());
    };
    _loc1.__get__disgrace = function ()
    {
        return (this._nDisgrace);
    };
    _loc1.__set__disgrace = function (v)
    {
        this._nDisgrace = v;
        //return (this.disgrace());
    };
    _loc1.__get__enable = function ()
    {
        return (this._bEnabled);
    };
    _loc1.__set__enable = function (v)
    {
        this._bEnabled = v;
        //return (this.enable());
    };
    _loc1.initialize = function (nValue, nHonour, nDisgrace, bEnabled)
    {
        this._nValue = _global.isNaN(nValue) || nValue == undefined ? (0) : (nValue);
        this._nHonour = _global.isNaN(nHonour) || nHonour == undefined ? (0) : (nHonour);
        this._nDisgrace = _global.isNaN(nDisgrace) || nDisgrace == undefined ? (0) : (nDisgrace);
        this._bEnabled = bEnabled == undefined ? (false) : (bEnabled);
    };
    _loc1.clone = function ()
    {
        return (new dofus.datacenter.Rank(this._nValue, this._nHonour, this._nDisgrace, this._bEnabled));
    };
    _loc1.addProperty("honour", _loc1.__get__honour, _loc1.__set__honour);
    _loc1.addProperty("value", _loc1.__get__value, _loc1.__set__value);
    _loc1.addProperty("disgrace", _loc1.__get__disgrace, _loc1.__set__disgrace);
    _loc1.addProperty("enable", _loc1.__get__enable, _loc1.__set__enable);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
