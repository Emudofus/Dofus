// Action script...

// [Initial MovieClip Action of sprite 20667]
#initclip 188
if (!ank.battlefield.PointsHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.PointsHandler = function (b, c, d)
    {
        this.initialize(b, c, d);
    }).prototype;
    _loc1.initialize = function (b, c, d)
    {
        this._mcBattlefield = b;
        this._mcContainer = c;
        this._oDatacenter = d;
        this._oList = new Object();
    };
    _loc1.clear = function ()
    {
        for (var k in this._mcContainer)
        {
            this._mcContainer[k].removeMovieClip();
        } // end of for...in
    };
    _loc1.addPoints = function (sID, nX, nY, sValue, nColor)
    {
        var _loc7 = this._mcContainer.getNextHighestDepth();
        var _loc8 = this._mcContainer.attachClassMovie(ank.battlefield.mc.Points, "points" + _loc7, _loc7, [this, sID, nY, sValue, nColor]);
        _loc8._x = nX;
        _loc8._y = nY;
        if (this._oList[sID] == undefined)
        {
            this._oList[sID] = new Array();
        } // end if
        this._oList[sID].push(_loc8);
        if (this._oList[sID].length == 1)
        {
            _loc8.animate();
        } // end if
    };
    _loc1.onAnimateFinished = function (sID)
    {
        var _loc3 = this._oList[sID];
        _loc3.shift();
        if (_loc3.length != 0)
        {
            _loc3[0].animate();
        } // end if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
