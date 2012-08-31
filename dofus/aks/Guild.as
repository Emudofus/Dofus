// Action script...

// [Initial MovieClip Action of sprite 955]
#initclip 167
class dofus.aks.Guild extends dofus.aks.Handler
{
    var aks, api;
    function Guild(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function create(nBackID, nBackColor, nSymbolID, nSymbolColor, sName)
    {
        aks.send("gC" + nBackID + "|" + nBackColor + "|" + nSymbolID + "|" + nSymbolColor + "|" + sName);
    } // End of the function
    function leave()
    {
        aks.send("gV");
    } // End of the function
    function leaveTaxInterface()
    {
        aks.send("gITV", false);
    } // End of the function
    function invite(sPlayerName)
    {
        aks.send("gJR" + sPlayerName);
    } // End of the function
    function acceptInvitation(nPlayerID)
    {
        aks.send("gJK" + nPlayerID);
    } // End of the function
    function refuseInvitation(nPlayerID)
    {
        aks.send("gJE" + nPlayerID, false);
    } // End of the function
    function getInfosGeneral()
    {
        aks.send("gIG", false);
    } // End of the function
    function getInfosMembers()
    {
        aks.send("gIM", false);
    } // End of the function
    function getInfosBoosts()
    {
        aks.send("gIB", false);
    } // End of the function
    function getInfosTaxCollector()
    {
        aks.send("gIT", false);
    } // End of the function
    function bann(sPlayerName)
    {
        aks.send("gK" + sPlayerName);
    } // End of the function
    function changeMemberProfil(oMember)
    {
        aks.send("gP" + oMember.id + "|" + oMember.rank + "|" + oMember.percentxp + "|" + oMember.rights.value, false);
    } // End of the function
    function boostCharacteristic(sCharacteristic)
    {
        aks.send("gB" + sCharacteristic);
    } // End of the function
    function boostSpell(nSpellID)
    {
        aks.send("gb" + nSpellID);
    } // End of the function
    function hireTaxCollector()
    {
        aks.send("gH");
    } // End of the function
    function joinTaxCollector(nTaxID)
    {
        aks.send("gTJ" + nTaxID, false);
    } // End of the function
    function leaveTaxCollector(nTaxID, nID)
    {
        aks.send("gTV" + nTaxID + (nID != undefined ? ("|" + nID) : ("")), false);
    } // End of the function
    function onNew()
    {
        api.ui.loadUIComponent("CreateGuild", "CreateGuild");
    } // End of the function
    function onCreate(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            api.kernel.showMessage(undefined, "Guilde créée", "INFO_CHAT");
            api.ui.loadUIAutoHideComponent("Guild", "Guild", {currentTab: "Members"}, {bStayIfPresent: true});
        }
        else
        {
            switch (sExtraData)
            {
                case "an":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("GUILD_CREATE_ALLREADY_USE_NAME"), "ERROR_BOX");
                    break;
                } 
                case "ae":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("GUILD_CREATE_ALLREADY_USE_EMBLEM"), "ERROR_BOX");
                    break;
                } 
                case "a":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("GUILD_CREATE_ALLREADY_IN_GUILD"), "ERROR_BOX");
                    break;
                } 
            } // End of switch
            api.ui.getUIComponent("CreateGuild").enabled = true;
        } // end else if
    } // End of the function
    function onStats(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc7 = _loc2[0];
        var _loc5 = parseInt(_loc2[1], 36);
        var _loc8 = parseInt(_loc2[2], 36);
        var _loc3 = parseInt(_loc2[3], 36);
        var _loc6 = parseInt(_loc2[4], 36);
        var _loc4 = parseInt(_loc2[5], 36);
        if (api.datacenter.Player.guildInfos == undefined)
        {
            api.datacenter.Player.guildInfos = new dofus.datacenter.GuildInfos(_loc7, _loc5, _loc8, _loc3, _loc6, _loc4);
        }
        else
        {
            api.datacenter.Player.guildInfos.initialize(_loc7, _loc5, _loc8, _loc3, _loc6, _loc4);
        } // end else if
    } // End of the function
    function onInfosGeneral(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc6 = _loc2[0] == "1";
        var _loc4 = Number(_loc2[1]);
        var _loc3 = Number(_loc2[2]);
        var _loc5 = Number(_loc2[3]);
        var _loc7 = Number(_loc2[4]);
        api.datacenter.Player.guildInfos.setGeneralInfos(_loc6, _loc4, _loc3, _loc5, _loc7);
    } // End of the function
    function onInfosMembers(sExtraData)
    {
        var _loc9 = sExtraData.charAt(0) == "+";
        var _loc8 = sExtraData.substr(1).split("|");
        var _loc4 = api.datacenter.Player.guildInfos;
        for (var _loc5 = 0; _loc5 < _loc8.length; ++_loc5)
        {
            var _loc3 = _loc8[_loc5].split(";");
            var _loc2 = new Object();
            _loc2.id = Number(_loc3[0]);
            if (_loc9)
            {
                var _loc7 = _loc4.members.length == 0;
                _loc2.name = _loc3[1];
                _loc2.level = Number(_loc3[2]);
                _loc2.gfx = Number(_loc3[3]);
                _loc2.rank = Number(_loc3[4]);
                _loc2.rankOrder = api.lang.getRankInfos(_loc2.rank).o;
                _loc2.winxp = Number(_loc3[5]);
                _loc2.percentxp = Number(_loc3[6]);
                _loc2.rights = new dofus.datacenter.GuildRights(Number(_loc3[7]));
                _loc2.state = Number(_loc3[8]);
                _loc2.isLocalPlayer = _loc2.id == api.datacenter.Player.ID;
                if (_loc7)
                {
                    _loc4.members.push(_loc2);
                }
                else
                {
                    var _loc6 = _loc4.members.findFirstItem("id", _loc2.id);
                    if (_loc6.index != -1)
                    {
                        _loc4.members.updateItem(_loc6.index, _loc2);
                    }
                    else
                    {
                        _loc4.members.push(_loc2);
                    } // end else if
                } // end else if
                _loc4.members.sortOn("rankOrder", Array.NUMERIC);
                continue;
            } // end if
            _loc6 = _loc4.members.findFirstItem("id", _loc2.id);
            if (_loc6.index != -1)
            {
                _loc4.members.removeItems(_loc6.index, 1);
            } // end if
        } // end of for
        _loc4.setMembers();
    } // End of the function
    function onInfosBoosts(sExtraData)
    {
        if (sExtraData.length == 0)
        {
            api.datacenter.Player.guildInfos.setNoBoosts();
        }
        else
        {
            var _loc2 = sExtraData.split("|");
            var _loc12 = Number(_loc2[0]);
            var _loc13 = Number(_loc2[1]);
            var _loc8 = Number(_loc2[2]);
            var _loc9 = Number(_loc2[3]);
            var _loc15 = Number(_loc2[4]);
            var _loc10 = Number(_loc2[5]);
            var _loc7 = Number(_loc2[6]);
            var _loc11 = Number(_loc2[7]);
            var _loc14 = Number(_loc2[8]);
            _loc2.splice(0, 9);
            for (var _loc3 = 0; _loc3 < _loc2.length; ++_loc3)
            {
                _loc2[_loc3] = _loc2[_loc3].split(";");
            } // end of for
            _loc2.sortOn("0");
            var _loc6 = new ank.utils.ExtendedArray();
            for (var _loc3 = 0; _loc3 < _loc2.length; ++_loc3)
            {
                var _loc4 = Number(_loc2[_loc3][0]);
                var _loc5 = Number(_loc2[_loc3][1]);
                _loc6.push(new dofus.datacenter.Spell(_loc4, _loc5));
            } // end of for
            api.datacenter.Player.guildInfos.setBoosts(_loc13, _loc12, _loc8, _loc9, _loc15, _loc10, _loc7, _loc11, _loc14, _loc6);
        } // end else if
    } // End of the function
    function onInfosTaxCollectorsMovement(sExtraData)
    {
        if (sExtraData.length == 0)
        {
            api.datacenter.Player.guildInfos.setNoTaxCollectors();
        }
        else
        {
            var _loc12 = sExtraData.charAt(0) == "+";
            var _loc11 = sExtraData.substr(1).split("|");
            var _loc4 = api.datacenter.Player.guildInfos;
            for (var _loc6 = 0; _loc6 < _loc11.length; ++_loc6)
            {
                var _loc3 = _loc11[_loc6].split(";");
                var _loc2 = new Object();
                _loc2.id = parseInt(_loc3[0], 36);
                if (_loc12)
                {
                    var _loc8 = _loc4.taxCollectors.length == 0;
                    var _loc5 = parseInt(_loc3[2], 36);
                    var _loc10 = api.lang.getMapText(String(_loc5)).x;
                    var _loc9 = api.lang.getMapText(String(_loc5)).y;
                    _loc2.name = api.lang.getFullNameText(_loc3[1].split(","));
                    _loc2.position = api.kernel.MapsServersManager.getMapName(_loc5) + " (" + _loc10 + ", " + _loc9 + ")";
                    _loc2.state = Number(_loc3[3]);
                    _loc2.timer = Number(_loc3[4]);
                    _loc2.maxTimer = Number(_loc3[5]);
                    _loc2.timerReference = getTimer();
                    _loc2.maxPlayerCount = Number(_loc3[6]);
                    _loc2.players = new ank.utils.ExtendedArray();
                    _loc2.attackers = new ank.utils.ExtendedArray();
                    if (_loc8)
                    {
                        _loc4.taxCollectors.push(_loc2);
                    }
                    else
                    {
                        var _loc7 = _loc4.taxCollectors.findFirstItem("id", _loc2.id);
                        if (_loc7.index != -1)
                        {
                            _loc4.taxCollectors.updateItem(_loc7.index, _loc2);
                        }
                        else
                        {
                            _loc4.taxCollectors.push(_loc2);
                        } // end else if
                    } // end else if
                    continue;
                } // end if
                _loc7 = _loc4.taxCollectors.findFirstItem("id", _loc2.id);
                if (_loc7.index != -1)
                {
                    _loc4.taxCollectors.removeItems(_loc7.index, 1);
                } // end if
            } // end of for
            _loc4.setTaxCollectors();
        } // end else if
    } // End of the function
    function onInfosTaxCollectorsPlayers(sExtraData)
    {
        var _loc10 = sExtraData.charAt(0) == "+";
        var _loc8 = sExtraData.substr(1).split("|");
        var _loc9 = parseInt(_loc8[0], 36);
        var _loc12 = api.datacenter.Player.guildInfos.taxCollectors;
        var _loc11 = _loc12.findFirstItem("id", _loc9);
        if (_loc11.index != -1)
        {
            var _loc4 = _loc11.item;
            for (var _loc5 = 1; _loc5 < _loc8.length; ++_loc5)
            {
                var _loc3 = _loc8[_loc5].split(";");
                if (_loc10)
                {
                    var _loc2 = new Object();
                    _loc2.id = parseInt(_loc3[0], 36);
                    _loc2.name = _loc3[1];
                    _loc2.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc3[2] + ".swf";
                    _loc2.level = Number(_loc3[3]);
                    _loc2.color1 = parseInt(_loc3[4], 36);
                    _loc2.color2 = parseInt(_loc3[5], 36);
                    _loc2.color3 = parseInt(_loc3[6], 36);
                    var _loc6 = _loc4.players.findFirstItem("id", _loc2.id);
                    if (_loc6.index != -1)
                    {
                        _loc4.players.updateItem(_loc6.index, _loc2);
                    }
                    else
                    {
                        _loc4.players.push(_loc2);
                    } // end else if
                    if (_loc2.id == api.datacenter.Player.ID)
                    {
                        api.datacenter.Player.guildInfos.defendedTaxCollectorID = _loc9;
                    } // end if
                    continue;
                } // end if
                var _loc7 = parseInt(_loc3[0], 36);
                _loc6 = _loc4.players.findFirstItem("id", _loc7);
                if (_loc6.index != -1)
                {
                    _loc4.players.removeItems(_loc6.index, 1);
                } // end if
                if (_loc7 == api.datacenter.Player.ID)
                {
                    api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
                } // end if
            } // end of for
        }
        else
        {
            ank.utils.Logger.err("[gITP] impossible de trouver le percepteur");
        } // end else if
    } // End of the function
    function onInfosTaxCollectorsAttackers(sExtraData)
    {
        var _loc9 = sExtraData.charAt(0) == "+";
        var _loc8 = sExtraData.substr(1).split("|");
        var _loc12 = parseInt(_loc8[0], 36);
        var _loc11 = api.datacenter.Player.guildInfos.taxCollectors;
        var _loc10 = _loc11.findFirstItem("id", _loc12);
        if (_loc10.index != -1)
        {
            var _loc4 = _loc10.item;
            for (var _loc5 = 1; _loc5 < _loc8.length; ++_loc5)
            {
                var _loc3 = _loc8[_loc5].split(";");
                if (_loc9)
                {
                    var _loc2 = new Object();
                    _loc2.id = parseInt(_loc3[0], 36);
                    _loc2.name = _loc3[1];
                    _loc2.level = Number(_loc3[2]);
                    var _loc6 = _loc4.attackers.findFirstItem("id", _loc2.id);
                    if (_loc6.index != -1)
                    {
                        _loc4.attackers.updateItem(_loc6.index, _loc2);
                    }
                    else
                    {
                        _loc4.attackers.push(_loc2);
                    } // end else if
                    continue;
                } // end if
                var _loc7 = parseInt(_loc3[0], 36);
                _loc6 = _loc4.attackers.findFirstItem("id", _loc7);
                if (_loc6.index != -1)
                {
                    _loc4.attackers.removeItems(_loc6.index, 1);
                } // end if
            } // end of for
        }
        else
        {
            ank.utils.Logger.err("[gITp] impossible de trouver le percepteur");
        } // end else if
    } // End of the function
    function onRequestLocal(sExtraData)
    {
        api.kernel.showMessage(api.lang.getText("GUILD"), api.lang.getText("YOU_INVIT_B_IN_GUILD", [sExtraData]), "INFO_CANCEL", {name: "Guild", listener: this, params: {spriteID: api.datacenter.Player.ID}});
    } // End of the function
    function onRequestDistant(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc4 = _loc2[0];
        var _loc3 = _loc2[1];
        var _loc5 = _loc2[2];
        api.kernel.showMessage(api.lang.getText("GUILD"), api.lang.getText("A_INVIT_YOU_IN_GUILD", [_loc3, _loc5]), "CAUTION_YESNO", {name: "Guild", listener: this, params: {spriteID: _loc4}});
    } // End of the function
    function onJoinError(sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        switch (_loc3)
        {
            case "a":
            {
                api.kernel.showMessage(undefined, api.lang.getText("GUILD_JOIN_ALREADY_IN_GUILD"), "ERROR_CHAT");
                break;
            } 
            case "d":
            {
                api.kernel.showMessage(undefined, api.lang.getText("GUILD_JOIN_NO_RIGHTS"), "ERROR_CHAT");
                break;
            } 
            case "u":
            {
                api.kernel.showMessage(undefined, api.lang.getText("GUILD_JOIN_UNKNOW"), "ERROR_CHAT");
                break;
            } 
            case "o":
            {
                api.kernel.showMessage(undefined, api.lang.getText("GUILD_JOIN_OCCUPED"), "ERROR_CHAT");
                break;
            } 
            case "r":
            {
                var _loc2 = sExtraData.substr(1);
                api.kernel.showMessage(undefined, api.lang.getText("GUILD_JOIN_REFUSED", [_loc2]), "ERROR_CHAT");
                api.ui.unloadUIComponent("AskCancelGuild");
                break;
            } 
            case "c":
            {
                api.ui.unloadUIComponent("AskCancelGuild");
                api.ui.unloadUIComponent("AskYesNoGuild");
                break;
            } 
        } // End of switch
    } // End of the function
    function onJoinOk(sExtraData)
    {
        var _loc2 = sExtraData.charAt(0);
        switch (_loc2)
        {
            case "a":
            {
                api.ui.unloadUIComponent("AskCancelGuild");
                api.kernel.showMessage(undefined, api.lang.getText("A_JOIN_YOUR_GUILD", [sExtraData.substr(1)]), "INFO_CHAT");
                break;
            } 
            case "j":
            {
                api.kernel.showMessage(undefined, api.lang.getText("YOUR_R_NEW_IN_GUILD", [api.datacenter.Player.guildInfos.name]), "INFO_CHAT");
                break;
            } 
        } // End of switch
    } // End of the function
    function onJoinDistantOk()
    {
        api.ui.unloadUIComponent("AskYesNoGuild");
    } // End of the function
    function onLeave()
    {
        api.ui.unloadUIComponent("CreateGuild");
    } // End of the function
    function onBann(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc3 = sExtraData.split("|");
            var _loc2 = _loc3[0];
            var _loc4 = _loc3[1];
            var _loc5 = _loc2 == api.datacenter.Player.Name;
            if (_loc5)
            {
                if (_loc2 != _loc4)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("YOU_BANN_A_FROM_GUILD", [_loc4]), "INFO_CHAT");
                }
                else
                {
                    api.kernel.showMessage(undefined, api.lang.getText("YOU_BANN_YOU_FROM_GUILD"), "INFO_CHAT");
                    api.ui.unloadUIComponent("Guild");
                    api.datacenter.Player.guildInfos = undefined;
                } // end else if
            }
            else
            {
                api.kernel.showMessage(undefined, api.lang.getText("YOU_ARE_BANN_BY_A_FROM_GUILD", [_loc2]), "INFO_CHAT");
                api.ui.unloadUIComponent("Guild");
                delete api.datacenter.Player.guildInfos;
            } // end else if
        }
        else
        {
            var _loc6 = sExtraData.charAt(0);
            switch (_loc6)
            {
                case "d":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"), "ERROR_CHAT");
                    break;
                } 
                case "a":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_BANN_FROM_GUILD_NOT_MEMBER"), "ERROR_CHAT");
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function onHireTaxCollector(bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            var _loc2 = sExtraData.charAt(0);
            switch (_loc2)
            {
                case "d":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"), "ERROR_CHAT");
                    break;
                } 
                case "a":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("ALREADY_TAXCOLLECTOR_ON_MAP"), "ERROR_CHAT");
                    break;
                } 
                case "k":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"), "ERROR_CHAT");
                    break;
                } 
                case "m":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_HIRE_MAX_TAXCOLLECTORS"), "ERROR_CHAT");
                    break;
                } 
            } // End of switch
        } // end if
    } // End of the function
    function onTaxCollectorAttacked(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc5 = api.lang.getFullNameText(_loc2[0].split(","));
        var _loc7 = Number(_loc2[1]);
        var _loc4 = _loc2[2];
        var _loc3 = _loc2[3];
        var _loc6 = " (" + _loc4 + ", " + _loc3 + ")";
        api.kernel.showMessage(undefined, "<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\'><a href=\'asfunction:onHref,OpenGuildTaxCollectors\'>" + api.lang.getText("TAX_ATTACKED", [_loc5, _loc6]) + "</a>", "GUILD_CHAT");
        api.sounds.onTaxcollectorAttack();
    } // End of the function
    function cancel(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskCancelGuild":
            {
                this.refuseInvitation(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    } // End of the function
    function yes(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoGuild":
            {
                this.acceptInvitation(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    } // End of the function
    function no(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoGuild":
            {
                this.refuseInvitation(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    } // End of the function
} // End of Class
#endinitclip
