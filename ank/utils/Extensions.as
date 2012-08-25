// Action script...

// [Initial MovieClip Action of sprite 20508]
#initclip 29
if (!ank.utils.Extensions)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.Extensions = function ()
    {
    }).prototype;
    (_global.ank.utils.Extensions = function ()
    {
    }).addExtensions = function ()
    {
        if (ank.utils.Extensions.bExtended == true)
        {
            return (true);
        } // end if
        var _loc2 = ank.utils.extensions.MovieClipExtensions.prototype;
        var _loc3 = MovieClip.prototype;
        _loc3.attachClassMovie = _loc2.attachClassMovie;
        _loc3.alignOnPixel = _loc2.alignOnPixel;
        _loc3.playFirstChildren = _loc2.playFirstChildren;
        _loc3.getFirstParentProperty = _loc2.getFirstParentProperty;
        _loc3.getActionClip = _loc2.getActionClip;
        _loc3.end = _loc2.end;
        _loc3.playAll = _loc2.playAll;
        _loc3.stopAll = _loc2.stopAll;
        ank.utils.Extensions.bExtended = true;
        return (true);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.Extensions = function ()
    {
    }).bExtended = false;
} // end if
#endinitclip
