// Action script...

// [Initial MovieClip Action of sprite 853]
#initclip 65
class ank.battlefield.utils.Pathfinding
{
    function Pathfinding()
    {
    } // End of the function
    static function pathFind(mapHandler, nCellBegin, nCellEnd, oParams)
    {
        if (nCellBegin == undefined)
        {
            return (null);
        } // end if
        if (nCellEnd == undefined)
        {
            return (null);
        } // end if
        var _loc38 = oParams.bAllDirections == undefined ? (true) : (oParams.bAllDirections);
        var _loc29 = oParams.nMaxLength == undefined ? (500) : (oParams.nMaxLength);
        var _loc28 = oParams.bIgnoreSprites == undefined ? (false) : (oParams.bIgnoreSprites);
        var _loc25 = oParams.bCellNumOnly == undefined ? (false) : (oParams.bCellNumOnly);
        var _loc37 = oParams.bWithBeginCellNum == undefined ? (false) : (oParams.bWithBeginCellNum);
        var _loc32 = mapHandler.getWidth();
        var _loc27;
        var _loc26;
        var _loc23;
        if (_loc38)
        {
            _loc27 = 8;
            _loc26 = [1, _loc32, _loc32 * 2 - 1, _loc32 - 1, -1, -_loc32, -_loc32 * 2 + 1, -(_loc32 - 1)];
            _loc23 = [1.500000E+000, 1, 1.500000E+000, 1, 1.500000E+000, 1, 1.500000E+000, 1];
        }
        else
        {
            _loc27 = 4;
            _loc26 = [_loc32, _loc32 - 1, -_loc32, -(_loc32 - 1)];
            _loc23 = [1, 1, 1, 1];
        } // end else if
        var _loc13 = mapHandler.getCellsData();
        var _loc6 = new Object();
        var _loc10 = new Object();
        var _loc24 = false;
        var _loc33 = _loc6["oCell" + nCellBegin] = new Object();
        _loc33.num = nCellBegin;
        _loc33.g = 0;
        _loc33.v = 0;
        _loc33.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler, nCellBegin, nCellEnd);
        _loc33.f = _loc33.h;
        _loc33.a = _loc13[nCellBegin].groundLevel;
        _loc33.s = _loc13[nCellBegin].groundSlope;
        _loc33.m = _loc13[nCellBegin].movement;
        _loc33.parent = null;
        while (!_loc24)
        {
            var _loc16 = null;
            var _loc18 = 500000;
            for (var _loc34 in _loc6)
            {
                if (_loc6[_loc34].f < _loc18)
                {
                    _loc18 = _loc6[_loc34].f;
                    _loc16 = _loc34;
                } // end if
            } // end of for...in
            var _loc1 = _loc6[_loc16];
            delete _loc6[_loc16];
            if (_loc1.num == nCellEnd)
            {
                var _loc9 = new Array();
                while (_loc1.num != nCellBegin)
                {
                    if (_loc1.m == 0)
                    {
                        _loc9 = new Array();
                    }
                    else if (_loc25)
                    {
                        _loc9.splice(0, 0, _loc1.num);
                    }
                    else
                    {
                        _loc9.splice(0, 0, {num: _loc1.num, dir: ank.battlefield.utils.Pathfinding.getDirection(mapHandler, _loc1.parent.num, _loc1.num)});
                    } // end else if
                    _loc1 = _loc1.parent;
                } // end while
                if (_loc37)
                {
                    if (_loc25)
                    {
                        _loc9.splice(0, 0, nCellBegin);
                    }
                    else
                    {
                        _loc9.splice(0, 0, {num: nCellBegin, dir: ank.battlefield.utils.Pathfinding.getDirection(mapHandler, _loc1.parent.num, nCellBegin)});
                    } // end if
                } // end else if
                return (_loc9);
            } // end if
            var _loc15 = false;
            for (var _loc4 = 0; _loc4 < _loc27; ++_loc4)
            {
                var _loc7 = _loc1.num + _loc26[_loc4];
                if (Math.abs(_loc13[_loc7].x - _loc13[_loc1.num].x) <= 53)
                {
                    var _loc3 = _loc13[_loc7];
                    var _loc19 = _loc3.groundSlope;
                    var _loc20 = _loc3.groundLevel;
                    var _loc17 = _loc28 ? (true) : (_loc3.spriteOnID != undefined ? (false) : (true));
                    _loc15 = _loc7 == nCellEnd && _loc3.movement == 1 ? (true) : (false);
                    if (_loc3.active && _loc17)
                    {
                        var _loc5 = "oCell" + _loc7;
                        var _loc11 = _loc1.v + _loc23[_loc4] + (_loc3.movement == 0 || _loc3.movement == 1 ? (1000 + (_loc4 % 2 == 0 ? (3) : (0))) : (0)) + (_loc3.movement == 1 && _loc15 ? (-1000) : ((_loc4 != _loc1.d ? (5.000000E-001) : (0)) + (5 - _loc3.movement) / 3));
                        var _loc12 = _loc1.g + _loc23[_loc4];
                        var _loc8 = null;
                        if (_loc6[_loc5])
                        {
                            _loc8 = _loc6[_loc5].v;
                        }
                        else if (_loc10[_loc5])
                        {
                            _loc8 = _loc10[_loc5].v;
                        } // end else if
                        if ((_loc8 == null || _loc8 > _loc11) && _loc12 <= _loc29)
                        {
                            if (_loc10[_loc5])
                            {
                                delete _loc10[_loc5];
                            } // end if
                            var _loc2 = new Object();
                            _loc2.num = _loc7;
                            _loc2.g = _loc12;
                            _loc2.v = _loc11;
                            _loc2.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler, _loc7, nCellEnd);
                            _loc2.f = _loc2.v + _loc2.h;
                            _loc2.d = _loc4;
                            _loc2.a = _loc20;
                            _loc2.s = _loc19;
                            _loc2.m = _loc3.movement;
                            _loc2.parent = _loc1;
                            _loc6[_loc5] = _loc2;
                        } // end if
                    } // end if
                } // end if
            } // end of for
            _loc10["oCell" + _loc1.num] = {v: _loc1.v};
            _loc24 = true;
            for (var _loc34 in _loc6)
            {
                _loc24 = false;
                break;
            } // end of for...in
        } // end while
        return (null);
    } // End of the function
    static function goalDistEstimate(mapHandler, nCell1, nCell2)
    {
        var _loc2 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell1);
        var _loc1 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell2);
        var _loc4 = Math.abs(_loc2.x - _loc1.x);
        var _loc3 = Math.abs(_loc2.y - _loc1.y);
        return (Math.sqrt(Math.pow(_loc4, 2) + Math.pow(_loc3, 2)));
    } // End of the function
    static function goalDistance(mapHandler, nCell1, nCell2)
    {
        var _loc2 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell1);
        var _loc1 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell2);
        var _loc4 = Math.abs(_loc2.x - _loc1.x);
        var _loc3 = Math.abs(_loc2.y - _loc1.y);
        return (_loc4 + _loc3);
    } // End of the function
    static function getCaseCoordonnee(mapHandler, nNum)
    {
        var _loc1 = mapHandler.getWidth();
        var _loc3 = Math.floor(nNum / (_loc1 * 2 - 1));
        var _loc5 = nNum - _loc3 * (_loc1 * 2 - 1);
        var _loc6 = _loc5 % _loc1;
        var _loc2 = new Object();
        _loc2.y = _loc3 - _loc6;
        _loc2.x = (nNum - (_loc1 - 1) * _loc2.y) / _loc1;
        return (_loc2);
    } // End of the function
    static function getDirection(mapHandler, nCell1, nCell2)
    {
        var _loc3 = mapHandler.getWidth();
        var _loc4 = [1, _loc3, _loc3 * 2 - 1, _loc3 - 1, -1, -_loc3, -_loc3 * 2 + 1, -(_loc3 - 1)];
        var _loc2 = nCell2 - nCell1;
        for (var _loc1 = 7; _loc1 >= 0; --_loc1)
        {
            if (_loc4[_loc1] == _loc2)
            {
                return (_loc1);
            } // end if
        } // end of for
        var _loc7 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell1);
        var _loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell2);
        var _loc5 = _loc6.x - _loc7.x;
        var _loc8 = _loc6.y - _loc7.y;
        if (_loc5 == 0)
        {
            if (_loc8 > 0)
            {
                return (3);
            }
            else
            {
                return (7);
            } // end else if
        }
        else if (_loc5 > 0)
        {
            return (1);
        }
        else
        {
            return (5);
        } // end else if
        return (-1);
    } // End of the function
    static function getDirectionFromCoordinates(x1, y1, x2, y2, bAllDirections)
    {
        var _loc1 = Math.atan2(y2 - y1, x2 - x1);
        if (bAllDirections)
        {
            if (_loc1 >= -3.926991E-001 && _loc1 < 3.926991E-001)
            {
                return (0);
            } // end if
            if (_loc1 >= 3.926991E-001 && _loc1 < 1.047198E+000)
            {
                return (1);
            } // end if
            if (_loc1 >= 1.047198E+000 && _loc1 < 2.094395E+000)
            {
                return (2);
            } // end if
            if (_loc1 >= 2.094395E+000 && _loc1 < 2.748894E+000)
            {
                return (3);
            } // end if
            if (_loc1 >= 2.748894E+000 || _loc1 < -2.748894E+000)
            {
                return (4);
            } // end if
            if (_loc1 >= -2.748894E+000 && _loc1 < -2.094395E+000)
            {
                return (5);
            } // end if
            if (_loc1 >= -2.094395E+000 && _loc1 < -1.047198E+000)
            {
                return (6);
            } // end if
            if (_loc1 >= -1.047198E+000 && _loc1 < -3.926991E-001)
            {
                return (7);
            } // end if
        }
        else
        {
            if (_loc1 >= 0 && _loc1 < 1.570796E+000)
            {
                return (1);
            } // end if
            if (_loc1 >= 1.570796E+000 && _loc1 <= 3.141593E+000)
            {
                return (3);
            } // end if
            if (_loc1 >= -3.141593E+000 && _loc1 < -1.570796E+000)
            {
                return (5);
            } // end if
            if (_loc1 >= -1.570796E+000 && _loc1 < 0)
            {
                return (7);
            } // end if
        } // end else if
        return (1);
    } // End of the function
    static function getArroundCellNum(mapHandler, nCellNum, nDirectionModerator, nIndex)
    {
        var _loc2 = mapHandler.getWidth();
        var _loc6 = [1, _loc2, _loc2 * 2 - 1, _loc2 - 1, -1, -_loc2, -_loc2 * 2 + 1, -(_loc2 - 1)];
        var _loc1 = 0;
        switch (nIndex % 8)
        {
            case 0:
            {
                _loc1 = 2;
                break;
            } 
            case 1:
            {
                _loc1 = 6;
                break;
            } 
            case 2:
            {
                _loc1 = 4;
                break;
            } 
            case 3:
            {
                _loc1 = 0;
                break;
            } 
            case 4:
            {
                _loc1 = 3;
                break;
            } 
            case 5:
            {
                _loc1 = 5;
                break;
            } 
            case 6:
            {
                _loc1 = 1;
                break;
            } 
            case 7:
            {
                _loc1 = 7;
                break;
            } 
        } // End of switch
        _loc1 = (_loc1 + nDirectionModerator) % 8;
        var _loc3 = nCellNum + _loc6[_loc1];
        var _loc4 = mapHandler.getCellsData();
        var _loc7 = _loc4[_loc3];
        if (_loc7.active && _loc4[_loc3] != undefined && Math.abs(_loc4[_loc3].x - _loc4[nCellNum].x) <= 53)
        {
            return (_loc3);
        }
        else
        {
            return (nCellNum);
        } // end else if
    } // End of the function
    static function convertHeightToFourDirection(nDirection)
    {
        return (nDirection | 1);
    } // End of the function
    static function getSlopeOk(slope1, level1, slope2, level2, dir)
    {
        switch (dir)
        {
            case 0:
            {
                if (((slope1 - 1 & 2) >> 1) + level1 != (slope2 - 1 & 1) + level2)
                {
                    return (false);
                } // end if
                break;
            } 
            case 1:
            {
                if (((slope1 - 1 & 4) >> 2) + level1 != ((slope2 - 1 & 2) >> 1) + level2)
                {
                    return (false);
                } // end if
                if (((slope1 - 1 & 8) >> 3) + level1 != (slope2 - 1 & 1) + level2)
                {
                    return (false);
                } // end if
                break;
            } 
            case 2:
            {
                if (((slope1 - 1 & 8) >> 3) + level1 != ((slope2 - 1 & 2) >> 1) + level2)
                {
                    return (false);
                } // end if
                break;
            } 
            case 3:
            {
                if (((slope1 - 1 & 8) >> 3) + level1 != ((slope2 - 1 & 4) >> 2) + level2)
                {
                    return (false);
                } // end if
                if ((slope1 - 1 & 1) + level1 != ((slope2 - 1 & 2) >> 1) + level2)
                {
                    return (false);
                } // end if
                break;
            } 
            case 4:
            {
                if ((slope1 - 1 & 1) + level1 != ((slope2 - 1 & 4) >> 2) + level2)
                {
                    return (false);
                } // end if
                break;
            } 
            case 5:
            {
                if ((slope1 - 1 & 1) + level1 != ((slope2 - 1 & 8) >> 3) + level2)
                {
                    return (false);
                } // end if
                if (((slope1 - 1 & 2) >> 1) + level1 != ((slope2 - 1 & 4) >> 2) + level2)
                {
                    return (false);
                } // end if
                break;
            } 
            case 6:
            {
                if (((slope1 - 1 & 2) >> 1) + level1 != ((slope2 - 1 & 8) >> 3) + level2)
                {
                    return (false);
                } // end if
                break;
            } 
            case 7:
            {
                if (((slope1 - 1 & 2) >> 1) + level1 != (slope2 - 1 & 1) + level2)
                {
                    return (false);
                } // end if
                if (((slope1 - 1 & 4) >> 2) + level1 != ((slope2 - 1 & 8) >> 3) + level2)
                {
                    return (false);
                } // end if
                break;
            } 
        } // End of switch
        return (true);
    } // End of the function
    static function checkView(mapHandler, cell1, cell2)
    {
        var _loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, cell1);
        var _loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, cell2);
        var _loc19 = mapHandler.getCellData(cell1);
        var _loc17 = mapHandler.getCellData(cell2);
        var _loc22 = _loc19.spriteOnID ? (1.500000E+000) : (0);
        var _loc21 = _loc17.spriteOnID ? (1.500000E+000) : (0);
        _loc5.z = mapHandler.getCellHeight(cell1) + _loc22;
        _loc6.z = mapHandler.getCellHeight(cell2) + _loc21;
        var _loc12 = _loc6.z - _loc5.z;
        var _loc11 = Math.max(Math.abs(_loc5.y - _loc6.y), Math.abs(_loc5.x - _loc6.x));
        var _loc14 = (_loc5.y - _loc6.y) / (_loc5.x - _loc6.x);
        var _loc15 = _loc5.y - _loc14 * _loc5.x;
        var _loc4 = _loc6.x - _loc5.x < 0 ? (-1) : (1);
        var _loc2 = _loc6.y - _loc5.y < 0 ? (-1) : (1);
        var _loc8 = _loc5.y;
        var _loc23 = _loc5.x;
        var _loc16 = _loc6.x * _loc4;
        var _loc24 = _loc6.y * _loc2;
        var _loc13;
        var _loc9;
        var _loc26;
        var _loc25;
        var _loc7;
        var _loc1;
        var _loc3;
        var _loc27;
        for (var _loc3 = _loc5.x + 5.000000E-001 * _loc4; _loc3 * _loc4 <= _loc16; _loc3 = _loc3 + _loc4)
        {
            _loc7 = _loc14 * _loc3 + _loc15;
            if (_loc2 > 0)
            {
                _loc13 = Math.round(_loc7);
                _loc9 = Math.ceil(_loc7 - 5.000000E-001);
            }
            else
            {
                _loc13 = Math.ceil(_loc7 - 5.000000E-001);
                _loc9 = Math.round(_loc7);
            } // end else if
            for (var _loc1 = _loc8; _loc1 * _loc2 <= _loc9 * _loc2; _loc1 = _loc1 + _loc2)
            {
                if (!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler, _loc3 - _loc4 / 2, _loc1, false, _loc5, _loc6, _loc12, _loc11))
                {
                    return (false);
                } // end if
            } // end of for
            _loc8 = _loc13;
        } // end of for
        for (var _loc1 = _loc8; _loc1 * _loc2 <= _loc6.y * _loc2; _loc1 = _loc1 + _loc2)
        {
            if (!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler, _loc3 - 5.000000E-001 * _loc4, _loc1, false, _loc5, _loc6, _loc12, _loc11))
            {
                return (false);
            } // end if
        } // end of for
        if (!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler, _loc3 - 5.000000E-001 * _loc4, _loc1 - _loc2, true, _loc5, _loc6, _loc12, _loc11))
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    static function checkCellView(mapHandler, x, y, bool, p1, p2, zDiff, d)
    {
        var _loc3 = ank.battlefield.utils.Pathfinding.getCaseNum(mapHandler, x, y);
        var _loc1 = mapHandler.getCellData(_loc3);
        var _loc2 = Math.max(Math.abs(p1.y - y), Math.abs(p1.x - x));
        var _loc4 = _loc2 / d * zDiff + p1.z;
        var _loc9 = mapHandler.getCellHeight(_loc3);
        var _loc5 = _loc1.spriteOnID == undefined || _loc2 == 0 || bool || p2.x == x && p2.y == y ? (false) : (true);
        if (_loc1.lineOfSight && _loc9 <= _loc4 && !_loc5)
        {
            return (true);
        }
        else
        {
            if (bool)
            {
                return (true);
            } // end if
            return (false);
        } // end else if
    } // End of the function
    static function getCaseNum(mapHandler, x, y)
    {
        var _loc1 = mapHandler.getWidth();
        return (x * _loc1 + y * (_loc1 - 1));
    } // End of the function
    static function checkAlign(mapHandler, cell1, cell2)
    {
        var _loc2 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, cell1);
        var _loc1 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, cell2);
        if (_loc2.x == _loc1.x)
        {
            return (true);
        } // end if
        if (_loc2.y == _loc1.y)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function checkRange(mapHandler, nCell1, nCell2, bLineOnly, nRangeMin, nRangeMax, nRangeModerator)
    {
        nRangeMin = Number(nRangeMin);
        nRangeMax = Number(nRangeMax);
        nRangeModerator = Number(nRangeModerator);
        var _loc8;
        if (nRangeMax != 0)
        {
            nRangeMax = nRangeMax + nRangeModerator;
            nRangeMax = Math.max(nRangeMin, nRangeMax);
        } // end if
        if (bLineOnly)
        {
            if (!ank.battlefield.utils.Pathfinding.checkAlign(mapHandler, nCell1, nCell2))
            {
                return (false);
            } // end if
        } // end if
        if (ank.battlefield.utils.Pathfinding.goalDistance(mapHandler, nCell1, nCell2) > nRangeMax || ank.battlefield.utils.Pathfinding.goalDistance(mapHandler, nCell1, nCell2) < nRangeMin)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
} // End of Class
#endinitclip
