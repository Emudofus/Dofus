// Action script...

// [Initial MovieClip Action of sprite 20617]
#initclip 138
if (!ank.battlefield.GridHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.GridHandler = function (c, d)
    {
        this.initialize(c, d);
    }).prototype;
    _loc1.initialize = function (c, d)
    {
        this._mcContainer = c;
        this._oDatacenter = d;
    };
    _loc1.draw = function (bAll)
    {
        this._mcGrid = this._mcContainer.createEmptyMovieClip("mcGrid", 10);
        var _loc3 = this._oDatacenter.Map.data;
        var _loc4 = ank.battlefield.Constants.CELL_COORD;
        var _loc6 = new Object();
        this._mcGrid.lineStyle(1, ank.battlefield.Constants.GRID_COLOR, ank.battlefield.Constants.GRID_ALPHA);
        for (var k in _loc3)
        {
            var _loc5 = _loc3[k];
            if (!_loc5.active && !bAll)
            {
                continue;
            } // end if
            if (_loc5.movement != 0 && _loc5.lineOfSight || bAll)
            {
                this._mcGrid.moveTo(_loc4[_loc5.groundSlope][0][0] + _loc5.x, _loc4[_loc5.groundSlope][0][1] + _loc5.y);
                this._mcGrid.lineTo(_loc4[_loc5.groundSlope][1][0] + _loc5.x, _loc4[_loc5.groundSlope][1][1] + _loc5.y);
                this._mcGrid.lineTo(_loc4[_loc5.groundSlope][2][0] + _loc5.x, _loc4[_loc5.groundSlope][2][1] + _loc5.y);
                continue;
            } // end if
            _loc6[k] = _loc5;
        } // end of for...in
        var _loc7 = this._oDatacenter.Map.width;
        var _loc8 = [-_loc7, -(_loc7 - 1)];
        for (var k in _loc6)
        {
            _loc5 = _loc6[k];
            var _loc9 = 0;
            
            while (++_loc9, _loc9 < 2)
            {
                var _loc10 = Number(k) + _loc8[_loc9];
                if (_loc6[_loc10] == undefined)
                {
                    if (!_loc3[_loc10].active && !bAll)
                    {
                        continue;
                    } // end if
                    var _loc11 = (_loc9 + 1) % 4;
                    this._mcGrid.moveTo(_loc4[_loc5.groundSlope][_loc9][0] + _loc5.x, _loc4[_loc5.groundSlope][_loc9][1] + _loc5.y);
                    this._mcGrid.lineTo(_loc4[_loc5.groundSlope][_loc11][0] + _loc5.x, _loc4[_loc5.groundSlope][_loc11][1] + _loc5.y);
                } // end if
            } // end while
        } // end of for...in
        this.bGridVisible = true;
    };
    _loc1.clear = function (Void)
    {
        this._mcGrid.removeMovieClip();
        this.bGridVisible = false;
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
