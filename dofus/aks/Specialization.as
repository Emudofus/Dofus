// Action script...

// [Initial MovieClip Action of sprite 962]
#initclip 174
class dofus.aks.Specialization extends dofus.aks.Handler
{
    var api;
    function Specialization(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function onSet(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        if (isNaN(_loc2) || sExtraData.length == 0 || _loc2 == 0)
        {
            api.datacenter.Player.specialization = undefined;
        }
        else
        {
            var _loc3 = new dofus.datacenter.Specialization(_loc2);
            api.datacenter.Player.specialization = _loc3;
        } // end else if
    } // End of the function
    function onChange(sExtraData)
    {
        this.onSet(sExtraData);
        var _loc2 = api.datacenter.Player.specialization;
        if (_loc2 == undefined)
        {
            api.kernel.showMessage(api.lang.getText("SPECIALIZATION"), api.lang.getText("YOU_HAVE_NO_SPECIALIZATION"), "ERROR_BOX");
        }
        else
        {
            api.kernel.showMessage(api.lang.getText("SPECIALIZATION"), api.lang.getText("YOUR_SPECIALIZATION_CHANGED", [_loc2.__get__name()]), "ERROR_BOX");
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
