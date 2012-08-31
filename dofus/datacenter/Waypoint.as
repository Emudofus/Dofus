// Action script...

// [Initial MovieClip Action of sprite 959]
#initclip 171
class dofus.datacenter.Waypoint extends Object
{
    var api, _nID, _bCurrent, _bRespawn, __get__name, fieldToSort, __get__coordinates, __get__cost, __get__id, __get__isCurrent, __get__isRespawn;
    function Waypoint(nID, bCurrent, bRespawn)
    {
        super();
        api = _global.API;
        _nID = nID;
        _bCurrent = bCurrent;
        _bRespawn = bRespawn;
        fieldToSort = this.__get__name() + nID;
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function get name()
    {
        return (api.kernel.MapsServersManager.getMapName(_nID));
    } // End of the function
    function get coordinates()
    {
        return (api.lang.getMapText(String(_nID)).x + ", " + api.lang.getMapText(String(_nID)).y);
    } // End of the function
    function get isRespawn()
    {
        return (_bRespawn);
    } // End of the function
    function get isCurrent()
    {
        return (_bCurrent);
    } // End of the function
    function get cost()
    {
        var _loc2 = api.datacenter.Map;
        var _loc3 = api.lang.getMapText(String(_nID));
        var _loc4 = Math.floor(Math.sqrt(Math.pow(_loc3.x - _loc2.x, 2) + Math.pow(_loc3.y - _loc2.y, 2)));
        return (_loc4 * api.lang.getConfigText("WAYPOINT_BASE_PRICE"));
    } // End of the function
} // End of Class
#endinitclip
