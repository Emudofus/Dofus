// Action script...

// [Initial MovieClip Action of sprite 20495]
#initclip 16
if (!dofus.aks.Handler)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Handler = function ()
    {
        super();
    }).prototype;
    _loc1.__get__aks = function ()
    {
        return (this._oAKS);
    };
    _loc1.initialize = function (oAKS, oAPI)
    {
        super.initialize(oAPI);
        this._oAKS = oAKS;
        this._oAPI = oAPI;
    };
    _loc1.addProperty("aks", _loc1.__get__aks, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
