// Action script...

// [Initial MovieClip Action of sprite 948]
#initclip 160
class dofus.aks.Job extends dofus.aks.Handler
{
    var api;
    function Job(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function onSkills(sExtraData)
    {
        var _loc12 = sExtraData.split("|");
        var _loc11 = api.datacenter.Player.Jobs;
        for (var _loc6 = 0; _loc6 < _loc12.length; ++_loc6)
        {
            var _loc9 = _loc12[_loc6].split(";");
            var _loc7 = Number(_loc9[0]);
            var _loc4 = new ank.utils.ExtendedArray();
            var _loc5 = _loc9[1].split(",");
            var _loc3 = _loc5.length;
            while (_loc3-- > 0)
            {
                var _loc2 = _loc5[_loc3].split("~");
                _loc4.push(new dofus.datacenter.Skill(_loc2[0], _loc2[1], _loc2[2], _loc2[3], _loc2[4]));
            } // end while
            var _loc10 = new dofus.datacenter.Job(_loc7, _loc4);
            var _loc8 = _loc11.findFirstItem("id", _loc7);
            if (_loc8.index != -1)
            {
                _loc11.updateItem(_loc8.index, _loc10);
                continue;
            } // end if
            _loc11.push(_loc10);
        } // end of for
    } // End of the function
    function onXP(sExtraData)
    {
        var _loc12 = sExtraData.split("|");
        var _loc11 = api.datacenter.Player.Jobs;
        var _loc10 = _loc12.length;
        while (_loc10-- > 0)
        {
            var _loc2 = _loc12[_loc10].split(";");
            var _loc6 = Number(_loc2[0]);
            var _loc5 = Number(_loc2[1]);
            var _loc9 = Number(_loc2[2]);
            var _loc8 = Number(_loc2[3]);
            var _loc7 = Number(_loc2[4]);
            var _loc4 = _loc11.findFirstItem("id", _loc6);
            if (_loc4.index != -1)
            {
                var _loc3 = _loc4.item;
                _loc3.level = _loc5;
                _loc3.xpMin = _loc9;
                _loc3.xp = _loc8;
                _loc3.xpMax = _loc7;
                _loc11.updateItem(_loc4.index, _loc3);
            } // end if
        } // end while
    } // End of the function
    function onLevel(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc4 = Number(_loc2[0]);
        var _loc3 = Number(_loc2[1]);
        api.kernel.showMessage(api.lang.getText("INFORMATIONS"), api.lang.getText("NEW_JOB_LEVEL", [api.lang.getJobText(_loc4).n, _loc3]), "ERROR_BOX", {name: "NewJobLevel"});
    } // End of the function
    function onRemove(sExtraData)
    {
        var _loc4 = Number(sExtraData);
        var _loc3 = api.datacenter.Player.Jobs;
        var _loc2 = _loc3.findFirstItem("id", _loc4);
        if (_loc2.index != -1)
        {
            api.kernel.showMessage(undefined, api.lang.getText("REMOVE_JOB", [_loc2.item.name]), "INFO_CHAT");
            _loc3.removeItems(_loc2.index, 1);
        } // end if
    } // End of the function
} // End of Class
#endinitclip
