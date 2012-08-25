// Action script...

// [Initial MovieClip Action of sprite 20547]
#initclip 68
if (!dofus.graphics.gapi.ui.inventory.ContainerHighlight)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui.inventory)
    {
        _global.dofus.graphics.gapi.ui.inventory = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.inventory.ContainerHighlight = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.inventory.ContainerHighlight.CLASS_NAME);
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
        this._mcBg._width = this.__width;
        this._mcBg._height = this.__height;
        this._mcL._height = this._mcR._height = this.__height;
        this._mcT._width = this._mcB._width = this.__width;
        this._mcL._x = this._mcT._x = this._mcL._y = this._mcT._y = this._mcB._x = this._mcR._y = 0;
        this._mcB._y = this.__height - this._mcL._width;
        this._mcR._x = this.__width - this._mcR._width;
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.inventory.ContainerHighlight = function ()
    {
        super();
    }).CLASS_NAME = "ContainerHighlight";
} // end if
#endinitclip
