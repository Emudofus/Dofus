// Action script...

// [Initial MovieClip Action of sprite 924]
#initclip 136
class dofus.aks.Basics extends dofus.aks.Handler
{
    var aks, api;
    function Basics(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function autorisedCommand(sCommand)
    {
        aks.send("BA" + sCommand, false);
    } // End of the function
    function whoAmI()
    {
        this.whoIs("");
    } // End of the function
    function whoIs(sName)
    {
        aks.send("BW" + sName);
    } // End of the function
    function kick(nCellNum)
    {
        aks.send("BQ" + nCellNum, false);
    } // End of the function
    function away()
    {
        aks.send("BY", false);
    } // End of the function
    function onAuthorizedCommand(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc3 = Number(sExtraData.charAt(0));
            var _loc2 = "DEBUG_LOG";
            switch (_loc3)
            {
                case 1:
                {
                    _loc2 = "DEBUG_ERROR";
                    break;
                } 
                case 2:
                {
                    _loc2 = "DEBUG_INFO";
                    break;
                } 
            } // End of switch
            api.kernel.showMessage(undefined, sExtraData.substr(1), _loc2);
        }
        else
        {
            api.kernel.showMessage(undefined, api.lang.getText("UNKNOW_COMMAND", ["/a"]), "ERROR_CHAT");
        } // end else if
    } // End of the function
    function onAuthorizedCommandPrompt(sExtraData)
    {
        api.datacenter.Basics.aks_a_prompt = sExtraData;
        api.ui.getUIComponent("Debug").setPrompt(sExtraData);
    } // End of the function
    function onAuthorizedCommandClear()
    {
        api.ui.getUIComponent("Debug").clear();
    } // End of the function
    function onReferenceTime(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        api.kernel.NightManager.setReferenceTime(_loc2);
    } // End of the function
    function onWhoIs(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc3 = sExtraData.split("|");
            if (_loc3.length != 3)
            {
                return;
            } // end if
            var _loc2 = _loc3[0];
            var _loc5 = _loc3[1];
            var _loc4 = _loc3[2];
            if (_loc2.toLowerCase() == api.datacenter.Basics.login)
            {
                switch (_loc5)
                {
                    case "1":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("I_AM_IN_SINGLE_GAME", [_loc4, _loc2]), "INFO_CHAT");
                        break;
                    } 
                    case "2":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("I_AM_IN_GAME", [_loc4, _loc2]), "INFO_CHAT");
                        break;
                    } 
                } // End of switch
            }
            else
            {
                switch (_loc5)
                {
                    case "1":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("IS_IN_SINGLE_GAME", [_loc4, _loc2]), "INFO_CHAT");
                        break;
                    } 
                    case "2":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("IS_IN_GAME", [_loc4, _loc2]), "INFO_CHAT");
                        break;
                    } 
                } // End of switch
            } // end else if
        }
        else
        {
            api.kernel.showMessage(undefined, api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER", [sExtraData]), "ERROR_CHAT");
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
