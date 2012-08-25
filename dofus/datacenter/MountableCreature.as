// Action script...

// [Initial MovieClip Action of sprite 20891]
#initclip 156
if (!dofus.datacenter.MountableCreature)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.MountableCreature = function (sGfxFile, nGfxID)
    {
        this.initialize(sGfxFile, nGfxID);
    }).prototype;
    _loc1.__get__gfxFile = function ()
    {
        return (this._sGfxFile);
    };
    _loc1.initialize = function (sGfxFile, nGfxID)
    {
        this._sGfxFile = sGfxFile;
        this._nGfxID = nGfxID;
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.addProperty("gfxFile", _loc1.__get__gfxFile, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
