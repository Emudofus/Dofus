// Action script...

// [Initial MovieClip Action of sprite 960]
#initclip 172
class dofus.aks.Areas extends dofus.aks.Handler
{
    var api;
    function Areas(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function onList(sExtraData)
    {
        var _loc7 = sExtraData.split("|");
        api.datacenter.Areas.removeAll();
        for (var _loc2 = 0; _loc2 < _loc7.length; ++_loc2)
        {
            var _loc4 = String(_loc7[_loc2]).split(";");
            var _loc3 = Number(_loc4[0]);
            var _loc5 = Number(_loc4[1]);
            var _loc6 = new dofus.datacenter.Area(_loc3, _loc5);
            api.datacenter.Areas.addItemAt(_loc3, _loc6);
        } // end of for
    } // End of the function
    function onAlignmentModification(sExtraData)
    {
        var _loc4 = String(sExtraData).split("|");
        var _loc3 = Number(_loc4[0]);
        var _loc5 = Number(_loc4[1]);
        var _loc2 = (dofus.datacenter.Area)(api.datacenter.Areas.getItemAt(_loc3));
        if (_loc2 == undefined)
        {
            _loc2 = new dofus.datacenter.Area(_loc3, _loc5);
            api.datacenter.Areas.addItemAt(_loc3, _loc2);
        }
        else
        {
            _loc2.alignment.index = _loc5;
        } // end else if
        api.kernel.showMessage(undefined, api.lang.getText("AREA_ALIGNMENT_IS", [_loc2.__get__name(), _loc2.alignment.name]), "ERROR_CHAT");
    } // End of the function
} // End of Class
#endinitclip
