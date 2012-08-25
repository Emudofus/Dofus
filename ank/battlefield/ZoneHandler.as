// Action script...

// [Initial MovieClip Action of sprite 20900]
#initclip 165
if (!ank.battlefield.ZoneHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.ZoneHandler = function (b, c)
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
        this._mcZones.removeMovieClip();
        this._mcZones = this._mcContainer.createEmptyMovieClip("zones", 10);
        this._nNextLayerDepth = 0;
    };
    _loc1.clearZone = function (nCellNum, radius, layer)
    {
        nCellNum = Number(nCellNum);
        radius = Number(radius);
        if (nCellNum < 0)
        {
            return;
        } // end if
        if (nCellNum > this._mcBattlefield.mapHandler.getCellCount())
        {
            return;
        } // end if
        var _loc5 = nCellNum * 1000 + radius * 100;
        this._mcZones[layer]["zone" + _loc5].clear();
    };
    _loc1.clearZoneLayer = function (layer)
    {
        this._mcZones[layer].removeMovieClip();
    };
    _loc1.drawZone = function (nCellNum, radiusIn, radiusOut, layer, col, shape)
    {
        nCellNum = Number(nCellNum);
        radiusIn = Number(radiusIn);
        radiusOut = Number(radiusOut);
        col = Number(col);
        if (nCellNum < 0)
        {
            return;
        } // end if
        if (nCellNum > this._mcBattlefield.mapHandler.getCellCount())
        {
            return;
        } // end if
        if (_global.isNaN(radiusIn) || _global.isNaN(radiusOut))
        {
            return;
        } // end if
        var _loc8 = nCellNum * 1000 + radiusOut * 100;
        if (this._mcZones[layer] == undefined)
        {
            this._mcZones.createEmptyMovieClip(layer, this._nNextLayerDepth++);
        } // end if
        this._mcZones[layer].__proto__ = MovieClip.prototype;
        this._mcZones[layer].cacheAsBitmap = this._mcZones.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["Zone/Zone"];
        var _loc9 = this._mcZones[layer].attachClassMovie(ank.battlefield.mc.Zone, "zone" + _loc8, _loc8, [this._mcBattlefield.mapHandler]);
        switch (shape)
        {
            case "C":
            {
                if (radiusIn == 0)
                {
                    _loc9.drawCircle(radiusOut, col, nCellNum);
                }
                else
                {
                    if (radiusIn > 0)
                    {
                        radiusIn = radiusIn - 1;
                    } // end if
                    _loc9.drawRing(radiusIn, radiusOut, col, nCellNum);
                } // end else if
                break;
            } 
            case "X":
            {
                if (radiusIn == 0)
                {
                    _loc9.drawCross(radiusOut, col, nCellNum);
                }
                else
                {
                    var _loc10 = this._mcBattlefield.mapHandler;
                    var _loc12 = _loc10.getWidth();
                    var _loc13 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, nCellNum);
                    var _loc11 = nCellNum - _loc12 * radiusIn;
                    if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, _loc11).y == _loc13.y)
                    {
                        _loc9.drawLine(radiusOut - radiusIn, col, _loc11, nCellNum, true);
                    } // end if
                    _loc11 = nCellNum - (_loc12 - 1) * radiusIn;
                    if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, _loc11).x == _loc13.x)
                    {
                        _loc9.drawLine(radiusOut - radiusIn, col, _loc11, nCellNum, true);
                    } // end if
                    _loc11 = nCellNum + _loc12 * radiusIn;
                    if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, _loc11).y == _loc13.y)
                    {
                        _loc9.drawLine(radiusOut - radiusIn, col, _loc11, nCellNum, true);
                    } // end if
                    _loc11 = nCellNum + (_loc12 - 1) * radiusIn;
                    if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10, _loc11).x == _loc13.x)
                    {
                        _loc9.drawLine(radiusOut - radiusIn, col, _loc11, nCellNum, true);
                    } // end if
                } // end else if
                break;
            } 
            default:
            {
                _loc9.drawCircle(radiusOut, col, nCellNum);
            } 
        } // End of switch
        this.moveZoneTo(_loc9, nCellNum);
    };
    _loc1.moveZoneTo = function (zone, nCellNum)
    {
        var _loc4 = this._mcBattlefield.mapHandler.getCellData(nCellNum);
        zone._x = _loc4.x;
        zone._y = _loc4.y + ank.battlefield.Constants.LEVEL_HEIGHT * (_loc4.groundLevel - 7);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
