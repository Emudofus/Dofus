// Action script...

// [Initial MovieClip Action of sprite 20581]
#initclip 102
if (!dofus.datacenter.Order)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Order = function (nIndex)
    {
        super();
        this.api = _global.API;
        this.initialize(nIndex);
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
        return (this._oOrderInfos.n);
    };
    _loc1.__get__alignment = function ()
    {
        return (new dofus.datacenter.Alignment(this._oOrderInfos.a));
    };
    _loc1.__get__iconFile = function ()
    {
        return (dofus.Constants.ORDERS_PATH + this._nIndex + ".swf");
    };
    _loc1.initialize = function (nIndex)
    {
        this._nIndex = nIndex;
        this._oOrderInfos = this.api.lang.getAlignmentOrder(nIndex);
    };
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("index", _loc1.__get__index, _loc1.__set__index);
    _loc1.addProperty("iconFile", _loc1.__get__iconFile, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
