// Action script...

// [Initial MovieClip Action of sprite 20958]
#initclip 223
if (!dofus.aks.Storages)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Storages = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.onList = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc4.length)
        {
            var _loc6 = _loc4[_loc5].split(";");
            var _loc7 = _loc6[0];
            var _loc8 = _loc6[1] == "1";
            var _loc9 = this.api.datacenter.Storages;
            if (_loc3)
            {
                var _loc10 = _loc9.getItemAt(_loc7);
                if (_loc10 == undefined)
                {
                    _loc10 = new dofus.datacenter.Storage();
                } // end if
                _loc10.isLocked = _loc8;
                _loc9.addItemAt(_loc7, _loc10);
                continue;
            } // end if
            _loc9.removeItemAt(_loc7);
        } // end while
    };
    _loc1.onLockedProperty = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1] == "1";
        var _loc6 = this.api.datacenter.Storages;
        var _loc7 = _loc6.getItemAt(_loc4);
        if (_loc7 == undefined)
        {
            _loc7 = new dofus.datacenter.Storage(_loc4);
            _loc6.addItemAt(_loc4, _loc7);
        } // end if
        _loc7.isLocked = _loc5;
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
