// Action script...

// [Initial MovieClip Action of sprite 20601]
#initclip 122
if (!ank.gapi.controls.common.DefaultBackground)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    if (!ank.gapi.controls.common)
    {
        _global.ank.gapi.controls.common = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.common.DefaultBackground = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.common.DefaultBackground.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this.draw();
    };
    _loc1.draw = function ()
    {
        this.drawBorder();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.common.DefaultBackground = function ()
    {
        super();
    }).CLASS_NAME = "DefaultBackground";
} // end if
#endinitclip
