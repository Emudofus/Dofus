// Action script...

// [Initial MovieClip Action of sprite 20706]
#initclip 227
if (!ank.battlefield.datacenter.Map)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.datacenter)
    {
        _global.ank.battlefield.datacenter = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.datacenter.Map = function (nID)
    {
        super();
        this.initialize(nID);
    }).prototype;
    _loc1.initialize = function (nID)
    {
        this.id = nID;
        this.originalsCellsBackup = new ank.utils.ExtendedObject();
    };
    _loc1.cleanSpritesOn = function ()
    {
        if (this.data != undefined)
        {
            for (var k in this.data)
            {
                this.data[k].removeAllSpritesOnID();
            } // end of for...in
        } // end if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
