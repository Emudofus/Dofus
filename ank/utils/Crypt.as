// Action script...

// [Initial MovieClip Action of sprite 20563]
#initclip 84
if (!ank.utils.Crypt)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.Crypt = function ()
    {
    }).prototype;
    (_global.ank.utils.Crypt = function ()
    {
    }).cryptPassword = function (pwd, key)
    {
        var _loc4 = "#1";
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < pwd.length)
        {
            var _loc6 = pwd.charCodeAt(_loc5);
            var _loc7 = key.charCodeAt(_loc5);
            var _loc8 = Math.floor(_loc6 / 16);
            var _loc9 = _loc6 % 16;
            _loc4 = _loc4 + (ank.utils.Crypt.HASH[(_loc8 + _loc7 % ank.utils.Crypt.HASH.length) % ank.utils.Crypt.HASH.length] + ank.utils.Crypt.HASH[(_loc9 + _loc7 % ank.utils.Crypt.HASH.length) % ank.utils.Crypt.HASH.length]);
        } // end while
        return (_loc4);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.Crypt = function ()
    {
    }).HASH = new Array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "_");
} // end if
#endinitclip
