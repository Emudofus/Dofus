// Action script...

// [Initial MovieClip Action of sprite 866]
#initclip 78
class ank.battlefield.TextHandler
{
    var _mcBattlefield, _mcContainer, _oDatacenter;
    function TextHandler(b, c, d)
    {
        this.initialize(b, c, d);
    } // End of the function
    function initialize(b, c, d)
    {
        _mcBattlefield = b;
        _mcContainer = c;
        _oDatacenter = d;
    } // End of the function
    function clear()
    {
        for (var _loc2 in _mcContainer)
        {
            _mcContainer[_loc2].removeMovieClip();
        } // end of for...in
    } // End of the function
    function addBubble(sID, nX, nY, sText)
    {
        var _loc4 = (_oDatacenter.Map.width - 1) * ank.battlefield.Constants.CELL_WIDTH;
        this.removeBubble(sID);
        var _loc2 = _mcContainer.attachClassMovie(ank.battlefield.mc.Bubble, "bubble" + sID, _mcContainer.getNextHighestDepth(), [sText, nX, nY, _loc4]);
        var _loc3 = _mcBattlefield.getZoom();
        if (_loc3 < 100)
        {
            _loc2._xscale = _loc2._yscale = 10000 / _loc3;
        } // end if
    } // End of the function
    function removeBubble(sID)
    {
        var _loc2 = _mcContainer["bubble" + sID];
        _loc2.remove();
    } // End of the function
} // End of Class
#endinitclip
