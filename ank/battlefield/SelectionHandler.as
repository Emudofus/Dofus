// Action script...

// [Initial MovieClip Action of sprite 856]
#initclip 68
class ank.battlefield.SelectionHandler
{
    var _mcBattlefield, _oDatacenter, _mcContainer;
    function SelectionHandler(b, c, d)
    {
        this.initialize(b, c, d);
    } // End of the function
    function initialize(b, c, d)
    {
        _mcBattlefield = b;
        _oDatacenter = d;
        _mcContainer = c;
        this.clear();
    } // End of the function
    function clear(Void)
    {
        for (var _loc2 in _mcContainer)
        {
            _mcContainer[_loc2].removeMovieClip();
        } // end of for...in
    } // End of the function
    function select(bSelected, nCellNum, nColor)
    {
        var _loc2 = _mcBattlefield.mapHandler.getCellData(nCellNum);
        if (_loc2 != undefined)
        {
            var _loc4 = "cell" + String(nCellNum);
            if (bSelected)
            {
                var _loc3 = _mcContainer.attachMovie("s" + _loc2.groundSlope, _loc4, nCellNum * 100);
                _loc3._x = _loc2.x;
                _loc3._y = _loc2.y;
                var _loc5 = new Color(_loc3);
                _loc5.setRGB(nColor);
            }
            else
            {
                _mcContainer[_loc4].removeMovieClip();
            } // end if
        } // end else if
    } // End of the function
    function selectMultiple(bSelect, aCellList, nColor)
    {
        for (var _loc5 in aCellList)
        {
            this.select(bSelect, aCellList[_loc5], nColor);
        } // end of for...in
    } // End of the function
} // End of Class
#endinitclip
