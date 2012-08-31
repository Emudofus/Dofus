// Action script...

// [Initial MovieClip Action of sprite 868]
#initclip 80
class ank.battlefield.PointsHandler
{
    var _mcBattlefield, _mcContainer, _oDatacenter, _oList;
    function PointsHandler(b, c, d)
    {
        this.initialize(b, c, d);
    } // End of the function
    function initialize(b, c, d)
    {
        _mcBattlefield = b;
        _mcContainer = c;
        _oDatacenter = d;
        _oList = new Object();
    } // End of the function
    function clear()
    {
        for (var _loc2 in _mcContainer)
        {
            _mcContainer[_loc2].removeMovieClip();
        } // end of for...in
    } // End of the function
    function addPoints(sID, nX, nY, sValue, nColor)
    {
        var _loc4 = _mcContainer.getNextHighestDepth();
        var _loc2 = _mcContainer.attachClassMovie(ank.battlefield.mc.Points, "points" + _loc4, _loc4, [this, sID, nY, sValue, nColor]);
        _loc2._x = nX;
        _loc2._y = nY;
        if (_oList[sID] == undefined)
        {
            _oList[sID] = new Array();
        } // end if
        _oList[sID].push(_loc2);
        if (_oList[sID].length == 1)
        {
            _loc2.animate();
        } // end if
    } // End of the function
    function onAnimateFinished(sID)
    {
        var _loc2 = _oList[sID];
        _loc2.shift();
        if (_loc2.length != 0)
        {
            _loc2[0].animate();
        } // end if
    } // End of the function
} // End of Class
#endinitclip
