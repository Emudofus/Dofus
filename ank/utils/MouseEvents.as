// Action script...

// [Initial MovieClip Action of sprite 20837]
#initclip 102
if (!ank.utils.MouseEvents)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.MouseEvents = function ()
    {
    }).prototype;
    (_global.ank.utils.MouseEvents = function ()
    {
    }).addListener = function (oListener)
    {
        Mouse.addListener(oListener);
        ank.utils.MouseEvents.garbageCollector();
    };
    (_global.ank.utils.MouseEvents = function ()
    {
    }).garbageCollector = function ()
    {
        var _loc2 = Mouse._listeners;
        var _loc3 = _loc2.length;
        
        while (--_loc3, _loc3 >= 0)
        {
            var _loc4 = _loc2[_loc3];
            if (_loc4 == undefined || _loc4._target == undefined)
            {
                _loc2.splice(_loc3, 1);
            } // end if
        } // end while
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
