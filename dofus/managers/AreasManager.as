// Action script...

// [Initial MovieClip Action of sprite 902]
#initclip 114
class dofus.managers.AreasManager extends dofus.utils.ApiElement
{
    var _oAreasCoords, api;
    function AreasManager()
    {
        super();
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        _oAreasCoords = new Object();
        var _loc6 = api.lang.getAllMapsInfos();
        for (var _loc7 in _loc6)
        {
            var _loc3 = _loc6[_loc7];
            var _loc5 = _loc3.x + "_" + _loc3.y;
            var _loc4 = api.lang.getMapSubAreaText(_loc3.sa).a;
            _oAreasCoords[_loc5] = _loc4;
        } // end of for...in
    } // End of the function
    function getAreaIDFromCoordinates(nX, nY)
    {
        return (_oAreasCoords[nX + "_" + nY]);
    } // End of the function
} // End of Class
#endinitclip
