// Action script...

// [Initial MovieClip Action of sprite 926]
#initclip 138
class ank.utils.Crypt
{
    function Crypt()
    {
    } // End of the function
    static function cryptPassword(pwd, key)
    {
        pwd = pwd + "\n";
        var _loc6 = pwd.length;
        var _loc7 = key.length;
        var _loc2 = "";
        for (var _loc1 = 0; _loc1 < _loc7; ++_loc1)
        {
            _loc2 = _loc2 + ank.utils.Crypt.HASH[(pwd.charCodeAt(_loc1 % _loc6) ^ key.charCodeAt(_loc1 % 32)) % 64];
        } // end of for
        var _loc4 = _loc2.length;
        pwd = _loc2;
        _loc2 = "";
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            _loc2 = _loc2 + ank.utils.Crypt.HASH[(pwd.charCodeAt(_loc4 - _loc1 - 1) ^ key.charCodeAt((_loc1 + 8) % 32)) % 64];
        } // end of for
        return (_loc2);
    } // End of the function
    static var HASH = new Array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "_");
} // End of Class
#endinitclip
