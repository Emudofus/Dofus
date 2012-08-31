// Action script...

// [Initial MovieClip Action of sprite 854]
#initclip 66
class ank.battlefield.ZoneHandler
{
    var _mcBattlefield, _mcContainer, _mcZones, _nNextLayerDepth;
    function ZoneHandler(b, c)
    {
        this.initialize(b, c);
    } // End of the function
    function initialize(b, c)
    {
        _mcBattlefield = b;
        _mcContainer = c;
        this.clear();
    } // End of the function
    function clear(Void)
    {
        _mcZones.removeMovieClip();
        _mcZones = _mcContainer.createEmptyMovieClip("zones", 10);
        _nNextLayerDepth = 0;
    } // End of the function
    function clearZone(nCellNum, radius, layer)
    {
        nCellNum = Number(nCellNum);
        radius = Number(radius);
        if (nCellNum < 0)
        {
            return;
        } // end if
        if (nCellNum > _mcBattlefield.mapHandler.getCellCount())
        {
            return;
        } // end if
        var _loc3 = nCellNum * 1000 + radius * 100;
        _mcZones[layer]["zone" + _loc3].clear();
    } // End of the function
    function clearZoneLayer(layer)
    {
        _mcZones[layer].removeMovieClip();
    } // End of the function
    function drawZone(nCellNum, radiusIn, radiusOut, layer, col, shape)
    {
        nCellNum = Number(nCellNum);
        radiusIn = Number(radiusIn);
        radiusOut = Number(radiusOut);
        col = Number(col);
        if (nCellNum < 0)
        {
            return;
        } // end if
        if (nCellNum > _mcBattlefield.mapHandler.getCellCount())
        {
            return;
        } // end if
        if (isNaN(radiusIn) || isNaN(radiusOut))
        {
            return;
        } // end if
        var _loc11 = nCellNum * 1000 + radiusOut * 100;
        if (_mcZones[layer] == undefined)
        {
            _mcZones.createEmptyMovieClip(layer, _nNextLayerDepth++);
        } // end if
        var _loc6 = _mcZones[layer].attachClassMovie(ank.battlefield.mc.Zone, "zone" + _loc11, _loc11, [_mcBattlefield.mapHandler]);
        switch (shape)
        {
            case "C":
            {
                if (radiusIn == 0)
                {
                    _loc6.drawCircle(radiusOut, col, nCellNum);
                }
                else
                {
                    if (radiusIn > 0)
                    {
                        radiusIn = radiusIn - 1;
                    } // end if
                    _loc6.drawRing(radiusIn, radiusOut, col, nCellNum);
                } // end else if
                break;
            } 
            case "X":
            {
                if (radiusIn == 0)
                {
                    _loc6.drawCross(radiusOut, col, nCellNum);
                }
                else
                {
                    var _loc8 = _mcBattlefield.mapHandler;
                    var _loc4;
                    var _loc10 = _loc8.getWidth();
                    var _loc9 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc8, nCellNum);
                    _loc4 = nCellNum - _loc10 * radiusIn;
                    if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc8, _loc4).y == _loc9.y)
                    {
                        _loc6.drawLine(radiusOut - radiusIn, col, _loc4, nCellNum, true);
                    } // end if
                    _loc4 = nCellNum - (_loc10 - 1) * radiusIn;
                    if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc8, _loc4).x == _loc9.x)
                    {
                        _loc6.drawLine(radiusOut - radiusIn, col, _loc4, nCellNum, true);
                    } // end if
                    _loc4 = nCellNum + _loc10 * radiusIn;
                    if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc8, _loc4).y == _loc9.y)
                    {
                        _loc6.drawLine(radiusOut - radiusIn, col, _loc4, nCellNum, true);
                    } // end if
                    _loc4 = nCellNum + (_loc10 - 1) * radiusIn;
                    if (ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc8, _loc4).x == _loc9.x)
                    {
                        _loc6.drawLine(radiusOut - radiusIn, col, _loc4, nCellNum, true);
                    } // end if
                } // end else if
                break;
            } 
            default:
            {
                _loc6.drawCircle(radiusOut, col, nCellNum);
            } 
        } // End of switch
        this.moveZoneTo(_loc6, nCellNum);
    } // End of the function
    function moveZoneTo(zone, nCellNum)
    {
        var _loc2 = _mcBattlefield.mapHandler.getCellData(nCellNum);
        zone._x = _loc2.x;
        zone._y = _loc2.y + ank.battlefield.Constants.LEVEL_HEIGHT * (_loc2.groundLevel - 7);
    } // End of the function
} // End of Class
#endinitclip
