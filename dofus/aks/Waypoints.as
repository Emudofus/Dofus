// Action script...

// [Initial MovieClip Action of sprite 20976]
#initclip 241
if (!dofus.aks.Waypoints)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Waypoints = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.leave = function ()
    {
        this.aks.send("WV", true);
    };
    _loc1.use = function (nWaypointID)
    {
        this.aks.send("WU" + nWaypointID, true);
    };
    _loc1.onCreate = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = 1;
        
        while (++_loc6, _loc6 < _loc3.length)
        {
            var _loc7 = _loc3[_loc6].split(";");
            var _loc8 = Number(_loc7[0]);
            var _loc9 = Number(_loc7[1]);
            var _loc10 = new dofus.datacenter.Waypoint(_loc8, _loc8 == this.api.datacenter.Map.id, _loc8 == _loc4, _loc9);
            _loc5.push(_loc10);
        } // end while
        this.api.ui.loadUIComponent("Waypoints", "Waypoints", {data: _loc5});
    };
    _loc1.onLeave = function ()
    {
        this.api.ui.unloadUIComponent("Waypoints");
    };
    _loc1.onUseError = function ()
    {
        this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_USE_WAYPOINT"), "ERROR_CHAT");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
