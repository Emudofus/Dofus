// Action script...

// [Initial MovieClip Action of sprite 20613]
#initclip 134
if (!dofus.aks.Party)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Party = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.invite = function (sSpriteName)
    {
        this.aks.send("PI" + sSpriteName);
    };
    _loc1.refuseInvitation = function ()
    {
        this.aks.send("PR", false);
    };
    _loc1.acceptInvitation = function ()
    {
        this.aks.send("PA");
    };
    _loc1.leave = function (sSpriteID)
    {
        this.aks.send("PV" + (sSpriteID != undefined ? (sSpriteID) : ("")));
        this.api.ui.getUIComponent("Banner").illustration.updateFlags();
    };
    _loc1.follow = function (bStop, sSpriteID)
    {
        this.aks.send("PF" + (bStop ? ("-") : ("+")) + sSpriteID);
    };
    _loc1.where = function ()
    {
        this.aks.send("PW");
    };
    _loc1.followAll = function (bStop, sSpriteID)
    {
        this.aks.send("PG" + (bStop ? ("-") : ("+")) + sSpriteID);
    };
    _loc1.onInvite = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = sExtraData.split("|");
            var _loc5 = _loc4[0];
            var _loc6 = _loc4[1];
            if (_loc5 == undefined || _loc6 == undefined)
            {
                this.refuseInvitation();
                return;
            } // end if
            if (_loc5 == this.api.datacenter.Player.Name)
            {
                this.api.kernel.showMessage(this.api.lang.getText("PARTY"), this.api.lang.getText("YOU_INVITE_B_IN_PARTY", [_loc6]), "INFO_CANCEL", {name: "Party", listener: this});
            } // end if
            if (_loc6 == this.api.datacenter.Player.Name)
            {
                if (this.api.kernel.ChatManager.isBlacklisted(_loc5))
                {
                    this.refuseInvitation();
                    return;
                } // end if
                this.api.kernel.showMessage(undefined, this.api.lang.getText("CHAT_A_INVITE_YOU_IN_PARTY", [this.api.kernel.ChatManager.getLinkName(_loc5)]), "INFO_CHAT");
                this.api.kernel.showMessage(this.api.lang.getText("PARTY"), this.api.lang.getText("A_INVITE_YOU_IN_PARTY", [_loc5]), "CAUTION_YESNOIGNORE", {name: "Party", player: _loc5, listener: this, params: {player: _loc5}});
                this.api.sounds.events.onGameInvitation();
            } // end if
        }
        else
        {
            var _loc7 = sExtraData.charAt(0);
            switch (_loc7)
            {
                case "a":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("PARTY_ALREADY_IN_GROUP"), "ERROR_CHAT", {name: "PartyError"});
                    break;
                } 
                case "f":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("PARTY_FULL"), "ERROR_CHAT", {name: "PartyError"});
                    break;
                } 
                case "n":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER", [sExtraData.substr(1)]), "ERROR_CHAT", {name: "PartyError"});
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onLeader = function (sExtraData)
    {
        var _loc3 = sExtraData;
        var _loc4 = this.api.ui.getUIComponent("Party");
        _loc4.setLeader(_loc3);
        var _loc5 = _loc4.getMember(_loc3).name;
        if (_loc5 != undefined)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("NEW_GROUP_LEADER", [_loc5]), "INFO_CHAT");
        } // end if
    };
    _loc1.onRefuse = function (sExtraData)
    {
        this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
        this.api.ui.unloadUIComponent("AskCancelParty");
    };
    _loc1.onAccept = function (sExtraData)
    {
        this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
        this.api.ui.unloadUIComponent("AskCancelParty");
    };
    _loc1.onCreate = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = sExtraData;
            if (_loc4 != this.api.datacenter.Player.Name)
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("U_ARE_IN_GROUP", [_loc4]), "INFO_CHAT");
            } // end if
            this.api.datacenter.Player.inParty = true;
            this.api.ui.loadUIComponent("Party", "Party", undefined, {bStrayIfPresent: true});
        }
        else
        {
            var _loc5 = sExtraData.charAt(0);
            switch (_loc5)
            {
                case "a":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("PARTY_ALREADY_IN_GROUP"), "ERROR_CHAT", {name: "PartyError"});
                    break;
                } 
                case "f":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("PARTY_FULL"), "ERROR_CHAT", {name: "PartyError"});
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onLeave = function (sExtraData)
    {
        var _loc3 = this.api.ui.getUIComponent("Party");
        if (_loc3.followID != undefined)
        {
            this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0], this.api.datacenter.Basics.banner_targetCoords[1]);
        } // end if
        var _loc4 = _loc3.getMember(sExtraData).name;
        if (_loc4 != undefined)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("A_KICK_FROM_PARTY", [_loc4]), "INFO_CHAT");
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("LEAVE_GROUP"), "INFO_CHAT");
        } // end else if
        this.api.ui.unloadUIComponent("Party");
        this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
        this.api.ui.unloadUIComponent("AskCancelParty");
        this.api.datacenter.Player.inParty = false;
        this.api.datacenter.Basics.aks_infos_highlightCoords_clear(2);
    };
    _loc1.onFollow = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = this.api.ui.getUIComponent("Party");
            var _loc5 = sExtraData;
            _loc4.setFollow(_loc5);
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("PARTY_NOT_IN_IN_GROUP"), "ERROR_BOX", {name: "PartyError"});
        } // end else if
    };
    _loc1.onMovement = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = this.api.ui.getUIComponent("Party");
        var _loc5 = sExtraData.substr(1).split("|");
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc5.length)
        {
            var _loc7 = String(_loc5[_loc6]).split(";");
            var _loc8 = _loc7[0];
            switch (sExtraData.charAt(0))
            {
                case "+":
                {
                    var _loc9 = _loc7[1];
                    var _loc10 = _loc7[2];
                    var _loc11 = Number(_loc7[3]);
                    var _loc12 = Number(_loc7[4]);
                    var _loc13 = Number(_loc7[5]);
                    var _loc14 = _loc7[6];
                    var _loc15 = _loc7[7];
                    var _loc16 = Number(_loc7[8]);
                    var _loc17 = Number(_loc7[9]);
                    var _loc18 = Number(_loc7[10]);
                    var _loc19 = Number(_loc7[11]);
                    var _loc20 = new Object();
                    _loc20.id = _loc8;
                    _loc20.name = _loc9;
                    _loc20.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc10 + ".swf";
                    _loc20.color1 = _loc11;
                    _loc20.color2 = _loc12;
                    _loc20.color3 = _loc13;
                    _loc20.life = _loc15;
                    _loc20.level = _loc16;
                    _loc20.initiative = _loc17;
                    _loc20.prospection = _loc18;
                    _loc20.side = _loc19;
                    this.api.kernel.CharactersManager.setSpriteAccessories(_loc20, _loc14);
                    _loc4.addMember(_loc20);
                    break;
                } 
                case "-":
                {
                    _loc4.removeMember(_loc8, true);
                    break;
                } 
                case "~":
                {
                    var _loc21 = _loc7[1];
                    var _loc22 = _loc7[2];
                    var _loc23 = Number(_loc7[3]);
                    var _loc24 = Number(_loc7[4]);
                    var _loc25 = Number(_loc7[5]);
                    var _loc26 = _loc7[6];
                    var _loc27 = _loc7[7];
                    var _loc28 = Number(_loc7[8]);
                    var _loc29 = Number(_loc7[9]);
                    var _loc30 = Number(_loc7[10]);
                    var _loc31 = Number(_loc7[11]);
                    var _loc32 = new Object();
                    _loc32.id = _loc8;
                    _loc32.name = _loc21;
                    _loc32.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc22 + ".swf";
                    _loc32.color1 = _loc23;
                    _loc32.color2 = _loc24;
                    _loc32.color3 = _loc25;
                    _loc32.life = _loc27;
                    _loc32.level = _loc28;
                    _loc32.initiative = _loc29;
                    _loc32.prospection = _loc30;
                    _loc32.side = _loc31;
                    this.api.kernel.CharactersManager.setSpriteAccessories(_loc32, _loc26);
                    _loc4.updateData(_loc32);
                    break;
                } 
            } // End of switch
        } // end while
        _loc4.refresh();
    };
    _loc1.cancel = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskCancelParty":
            {
                this.refuseInvitation();
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoIgnoreParty":
            {
                this.acceptInvitation();
                break;
            } 
        } // End of switch
    };
    _loc1.no = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoIgnoreParty":
            {
                this.refuseInvitation();
                break;
            } 
        } // End of switch
    };
    _loc1.ignore = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoIgnoreParty":
            {
                this.api.kernel.ChatManager.addToBlacklist(oEvent.params.player);
                this.api.kernel.showMessage(undefined, this.api.lang.getText("TEMPORARY_BLACKLISTED", [oEvent.params.player]), "INFO_CHAT");
                this.refuseInvitation(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
