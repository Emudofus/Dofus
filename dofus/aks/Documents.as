// Action script...

// [Initial MovieClip Action of sprite 20591]
#initclip 112
if (!dofus.aks.Documents)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Documents = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.leave = function ()
    {
        this.aks.send("dV");
    };
    _loc1.onCreate = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = sExtraData;
            var _loc5 = this.api.config.language;
            this.api.ui.loadUIComponent("CenterText", "CenterText", {text: this.api.lang.getText("LOADING"), background: false}, {bForceLoad: true});
            this.api.kernel.DocumentsServersManager.loadDocument(_loc5 + "_" + _loc4);
        } // end if
    };
    _loc1.onLeave = function ()
    {
        this.api.ui.unloadUIComponent("Document");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
