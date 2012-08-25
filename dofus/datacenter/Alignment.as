// Action script...

// [Initial MovieClip Action of sprite 20572]
#initclip 93
if (!dofus.datacenter.Alignment)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Alignment = function (nIndex, nValue)
    {
        this.api = _global.API;
        this.initialize(nIndex, nValue);
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
        if (this._nIndex == -1)
        {
            return ("");
        } // end if
        return (this.api.lang.getAlignment(this._nIndex).n);
    };
    _loc1.__get__value = function ()
    {
        return (this._nValue);
    };
    _loc1.__set__value = function (nValue)
    {
        this._nValue = _global.isNaN(nValue) || nValue == undefined ? (0) : (nValue);
        //return (this.value());
    };
    _loc1.__get__frame = function ()
    {
        if (this._nValue <= 20)
        {
            return (1);
        }
        else if (this._nValue <= 40)
        {
            return (2);
        }
        else if (this._nValue <= 60)
        {
            return (3);
        }
        else if (this._nValue <= 80)
        {
            return (4);
        }
        else
        {
            return (5);
        } // end else if
    };
    _loc1.__get__iconFile = function ()
    {
        return (dofus.Constants.ALIGNMENTS_PATH + this._nIndex + ".swf");
    };
    _loc1.initialize = function (nIndex, nValue)
    {
        this._nIndex = _global.isNaN(nIndex) || nIndex == undefined ? (0) : (nIndex);
        this._nValue = _global.isNaN(nValue) || nValue == undefined ? (0) : (nValue);
    };
    _loc1.clone = function ()
    {
        return (new dofus.datacenter.Alignment(this._nIndex, this._nValue));
    };
    _loc1.compareTo = function (obj)
    {
        var _loc3 = (dofus.datacenter.Alignment)(obj);
        if (_loc3.index == this._nIndex)
        {
            return (0);
        } // end if
        return (-1);
    };
    _loc1.addProperty("frame", _loc1.__get__frame, function ()
    {
    });
    _loc1.addProperty("value", _loc1.__get__value, _loc1.__set__value);
    _loc1.addProperty("iconFile", _loc1.__get__iconFile, function ()
    {
    });
    _loc1.addProperty("index", _loc1.__get__index, _loc1.__set__index);
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1.fallenAngelDemon = false;
} // end if
#endinitclip
