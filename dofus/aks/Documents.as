// Action script...

// [Initial MovieClip Action of sprite 954]
#initclip 166
class dofus.aks.Documents extends dofus.aks.Handler
{
    var aks, api;
    function Documents(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function leave()
    {
        aks.send("dV");
    } // End of the function
    function onCreate(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc2 = sExtraData;
            var _loc3 = api.config.language;
            api.ui.loadUIComponent("CenterText", "CenterText", {text: api.lang.getText("LOADING"), background: false}, {bForceLoad: true});
            api.kernel.DocumentsServersManager.loadDocument(_loc3 + "_" + _loc2);
        } // end if
    } // End of the function
    function onLeave()
    {
        api.ui.unloadUIComponent("Document");
    } // End of the function
} // End of Class
#endinitclip
