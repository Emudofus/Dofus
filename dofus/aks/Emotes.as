// Action script...

// [Initial MovieClip Action of sprite 20856]
#initclip 121
if (!dofus.aks.Emotes)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Emotes = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.useEmote = function (nEmoteID)
    {
        if (this.api.datacenter.Game.isFight)
        {
            return;
        } // end if
        if (getTimer() - this.api.datacenter.Basics.aks_emote_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
        {
            return;
        } // end if
        this.api.datacenter.Basics.aks_emote_lastActionTime = getTimer();
        this.aks.send("eU" + nEmoteID, true);
    };
    _loc1.setDirection = function (nDir)
    {
        this.aks.send("eD" + nDir, true);
    };
    _loc1.onUse = function (bSuccess, sExtraData)
    {
        if (this.api.datacenter.Game.isFight)
        {
            return;
        } // end if
        if (!bSuccess)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_USE_EMOTE"), "ERROR_CHAT");
            return;
        } // end if
        var _loc4 = sExtraData.split("|");
        var _loc5 = _loc4[0];
        var _loc6 = Number(_loc4[1]);
        var _loc7 = Number(_loc4[2]);
        var _loc8 = _global.isNaN(_loc6) ? ("static") : ("emote" + _loc6);
        this.api.gfx.convertHeightToFourSpriteDirection(_loc5);
        if (_global.isNaN(_loc7) && _global.isNaN(_loc6))
        {
            this.api.gfx.setForcedSpriteAnim(_loc5, _loc8);
        }
        else
        {
            this.api.gfx.setSpriteTimerAnim(_loc5, _loc8, true, _loc7);
        } // end else if
    };
    _loc1.onList = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = this.api.datacenter.Player;
        _loc6.clearEmotes();
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < 32)
        {
            if ((_loc4 >> _loc7 & 1) == 1)
            {
                if (this.api.lang.getEmoteText(_loc7 + 1) != undefined)
                {
                    _loc6.addEmote(_loc7 + 1);
                } // end if
            } // end if
        } // end while
        var _loc8 = 0;
        
        while (++_loc8, _loc8 < 32)
        {
            if ((_loc5 >> _loc8 & 1) == 1)
            {
                if (this.api.lang.getEmoteText(_loc8 + 1) != undefined)
                {
                    _loc6.addEmote(_loc8 + 1);
                } // end if
            } // end if
        } // end while
    };
    _loc1.onAdd = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1] == "0";
        if (!_loc5)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("NEW_EMOTE", [this.api.lang.getEmoteText(_loc4).n]), "INFO_CHAT");
        } // end if
        this.refresh();
    };
    _loc1.onRemove = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = _loc3[1] == "0";
        if (!_loc5)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("REMOVE_EMOTE", [this.api.lang.getEmoteText(_loc4).n]), "INFO_CHAT");
        } // end if
        this.refresh();
    };
    _loc1.onDirection = function (sExtraData)
    {
        if (this.api.datacenter.Game.isFight)
        {
            return;
        } // end if
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = Number(_loc3[1]);
        var _loc6 = this.api.gfx.getSprite(_loc4).animation;
        this.api.gfx.setSpriteDirection(_loc4, _loc5);
        this.api.gfx.setSpriteAnim(_loc4, _loc6);
    };
    _loc1.refresh = function ()
    {
        this.api.ui.getUIComponent("Banner").updateSmileysEmotes();
        this.api.ui.getUIComponent("Banner").showSmileysEmotesPanel(true);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
