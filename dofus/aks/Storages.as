// Action script...

// [Initial MovieClip Action of sprite 952]
#initclip 164
class dofus.aks.Storages extends dofus.aks.Handler
{
    var api;
    function Storages(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function onList(sExtraData)
    {
        var _loc9 = sExtraData.charAt(0) == "+";
        var _loc8 = sExtraData.substr(1).split("|");
        for (var _loc4 = 0; _loc4 < _loc8.length; ++_loc4)
        {
            var _loc6 = _loc8[_loc4].split(";");
            var _loc5 = _loc6[0];
            var _loc7 = _loc6[1] == "1";
            var _loc3 = api.datacenter.Storages;
            if (_loc9)
            {
                var _loc2 = _loc3.getItemAt(_loc5);
                if (_loc2 == undefined)
                {
                    _loc2 = new dofus.datacenter.Storage();
                } // end if
                _loc2.isLocked = _loc7;
                _loc3.addItemAt(_loc5, _loc2);
                continue;
            } // end if
            _loc3.removeItemAt(_loc5);
        } // end of for
    } // End of the function
    function onLockedProperty(sExtraData)
    {
        var _loc4 = sExtraData.split("|");
        var _loc3 = _loc4[0];
        var _loc6 = _loc4[1] == "1";
        var _loc5 = api.datacenter.Storages;
        var _loc2 = _loc5.getItemAt(_loc3);
        if (_loc2 == undefined)
        {
            _loc2 = new dofus.datacenter.Storage(_loc3);
            _loc5.addItemAt(_loc3, _loc2);
        } // end if
        _loc2.isLocked = _loc6;
    } // End of the function
} // End of Class
#endinitclip
