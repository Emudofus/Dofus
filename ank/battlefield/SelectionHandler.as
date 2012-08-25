// Action script...

// [Initial MovieClip Action of sprite 20565]
#initclip 86
if (!ank.battlefield.SelectionHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.SelectionHandler = function (b, c, d)
    {
        this.initialize(b, c, d);
    }).prototype;
    _loc1.initialize = function (b, c, d)
    {
        this._mcBattlefield = b;
        this._oDatacenter = d;
        this._mcContainer = c;
        this.clear();
    };
    _loc1.clear = function (Void)
    {
        for (var k in this._mcContainer.Select)
        {
            var _loc3 = this._mcContainer.Select[k];
            if (_loc3 != undefined)
            {
                var _loc4 = _loc3.inObjectClips;
                for (var l in _loc4)
                {
                    _loc4[l].removeMovieClip();
                } // end of for...in
            } // end if
            _loc3.removeMovieClip();
        } // end of for...in
    };
    _loc1.clearLayer = function (sLayer)
    {
        if (sLayer == undefined)
        {
            sLayer = "default";
        } // end if
        var _loc3 = this._mcContainer.Select[sLayer];
        if (_loc3 != undefined)
        {
            var _loc4 = _loc3.inObjectClips;
            for (var k in _loc4)
            {
                _loc4[k].removeMovieClip();
            } // end of for...in
        } // end if
        _loc3.removeMovieClip();
    };
    _loc1.select = function (bSelected, nCellNum, nColor, sLayer, nAlpha)
    {
        var _loc7 = this._mcBattlefield.mapHandler.getCellData(nCellNum);
        if (sLayer == undefined)
        {
            sLayer = "default";
        } // end if
        var _loc8 = this._mcContainer.Select[sLayer];
        if (_loc8 == undefined)
        {
            _loc8 = this._mcContainer.Select.createEmptyMovieClip(sLayer, this._mcContainer.Select.getNextHighestDepth());
            _loc8.inObjectClips = new Array();
        } // end if
        if (_loc7 != undefined && _loc7.x != undefined)
        {
            var _loc9 = _loc7.movement > 1 && _loc7.layerObject2Num != 0;
            var _loc10 = "cell" + String(nCellNum);
            if (bSelected)
            {
                if (_loc9)
                {
                    var _loc12 = this._mcContainer.Object2["select" + nCellNum];
                    if (_loc12 == undefined)
                    {
                        _loc12 = this._mcContainer.Object2.createEmptyMovieClip("select" + nCellNum, nCellNum * 100 + 2);
                    } // end if
                    var _loc11 = _loc12[sLayer];
                    if (_loc11 == undefined)
                    {
                        _loc11 = _loc12.attachMovie("s" + _loc7.groundSlope, sLayer, _loc12.getNextHighestDepth());
                    } // end if
                    _loc8.inObjectClips.push(_loc11);
                }
                else
                {
                    _loc11 = _loc8.attachMovie("s" + _loc7.groundSlope, _loc10, nCellNum * 100);
                } // end else if
                _loc11._x = _loc7.x;
                _loc11._y = _loc7.y;
                var _loc13 = new Color(_loc11);
                _loc13.setRGB(Number(nColor));
                _loc11._alpha = nAlpha != undefined ? (nAlpha) : (100);
            }
            else if (_loc9)
            {
                this._mcContainer.Object2["select" + nCellNum][sLayer].unloadMovie();
                this._mcContainer.Object2["select" + nCellNum][sLayer].removeMovieClip();
            }
            else
            {
                _loc8[_loc10].unloadMovie();
                _loc8[_loc10].removeMovieClip();
            } // end else if
        } // end else if
    };
    _loc1.selectMultiple = function (bSelect, aCellList, nColor, sLayer, nAlpha)
    {
        for (var i in aCellList)
        {
            this.select(bSelect, aCellList[i], nColor, sLayer, nAlpha);
        } // end of for...in
    };
    _loc1.getLayers = function ()
    {
        var _loc2 = new Array();
        for (var k in this._mcContainer.Select)
        {
            var _loc3 = this._mcContainer.Select[k];
            if (_loc3 != undefined)
            {
                _loc2.push(_loc3._name);
            } // end if
        } // end of for...in
        return (_loc2);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
