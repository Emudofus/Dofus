// Action script...

// [Initial MovieClip Action of sprite 20669]
#initclip 190
if (!ank.battlefield.TextHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.TextHandler = function (b, c, d)
    {
        this.initialize(b, c, d);
    }).prototype;
    _loc1.initialize = function (b, c, d)
    {
        this._mcBattlefield = b;
        this._mcContainer = c;
        this._oDatacenter = d;
    };
    _loc1.clear = function ()
    {
        for (var k in this._mcContainer)
        {
            this._mcContainer[k].removeMovieClip();
        } // end of for...in
    };
    _loc1.addBubble = function (sID, nX, nY, sText, type)
    {
        var _loc7 = (this._oDatacenter.Map.width - 1) * ank.battlefield.Constants.CELL_WIDTH;
        this.removeBubble(sID);
        var _loc8 = this._mcContainer.attachClassMovie(type == ank.battlefield.TextHandler.BUBBLE_TYPE_THINK ? (ank.battlefield.mc.BubbleThink) : (ank.battlefield.mc.Bubble), "bubble" + sID, this._mcContainer.getNextHighestDepth(), [sText, nX, nY, _loc7]);
        var _loc9 = this._mcBattlefield.getZoom();
        if (_loc9 < 100)
        {
            _loc8._xscale = _loc8._yscale = 10000 / _loc9;
        } // end if
    };
    _loc1.removeBubble = function (sID)
    {
        var _loc3 = this._mcContainer["bubble" + sID];
        _loc3.remove();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.battlefield.TextHandler = function (b, c, d)
    {
        this.initialize(b, c, d);
    }).BUBBLE_TYPE_CHAT = 1;
    (_global.ank.battlefield.TextHandler = function (b, c, d)
    {
        this.initialize(b, c, d);
    }).BUBBLE_TYPE_THINK = 2;
} // end if
#endinitclip
