// Action script...

// [Initial MovieClip Action of sprite 950]
#initclip 162
class dofus.aks.Key extends dofus.aks.Handler
{
    var aks, api;
    function Key(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function leave()
    {
        aks.send("KV", false);
    } // End of the function
    function sendKey(nType, sKeyCode)
    {
        aks.send("KK" + nType + "|" + sKeyCode);
    } // End of the function
    function onCreate(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc4 = Number(_loc2[0]);
        var _loc3 = Number(_loc2[1]);
        api.ui.loadUIComponent("KeyCode", "KeyCode", {title: api.lang.getText("TYPE_CODE"), changeType: _loc4, slotsCount: _loc3});
    } // End of the function
    function onKey(bSuccess)
    {
        var _loc2 = bSuccess ? (api.lang.getText("CODE_CHANGED")) : (api.lang.getText("BAD_CODE"));
        api.kernel.showMessage(api.lang.getText("CODE"), _loc2, "ERROR_BOX", {name: "Key"});
    } // End of the function
    function onLeave()
    {
        api.ui.unloadUIComponent("KeyCode");
    } // End of the function
} // End of Class
#endinitclip
