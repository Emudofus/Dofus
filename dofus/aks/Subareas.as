// Action script...

// [Initial MovieClip Action of sprite 20639]
#initclip 160
if (!dofus.aks.Subareas)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Subareas = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.onList = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        this.api.datacenter.Subareas.removeAll();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = String(_loc3[_loc4]).split(";");
            var _loc6 = Number(_loc5[0]);
            var _loc7 = Number(_loc5[1]);
            var _loc8 = new dofus.datacenter.Subarea(_loc6, _loc7);
            this.api.datacenter.Subareas.addItemAt(_loc6, _loc8);
        } // end while
    };
    _loc1.onAlignmentModification = function (sExtraData)
    {
        var _loc3 = String(sExtraData).split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = Number(_loc3[2]) == 1;
        var _loc7 = (dofus.datacenter.Subarea)(this.api.datacenter.Subareas.getItemAt(_loc4));
        if (_loc7 == undefined)
        {
            _loc7 = new dofus.datacenter.Subarea(_loc4, _loc5);
            this.api.datacenter.Subareas.addItemAt(_loc4, _loc7);
        }
        else
        {
            _loc7.alignment.index = _loc5;
        } // end else if
        if (!_loc6)
        {
            if (_loc5 == -1)
            {
                this.api.kernel.showMessage(undefined, "<b>" + this.api.lang.getText("SUBAREA_ALIGNMENT_PRISM_REMOVED", [_loc7.name]) + "</b>", "PVP_CHAT");
            }
            else
            {
                this.api.kernel.showMessage(undefined, "<b>" + this.api.lang.getText("SUBAREA_ALIGNMENT_IS", [_loc7.name, _loc7.alignment.name]) + "</b>", "PVP_CHAT");
            } // end if
        } // end else if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
