// Action script...

// [Initial MovieClip Action of sprite 20799]
#initclip 64
if (!ank.battlefield.PointerHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.PointerHandler = function (b, c)
    {
        this.initialize(b, c);
    }).prototype;
    _loc1.initialize = function (b, c)
    {
        this._mcBattlefield = b;
        this._mcContainer = c;
        this.clear();
    };
    _loc1.clear = function (Void)
    {
        this.hide();
        this._aShapes = new Array();
    };
    _loc1.hide = function (Void)
    {
        this._mcZones.removeMovieClip();
        this._mcZones = this._mcContainer.createEmptyMovieClip("zones", 2);
        this._mcZones.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["Zone/Pointers"];
    };
    _loc1.addShape = function (sShape, mSize, nColor, nCellNumRef)
    {
        this._aShapes.push({shape: sShape, size: mSize, col: nColor, cellNumRef: nCellNumRef});
    };
    _loc1.draw = function (nCellNum)
    {
        var _loc3 = this._aShapes;
        if (_loc3.length == 0)
        {
            return;
        } // end if
        this.hide();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            this._mcZones.__proto__ = MovieClip.prototype;
            var _loc5 = this._mcZones.attachClassMovie(ank.battlefield.mc.Zone, "zone" + _loc4, 10 * _loc4, [this._mcBattlefield.mapHandler]);
            switch (_loc3[_loc4].shape)
            {
                case "P":
                {
                    _loc5.drawCircle(0, _loc3[_loc4].col, nCellNum);
                    break;
                } 
                case "C":
                {
                    if (typeof(_loc3[_loc4].size) == "number")
                    {
                        _loc5.drawCircle(_loc3[_loc4].size, _loc3[_loc4].col, nCellNum);
                    }
                    else if (_loc3[_loc4].size[0] == 0 && !_global.isNaN(Number(_loc3[_loc4].size[1])))
                    {
                        _loc5.drawCircle(Number(_loc3[_loc4].size[1]), _loc3[_loc4].col, nCellNum);
                    }
                    else
                    {
                        var _loc6 = 0;
                        if (_loc3[_loc4].size[0] > 0)
                        {
                            _loc6 = -1;
                        } // end if
                        _loc5.drawRing(_loc3[_loc4].size[0] + _loc6, _loc3[_loc4].size[1], _loc3[_loc4].col, nCellNum);
                    } // end else if
                    break;
                } 
                case "D":
                {
                    var _loc7 = -1;
                    var _loc8 = -1;
                    if (typeof(_loc3[_loc4].size) == "number")
                    {
                        _loc8 = Number(_loc3[_loc4].size);
                        _loc7 = _loc8 % 2 == 0 ? (1) : (0);
                    }
                    else
                    {
                        _loc7 = Number(_loc3[_loc4].size[1]);
                        _loc8 = Number(_loc3[_loc4].size[0]);
                    } // end else if
                    var _loc9 = _loc7;
                    
                    while (_loc9 = _loc9 + 2, _loc9 < _loc8)
                    {
                        _loc5.drawRing(_loc9 + 1, _loc9, _loc3[_loc4].col, nCellNum);
                    } // end while
                    break;
                } 
                case "L":
                {
                    _loc5.drawLine(_loc3[_loc4].size, _loc3[_loc4].col, nCellNum, _loc3[_loc4].cellNumRef);
                    break;
                } 
                case "X":
                {
                    if (typeof(_loc3[_loc4].size) == "number")
                    {
                        _loc5.drawCross(_loc3[_loc4].size, _loc3[_loc4].col, nCellNum);
                    }
                    else
                    {
                        var _loc10 = this._mcBattlefield.mapHandler;
                        var _loc12 = _loc10.getWidth();
                        var _loc13 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, nCellNum);
                        var _loc11 = nCellNum - _loc12 * _loc3[_loc4].size[0];
                        if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, _loc11).y == _loc13.y)
                        {
                            _loc5.drawLine(_loc3[_loc4].size[1] - _loc3[_loc4].size[0], _loc3[_loc4].col, _loc11, nCellNum, true);
                        } // end if
                        _loc11 = nCellNum - (_loc12 - 1) * _loc3[_loc4].size[0];
                        if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, _loc11).x == _loc13.x)
                        {
                            _loc5.drawLine(_loc3[_loc4].size[1] - _loc3[_loc4].size[0], _loc3[_loc4].col, _loc11, nCellNum, true);
                        } // end if
                        _loc11 = nCellNum + _loc12 * _loc3[_loc4].size[0];
                        if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, _loc11).y == _loc13.y)
                        {
                            _loc5.drawLine(_loc3[_loc4].size[1] - _loc3[_loc4].size[0], _loc3[_loc4].col, _loc11, nCellNum, true);
                        } // end if
                        _loc11 = nCellNum + (_loc12 - 1) * _loc3[_loc4].size[0];
                        if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, _loc11).x == _loc13.x)
                        {
                            _loc5.drawLine(_loc3[_loc4].size[1] - _loc3[_loc4].size[0], _loc3[_loc4].col, _loc11, nCellNum, true);
                        } // end if
                    } // end else if
                    break;
                } 
                case "T":
                {
                    _loc5.drawLine(_loc3[_loc4].size, _loc3[_loc4].col, nCellNum, _loc3[_loc4].cellNumRef, false, true);
                    break;
                } 
                case "R":
                {
                    _loc5.drawRectangle(_loc3[_loc4].size[0], _loc3[_loc4].size[1], _loc3[_loc4].col, nCellNum);
                    break;
                } 
                case "O":
                {
                    _loc5.drawRing(_loc3[_loc4].size, _loc3[_loc4].size - 1, _loc3[_loc4].col, nCellNum);
                    break;
                } 
            } // End of switch
            this.movePointerTo(_loc5, nCellNum);
        } // end while
    };
    _loc1.movePointerTo = function (mcZone, nCellNum)
    {
        var _loc4 = this._mcBattlefield.mapHandler.getCellData(nCellNum);
        mcZone._x = _loc4.x;
        mcZone._y = _loc4.y + ank.battlefield.Constants.LEVEL_HEIGHT * (_loc4.groundLevel - 7);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
