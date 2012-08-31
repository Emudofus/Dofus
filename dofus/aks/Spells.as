// Action script...

// [Initial MovieClip Action of sprite 951]
#initclip 163
class dofus.aks.Spells extends dofus.aks.Handler
{
    var aks, api;
    function Spells(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function moveToUsed(nID, nPosition)
    {
        aks.send("SM" + nID + "|" + nPosition, false);
    } // End of the function
    function boost(nID)
    {
        aks.send("SB" + nID);
    } // End of the function
    function onUpgradeSpell(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc2 = api.kernel.CharactersManager.getSpellObjectFromData(sExtraData);
            api.datacenter.Player.updateSpell(_loc2);
        } // end if
    } // End of the function
    function onList(sExtraData)
    {
        var _loc5 = sExtraData.split(";");
        var _loc6 = new Array();
        for (var _loc2 = 0; _loc2 < _loc5.length; ++_loc2)
        {
            var _loc4 = _loc5[_loc2];
            if (_loc4.length != 0)
            {
                var _loc3 = api.kernel.CharactersManager.getSpellObjectFromData(_loc4);
                if (_loc3 != undefined)
                {
                    _loc6.push(_loc3);
                } // end if
            } // end if
        } // end of for
        var _loc7 = api.datacenter.Player;
        _loc7.Spells.replaceAll(1, _loc6);
    } // End of the function
} // End of Class
#endinitclip
