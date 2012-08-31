// Action script...

// [Initial MovieClip Action of sprite 859]
#initclip 71
class ank.utils.Compressor
{
    var _hashCodes;
    function Compressor()
    {
        this.initialize();
    } // End of the function
    function initialize()
    {
        var _loc2 = ank.utils.Compressor.ZKARRAY.length - 1;
        _hashCodes = new Object();
        while (_loc2 >= 0)
        {
            _hashCodes[ank.utils.Compressor.ZKARRAY[_loc2]] = _loc2;
            --_loc2;
        } // end while
    } // End of the function
    static function decode64(codedValue)
    {
        return (ank.utils.Compressor._self._hashCodes[codedValue]);
    } // End of the function
    static function encode64(value)
    {
        return (ank.utils.Compressor.ZKARRAY[value]);
    } // End of the function
    static var ZIPKEY = new Array("_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i", "_j", "_k", "_l", "_m", "_n", "_o", "_p", "_q", "_r", "_s", "_t", "_u", "_v", "_w", "_x", "_y", "_z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "_");
    static var ZKARRAY = new Array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "_");
    static var _self = new ank.utils.Compressor();
} // End of Class
#endinitclip
