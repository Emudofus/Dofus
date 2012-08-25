// Action script...

// [Initial MovieClip Action of sprite 20942]
#initclip 207
if (!ank.gapi.controls.common.DefaultHighlight)
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
    var _loc1 = (_global.ank.gapi.controls.common.DefaultHighlight = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.common.DefaultHighlight.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcHighlight", 10);
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this._mcHighlight._width = this.__width;
        this._mcHighlight._height = this.__height;
    };
    _loc1.draw = function ()
    {
        this.drawRoundRect(this._mcHighlight, 0, 0, 1, 1, 0, 0, 50);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.common.DefaultHighlight = function ()
    {
        super();
    }).CLASS_NAME = "DefaultHighlight";
} // end if
#endinitclip
