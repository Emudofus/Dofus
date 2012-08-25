// Action script...

// [Initial MovieClip Action of sprite 20743]
#initclip 8
if (!dofus.datacenter.FeatEffect)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.FeatEffect = function (nIndex, aParams)
    {
        super();
        this.api = _global.API;
        this.initialize(nIndex, aParams);
    }).prototype;
    _loc1.__get__index = function ()
    {
        return (this._nIndex);
    };
    _loc1.__set__index = function (nIndex)
    {
        this._nIndex = nIndex;
        //return (this.index());
    };
    _loc1.__get__description = function ()
    {
        return (ank.utils.PatternDecoder.getDescription(this._sFeatEffectInfos, this._aParams));
    };
    _loc1.__set__params = function (aParams)
    {
        this._aParams = aParams;
        //return (this.params());
    };
    _loc1.__get__params = function ()
    {
        return (this._aParams);
    };
    _loc1.initialize = function (nIndex, aParams)
    {
        this._nIndex = nIndex;
        this._aParams = aParams;
        this._sFeatEffectInfos = this.api.lang.getAlignmentFeatEffect(nIndex);
    };
    _loc1.addProperty("params", _loc1.__get__params, _loc1.__set__params);
    _loc1.addProperty("index", _loc1.__get__index, _loc1.__set__index);
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
