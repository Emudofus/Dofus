// Action script...

// [Initial MovieClip Action of sprite 20969]
#initclip 234
if (!dofus.graphics.battlefield.CraftResultOverHead)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.battlefield)
    {
        _global.dofus.graphics.battlefield = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.battlefield.CraftResultOverHead = function (bAdd, oItem)
    {
        super();
        this.initialize();
        this.draw(bAdd, oItem);
    }).prototype;
    _loc1.__get__height = function ()
    {
        return (33);
    };
    _loc1.__get__width = function ()
    {
        return (62);
    };
    _loc1.initialize = function ()
    {
        this.attachMovie("CraftResultOverHeadBubble", "_mcBack", 10);
    };
    _loc1.reverseClip = function ()
    {
        this._mcBack._yscale = -100;
        this._mcBack._y = this._mcBack._y + (this._mcBack._height - 7);
    };
    _loc1.draw = function (bAdd, oItem)
    {
        if (oItem == undefined)
        {
            this.attachMovie("CraftResultOverHeadCross", "_mcCross", 40);
            this._ldrItem.removeMovieClip();
        }
        else
        {
            this.attachMovie("Loader", "_ldrItem", 20, {_x: 6, _y: 4, _width: 20, _height: 20, scaleContent: true, contentPath: oItem.iconFile});
            this._mcCross.removeMovieClip();
        } // end else if
        if (!bAdd)
        {
            this.attachMovie("CraftResultOverHeadMiss", "_mcMiss", 30);
        }
        else
        {
            this._mcMiss.removeMovieClip();
        } // end else if
    };
    _loc1.addProperty("width", _loc1.__get__width, function ()
    {
    });
    _loc1.addProperty("height", _loc1.__get__height, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
