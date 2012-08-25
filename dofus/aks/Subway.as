// Action script...

// [Initial MovieClip Action of sprite 20934]
#initclip 199
if (!dofus.aks.Subway)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Subway = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.leave = function ()
    {
        this.aks.send("Wv");
    };
    _loc1.use = function (mapID)
    {
        this.aks.send("Wu" + mapID);
    };
    _loc1.prismLeave = function ()
    {
        this.aks.send("Ww");
    };
    _loc1.prismUse = function (mapID)
    {
        this.aks.send("Wp" + mapID);
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
            var _loc10 = this.api.lang.getHintsByMapID(_loc8);
            var _loc11 = 0;
            
            while (++_loc11, _loc11 < _loc10.length)
            {
                var _loc12 = new dofus.datacenter.Subway(_loc10[_loc11], _loc9);
                if (_loc5[_loc12.categoryID] == undefined)
                {
                    _loc5[_loc12.categoryID] = new ank.utils.ExtendedArray();
                } // end if
                _loc5[_loc12.categoryID].push(_loc12);
            } // end while
        } // end while
        this.api.ui.loadUIComponent("Subway", "Subway", {data: _loc5});
    };
    _loc1.onLeave = function ()
    {
        this.api.ui.unloadUIComponent("Subway");
    };
    _loc1.onPrismCreate = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = 1;
        
        while (++_loc6, _loc6 < _loc3.length)
        {
            var _loc7 = _loc3[_loc6].split(";");
            var _loc8 = Number(_loc7[0]);
            var _loc9 = false;
            var _loc10 = -1;
            var _loc11 = _loc7[1];
            if (_loc11.charAt(_loc11.length - 1) == "*")
            {
                _loc9 = true;
                _loc10 = Number(_loc11.substr(0, _loc11.length - 1));
            }
            else
            {
                _loc10 = Number(_loc11);
            } // end else if
            _loc5.push(new dofus.datacenter.PrismPoint(_loc8, _loc10, _loc9));
        } // end while
        this.api.ui.loadUIComponent("Subway", "Subway", {data: _loc5, type: dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM});
    };
    _loc1.onPrismLeave = function ()
    {
        this.api.ui.unloadUIComponent("Subway");
    };
    _loc1.onUseError = function ()
    {
        this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_USE_SUBWAY"), "ERROR_CHAT");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
