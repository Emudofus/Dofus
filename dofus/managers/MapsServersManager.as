// Action script...

// [Initial MovieClip Action of sprite 886]
#initclip 98
class dofus.managers.MapsServersManager extends dofus.managers.ServersManager
{
    var api, _aServersList, _nCurrentServerIndex, _nIndexMax, loadData;
    function MapsServersManager()
    {
        super();
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        if (api.lang == undefined)
        {
            ank.utils.Logger.err("[MapsServersManager] pas de fich de langue");
            return;
        } // end if
        _aServersList = api.lang.getConfigText("MAPS_DATA_PATH");
        _nCurrentServerIndex = random(_aServersList.length);
        _nIndexMax = _aServersList.length - 1;
    } // End of the function
    function loadMap(sID, sDate)
    {
        this.loadData(sID + "_" + sDate + ".swf", false, true);
    } // End of the function
    function getMapName(nMapID)
    {
        var _loc2 = api.lang.getMapText(String(nMapID));
        var _loc4 = api.lang.getMapAreaInfos(_loc2.sa);
        var _loc5 = api.lang.getMapAreaText(_loc4.areaID).n;
        var _loc3 = api.lang.getMapSubAreaText(_loc2.sa).n;
        return (_loc5 + (_loc3.indexOf("//") == -1 ? (" (" + _loc3 + ")") : ("")));
    } // End of the function
    function onComplete(mc)
    {
        var _loc2 = mc;
        var _loc4 = Number(_loc2.id);
        var _loc6 = this.getMapName(_loc4);
        var _loc10 = Number(_loc2.width);
        var _loc14 = Number(_loc2.height);
        var _loc15 = Number(_loc2.backgroundNum);
        var _loc13 = _loc2.mapData;
        var _loc8 = _loc2.ambianceId;
        var _loc16 = _loc2.musicId;
        var _loc11 = _loc2.bOutdoor == 1 ? (true) : (false);
        var _loc5 = (_loc2.capabilities & 1) == 0;
        var _loc7 = (_loc2.capabilities >> 1 & 1) == 0;
        var _loc12 = (_loc2.capabilities >> 2 & 1) == 0;
        var _loc9 = (_loc2.capabilities >> 3 & 1) == 0;
        var _loc3 = new dofus.datacenter.DofusMap(_loc4);
        _loc3.bCanChallenge = _loc5;
        _loc3.bCanAttack = _loc7;
        _loc3.bSaveTeleport = _loc12;
        _loc3.bUseTeleport = _loc9;
        _loc3.bOutdoor = _loc11;
        _loc3.ambianceID = _loc8;
        _loc3.musicID = _loc16;
        api.gfx.buildMap(_loc4, _loc6, _loc10, _loc14, _loc15, _loc13, _loc3);
    } // End of the function
    function onError()
    {
        api.kernel.showMessage(undefined, api.lang.getText("NO_MAPDATA_FILE"), "ERROR_BOX", {name: "NoMapData"});
    } // End of the function
} // End of Class
#endinitclip
