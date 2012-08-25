// Action script...

// [Initial MovieClip Action of sprite 20676]
#initclip 197
if (!com.ankamagames.types.Point)
{
    if (!com)
    {
        _global.com = new Object();
    } // end if
    if (!com.ankamagames)
    {
        _global.com.ankamagames = new Object();
    } // end if
    if (!com.ankamagames.types)
    {
        _global.com.ankamagames.types = new Object();
    } // end if
    var _loc1 = (_global.com.ankamagames.types.Point = function (x, y)
    {
        this.x = x;
        this.y = y;
    }).prototype;
    _loc1.toString = function ()
    {
        return (this.x + ";" + this.y);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
