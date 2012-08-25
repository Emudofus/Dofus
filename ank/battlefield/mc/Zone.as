// Action script...

// [Initial MovieClip Action of sprite 20632]
#initclip 153
if (!ank.battlefield.mc.Zone)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.mc)
    {
        _global.ank.battlefield.mc = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.mc.Zone = function (map)
    {
        super();
        this.initialize(map);
    }).prototype;
    _loc1.initialize = function (map)
    {
        this._oMap = map;
        this.clear();
    };
    _loc1.clear = function ()
    {
        this.createEmptyMovieClip("_mcZone", 10);
    };
    _loc1.remove = function ()
    {
        this.removeMovieClip();
    };
    _loc1.drawCircle = function (nRadius, nColor, nCenterCellNum)
    {
        var _loc5 = this._mcZone;
        _loc5.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        this.drawCircleBorder(nRadius, nColor, nCenterCellNum);
        _loc5.endFill();
    };
    _loc1.drawRing = function (nRadiusIn, nRadiusOut, nColor, nCenterCellNum)
    {
        var _loc6 = this._mcZone;
        _loc6.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        this.drawCircleBorder(nRadiusOut, nColor, nCenterCellNum);
        this.drawCircleBorder(nRadiusIn, nColor, nCenterCellNum);
        _loc6.endFill();
    };
    _loc1.drawRectangle = function (nWidth, nHeight, nColor, nCenterCellNum)
    {
        var _loc6 = this._mcZone;
        _loc6.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        this.drawRectangleBorder(nWidth, nHeight, nColor, nCenterCellNum);
        _loc6.endFill();
    };
    _loc1.drawCross = function (nRadius, nColor, nCenterCellNum)
    {
        var _loc5 = ank.battlefield.Constants.CELL_COORD;
        var _loc6 = this._oMap.getWidth();
        var _loc7 = nCenterCellNum;
        var _loc10 = this._mcZone;
        _loc10.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        _loc10.lineStyle(1, nColor, 100);
        var _loc9 = this.getGroundData(_loc7);
        _loc10.moveTo(_loc5[_loc9.gf][0][0], _loc5[_loc9.gf][0][1] - _loc9.gl * 20);
        var _loc8 = 1;
        
        while (++_loc8, _loc8 <= nRadius)
        {
            _loc7 = _loc7 - _loc6;
            _loc9 = this.getGroundData(_loc7);
            _loc10.lineTo(_loc5[_loc9.gf][0][0] - _loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc5[_loc9.gf][0][1] - _loc9.gl * 20 - _loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end while
        _loc8 = nRadius;
        
        while (--_loc8, _loc8 >= 0)
        {
            if (_loc8 != nRadius)
            {
                _loc7 = _loc7 + _loc6;
            } // end if
            _loc9 = this.getGroundData(_loc7);
            _loc10.lineTo(_loc5[_loc9.gf][1][0] - _loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc5[_loc9.gf][1][1] - _loc9.gl * 20 - _loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end while
        _loc8 = 1;
        
        while (++_loc8, _loc8 <= nRadius)
        {
            _loc7 = _loc7 - (_loc6 - 1);
            _loc9 = this.getGroundData(_loc7);
            _loc10.lineTo(_loc5[_loc9.gf][1][0] + _loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc5[_loc9.gf][1][1] - _loc9.gl * 20 - _loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end while
        _loc8 = nRadius;
        
        while (--_loc8, _loc8 >= 0)
        {
            if (_loc8 != nRadius)
            {
                _loc7 = _loc7 + (_loc6 - 1);
            } // end if
            _loc9 = this.getGroundData(_loc7);
            _loc10.lineTo(_loc5[_loc9.gf][2][0] + _loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc5[_loc9.gf][2][1] - _loc9.gl * 20 - _loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end while
        _loc8 = 1;
        
        while (++_loc8, _loc8 <= nRadius)
        {
            _loc7 = _loc7 + _loc6;
            _loc9 = this.getGroundData(_loc7);
            _loc10.lineTo(_loc5[_loc9.gf][2][0] + _loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc5[_loc9.gf][2][1] - _loc9.gl * 20 + _loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end while
        _loc8 = nRadius;
        
        while (--_loc8, _loc8 >= 0)
        {
            if (_loc8 != nRadius)
            {
                _loc7 = _loc7 - _loc6;
            } // end if
            _loc9 = this.getGroundData(_loc7);
            _loc10.lineTo(_loc5[_loc9.gf][3][0] + _loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc5[_loc9.gf][3][1] - _loc9.gl * 20 + _loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end while
        _loc8 = 1;
        
        while (++_loc8, _loc8 <= nRadius)
        {
            _loc7 = _loc7 + (_loc6 - 1);
            _loc9 = this.getGroundData(_loc7);
            _loc10.lineTo(_loc5[_loc9.gf][3][0] - _loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc5[_loc9.gf][3][1] - _loc9.gl * 20 + _loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end while
        _loc8 = nRadius;
        
        while (--_loc8, _loc8 > 0)
        {
            if (_loc8 != nRadius)
            {
                _loc7 = _loc7 - (_loc6 - 1);
            } // end if
            _loc9 = this.getGroundData(_loc7);
            _loc10.lineTo(_loc5[_loc9.gf][0][0] - _loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH, _loc5[_loc9.gf][0][1] - _loc9.gl * 20 + _loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
        } // end while
        _loc10.endFill();
    };
    _loc1.drawLine = function (length, nColor, extremCellNum, refCellNum, bCenterRef, bOrtho)
    {
        var _loc8 = 0;
        var _loc9 = 0;
        if (bCenterRef == true)
        {
            var _loc10 = this._oMap.getCellData(extremCellNum);
            var _loc11 = this._oMap.getCellData(refCellNum);
            _loc8 = _loc10.x - _loc11.x;
            _loc9 = _loc10.rootY - _loc11.rootY;
        } // end if
        var _loc12 = ank.battlefield.Constants.CELL_COORD;
        var _loc13 = this._oMap.getWidth();
        var _loc14 = extremCellNum;
        var _loc19 = [0, 0, 0, 0, 0, 0, 0, 0];
        if (refCellNum != extremCellNum)
        {
            var _loc20 = ank.battlefield.utils.Pathfinding.getDirection(this._oMap, refCellNum, extremCellNum);
            if (bOrtho == true)
            {
                _loc19[(_loc20 + 6) % 8] = length;
                _loc19[(_loc20 + 10) % 8] = length;
            }
            else
            {
                _loc19[_loc20] = length;
            } // end if
        } // end else if
        var _loc18 = this._mcZone;
        _loc18.beginFill(nColor, ank.battlefield.mc.Zone.ALPHA);
        _loc18.lineStyle(1, nColor, 100);
        var _loc17 = this.getGroundData(_loc14);
        _loc18.moveTo(_loc12[_loc17.gf][0][0] + _loc8, _loc12[_loc17.gf][0][1] - _loc17.gl * 20 + _loc9);
        var _loc15 = 1;
        
        while (++_loc15, _loc15 <= _loc19[5])
        {
            _loc14 = _loc14 - _loc13;
            _loc17 = this.getGroundData(_loc14);
            _loc18.lineTo(_loc12[_loc17.gf][0][0] - _loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc8, _loc12[_loc17.gf][0][1] - _loc17.gl * 20 - _loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc9);
        } // end while
        _loc15 = _loc19[5];
        
        while (--_loc15, _loc15 >= 0)
        {
            if (_loc15 != _loc19[5])
            {
                _loc14 = _loc14 + _loc13;
            } // end if
            _loc17 = this.getGroundData(_loc14);
            _loc18.lineTo(_loc12[_loc17.gf][1][0] - _loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc8, _loc12[_loc17.gf][1][1] - _loc17.gl * 20 - _loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc9);
        } // end while
        _loc15 = 1;
        
        while (++_loc15, _loc15 <= _loc19[7])
        {
            _loc14 = _loc14 - (_loc13 - 1);
            _loc17 = this.getGroundData(_loc14);
            _loc18.lineTo(_loc12[_loc17.gf][1][0] + _loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc8, _loc12[_loc17.gf][1][1] - _loc17.gl * 20 - _loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc9);
        } // end while
        _loc15 = _loc19[7];
        
        while (--_loc15, _loc15 >= 0)
        {
            if (_loc15 != _loc19[7])
            {
                _loc14 = _loc14 + (_loc13 - 1);
            } // end if
            _loc17 = this.getGroundData(_loc14);
            _loc18.lineTo(_loc12[_loc17.gf][2][0] + _loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc8, _loc12[_loc17.gf][2][1] - _loc17.gl * 20 - _loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc9);
        } // end while
        _loc15 = 1;
        
        while (++_loc15, _loc15 <= _loc19[1])
        {
            _loc14 = _loc14 + _loc13;
            _loc17 = this.getGroundData(_loc14);
            _loc18.lineTo(_loc12[_loc17.gf][2][0] + _loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc8, _loc12[_loc17.gf][2][1] - _loc17.gl * 20 + _loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc9);
        } // end while
        _loc15 = _loc19[1];
        
        while (--_loc15, _loc15 >= 0)
        {
            if (_loc15 != _loc19[1])
            {
                _loc14 = _loc14 - _loc13;
            } // end if
            _loc17 = this.getGroundData(_loc14);
            _loc18.lineTo(_loc12[_loc17.gf][3][0] + _loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc8, _loc12[_loc17.gf][3][1] - _loc17.gl * 20 + _loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc9);
        } // end while
        _loc15 = 1;
        
        while (++_loc15, _loc15 <= _loc19[3])
        {
            _loc14 = _loc14 + (_loc13 - 1);
            _loc17 = this.getGroundData(_loc14);
            _loc18.lineTo(_loc12[_loc17.gf][3][0] - _loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc8, _loc12[_loc17.gf][3][1] - _loc17.gl * 20 + _loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc9);
        } // end while
        _loc15 = _loc19[3];
        
        while (--_loc15, _loc15 > 0)
        {
            if (_loc15 != _loc19[3])
            {
                _loc14 = _loc14 - (_loc13 - 1);
            } // end if
            _loc17 = this.getGroundData(_loc14);
            _loc18.lineTo(_loc12[_loc17.gf][0][0] - _loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + _loc8, _loc12[_loc17.gf][0][1] - _loc17.gl * 20 + _loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + _loc9);
        } // end while
        _loc18.endFill();
    };
    _loc1.getGroundData = function (nCellNum)
    {
        var _loc3 = this._oMap.getCellData(nCellNum);
        var _loc4 = _loc3.groundSlope == undefined ? (1) : (_loc3.groundSlope);
        var _loc5 = _loc3.groundLevel == undefined ? (0) : (_loc3.groundLevel - 7);
        return ({gf: _loc4, gl: _loc5});
    };
    _loc1.drawCircleBorder = function (nRadius, nColor, nCenterCellNum)
    {
        var _loc5 = ank.battlefield.Constants.CELL_COORD;
        var _loc6 = this._oMap.getWidth();
        var _loc7 = _loc6 * 2 - 1;
        var _loc8 = nCenterCellNum - nRadius * _loc6;
        var _loc13 = -nRadius * ank.battlefield.Constants.CELL_HALF_WIDTH;
        var _loc14 = -nRadius * ank.battlefield.Constants.CELL_HALF_HEIGHT;
        var _loc12 = this._mcZone;
        _loc12.lineStyle(1, nColor, 100);
        var _loc11 = this.getGroundData(_loc8);
        _loc12.moveTo(_loc13 + _loc5[_loc11.gf][0][0], _loc14 + _loc5[_loc11.gf][0][1] - _loc11.gl * 20);
        var _loc9 = 0;
        
        while (++_loc9, _loc9 < nRadius + 1)
        {
            if (_loc9 != 0)
            {
                ++_loc8;
            } // end if
            _loc11 = this.getGroundData(_loc8);
            _loc12.lineTo(_loc13 + _loc5[_loc11.gf][1][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc5[_loc11.gf][1][1] - _loc11.gl * 20);
            _loc12.lineTo(_loc13 + _loc5[_loc11.gf][2][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc5[_loc11.gf][2][1] - _loc11.gl * 20);
        } // end while
        _loc9 = _loc9 - 1;
        var _loc10 = 0;
        
        while (++_loc10, _loc10 < nRadius)
        {
            _loc8 = _loc8 + _loc7;
            _loc11 = this.getGroundData(_loc8);
            _loc12.lineTo(_loc13 + _loc5[_loc11.gf][1][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc5[_loc11.gf][1][1] + (_loc10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
            _loc12.lineTo(_loc13 + _loc5[_loc11.gf][2][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc5[_loc11.gf][2][1] + (_loc10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
        } // end while
        _loc9 = nRadius;
        
        while (--_loc9, _loc9 >= 0)
        {
            if (_loc9 != nRadius)
            {
                --_loc8;
            } // end if
            _loc11 = this.getGroundData(_loc8);
            _loc12.lineTo(_loc13 + _loc5[_loc11.gf][3][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc5[_loc11.gf][3][1] + _loc10 * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
            _loc12.lineTo(_loc13 + _loc5[_loc11.gf][0][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc5[_loc11.gf][0][1] + _loc10 * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
        } // end while
        _loc9 = _loc9 + 1;
        _loc10 = nRadius - 1;
        
        while (--_loc10, _loc10 >= 0)
        {
            _loc8 = _loc8 - _loc7;
            _loc11 = this.getGroundData(_loc8);
            _loc12.lineTo(_loc13 + _loc5[_loc11.gf][3][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc5[_loc11.gf][3][1] + _loc10 * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
            _loc12.lineTo(_loc13 + _loc5[_loc11.gf][0][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc5[_loc11.gf][0][1] + _loc10 * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
        } // end while
    };
    _loc1.drawRectangleBorder = function (nWidth, nHeight, nColor, nCenterCellNum)
    {
        var _loc6 = ank.battlefield.Constants.CELL_COORD;
        var _loc7 = this._oMap.getWidth() * 2 - 1;
        var _loc8 = Number(nCenterCellNum);
        var _loc13 = 0;
        var _loc14 = 0;
        var _loc12 = this._mcZone;
        _loc12.lineStyle(1, nColor, 100);
        var _loc11 = this.getGroundData(_loc8);
        _loc12.moveTo(_loc13 + _loc6[_loc11.gf][0][0], _loc14 + _loc6[_loc11.gf][0][1] - _loc11.gl * 20);
        var _loc9 = 0;
        
        while (++_loc9, _loc9 < nWidth)
        {
            if (_loc9 != 0)
            {
                ++_loc8;
            } // end if
            _loc11 = this.getGroundData(_loc8);
            _loc12.lineTo(_loc13 + _loc6[_loc11.gf][1][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc6[_loc11.gf][1][1] - _loc11.gl * 20);
            _loc12.lineTo(_loc13 + _loc6[_loc11.gf][2][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc6[_loc11.gf][2][1] - _loc11.gl * 20);
        } // end while
        _loc9 = _loc9 - 1;
        var _loc10 = 0;
        
        while (++_loc10, _loc10 < nHeight - 1)
        {
            _loc8 = _loc8 + _loc7;
            _loc11 = this.getGroundData(_loc8);
            _loc12.lineTo(_loc13 + _loc6[_loc11.gf][1][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc6[_loc11.gf][1][1] + (_loc10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
            _loc12.lineTo(_loc13 + _loc6[_loc11.gf][2][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc6[_loc11.gf][2][1] + (_loc10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
        } // end while
        _loc9 = nWidth - 1;
        
        while (--_loc9, _loc9 >= 0)
        {
            if (_loc9 != nWidth - 1)
            {
                --_loc8;
            } // end if
            _loc11 = this.getGroundData(_loc8);
            _loc12.lineTo(_loc13 + _loc6[_loc11.gf][3][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc6[_loc11.gf][3][1] + _loc10 * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
            _loc12.lineTo(_loc13 + _loc6[_loc11.gf][0][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc6[_loc11.gf][0][1] + _loc10 * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
        } // end while
        _loc9 = _loc9 + 1;
        _loc10 = nHeight - 2;
        
        while (--_loc10, _loc10 >= 0)
        {
            _loc8 = _loc8 - _loc7;
            _loc11 = this.getGroundData(_loc8);
            _loc12.lineTo(_loc13 + _loc6[_loc11.gf][3][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc6[_loc11.gf][3][1] + _loc10 * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
            _loc12.lineTo(_loc13 + _loc6[_loc11.gf][0][0] + _loc9 * ank.battlefield.Constants.CELL_WIDTH, _loc14 + _loc6[_loc11.gf][0][1] + _loc10 * ank.battlefield.Constants.CELL_HEIGHT - _loc11.gl * 20);
        } // end while
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.battlefield.mc.Zone = function (map)
    {
        super();
        this.initialize(map);
    }).ALPHA = 30;
} // end if
#endinitclip
