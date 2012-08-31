// Action script...

// [Initial MovieClip Action of sprite 170]
#initclip 18
class ank.utils.MouseEvents
{
    function MouseEvents()
    {
    } // End of the function
    static function addListener(oListener)
    {
        Mouse.addListener(oListener);
        ank.utils.MouseEvents.garbageCollector();
    } // End of the function
    static function garbageCollector()
    {
        var _loc3 = Mouse._listeners;
        for (var _loc1 = _loc3.length; _loc1 >= 0; --_loc1)
        {
            var _loc2 = _loc3[_loc1];
            if (_loc2 == undefined || _loc2._target == undefined)
            {
                _loc3.splice(_loc1, 1);
            } // end if
        } // end of for
    } // End of the function
} // End of Class
#endinitclip
