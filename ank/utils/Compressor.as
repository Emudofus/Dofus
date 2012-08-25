// Action script...

// [Initial MovieClip Action of sprite 20808]
#initclip 73
if (!ank.utils.Compressor)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.Compressor = function ()
    {
        this.initialize();
    }).prototype;
    _loc1.initialize = function ()
    {
        var _loc2 = ank.utils.Compressor.ZKARRAY.length - 1;
        this._hashCodes = new Object();
        while (_loc2 >= 0)
        {
            this._hashCodes[ank.utils.Compressor.ZKARRAY[_loc2]] = _loc2;
            --_loc2;
        } // end while
    };
    (_global.ank.utils.Compressor = function ()
    {
        this.initialize();
    }).decode64 = function (codedValue)
    {
        return (ank.utils.Compressor._self._hashCodes[codedValue]);
    };
    (_global.ank.utils.Compressor = function ()
    {
        this.initialize();
    }).encode64 = function (value)
    {
        return (ank.utils.Compressor.ZKARRAY[value]);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.Compressor = function ()
    {
        this.initialize();
    }).ZIPKEY = new Array("_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i", "_j", "_k", "_l", "_m", "_n", "_o", "_p", "_q", "_r", "_s", "_t", "_u", "_v", "_w", "_x", "_y", "_z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "_", _global.ank.utils.Compressor = function ()
    {
        this.initialize();
    }).ZKARRAY = new Array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "_", _global.ank.utils.Compressor = function ()
    {
        this.initialize();
    })._self = new ank.utils.Compressor();
} // end if
#endinitclip
