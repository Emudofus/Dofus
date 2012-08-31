// Action script...

// [Initial MovieClip Action of sprite 852]
#initclip 64
class ank.battlefield.mc.Zone extends MovieClip
{
    var _oMap, createEmptyMovieClip, removeMovieClip, _mcZone;
    function Zone(map)
    {
        super();
        this.initialize(map);
    } // End of the function
    function initialize(map)
    {
        _oMap = map;
        this.clear();
    } // End of the function
    function clear()
    {
        this.createEmptyMovieClip("_mcZone", 10);
    } // End of the function
    function remove()
    {
        this.removeMovieClip();
    } // End of the function
    function drawCircle(nRadius, nColor, nCenterCellNum)
    {
        var _loc2 = _mcZone;
        _loc2.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        this.drawCircleBorder(nRadius, nColor, nCenterCellNum);
        _loc2.endFill();
    } // End of the function
    function drawRing(nRadiusIn, nRadiusOut, nColor, nCenterCellNum)
    {
        var _loc2 = _mcZone;
        _loc2.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        this.drawCircleBorder(nRadiusOut, nColor, nCenterCellNum);
        this.drawCircleBorder(nRadiusIn, nColor, nCenterCellNum);
        _loc2.endFill();
    } // End of the function
    function drawRectangle(nWidth, nHeight, nColor, nCenterCellNum)
    {
        var _loc2 = _mcZone;
        _loc2.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        this.drawRectangleBorder(nWidth, nHeight, nColor, nCenterCellNum);
        _loc2.endFill();
    } // End of the function
    function drawCross(nRadius, nColor, nCenterCellNum)
    {
        var _loc4 = ank.battlefield.Constants.CELL_COORD;
        var _loc8 = _oMap.getWidth();
        var _loc5 = nCenterCellNum;
        var _loc2;
        var _loc3;
        var _loc7;
        _loc7 = _mcZone;
        _loc7.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        _loc7.lineStyle(1, nColor, 100);
        _loc3 = this.getGroundData(_loc5);
        _loc7.moveTo(_loc4[_loc3.gf][0][0], _loc4[_loc3.gf][0][1] - _loc3.gl * 20);
        for (var _loc2 = 1; _loc2 <= nRadius; ++_loc2)
        {
            _loc5 = _loc5 - _loc8;
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][0][0] - _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc4[_loc3.gf][0][1] - _loc3.gl * 20 - _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end of for
        for (var _loc2 = nRadius; _loc2 >= 0; --_loc2)
        {
            if (_loc2 != nRadius)
            {
                _loc5 = _loc5 + _loc8;
            } // end if
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][1][0] - _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc4[_loc3.gf][1][1] - _loc3.gl * 20 - _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end of for
        for (var _loc2 = 1; _loc2 <= nRadius; ++_loc2)
        {
            _loc5 = _loc5 - (_loc8 - 1);
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][1][0] + _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc4[_loc3.gf][1][1] - _loc3.gl * 20 - _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end of for
        for (var _loc2 = nRadius; _loc2 >= 0; --_loc2)
        {
            if (_loc2 != nRadius)
            {
                _loc5 = _loc5 + (_loc8 - 1);
            } // end if
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][2][0] + _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc4[_loc3.gf][2][1] - _loc3.gl * 20 - _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end of for
        for (var _loc2 = 1; _loc2 <= nRadius; ++_loc2)
        {
            _loc5 = _loc5 + _loc8;
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][2][0] + _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc4[_loc3.gf][2][1] - _loc3.gl * 20 + _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end of for
        for (var _loc2 = nRadius; _loc2 >= 0; --_loc2)
        {
            if (_loc2 != nRadius)
            {
                _loc5 = _loc5 - _loc8;
            } // end if
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][3][0] + _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc4[_loc3.gf][3][1] - _loc3.gl * 20 + _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end of for
        for (var _loc2 = 1; _loc2 <= nRadius; ++_loc2)
        {
            _loc5 = _loc5 + (_loc8 - 1);
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][3][0] - _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc4[_loc3.gf][3][1] - _loc3.gl * 20 + _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end of for
        for (var _loc2 = nRadius; _loc2 > 0; --_loc2)
        {
            if (_loc2 != nRadius)
            {
                _loc5 = _loc5 - (_loc8 - 1);
            } // end if
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][0][0] - _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc4[_loc3.gf][0][1] - _loc3.gl * 20 + _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end of for
        _loc7.endFill();
    } // End of the function
    function drawLine(length, nColor, extremCellNum, refCellNum, bCenterRef, bOrtho)
    {
        var _loc9 = 0;
        var _loc8 = 0;
        if (bCenterRef == true)
        {
            var _loc12 = _oMap.getCellData(extremCellNum);
            var _loc13 = _oMap.getCellData(refCellNum);
            _loc9 = _loc12.x - _loc13.x;
            _loc8 = _loc12.rootY - _loc13.rootY;
        } // end if
        var _loc4 = ank.battlefield.Constants.CELL_COORD;
        var _loc10 = _oMap.getWidth();
        var _loc5 = extremCellNum;
        var _loc2;
        var _loc20;
        var _loc3;
        var _loc7;
        var _loc6 = [0, 0, 0, 0, 0, 0, 0, 0];
        if (refCellNum != extremCellNum)
        {
            var _loc11 = ank.battlefield.utils.Pathfinding.getDirection(_oMap, refCellNum, extremCellNum);
            if (bOrtho == true)
            {
                _loc6[(_loc11 + 6) % 8] = length;
                _loc6[(_loc11 + 10) % 8] = length;
            }
            else
            {
                _loc6[_loc11] = length;
            } // end if
        } // end else if
        _loc7 = _mcZone;
        _loc7.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        _loc7.lineStyle(1, nColor, 100);
        _loc3 = this.getGroundData(_loc5);
        _loc7.moveTo(_loc4[_loc3.gf][0][0] + _loc9, _loc4[_loc3.gf][0][1] - _loc3.gl * 20 + _loc8);
        for (var _loc2 = 1; _loc2 <= _loc6[5]; ++_loc2)
        {
            _loc5 = _loc5 - _loc10;
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][0][0] - _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc9, _loc4[_loc3.gf][0][1] - _loc3.gl * 20 - _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc8);
        } // end of for
        for (var _loc2 = _loc6[5]; _loc2 >= 0; --_loc2)
        {
            if (_loc2 != _loc6[5])
            {
                _loc5 = _loc5 + _loc10;
            } // end if
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][1][0] - _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc9, _loc4[_loc3.gf][1][1] - _loc3.gl * 20 - _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc8);
        } // end of for
        for (var _loc2 = 1; _loc2 <= _loc6[7]; ++_loc2)
        {
            _loc5 = _loc5 - (_loc10 - 1);
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][1][0] + _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc9, _loc4[_loc3.gf][1][1] - _loc3.gl * 20 - _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc8);
        } // end of for
        for (var _loc2 = _loc6[7]; _loc2 >= 0; --_loc2)
        {
            if (_loc2 != _loc6[7])
            {
                _loc5 = _loc5 + (_loc10 - 1);
            } // end if
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][2][0] + _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc9, _loc4[_loc3.gf][2][1] - _loc3.gl * 20 - _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc8);
        } // end of for
        for (var _loc2 = 1; _loc2 <= _loc6[1]; ++_loc2)
        {
            _loc5 = _loc5 + _loc10;
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][2][0] + _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc9, _loc4[_loc3.gf][2][1] - _loc3.gl * 20 + _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc8);
        } // end of for
        for (var _loc2 = _loc6[1]; _loc2 >= 0; --_loc2)
        {
            if (_loc2 != _loc6[1])
            {
                _loc5 = _loc5 - _loc10;
            } // end if
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][3][0] + _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc9, _loc4[_loc3.gf][3][1] - _loc3.gl * 20 + _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc8);
        } // end of for
        for (var _loc2 = 1; _loc2 <= _loc6[3]; ++_loc2)
        {
            _loc5 = _loc5 + (_loc10 - 1);
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][3][0] - _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc9, _loc4[_loc3.gf][3][1] - _loc3.gl * 20 + _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc8);
        } // end of for
        for (var _loc2 = _loc6[3]; _loc2 > 0; --_loc2)
        {
            if (_loc2 != _loc6[3])
            {
                _loc5 = _loc5 - (_loc10 - 1);
            } // end if
            _loc3 = this.getGroundData(_loc5);
            _loc7.lineTo(_loc4[_loc3.gf][0][0] - _loc2 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc9, _loc4[_loc3.gf][0][1] - _loc3.gl * 20 + _loc2 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc8);
        } // end of for
        _loc7.endFill();
    } // End of the function
    function getGroundData(nCellNum)
    {
        var _loc2 = _oMap.getCellData(nCellNum);
        var _loc3 = _loc2.groundSlope == undefined ? (1) : (_loc2.groundSlope);
        var _loc4 = _loc2.groundLevel == undefined ? (0) : (_loc2.groundLevel - 7);
        return ({gf: _loc3, gl: _loc4});
    } // End of the function
    function drawCircleBorder(nRadius, nColor, nCenterCellNum)
    {
        var _loc3 = ank.battlefield.Constants.CELL_COORD;
        var _loc12 = _oMap.getWidth();
        var _loc11 = _loc12 * 2 - 1;
        var _loc7 = nCenterCellNum - nRadius * _loc12;
        var _loc4;
        var _loc5;
        var _loc2;
        var _loc6;
        var _loc9 = -nRadius * ank.battlefield.Constants.CELL_HALF_WIDTH;
        var _loc8 = -nRadius * ank.battlefield.Constants.CELL_HALF_HEIGHT;
        _loc6 = _mcZone;
        _loc6.lineStyle(1, nColor, 100);
        _loc2 = this.getGroundData(_loc7);
        _loc6.moveTo(_loc9 + _loc3[_loc2.gf][0][0], _loc8 + _loc3[_loc2.gf][0][1] - _loc2.gl * 20);
        for (var _loc4 = 0; _loc4 < nRadius + 1; ++_loc4)
        {
            if (_loc4 != 0)
            {
                ++_loc7;
            } // end if
            _loc2 = this.getGroundData(_loc7);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][1][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][1][1] - _loc2.gl * 20);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][2][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][2][1] - _loc2.gl * 20);
        } // end of for
        _loc4 = _loc4 - 1;
        for (var _loc5 = 0; _loc5 < nRadius; ++_loc5)
        {
            _loc7 = _loc7 + _loc11;
            _loc2 = this.getGroundData(_loc7);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][1][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][1][1] + (_loc5 + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][2][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][2][1] + (_loc5 + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
        } // end of for
        for (var _loc4 = nRadius; _loc4 >= 0; --_loc4)
        {
            if (_loc4 != nRadius)
            {
                --_loc7;
            } // end if
            _loc2 = this.getGroundData(_loc7);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][3][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][3][1] + _loc5 * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][0][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][0][1] + _loc5 * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
        } // end of for
        _loc4 = _loc4 + 1;
        for (var _loc5 = nRadius - 1; _loc5 >= 0; --_loc5)
        {
            _loc7 = _loc7 - _loc11;
            _loc2 = this.getGroundData(_loc7);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][3][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][3][1] + _loc5 * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][0][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][0][1] + _loc5 * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
        } // end of for
    } // End of the function
    function drawRectangleBorder(nWidth, nHeight, nColor, nCenterCellNum)
    {
        var _loc3 = ank.battlefield.Constants.CELL_COORD;
        var _loc11 = _oMap.getWidth() * 2 - 1;
        var _loc7 = Number(nCenterCellNum);
        var _loc4;
        var _loc5;
        var _loc2;
        var _loc6;
        var _loc9 = 0;
        var _loc8 = 0;
        _loc6 = _mcZone;
        _loc6.lineStyle(1, nColor, 100);
        _loc2 = this.getGroundData(_loc7);
        _loc6.moveTo(_loc9 + _loc3[_loc2.gf][0][0], _loc8 + _loc3[_loc2.gf][0][1] - _loc2.gl * 20);
        for (var _loc4 = 0; _loc4 < nWidth; ++_loc4)
        {
            if (_loc4 != 0)
            {
                ++_loc7;
            } // end if
            _loc2 = this.getGroundData(_loc7);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][1][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][1][1] - _loc2.gl * 20);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][2][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][2][1] - _loc2.gl * 20);
        } // end of for
        _loc4 = _loc4 - 1;
        for (var _loc5 = 0; _loc5 < nHeight - 1; ++_loc5)
        {
            _loc7 = _loc7 + _loc11;
            _loc2 = this.getGroundData(_loc7);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][1][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][1][1] + (_loc5 + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][2][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][2][1] + (_loc5 + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
        } // end of for
        for (var _loc4 = nWidth - 1; _loc4 >= 0; --_loc4)
        {
            if (_loc4 != nWidth - 1)
            {
                --_loc7;
            } // end if
            _loc2 = this.getGroundData(_loc7);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][3][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][3][1] + _loc5 * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][0][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][0][1] + _loc5 * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
        } // end of for
        _loc4 = _loc4 + 1;
        for (var _loc5 = nHeight - 2; _loc5 >= 0; --_loc5)
        {
            _loc7 = _loc7 - _loc11;
            _loc2 = this.getGroundData(_loc7);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][3][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][3][1] + _loc5 * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
            _loc6.lineTo(_loc9 + _loc3[_loc2.gf][0][0] + _loc4 * ank.battlefield.Constants.CELL_WIDTH, _loc8 + _loc3[_loc2.gf][0][1] + _loc5 * ank.battlefield.Constants.CELL_HEIGHT - _loc2.gl * 20);
        } // end of for
    } // End of the function
    static var ALPHA = 30;
} // End of Class
#endinitclip
