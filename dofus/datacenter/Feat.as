// Action script...

// [Initial MovieClip Action of sprite 20859]
#initclip 124
if (!dofus.datacenter.Feat)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Feat = function (nIndex, nLevel, aParams)
    {
        super();
        this.api = _global.API;
        this.initialize(nIndex, nLevel, aParams);
    }).prototype;
    _loc1.__get__index = function ()
    {
        return (this._nIndex);
    };
    _loc1.__set__index = function (nIndex)
    {
        this._nIndex = _global.isNaN(nIndex) || nIndex == undefined ? (0) : (nIndex);
        //return (this.index());
    };
    _loc1.__get__name = function ()
    {
        return (this._oFeatInfos.n);
    };
    _loc1.__get__level = function ()
    {
        return (this._nLevel);
    };
    _loc1.__get__effect = function ()
    {
        return (new dofus.datacenter.FeatEffect(this._oFeatInfos.e, this._aParams));
    };
    _loc1.__get__iconFile = function ()
    {
        return (dofus.Constants.FEATS_PATH + this._oFeatInfos.g + ".swf");
    };
    _loc1.initialize = function (nIndex, nLevel, aParams)
    {
        this._nIndex = nIndex;
        this._nLevel = nLevel;
        this._aParams = aParams;
        this._oFeatInfos = this.api.lang.getAlignmentFeat(nIndex);
    };
    _loc1.addProperty("level", _loc1.__get__level, function ()
    {
    });
    _loc1.addProperty("index", _loc1.__get__index, _loc1.__set__index);
    _loc1.addProperty("iconFile", _loc1.__get__iconFile, function ()
    {
    });
    _loc1.addProperty("effect", _loc1.__get__effect, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
