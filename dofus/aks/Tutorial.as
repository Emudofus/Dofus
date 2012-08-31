// Action script...

// [Initial MovieClip Action of sprite 965]
#initclip 177
class dofus.aks.Tutorial extends dofus.aks.Handler
{
    var aks, api;
    function Tutorial(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function end(nActionListID, nCellNum, nDir)
    {
        if (nActionListID == undefined)
        {
            nActionListID = 0;
        } // end if
        if (nCellNum == undefined || nDir == undefined)
        {
            aks.send("TV" + String(nActionListID), false);
        }
        else
        {
            aks.send("TV" + String(nActionListID) + "|" + String(nCellNum) + "|" + String(nDir), false);
        } // end else if
    } // End of the function
    function onCreate(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc3 = _loc2[0];
        var _loc5 = _loc2[1];
        var _loc4 = api.config.language;
        api.kernel.TutorialServersManager.loadTutorial(_loc4 + "_" + _loc3 + "_" + _loc5);
    } // End of the function
} // End of Class
#endinitclip
