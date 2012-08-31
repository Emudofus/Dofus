// Action script...

// [Initial MovieClip Action of sprite 851]
#initclip 63
class ank.battlefield.PointerHandler
{
    var _mcBattlefield, _mcContainer, _aShapes, _mcZones;
    function PointerHandler(b, c)
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
        this.hide();
        _aShapes = new Array();
    } // End of the function
    function hide(Void)
    {
        _mcZones.removeMovieClip();
        _mcZones = _mcContainer.createEmptyMovieClip("zones", 2);
    } // End of the function
    function addShape(sShape, mSize, nColor, nCellNumRef)
    {
        _aShapes.push({shape: sShape, size: mSize, col: nColor, cellNumRef: nCellNumRef});
    } // End of the function
    function draw(nCellNum)
    {
        var _loc3 = _aShapes;
        if (_loc3.length == 0)
        {
            return;
        } // end if
        this.hide();
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            var _loc4 = _mcZones.attachClassMovie(ank.battlefield.mc.Zone, "zone" + _loc2, 10 * _loc2, [_mcBattlefield.mapHandler]);
            switch (_loc3[_loc2].shape)
            {
                case "P":
                {
                    _loc4.drawCircle(0, _loc3[_loc2].col, nCellNum);
                    break;
                } 
                case "C":
                {
                    _loc4.drawCircle(_loc3[_loc2].size, _loc3[_loc2].col, nCellNum);
                    break;
                } 
                case "L":
                {
                    _loc4.drawLine(_loc3[_loc2].size, _loc3[_loc2].col, nCellNum, _loc3[_loc2].cellNumRef);
                    break;
                } 
                case "X":
                {
                    _loc4.drawCross(_loc3[_loc2].size, _loc3[_loc2].col, nCellNum);
                    break;
                } 
                case "T":
                {
                    _loc4.drawLine(_loc3[_loc2].size, _loc3[_loc2].col, nCellNum, _loc3[_loc2].cellNumRef, false, true);
                    break;
                } 
                case "R":
                {
                    _loc4.drawRectangle(_loc3[_loc2].size[0], _loc3[_loc2].size[1], _loc3[_loc2].col, nCellNum);
                    break;
                } 
            } // End of switch
            this.movePointerTo(_loc4, nCellNum);
        } // end of for
    } // End of the function
    function movePointerTo(mcZone, nCellNum)
    {
        var _loc2 = _mcBattlefield.mapHandler.getCellData(nCellNum);
        mcZone._x = _loc2.x;
        mcZone._y = _loc2.y + ank.battlefield.Constants.LEVEL_HEIGHT * (_loc2.groundLevel - 7);
    } // End of the function
} // End of Class
#endinitclip
