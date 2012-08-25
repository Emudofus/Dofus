// Action script...

// [Initial MovieClip Action of sprite 20657]
#initclip 178
if (!dofus.graphics.battlefield.SmileyOverHead)
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
    var _loc1 = (_global.dofus.graphics.battlefield.SmileyOverHead = function (nSmileyID)
    {
        super();
        this.draw(nSmileyID);
    }).prototype;
    _loc1.__get__height = function ()
    {
        return (20);
    };
    _loc1.__get__width = function ()
    {
        return (20);
    };
    _loc1.draw = function (nSmileyID)
    {
        this.attachMovie("Loader", "_ldrSmiley", 10, {_x: -10, _width: 20, _height: 20, scaleContent: true, contentPath: dofus.Constants.SMILEYS_ICONS_PATH + nSmileyID + ".swf"});
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
