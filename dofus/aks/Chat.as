// Action script...

// [Initial MovieClip Action of sprite 929]
#initclip 141
class dofus.aks.Chat extends dofus.aks.Handler
{
    var api, aks;
    function Chat(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function send(sMessage, sDest)
    {
        if (sDest.toLowerCase() == api.datacenter.Player.Name.toLowerCase())
        {
            api.kernel.showMessage(api.lang.getText("CANT_WISP_YOURSELF"), dofus.Constants.ERROR_CHAT_COLOR);
            return;
        } // end if
        sMessage = sMessage.replace(["<", ">", "|"], ["&lt;", "&gt;", " "]);
        aks.send("BM" + sDest + "|" + sMessage);
    } // End of the function
    function useSmiley(nSmileyID)
    {
        if (getTimer() - api.datacenter.Basics.aks_chat_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
        {
            return;
        } // end if
        api.datacenter.Basics.aks_chat_lastActionTime = getTimer();
        aks.send("BS" + nSmileyID, false);
    } // End of the function
    function onMessage(bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            switch (sExtraData.charAt(0))
            {
                case "S":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("SYNTAX_ERROR", [" /w <" + api.lang.getText("NAME") + "> <" + api.lang.getText("MSG") + ">"]), "ERROR_CHAT");
                    break;
                } 
                case "f":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("USER_NOT_CONNECTED", [sExtraData.substr(1)]), "ERROR_CHAT");
                    break;
                } 
            } // End of switch
            return;
        } // end if
        var _loc7 = sExtraData.charAt(0);
        sExtraData = _loc7 == "|" ? (sExtraData.substr(1)) : (sExtraData.substr(2));
        var _loc6 = sExtraData.split("|");
        var _loc2 = _loc6[2];
        var _loc3 = _loc6[1];
        var _loc9 = _loc6[0];
        var _loc4;
        switch (_loc7)
        {
            case "F":
            {
                _loc4 = "WHISP_CHAT";
                _loc2 = api.lang.getText("FROM") + " <b><i>" + _loc3 + " : </i></b>" + _loc2;
                api.kernel.Console.pushWhisper("/w " + _loc3 + " ");
                break;
            } 
            case "T":
            {
                _loc4 = "WHISP_CHAT";
                _loc2 = api.lang.getText("TO") + " <b>" + _loc3 + " : </b>" + _loc2;
                break;
            } 
            case "#":
            {
                if (api.datacenter.Game.isFight)
                {
                    _loc4 = "WHISP_CHAT";
                    var _loc8;
                    if (api.datacenter.Game.isSpectator)
                    {
                        _loc8 = "(" + api.lang.getText("SPECTATOR") + ")";
                    }
                    else
                    {
                        _loc8 = "(" + api.lang.getText("TEAM") + ")";
                    } // end else if
                    _loc2 = _loc8 + " <b>" + _loc3 + " : " + _loc2 + "</b>";
                } // end if
                break;
            } 
            case "%":
            {
                _loc4 = "GUILD_CHAT_SOUND";
                _loc2 = "(" + api.lang.getText("GUILD") + ") <b>" + _loc3 + " : " + _loc2 + "</b>";
                break;
            } 
            default:
            {
                if (!api.datacenter.Game.isRunning)
                {
                    api.gfx.addSpriteBubble(_loc9, _loc2);
                } // end if
                _loc4 = "MESSAGE_CHAT";
                _loc2 = "<b>" + _loc3 + "</b> : " + _loc2;
                break;
            } 
        } // End of switch
        api.kernel.showMessage(undefined, _loc2, _loc4);
    } // End of the function
    function onServerMessage(sExtraData)
    {
        if (sExtraData != undefined)
        {
            api.kernel.showMessage(undefined, sExtraData, "INFO_CHAT");
        } // end if
    } // End of the function
    function onSmiley(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc4 = _loc2[0];
        var _loc3 = Number(_loc2[1]);
        api.gfx.addSpriteOverHeadItem(_loc4, "smiley", dofus.graphics.battlefield.SmileyOverHead, [_loc3], dofus.Constants.SMILEY_DELAY);
    } // End of the function
} // End of Class
#endinitclip
