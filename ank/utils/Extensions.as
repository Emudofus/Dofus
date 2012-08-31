// Action script...

// [Initial MovieClip Action of sprite 817]
#initclip 26
class ank.utils.Extensions
{
    function Extensions()
    {
    } // End of the function
    static function addExtensions()
    {
        if (ank.utils.Extensions.bExtended == true)
        {
            return (true);
        } // end if
        var _loc2 = ank.utils.extensions.MovieClipExtensions.prototype;
        var _loc1 = MovieClip.prototype;
        _loc1.attachClassMovie = _loc2.attachClassMovie;
        _loc1.alignOnPixel = _loc2.alignOnPixel;
        _loc1.playFirstChildren = _loc2.playFirstChildren;
        _loc1.getFirstParentProperty = _loc2.getFirstParentProperty;
        _loc1.getActionClip = _loc2.getActionClip;
        _loc1.end = _loc2.end;
        var _loc4 = ank.utils.extensions.StringExtensions.prototype;
        var _loc3 = String.prototype;
        _loc3.replace = _loc4.replace;
        _loc3.addLeftChar = _loc4.addLeftChar;
        _loc3.addMiddleChar = _loc4.addMiddleChar;
        bExtended = true;
        return (true);
    } // End of the function
    static var bExtended = false;
} // End of Class
#endinitclip
