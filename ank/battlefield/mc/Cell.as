// Action script...

// [Initial MovieClip Action of sprite 20861]
#initclip 126
if (!ank.battlefield.mc.Cell)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.mc)
    {
        _global.ank.battlefield.mc = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.mc.Cell = function ()
    {
        super();
    }).prototype;
    _loc1.__get__num = function ()
    {
        return (this.data.num);
    };
    _loc1.initialize = function (b)
    {
        this._mcBattlefield = b;
    };
    _loc1._release = function (Void)
    {
        this._mcBattlefield.onCellRelease(this);
    };
    _loc1._rollOver = function (Void)
    {
        this._mcBattlefield.onCellRollOver(this);
    };
    _loc1._rollOut = function (Void)
    {
        this._mcBattlefield.onCellRollOut(this);
    };
    _loc1.addProperty("num", _loc1.__get__num, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
