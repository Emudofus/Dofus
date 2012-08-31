// Action script...

// [Initial MovieClip Action of sprite 953]
#initclip 165
class dofus.aks.Emotes extends dofus.aks.Handler
{
    var api, aks;
    function Emotes(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function useEmote(nEmoteID)
    {
        if (api.datacenter.Game.isFight)
        {
            return;
        } // end if
        if (getTimer() - api.datacenter.Basics.aks_emote_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
        {
            return;
        } // end if
        api.datacenter.Basics.aks_emote_lastActionTime = getTimer();
        aks.send("eU" + nEmoteID, false);
    } // End of the function
    function onUse(bSuccess, sExtraData)
    {
        if (api.datacenter.Game.isFight)
        {
            return;
        } // end if
        if (!bSuccess)
        {
            api.kernel.showMessage(undefined, api.lang.getText("CANT_USE_EMOTE"), "ERROR_CHAT");
            return;
        } // end if
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc2 = Number(_loc3[1]);
        var _loc6 = Number(_loc3[2]);
        var _loc5 = isNaN(_loc2) ? ("static") : ("emote" + _loc2);
        api.gfx.convertHeightToFourSpriteDirection(_loc4);
        if (isNaN(_loc6) && isNaN(_loc2))
        {
            api.gfx.setForcedSpriteAnim(_loc4, _loc5);
        }
        else
        {
            api.gfx.setSpriteTimerAnim(_loc4, _loc5, true, _loc6);
        } // end else if
    } // End of the function
    function onList(sExtraData)
    {
        var _loc7 = sExtraData.split("|");
        var _loc5 = Number(_loc7[0]);
        var _loc6 = Number(_loc7[1]);
        var _loc4 = api.datacenter.Player;
        _loc4.clearEmotes();
        for (var _loc3 = 0; _loc3 < 32; ++_loc3)
        {
            if ((_loc5 >> _loc3 & 1) == 1)
            {
                if (api.lang.getEmoteText(_loc3 + 1) != undefined)
                {
                    _loc4.addEmote(_loc3 + 1);
                } // end if
            } // end if
        } // end of for
        for (var _loc2 = 0; _loc2 < 32; ++_loc2)
        {
            if ((_loc6 >> _loc2 & 1) == 1)
            {
                if (api.lang.getEmoteText(_loc2 + 1) != undefined)
                {
                    _loc4.addEmote(_loc2 + 1);
                } // end if
            } // end if
        } // end of for
    } // End of the function
    function onAdd(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc3 = Number(_loc2[0]);
        var _loc4 = _loc2[1] == "0";
        if (!_loc4)
        {
            api.kernel.showMessage(undefined, api.lang.getText("NEW_EMOTE", [api.lang.getEmoteText(_loc3).n]), "INFO_CHAT");
        } // end if
        this.refresh();
    } // End of the function
    function onRemove(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc3 = Number(_loc2[0]);
        var _loc4 = _loc2[1] == "0";
        if (!_loc4)
        {
            api.kernel.showMessage(undefined, api.lang.getText("REMOVE_EMOTE", [api.lang.getEmoteText(_loc3).n]), "INFO_CHAT");
        } // end if
        this.refresh();
    } // End of the function
    function refresh()
    {
        api.ui.getUIComponent("Banner").updateSmileysEmotes();
        api.ui.getUIComponent("Banner").showSmileysEmotesPanel(true);
    } // End of the function
} // End of Class
#endinitclip
