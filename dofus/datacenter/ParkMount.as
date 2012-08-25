// Action script...

// [Initial MovieClip Action of sprite 20697]
#initclip 218
if (!dofus.datacenter.ParkMount)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ParkMount = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID, nModelID)
    {
        super();
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
        this.modelID = nModelID;
        this._lang = _global.API.lang.getMountText(nModelID);
    }).prototype;
    _loc1.__get__color1 = function ()
    {
        return (this._lang.c1);
    };
    _loc1.__get__color2 = function ()
    {
        return (this._lang.c2);
    };
    _loc1.__get__color3 = function ()
    {
        return (this._lang.c3);
    };
    _loc1.__get__modelName = function ()
    {
        return (this._lang.n);
    };
    _loc1.addProperty("modelName", _loc1.__get__modelName, function ()
    {
    });
    _loc1.addProperty("color2", _loc1.__get__color2, function ()
    {
    });
    _loc1.addProperty("color3", _loc1.__get__color3, function ()
    {
    });
    _loc1.addProperty("color1", _loc1.__get__color1, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
