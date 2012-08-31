// Action script...

// [Initial MovieClip Action of sprite 931]
#initclip 143
class dofus.aks.Dialog extends dofus.aks.Handler
{
    var aks, api;
    function Dialog(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function begining(sNpcID)
    {
        aks.send("DB" + sNpcID, false);
    } // End of the function
    function create(sNpcID)
    {
        aks.send("DC" + sNpcID, false);
    } // End of the function
    function leave()
    {
        aks.send("DV", false);
    } // End of the function
    function response(nQuestionID, nResponseID)
    {
        aks.send("DR" + nQuestionID + "|" + nResponseID, false);
    } // End of the function
    function onCreate(bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            return;
        } // end if
        var _loc2 = Number(sExtraData);
        var _loc3 = api.datacenter.Sprites.getItemAt(_loc2);
        api.ui.loadUIComponent("NpcDialog", "NpcDialog", {name: _loc3.name, gfx: _loc3.gfxID, id: _loc2});
    } // End of the function
    function onQuestion(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc3 = _loc2[0].split(";");
        var _loc7 = Number(_loc3[0]);
        var _loc6 = _loc3[1].split(",");
        var _loc5 = _loc2[1].split(";");
        var _loc4 = new dofus.datacenter.Question(_loc7, _loc5, _loc6);
        api.ui.getUIComponent("NpcDialog").setQuestion(_loc4);
    } // End of the function
    function onLeave()
    {
        api.ui.unloadUIComponent("NpcDialog");
    } // End of the function
} // End of Class
#endinitclip
