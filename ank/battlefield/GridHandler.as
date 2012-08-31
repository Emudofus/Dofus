// Action script...

// [Initial MovieClip Action of sprite 862]
#initclip 74
class ank.battlefield.GridHandler
{
    var _mcContainer, _oDatacenter, _mcGrid, bGridVisible;
    function GridHandler(c, d)
    {
        this.initialize(c, d);
    } // End of the function
    function initialize(c, d)
    {
        _mcContainer = c;
        _oDatacenter = d;
    } // End of the function
    function draw(bAll)
    {
        _mcGrid = _mcContainer.createEmptyMovieClip("mcGrid", 10);
        var _loc8 = _oDatacenter.Map.data;
        var _loc4 = ank.battlefield.Constants.CELL_COORD;
        var _loc2;
        var _loc7 = new Object();
        _mcGrid.lineStyle(1, ank.battlefield.Constants.GRID_COLOR, ank.battlefield.Constants.GRID_ALPHA);
        for (var _loc11 in _loc8)
        {
            _loc2 = _loc8[_loc11];
            if (!_loc2.active && !bAll)
            {
                continue;
            } // end if
            if (_loc2.movement != 0 && _loc2.lineOfSight || bAll)
            {
                _mcGrid.moveTo(_loc4[_loc2.groundSlope][0][0] + _loc2.x, _loc4[_loc2.groundSlope][0][1] + _loc2.y);
                _mcGrid.lineTo(_loc4[_loc2.groundSlope][1][0] + _loc2.x, _loc4[_loc2.groundSlope][1][1] + _loc2.y);
                _mcGrid.lineTo(_loc4[_loc2.groundSlope][2][0] + _loc2.x, _loc4[_loc2.groundSlope][2][1] + _loc2.y);
                continue;
            } // end if
            _loc7[_loc11] = _loc2;
        } // end of for...in
        var _loc12 = _oDatacenter.Map.width;
        var _loc10 = [-_loc12, -(_loc12 - 1)];
        for (var _loc11 in _loc7)
        {
            _loc2 = _loc7[_loc11];
            for (var _loc3 = 0; _loc3 < 2; ++_loc3)
            {
                var _loc5 = Number(_loc11) + _loc10[_loc3];
                if (_loc7[_loc5] == undefined)
                {
                    if (!_loc8[_loc5].active && !bAll)
                    {
                        continue;
                    } // end if
                    var _loc6 = (_loc3 + 1) % 4;
                    _mcGrid.moveTo(_loc4[_loc2.groundSlope][_loc3][0] + _loc2.x, _loc4[_loc2.groundSlope][_loc3][1] + _loc2.y);
                    _mcGrid.lineTo(_loc4[_loc2.groundSlope][_loc6][0] + _loc2.x, _loc4[_loc2.groundSlope][_loc6][1] + _loc2.y);
                } // end if
            } // end of for
        } // end of for...in
        bGridVisible = true;
    } // End of the function
    function clear(Void)
    {
        _mcGrid.removeMovieClip();
        bGridVisible = false;
    } // End of the function
} // End of Class
#endinitclip
