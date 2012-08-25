// Action script...

// [Initial MovieClip Action of sprite 20577]
#initclip 98
if (!dofus.graphics.gapi.ui.inventory.ContainerBackground)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.inventory.ContainerBackground = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.inventory.ContainerBackground.CLASS_NAME);
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
        this._mcBg._width = this.__width - this._mcR._width;
        this._mcBg._height = this.__height - this._mcB._height;
        this._mcBg._x = this._mcL._width;
        this._mcBg._y = this._mcT._height;
        this._mcL._height = this._mcR._height = this.__height;
        this._mcT._width = this._mcB._width = this.__width;
        this._mcL._x = this._mcT._x = this._mcL._y = this._mcT._y = this._mcB._x = this._mcR._y = 0;
        this._mcB._y = this.__height - this._mcL._width;
        this._mcR._x = this.__width - this._mcR._width;
        this._mcTL._x = this._mcTL._y = this._mcBL._x = this._mcTR._y = 0;
        this._mcTR._x = this._mcBR._x = this.__width - (this._mcL._width + this._mcR._width) / 2;
        this._mcBR._y = this._mcBL._y = this.__height - (this._mcB._height + this._mcT._height) / 2;
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.inventory.ContainerBackground = function ()
    {
        super();
    }).CLASS_NAME = "ContainerBackground";
} // end if
#endinitclip
