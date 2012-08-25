// Action script...

// [Initial MovieClip Action of sprite 20567]
#initclip 88
if (!ank.battlefield.datacenter.VisualEffect)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.datacenter)
    {
        _global.ank.battlefield.datacenter = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.datacenter.VisualEffect = function ()
    {
        super();
    }).prototype;
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
