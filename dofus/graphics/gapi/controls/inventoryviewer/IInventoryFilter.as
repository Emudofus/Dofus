// Action script...

// [Initial MovieClip Action of sprite 20559]
#initclip 80
if (!dofus.graphics.gapi.controls.inventoryviewer.IInventoryFilter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls.inventoryviewer)
    {
        _global.dofus.graphics.gapi.controls.inventoryviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.inventoryviewer.IInventoryFilter = function ()
    {
    }).prototype;
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
