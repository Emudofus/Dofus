// Action script...

// [Initial MovieClip Action of sprite 20670]
#initclip 191
if (!dofus.datacenter.Accessory)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Accessory = function (nUnicID, nType, nFrame)
    {
        super();
        this.api = _global.API;
        this.initialize(nUnicID, nType, nFrame);
    }).prototype;
    _loc1.__get__unicID = function ()
    {
        return (this._nUnicID);
    };
    _loc1.__get__type = function ()
    {
        if (this._nType != undefined)
        {
            return (this._nType);
        } // end if
        return (this._oItemText.t);
    };
    _loc1.__get__gfxID = function ()
    {
        return (this._oItemText.g);
    };
    _loc1.__get__gfx = function ()
    {
        return (this.type + "_" + this.gfxID);
    };
    _loc1.__get__frame = function ()
    {
        return (this._nFrame);
    };
    _loc1.initialize = function (nUnicID, nType, nFrame)
    {
        this._nUnicID = nUnicID;
        if (nFrame != undefined)
        {
            this._nFrame = nFrame;
        } // end if
        if (nType != undefined)
        {
            this._nType = nType;
        } // end if
        this._oItemText = this.api.lang.getItemUnicText(nUnicID);
    };
    _loc1.addProperty("unicID", _loc1.__get__unicID, function ()
    {
    });
    _loc1.addProperty("type", _loc1.__get__type, function ()
    {
    });
    _loc1.addProperty("frame", _loc1.__get__frame, function ()
    {
    });
    _loc1.addProperty("gfx", _loc1.__get__gfx, function ()
    {
    });
    _loc1.addProperty("gfxID", _loc1.__get__gfxID, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
