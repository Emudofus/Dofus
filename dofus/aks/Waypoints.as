// Action script...

// [Initial MovieClip Action of sprite 958]
#initclip 170
class dofus.aks.Waypoints extends dofus.aks.Handler
{
    var aks, api;
    function Waypoints(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function leave()
    {
        aks.send("WV");
    } // End of the function
    function use(nWaypointID)
    {
        aks.send("WU" + nWaypointID);
    } // End of the function
    function onCreate(sExtraData)
    {
        var _loc5 = sExtraData.split("|");
        var _loc7 = Number(_loc5[0]);
        var _loc6 = new ank.utils.ExtendedArray();
        for (var _loc3 = 1; _loc3 < _loc5.length; ++_loc3)
        {
            var _loc2 = Number(_loc5[_loc3]);
            var _loc4 = new dofus.datacenter.Waypoint(_loc2, _loc2 == api.datacenter.Map.id, _loc2 == _loc7);
            _loc6.push(_loc4);
        } // end of for
        api.ui.loadUIComponent("Waypoints", "Waypoints", {data: _loc6});
    } // End of the function
    function onLeave()
    {
        api.ui.unloadUIComponent("Waypoints");
    } // End of the function
    function onUseError()
    {
        api.kernel.showMessage(undefined, api.lang.getText("CANT_USE_WAYPOINT"), "ERROR_CHAT");
    } // End of the function
} // End of Class
#endinitclip
