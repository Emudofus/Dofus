// Action script...

// [Initial MovieClip Action of sprite 20537]
#initclip 58
if (!ank.gapi.controls.StylizedRectangle)
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
    var _loc1 = (_global.ank.gapi.controls.StylizedRectangle = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.StylizedRectangle.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcBackground", 10);
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        if (this._bInitialized)
        {
            this.draw();
        } // end if
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        var _loc3 = _loc2.cornerradius;
        var _loc4 = _loc2.bgcolor;
        var _loc5 = _loc2.alpha;
        this._mcBackground.clear();
        this.drawRoundRect(this._mcBackground, 0, 0, this.__width, this.__height, _loc3, _loc4, _loc5);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.StylizedRectangle = function ()
    {
        super();
    }).CLASS_NAME = "StylizedRectangle";
} // end if
#endinitclip
