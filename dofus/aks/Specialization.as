// Action script...

// [Initial MovieClip Action of sprite 20698]
#initclip 219
if (!dofus.aks.Specialization)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Specialization = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.onSet = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        if (_global.isNaN(_loc3) || (sExtraData.length == 0 || _loc3 == 0))
        {
            this.api.datacenter.Player.specialization = undefined;
        }
        else
        {
            var _loc4 = new dofus.datacenter.Specialization(_loc3);
            this.api.datacenter.Player.specialization = _loc4;
        } // end else if
    };
    _loc1.onChange = function (sExtraData)
    {
        this.onSet(sExtraData);
        var _loc3 = this.api.datacenter.Player.specialization;
        if (_loc3 == undefined)
        {
            this.api.kernel.showMessage(this.api.lang.getText("SPECIALIZATION"), this.api.lang.getText("YOU_HAVE_NO_SPECIALIZATION"), "ERROR_BOX");
        }
        else
        {
            this.api.kernel.showMessage(this.api.lang.getText("SPECIALIZATION"), this.api.lang.getText("YOUR_SPECIALIZATION_CHANGED", [_loc3.name]), "ERROR_BOX");
        } // end else if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
