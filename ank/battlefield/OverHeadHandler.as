// Action script...

// [Initial MovieClip Action of sprite 20627]
#initclip 148
if (!ank.battlefield.OverHeadHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.OverHeadHandler = function (b, c)
    {
        this.initialize(b, c);
    }).prototype;
    _loc1.initialize = function (b, c)
    {
        this._mcBattlefield = b;
        this._mcContainer = c;
    };
    _loc1.clear = function ()
    {
        for (var k in this._mcContainer)
        {
            if (typeof(this._mcContainer[k]) == "movieclip")
            {
                this._mcContainer[k].swapDepths(0);
                this._mcContainer[k].removeMovieClip();
            } // end if
        } // end of for...in
    };
    _loc1.addOverHeadItem = function (sID, nX, nY, mcSprite, sLayerName, fClassName, aParams, nDelay)
    {
        var _loc10 = this._mcContainer["oh" + sID];
        var _loc11 = this._mcBattlefield.getZoom();
        if (_loc10 == undefined)
        {
            _loc10 = this._mcContainer.attachClassMovie(ank.battlefield.mc.OverHead, "oh" + sID, mcSprite.getDepth(), [mcSprite, _loc11, this._mcBattlefield]);
        } // end if
        _loc10._x = nX;
        _loc10._y = nY;
        if (_loc11 < 100)
        {
            _loc10._xscale = _loc10._yscale = 10000 / _loc11;
        } // end if
        _loc10.addItem(sLayerName, fClassName, aParams, nDelay);
    };
    _loc1.removeOverHeadLayer = function (sID, sLayerName)
    {
        var _loc4 = this._mcContainer["oh" + sID];
        _loc4.removeLayer(sLayerName);
    };
    _loc1.removeOverHead = function (sID)
    {
        var _loc3 = this._mcContainer["oh" + sID];
        _loc3.remove();
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
