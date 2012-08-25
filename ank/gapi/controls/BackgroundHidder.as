// Action script...

// [Initial MovieClip Action of sprite 20757]
#initclip 22
if (!ank.gapi.controls.BackgroundHidder)
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
    var _loc1 = (_global.ank.gapi.controls.BackgroundHidder = function ()
    {
        super();
    }).prototype;
    _loc1.__set__handCursor = function (bHandCursor)
    {
        this.useHandCursor = bHandCursor;
        //return (this.handCursor());
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.BackgroundHidder.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("hidden_mc", 10);
        this.onRelease = function ()
        {
            this.dispatchEvent({type: "click"});
        };
    };
    _loc1.arrange = function ()
    {
        this.hidden_mc._width = this.__width;
        this.hidden_mc._height = this.__height;
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        var _loc3 = _loc2.backgroundcolor == undefined ? (0) : (_loc2.backgroundcolor);
        var _loc4 = _loc2.backgroundalpha == undefined ? (10) : (_loc2.backgroundalpha);
        this.hidden_mc.clear();
        this.drawRoundRect(this.hidden_mc, 0, 0, 1, 1, 0, _loc3, _loc4);
    };
    _loc1.addProperty("handCursor", function ()
    {
    }, _loc1.__set__handCursor);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.BackgroundHidder = function ()
    {
        super();
    }).CLASS_NAME = "BackgroundHidder";
} // end if
#endinitclip
