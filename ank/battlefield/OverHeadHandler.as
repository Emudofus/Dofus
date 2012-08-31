// Action script...

// [Initial MovieClip Action of sprite 864]
#initclip 76
class ank.battlefield.OverHeadHandler
{
    var _mcBattlefield, _mcContainer;
    function OverHeadHandler(b, c)
    {
        this.initialize(b, c);
    } // End of the function
    function initialize(b, c)
    {
        _mcBattlefield = b;
        _mcContainer = c;
    } // End of the function
    function clear()
    {
        for (var _loc2 in _mcContainer)
        {
            if (typeof(_mcContainer[_loc2]) == "movieclip")
            {
                _mcContainer[_loc2].swapDepths(0);
                _mcContainer[_loc2].removeMovieClip();
            } // end if
        } // end of for...in
    } // End of the function
    function addOverHeadItem(sID, nX, nY, mcSprite, sLayerName, fClassName, aParams, nDelay)
    {
        var _loc2 = _mcContainer["oh" + sID];
        var _loc3 = _mcBattlefield.getZoom();
        if (_loc2 == undefined)
        {
            _loc2 = _mcContainer.attachClassMovie(ank.battlefield.mc.OverHead, "oh" + sID, _mcContainer.getNextHighestDepth(), [mcSprite, _loc3]);
        } // end if
        _loc2._x = nX;
        _loc2._y = nY;
        if (_loc3 < 100)
        {
            _loc2._xscale = _loc2._yscale = 10000 / _loc3;
        } // end if
        _loc2.addItem(sLayerName, fClassName, aParams, nDelay);
    } // End of the function
    function removeOverHeadLayer(sID, sLayerName)
    {
        var _loc2 = _mcContainer["oh" + sID];
        _loc2.removeLayer(sLayerName);
    } // End of the function
    function removeOverHead(sID)
    {
        var _loc2 = _mcContainer["oh" + sID];
        _loc2.remove();
    } // End of the function
} // End of Class
#endinitclip
