// Action script...

// [Initial MovieClip Action of sprite 20835]
#initclip 100
if (!ank.battlefield.utils.Pathfinding)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.utils)
    {
        _global.ank.battlefield.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).prototype;
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).pathFind = function (mapHandler, nCellBegin, nCellEnd, oParams)
    {
        if (nCellBegin == undefined)
        {
            return (null);
        } // end if
        if (nCellEnd == undefined)
        {
            return (null);
        } // end if
        var _loc6 = oParams.bAllDirections == undefined ? (true) : (oParams.bAllDirections);
        var _loc7 = oParams.nMaxLength == undefined ? (500) : (oParams.nMaxLength);
        var _loc8 = oParams.bIgnoreSprites == undefined ? (false) : (oParams.bIgnoreSprites);
        var _loc9 = oParams.bCellNumOnly == undefined ? (false) : (oParams.bCellNumOnly);
        var _loc10 = oParams.bWithBeginCellNum == undefined ? (false) : (oParams.bWithBeginCellNum);
        var _loc11 = mapHandler.getWidth();
        if (_loc6)
        {
            var _loc12 = 8;
            var _loc13 = [1, _loc11, _loc11 * 2 - 1, _loc11 - 1, -1, -_loc11, -_loc11 * 2 + 1, -(_loc11 - 1)];
            var _loc14 = [1.500000E+000, 1, 1.500000E+000, 1, 1.500000E+000, 1, 1.500000E+000, 1];
        }
        else
        {
            _loc12 = 4;
            _loc13 = [_loc11, _loc11 - 1, -_loc11, -(_loc11 - 1)];
            _loc14 = [1, 1, 1, 1];
        } // end else if
        var _loc15 = mapHandler.getCellsData();
        var _loc16 = new Object();
        var _loc17 = new Object();
        var _loc18 = false;
        var _loc19 = _loc16["oCell" + nCellBegin] = new Object();
        _loc19.num = nCellBegin;
        _loc19.g = 0;
        _loc19.v = 0;
        _loc19.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler, nCellBegin, nCellEnd);
        _loc19.f = _loc19.h;
        _loc19.l = _loc15[nCellBegin].groundLevel;
        _loc19.m = _loc15[nCellBegin].movement;
        _loc19.parent = null;
        while (!_loc18)
        {
            var _loc20 = null;
            var _loc21 = 500000;
            for (var k in _loc16)
            {
                if (_loc16[k].f < _loc21)
                {
                    _loc21 = _loc16[k].f;
                    _loc20 = k;
                } // end if
            } // end of for...in
            var _loc22 = _loc16[_loc20];
            delete _loc16[_loc20];
            if (_loc22.num == nCellEnd)
            {
                var _loc23 = new Array();
                while (_loc22.num != nCellBegin)
                {
                    if (_loc22.m == 0)
                    {
                        _loc23 = new Array();
                    }
                    else if (_loc9)
                    {
                        _loc23.splice(0, 0, _loc22.num);
                    }
                    else
                    {
                        _loc23.splice(0, 0, {num: _loc22.num, dir: ank.battlefield.utils.Pathfinding.getDirection(mapHandler, _loc22.parent.num, _loc22.num)});
                    } // end else if
                    _loc22 = _loc22.parent;
                } // end while
                if (_loc10)
                {
                    if (_loc9)
                    {
                        _loc23.splice(0, 0, nCellBegin);
                    }
                    else
                    {
                        _loc23.splice(0, 0, {num: nCellBegin, dir: ank.battlefield.utils.Pathfinding.getDirection(mapHandler, _loc22.parent.num, nCellBegin)});
                    } // end if
                } // end else if
                return (_loc23);
            } // end if
            var _loc24 = false;
            var _loc25 = 0;
            
            while (++_loc25, _loc25 < _loc12)
            {
                var _loc26 = _loc22.num + _loc13[_loc25];
                if (Math.abs(_loc15[_loc26].x - _loc15[_loc22.num].x) <= 53)
                {
                    var _loc27 = _loc15[_loc26];
                    var _loc28 = _loc27.groundLevel;
                    var _loc29 = _loc8 ? (true) : (_loc27.spriteOnID != undefined ? (false) : (true));
                    _loc24 = _loc26 == nCellEnd && _loc27.movement == 1 ? (true) : (false);
                    var _loc30 = _loc22.l == undefined || Math.abs(_loc28 - _loc22.l) < 2;
                    if (_loc30 && (_loc27.active && _loc29))
                    {
                        var _loc31 = "oCell" + _loc26;
                        var _loc32 = _loc22.v + _loc14[_loc25] + (_loc27.movement == 0 || _loc27.movement == 1 ? (1000 + (_loc25 % 2 == 0 ? (3) : (0))) : (0)) + (_loc27.movement == 1 && _loc24 ? (-1000) : ((_loc25 != _loc22.d ? (5.000000E-001) : (0)) + (5 - _loc27.movement) / 3));
                        var _loc33 = _loc22.g + _loc14[_loc25];
                        var _loc34 = null;
                        if (_loc16[_loc31])
                        {
                            _loc34 = _loc16[_loc31].v;
                        }
                        else if (_loc17[_loc31])
                        {
                            _loc34 = _loc17[_loc31].v;
                        } // end else if
                        if ((_loc34 == null || _loc34 > _loc32) && _loc33 <= _loc7)
                        {
                            if (_loc17[_loc31])
                            {
                                delete _loc17[_loc31];
                            } // end if
                            var _loc35 = new Object();
                            _loc35.num = _loc26;
                            _loc35.g = _loc33;
                            _loc35.v = _loc32;
                            _loc35.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler, _loc26, nCellEnd);
                            _loc35.f = _loc35.v + _loc35.h;
                            _loc35.d = _loc25;
                            _loc35.l = _loc28;
                            _loc35.m = _loc27.movement;
                            _loc35.parent = _loc22;
                            _loc16[_loc31] = _loc35;
                        } // end if
                    } // end if
                } // end if
            } // end while
            _loc17["oCell" + _loc22.num] = {v: _loc22.v};
            _loc18 = true;
            for (var k in _loc16)
            {
                _loc18 = false;
                break;
            } // end of for...in
        } // end while
        return (null);
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).goalDistEstimate = function (mapHandler, nCell1, nCell2)
    {
        var _loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell1);
        var _loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell2);
        var _loc7 = Math.abs(_loc5.x - _loc6.x);
        var _loc8 = Math.abs(_loc5.y - _loc6.y);
        return (Math.sqrt(Math.pow(_loc7, 2) + Math.pow(_loc8, 2)));
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).goalDistance = function (mapHandler, nCell1, nCell2)
    {
        var _loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell1);
        var _loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell2);
        var _loc7 = Math.abs(_loc5.x - _loc6.x);
        var _loc8 = Math.abs(_loc5.y - _loc6.y);
        return (_loc7 + _loc8);
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).getCaseCoordonnee = function (mapHandler, nNum)
    {
        var _loc4 = mapHandler.getWidth();
        var _loc5 = Math.floor(nNum / (_loc4 * 2 - 1));
        var _loc6 = nNum - _loc5 * (_loc4 * 2 - 1);
        var _loc7 = _loc6 % _loc4;
        var _loc8 = new Object();
        _loc8.y = _loc5 - _loc7;
        _loc8.x = (nNum - (_loc4 - 1) * _loc8.y) / _loc4;
        return (_loc8);
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).getDirection = function (mapHandler, nCell1, nCell2)
    {
        var _loc5 = mapHandler.getWidth();
        var _loc6 = [1, _loc5, _loc5 * 2 - 1, _loc5 - 1, -1, -_loc5, -_loc5 * 2 + 1, -(_loc5 - 1)];
        var _loc7 = nCell2 - nCell1;
        for (var _loc8 = 7; _loc8 >= 0; --_loc8)
        {
            if (_loc6[_loc8] == _loc7)
            {
                return (_loc8);
            } // end if
        } // end of for
        var _loc9 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell1);
        var _loc10 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, nCell2);
        var _loc11 = _loc10.x - _loc9.x;
        var _loc12 = _loc10.y - _loc9.y;
        if (_loc11 == 0)
        {
            if (_loc12 > 0)
            {
                return (3);
            }
            else
            {
                return (7);
            } // end else if
        }
        else if (_loc11 > 0)
        {
            return (1);
        }
        else
        {
            return (5);
        } // end else if
        return (-1);
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).getDirectionFromCoordinates = function (x1, y1, x2, y2, bAllDirections)
    {
        var _loc7 = Math.atan2(y2 - y1, x2 - x1);
        if (bAllDirections)
        {
            if (_loc7 >= -Math.PI / 8 && _loc7 < Math.PI / 8)
            {
                return (0);
            } // end if
            if (_loc7 >= Math.PI / 8 && _loc7 < Math.PI / 3)
            {
                return (1);
            } // end if
            if (_loc7 >= Math.PI / 3 && _loc7 < 2 * Math.PI / 3)
            {
                return (2);
            } // end if
            if (_loc7 >= 2 * Math.PI / 3 && _loc7 < 7 * Math.PI / 8)
            {
                return (3);
            } // end if
            if (_loc7 >= 7 * Math.PI / 8 || _loc7 < -7 * Math.PI / 8)
            {
                return (4);
            } // end if
            if (_loc7 >= -7 * Math.PI / 8 && _loc7 < -2 * Math.PI / 3)
            {
                return (5);
            } // end if
            if (_loc7 >= -2 * Math.PI / 3 && _loc7 < -Math.PI / 3)
            {
                return (6);
            } // end if
            if (_loc7 >= -Math.PI / 3 && _loc7 < -Math.PI / 8)
            {
                return (7);
            } // end if
        }
        else
        {
            if (_loc7 >= 0 && _loc7 < Math.PI / 2)
            {
                return (1);
            } // end if
            if (_loc7 >= Math.PI / 2 && _loc7 <= Math.PI)
            {
                return (3);
            } // end if
            if (_loc7 >= -Math.PI && _loc7 < -Math.PI / 2)
            {
                return (5);
            } // end if
            if (_loc7 >= -Math.PI / 2 && _loc7 < 0)
            {
                return (7);
            } // end if
        } // end else if
        return (1);
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).getArroundCellNum = function (mapHandler, nCellNum, nDirectionModerator, nIndex)
    {
        var _loc6 = mapHandler.getWidth();
        var _loc7 = [1, _loc6, _loc6 * 2 - 1, _loc6 - 1, -1, -_loc6, -_loc6 * 2 + 1, -(_loc6 - 1)];
        var _loc8 = 0;
        switch (nIndex % 8)
        {
            case 0:
            {
                _loc8 = 2;
                break;
            } 
            case 1:
            {
                _loc8 = 6;
                break;
            } 
            case 2:
            {
                _loc8 = 4;
                break;
            } 
            case 3:
            {
                _loc8 = 0;
                break;
            } 
            case 4:
            {
                _loc8 = 3;
                break;
            } 
            case 5:
            {
                _loc8 = 5;
                break;
            } 
            case 6:
            {
                _loc8 = 1;
                break;
            } 
            case 7:
            {
                _loc8 = 7;
                break;
            } 
        } // End of switch
        _loc8 = (_loc8 + nDirectionModerator) % 8;
        var _loc9 = nCellNum + _loc7[_loc8];
        var _loc10 = mapHandler.getCellsData();
        var _loc11 = _loc10[_loc9];
        if (_loc11.active && (_loc10[_loc9] != undefined && Math.abs(_loc10[_loc9].x - _loc10[nCellNum].x) <= 53))
        {
            return (_loc9);
        }
        else
        {
            return (nCellNum);
        } // end else if
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).convertHeightToFourDirection = function (nDirection)
    {
        return (nDirection | 1);
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).getSlopeOk = function (slope1, level1, slope2, level2, dir)
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
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).checkView = function (mapHandler, cell1, cell2)
    {
        var _loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, cell1);
        var _loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, cell2);
        var _loc7 = mapHandler.getCellData(cell1);
        var _loc8 = mapHandler.getCellData(cell2);
        var _loc9 = _loc7.spriteOnID ? (1.500000E+000) : (0);
        var _loc10 = _loc8.spriteOnID ? (1.500000E+000) : (0);
        _loc9 = _loc9 + (_loc7.carriedSpriteOnId ? (1.500000E+000) : (0));
        _loc10 = _loc10 + (_loc8.carriedSpriteOnId ? (1.500000E+000) : (0));
        _loc5.z = mapHandler.getCellHeight(cell1) + _loc9;
        _loc6.z = mapHandler.getCellHeight(cell2) + _loc10;
        var _loc11 = _loc6.z - _loc5.z;
        var _loc12 = Math.max(Math.abs(_loc5.y - _loc6.y), Math.abs(_loc5.x - _loc6.x));
        var _loc13 = (_loc5.y - _loc6.y) / (_loc5.x - _loc6.x);
        var _loc14 = _loc5.y - _loc13 * _loc5.x;
        var _loc15 = _loc6.x - _loc5.x < 0 ? (-1) : (1);
        var _loc16 = _loc6.y - _loc5.y < 0 ? (-1) : (1);
        var _loc17 = _loc5.y;
        var _loc18 = _loc5.x;
        var _loc19 = _loc6.x * _loc15;
        var _loc20 = _loc6.y * _loc16;
        var _loc27 = _loc5.x + 5.000000E-001 * _loc15;
        
        while (_loc27 = _loc27 + _loc15, _loc27 * _loc15 <= _loc19)
        {
            var _loc25 = _loc13 * _loc27 + _loc14;
            if (_loc16 > 0)
            {
                var _loc21 = Math.round(_loc25);
                var _loc22 = Math.ceil(_loc25 - 5.000000E-001);
            }
            else
            {
                _loc21 = Math.ceil(_loc25 - 5.000000E-001);
                _loc22 = Math.round(_loc25);
            } // end else if
            var _loc26 = _loc17;
            
            while (_loc26 = _loc26 + _loc16, _loc26 * _loc16 <= _loc22 * _loc16)
            {
                if (!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler, _loc27 - _loc15 / 2, _loc26, false, _loc5, _loc6, _loc11, _loc12))
                {
                    return (false);
                } // end if
            } // end while
            _loc17 = _loc21;
        } // end while
        _loc26 = _loc17;
        
        while (_loc26 = _loc26 + _loc16, _loc26 * _loc16 <= _loc6.y * _loc16)
        {
            if (!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler, _loc27 - 5.000000E-001 * _loc15, _loc26, false, _loc5, _loc6, _loc11, _loc12))
            {
                return (false);
            } // end if
        } // end while
        if (!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler, _loc27 - 5.000000E-001 * _loc15, _loc26 - _loc16, true, _loc5, _loc6, _loc11, _loc12))
        {
            return (false);
        } // end if
        return (true);
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).checkCellView = function (mapHandler, x, y, bool, p1, p2, zDiff, d)
    {
        var _loc10 = ank.battlefield.utils.Pathfinding.getCaseNum(mapHandler, x, y);
        var _loc11 = mapHandler.getCellData(_loc10);
        var _loc12 = Math.max(Math.abs(p1.y - y), Math.abs(p1.x - x));
        var _loc13 = _loc12 / d * zDiff + p1.z;
        var _loc14 = mapHandler.getCellHeight(_loc10);
        var _loc15 = _loc11.spriteOnID == undefined || (_loc12 == 0 || (bool || p2.x == x && p2.y == y)) ? (false) : (true);
        if (_loc11.lineOfSight && (_loc14 <= _loc13 && !_loc15))
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
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).getCaseNum = function (mapHandler, x, y)
    {
        var _loc5 = mapHandler.getWidth();
        return (x * _loc5 + y * (_loc5 - 1));
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).checkAlign = function (mapHandler, cell1, cell2)
    {
        var _loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, cell1);
        var _loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler, cell2);
        if (_loc5.x == _loc6.x)
        {
            return (true);
        } // end if
        if (_loc5.y == _loc6.y)
        {
            return (true);
        } // end if
        return (false);
    };
    (_global.ank.battlefield.utils.Pathfinding = function ()
    {
    }).checkRange = function (mapHandler, nCell1, nCell2, bLineOnly, nRangeMin, nRangeMax, nRangeModerator)
    {
        nRangeMin = Number(nRangeMin);
        nRangeMax = Number(nRangeMax);
        nRangeModerator = Number(nRangeModerator);
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
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
