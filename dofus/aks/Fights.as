// Action script...

// [Initial MovieClip Action of sprite 963]
#initclip 175
class dofus.aks.Fights extends dofus.aks.Handler
{
    var aks, api;
    function Fights(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function getList()
    {
        aks.send("fL");
    } // End of the function
    function getDetails(nID)
    {
        aks.send("fD" + nID, false);
    } // End of the function
    function setSecret()
    {
        aks.send("fS");
    } // End of the function
    function onCount(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        if (isNaN(_loc2) || sExtraData.length == 0 || _loc2 == 0)
        {
            api.ui.getUIComponent("Banner").fightsCount = 0;
        }
        else
        {
            api.ui.getUIComponent("Banner").fightsCount = _loc2;
        } // end else if
    } // End of the function
    function onList(sExtraData)
    {
        var _loc8 = sExtraData.split("|");
        var _loc17 = new Array();
        for (var _loc3 = 0; _loc3 < _loc8.length; ++_loc3)
        {
            if (String(_loc8[_loc3]).length == 0)
            {
                continue;
            } // end if
            var _loc2 = _loc8[_loc3].split(";");
            var _loc9 = Number(_loc2[0]);
            var _loc7 = Number(_loc2[1]);
            var _loc12 = _loc7 == -1 ? (-1) : (api.kernel.NightManager.getDiffDate(_loc7));
            var _loc6 = new dofus.datacenter.FightInfos(_loc9, _loc12);
            var _loc5 = String(_loc2[2]).split(",");
            var _loc13 = Number(_loc5[0]);
            var _loc14 = Number(_loc5[1]);
            var _loc15 = Number(_loc5[2]);
            _loc6.addTeam(1, _loc13, _loc14, _loc15);
            var _loc4 = String(_loc2[3]).split(",");
            var _loc10 = Number(_loc4[0]);
            var _loc11 = Number(_loc4[1]);
            var _loc16 = Number(_loc4[2]);
            _loc6.addTeam(2, _loc10, _loc11, _loc16);
            _loc17.push(_loc6);
        } // end of for
        api.ui.getUIComponent("FightsInfos").fights.replaceAll(0, _loc17);
    } // End of the function
    function onDetails(sExtraData)
    {
        var _loc12 = sExtraData.split("|");
        var _loc13 = Number(_loc12[0]);
        var _loc10 = new ank.utils.ExtendedArray();
        var _loc7 = _loc12[1].split(";");
        for (var _loc3 = 0; _loc3 < _loc7.length; ++_loc3)
        {
            if (_loc7[_loc3] == "")
            {
                continue;
            } // end if
            var _loc5 = _loc7[_loc3].split("~");
            _loc10.push({name: api.kernel.CharactersManager.getNameFromData(_loc5[0]).name, level: Number(_loc5[1])});
        } // end of for
        var _loc11 = new ank.utils.ExtendedArray();
        var _loc6 = _loc12[2].split(";");
        for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
        {
            if (_loc6[_loc2] == "")
            {
                continue;
            } // end if
            var _loc4 = _loc6[_loc2].split("~");
            _loc11.push({name: api.kernel.CharactersManager.getNameFromData(_loc4[0]).name, level: Number(_loc4[1])});
        } // end of for
        api.ui.getUIComponent("FightsInfos").addFightTeams(_loc13, _loc10, _loc11);
    } // End of the function
} // End of Class
#endinitclip
