// Action script...

// [Initial MovieClip Action of sprite 20932]
#initclip 197
if (!dofus.aks.Guild)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Guild = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.create = function (nBackID, nBackColor, nSymbolID, nSymbolColor, sName)
    {
        this.aks.send("gC" + nBackID + "|" + nBackColor + "|" + nSymbolID + "|" + nSymbolColor + "|" + sName);
    };
    _loc1.leave = function ()
    {
        this.aks.send("gV");
    };
    _loc1.leaveTaxInterface = function ()
    {
        this.aks.send("gITV", false);
    };
    _loc1.invite = function (sPlayerName)
    {
        this.aks.send("gJR" + sPlayerName);
    };
    _loc1.acceptInvitation = function (nPlayerID)
    {
        this.aks.send("gJK" + nPlayerID);
    };
    _loc1.refuseInvitation = function (nPlayerID)
    {
        this.aks.send("gJE" + nPlayerID, false);
    };
    _loc1.getInfosGeneral = function ()
    {
        this.aks.send("gIG", true);
    };
    _loc1.getInfosMembers = function ()
    {
        this.aks.send("gIM", true);
    };
    _loc1.getInfosBoosts = function ()
    {
        this.aks.send("gIB", true);
    };
    _loc1.getInfosTaxCollector = function ()
    {
        this.aks.send("gIT", false);
    };
    _loc1.getInfosMountPark = function ()
    {
        this.aks.send("gIF", false);
    };
    _loc1.getInfosGuildHouses = function ()
    {
        this.aks.send("gIH", false);
    };
    _loc1.bann = function (sPlayerName)
    {
        this.aks.send("gK" + sPlayerName);
    };
    _loc1.changeMemberProfil = function (oMember)
    {
        this.aks.send("gP" + oMember.id + "|" + oMember.rank + "|" + oMember.percentxp + "|" + oMember.rights.value, true);
    };
    _loc1.boostCharacteristic = function (sCharacteristic)
    {
        var _loc3 = sCharacteristic;
        switch (_loc3)
        {
            case "c":
            {
                _loc3 = "k";
                break;
            } 
            case "w":
            {
                _loc3 = "o";
                break;
            } 
        } // End of switch
        this.aks.send("gB" + _loc3, true);
    };
    _loc1.boostSpell = function (nSpellID)
    {
        this.aks.send("gb" + nSpellID, true);
    };
    _loc1.hireTaxCollector = function ()
    {
        this.aks.send("gH");
    };
    _loc1.joinTaxCollector = function (nTaxID)
    {
        this.aks.send("gTJ" + nTaxID, false);
    };
    _loc1.leaveTaxCollector = function (nTaxID, nID)
    {
        this.aks.send("gTV" + nTaxID + (nID != undefined ? ("|" + nID) : ("")), false);
    };
    _loc1.removeTaxCollector = function (nID)
    {
        this.aks.send("gF" + nID, false);
    };
    _loc1.teleportToGuildHouse = function (nHouseID)
    {
        this.aks.send("gh" + nHouseID, false);
    };
    _loc1.teleportToGuildFarm = function (nID)
    {
        this.aks.send("gf" + nID, false);
    };
    _loc1.onNew = function ()
    {
        this.api.ui.loadUIComponent("CreateGuild", "CreateGuild");
    };
    _loc1.onCreate = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_CREATED"), "INFO_CHAT");
            this.api.ui.loadUIAutoHideComponent("Guild", "Guild", {currentTab: "Members"}, {bStayIfPresent: true});
        }
        else
        {
            switch (sExtraData)
            {
                case "an":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_CREATE_ALLREADY_USE_NAME"), "ERROR_BOX");
                    break;
                } 
                case "ae":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_CREATE_ALLREADY_USE_EMBLEM"), "ERROR_BOX");
                    break;
                } 
                case "a":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_CREATE_ALLREADY_IN_GUILD"), "ERROR_BOX");
                    break;
                } 
            } // End of switch
            this.api.ui.getUIComponent("CreateGuild").enabled = true;
        } // end else if
    };
    _loc1.onStats = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _global.parseInt(_loc3[1], 36);
        var _loc6 = _global.parseInt(_loc3[2], 36);
        var _loc7 = _global.parseInt(_loc3[3], 36);
        var _loc8 = _global.parseInt(_loc3[4], 36);
        var _loc9 = _global.parseInt(_loc3[5], 36);
        if (this.api.datacenter.Player.guildInfos == undefined)
        {
            this.api.datacenter.Player.guildInfos = new dofus.datacenter.GuildInfos(_loc4, _loc5, _loc6, _loc7, _loc8, _loc9);
        }
        else
        {
            this.api.datacenter.Player.guildInfos.initialize(_loc4, _loc5, _loc6, _loc7, _loc8, _loc9);
        } // end else if
    };
    _loc1.onInfosGeneral = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0] == "1";
        var _loc5 = Number(_loc3[1]);
        var _loc6 = Number(_loc3[2]);
        var _loc7 = Number(_loc3[3]);
        var _loc8 = Number(_loc3[4]);
        this.api.datacenter.Player.guildInfos.setGeneralInfos(_loc4, _loc5, _loc6, _loc7, _loc8);
    };
    _loc1.onInfosMembers = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = this.api.datacenter.Player.guildInfos;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc4.length)
        {
            var _loc7 = _loc4[_loc6].split(";");
            var _loc8 = new Object();
            _loc8.id = Number(_loc7[0]);
            if (_loc3)
            {
                var _loc9 = _loc5.members.length == 0;
                _loc8.name = _loc7[1];
                _loc8.level = Number(_loc7[2]);
                _loc8.gfx = Number(_loc7[3]);
                _loc8.rank = Number(_loc7[4]);
                _loc8.rankOrder = this.api.lang.getRankInfos(_loc8.rank).o;
                _loc8.winxp = Number(_loc7[5]);
                _loc8.percentxp = Number(_loc7[6]);
                _loc8.rights = new dofus.datacenter.GuildRights(Number(_loc7[7]));
                _loc8.state = Number(_loc7[8]);
                _loc8.alignement = Number(_loc7[9]);
                _loc8.lastConnection = Number(_loc7[10]);
                _loc8.isLocalPlayer = _loc8.id == this.api.datacenter.Player.ID;
                if (_loc9)
                {
                    _loc5.members.push(_loc8);
                }
                else
                {
                    var _loc10 = _loc5.members.findFirstItem("id", _loc8.id);
                    if (_loc10.index != -1)
                    {
                        _loc5.members.updateItem(_loc10.index, _loc8);
                    }
                    else
                    {
                        _loc5.members.push(_loc8);
                    } // end else if
                } // end else if
                _loc5.members.sortOn("rankOrder", Array.NUMERIC);
                continue;
            } // end if
            var _loc11 = _loc5.members.findFirstItem("id", _loc8.id);
            if (_loc11.index != -1)
            {
                _loc5.members.removeItems(_loc11.index, 1);
            } // end if
        } // end while
        _loc5.setMembers();
    };
    _loc1.onInfosBoosts = function (sExtraData)
    {
        if (sExtraData.length == 0)
        {
            this.api.datacenter.Player.guildInfos.setNoBoosts();
        }
        else
        {
            var _loc3 = sExtraData.split("|");
            var _loc4 = Number(_loc3[0]);
            var _loc5 = Number(_loc3[1]);
            var _loc6 = Number(_loc3[2]);
            var _loc7 = Number(_loc3[3]);
            var _loc8 = Number(_loc3[4]);
            var _loc9 = Number(_loc3[5]);
            var _loc10 = Number(_loc3[6]);
            var _loc11 = Number(_loc3[7]);
            var _loc12 = Number(_loc3[8]);
            var _loc13 = Number(_loc3[9]);
            _loc3.splice(0, 10);
            var _loc14 = 0;
            
            while (++_loc14, _loc14 < _loc3.length)
            {
                _loc3[_loc14] = _loc3[_loc14].split(";");
            } // end while
            _loc3.sortOn("0");
            var _loc15 = new ank.utils.ExtendedArray();
            var _loc16 = 0;
            
            while (++_loc16, _loc16 < _loc3.length)
            {
                var _loc17 = Number(_loc3[_loc16][0]);
                var _loc18 = Number(_loc3[_loc16][1]);
                _loc15.push(new dofus.datacenter.Spell(_loc17, _loc18));
            } // end while
            this.api.datacenter.Player.guildInfos.setBoosts(_loc5, _loc4, _loc6, _loc7, _loc8, _loc9, _loc10, _loc11, _loc12, _loc13, _loc15);
        } // end else if
    };
    _loc1.onInfosMountPark = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = 1;
        
        while (++_loc6, _loc6 < _loc3.length)
        {
            var _loc7 = _loc3[_loc6].split(";");
            var _loc8 = Number(_loc7[0]);
            var _loc9 = Number(_loc7[1]);
            var _loc10 = Number(_loc7[2]);
            var _loc11 = new dofus.datacenter.MountPark(0, -1, _loc9, _loc10, this.api.datacenter.Player.guildInfos.name);
            _loc11.map = _loc8;
            _loc11.mounts = new ank.utils.ExtendedArray();
            if (_loc7[3] != "")
            {
                var _loc12 = _loc7[3].split(",");
                var _loc13 = 0;
                
                while (_loc13 = _loc13 + 3, _loc13 < _loc12.length)
                {
                    var _loc14 = new dofus.datacenter.Mount(Number(_loc12[_loc13]));
                    _loc14.name = _loc12[_loc13 + 1] == "" ? (this.api.lang.getText("NO_NAME")) : (_loc12[_loc13 + 1]);
                    _loc14.ownerName = _loc12[_loc13 + 2];
                    _loc11.mounts.push(_loc14);
                } // end while
            } // end if
            _loc5.push(_loc11);
        } // end while
        this.api.datacenter.Player.guildInfos.setMountParks(_loc4, _loc5);
    };
    _loc1.onInfosTaxCollectorsMovement = function (sExtraData)
    {
        if (sExtraData.length == 0)
        {
            this.api.datacenter.Player.guildInfos.setNoTaxCollectors();
        }
        else
        {
            var _loc3 = sExtraData.charAt(0) == "+";
            var _loc4 = sExtraData.substr(1).split("|");
            var _loc5 = this.api.datacenter.Player.guildInfos;
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc4.length)
            {
                var _loc7 = _loc4[_loc6].split(";");
                var _loc8 = new Object();
                _loc8.id = _global.parseInt(_loc7[0], 36);
                if (_loc3)
                {
                    var _loc9 = _loc5.taxCollectors.length == 0;
                    var _loc10 = _global.parseInt(_loc7[2], 36);
                    var _loc11 = this.api.lang.getMapText(_loc10).x;
                    var _loc12 = this.api.lang.getMapText(_loc10).y;
                    _loc8.name = this.api.lang.getFullNameText(_loc7[1].split(","));
                    _loc8.position = this.api.kernel.MapsServersManager.getMapName(_loc10) + " (" + _loc11 + ", " + _loc12 + ")";
                    _loc8.state = Number(_loc7[3]);
                    _loc8.timer = Number(_loc7[4]);
                    _loc8.maxTimer = Number(_loc7[5]);
                    _loc8.timerReference = getTimer();
                    _loc8.maxPlayerCount = Number(_loc7[6]);
                    var _loc13 = _loc7[1].split(",");
                    if (_loc13.length != 2)
                    {
                        _loc8.showMoreInfo = true;
                        _loc8.callerName = _loc13[2] == "" ? ("?") : (_loc13[2]);
                        _loc8.startDate = _global.parseInt(_loc13[3], 10);
                        _loc8.lastHarvesterName = _loc13[4] == "" ? ("?") : (_loc13[4]);
                        _loc8.lastHarvestDate = _global.parseInt(_loc13[5], 10);
                        _loc8.nextHarvestDate = _global.parseInt(_loc13[6], 10);
                    }
                    else
                    {
                        _loc8.showMoreInfo = false;
                        _loc8.callerName = "?";
                        _loc8.startDate = -1;
                        _loc8.lastHarvesterName = "?";
                        _loc8.lastHarvestDate = -1;
                        _loc8.nextHarvestDate = -1;
                    } // end else if
                    _loc8.players = new ank.utils.ExtendedArray();
                    _loc8.attackers = new ank.utils.ExtendedArray();
                    if (_loc9)
                    {
                        _loc5.taxCollectors.push(_loc8);
                    }
                    else
                    {
                        var _loc14 = _loc5.taxCollectors.findFirstItem("id", _loc8.id);
                        if (_loc14.index != -1)
                        {
                            _loc5.taxCollectors.updateItem(_loc14.index, _loc8);
                        }
                        else
                        {
                            _loc5.taxCollectors.push(_loc8);
                        } // end else if
                    } // end else if
                    continue;
                } // end if
                var _loc15 = _loc5.taxCollectors.findFirstItem("id", _loc8.id);
                if (_loc15.index != -1)
                {
                    _loc5.taxCollectors.removeItems(_loc15.index, 1);
                } // end if
            } // end while
            _loc5.setTaxCollectors();
        } // end else if
    };
    _loc1.onInfosTaxCollectorsPlayers = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = _global.parseInt(_loc4[0], 36);
        var _loc6 = this.api.datacenter.Player.guildInfos.taxCollectors;
        var _loc7 = _loc6.findFirstItem("id", _loc5);
        if (_loc7.index != -1)
        {
            var _loc8 = _loc7.item;
            var _loc9 = 1;
            
            while (++_loc9, _loc9 < _loc4.length)
            {
                var _loc10 = _loc4[_loc9].split(";");
                if (_loc3)
                {
                    var _loc11 = new Object();
                    _loc11.id = _global.parseInt(_loc10[0], 36);
                    _loc11.name = _loc10[1];
                    _loc11.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc10[2] + ".swf";
                    _loc11.level = Number(_loc10[3]);
                    _loc11.color1 = _global.parseInt(_loc10[4], 36);
                    _loc11.color2 = _global.parseInt(_loc10[5], 36);
                    _loc11.color3 = _global.parseInt(_loc10[6], 36);
                    var _loc12 = _loc8.players.findFirstItem("id", _loc11.id);
                    if (_loc12.index != -1)
                    {
                        _loc8.players.updateItem(_loc12.index, _loc11);
                    }
                    else
                    {
                        _loc8.players.push(_loc11);
                    } // end else if
                    if (_loc11.id == this.api.datacenter.Player.ID)
                    {
                        this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = _loc5;
                    } // end if
                    continue;
                } // end if
                var _loc13 = _global.parseInt(_loc10[0], 36);
                var _loc14 = _loc8.players.findFirstItem("id", _loc13);
                if (_loc14.index != -1)
                {
                    _loc8.players.removeItems(_loc14.index, 1);
                } // end if
                if (_loc13 == this.api.datacenter.Player.ID)
                {
                    this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
                } // end if
            } // end while
        }
        else
        {
            ank.utils.Logger.err("[gITP] impossible de trouver le percepteur");
        } // end else if
    };
    _loc1.onInfosTaxCollectorsAttackers = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        var _loc4 = sExtraData.substr(1).split("|");
        var _loc5 = _global.parseInt(_loc4[0], 36);
        var _loc6 = this.api.datacenter.Player.guildInfos.taxCollectors;
        var _loc7 = _loc6.findFirstItem("id", _loc5);
        if (_loc7.index != -1)
        {
            var _loc8 = _loc7.item;
            var _loc9 = 1;
            
            while (++_loc9, _loc9 < _loc4.length)
            {
                var _loc10 = _loc4[_loc9].split(";");
                if (_loc3)
                {
                    var _loc11 = new Object();
                    _loc11.id = _global.parseInt(_loc10[0], 36);
                    _loc11.name = _loc10[1];
                    _loc11.level = Number(_loc10[2]);
                    var _loc12 = _loc8.attackers.findFirstItem("id", _loc11.id);
                    if (_loc12.index != -1)
                    {
                        _loc8.attackers.updateItem(_loc12.index, _loc11);
                    }
                    else
                    {
                        _loc8.attackers.push(_loc11);
                    } // end else if
                    continue;
                } // end if
                var _loc13 = _global.parseInt(_loc10[0], 36);
                var _loc14 = _loc8.attackers.findFirstItem("id", _loc13);
                if (_loc14.index != -1)
                {
                    _loc8.attackers.removeItems(_loc14.index, 1);
                } // end if
            } // end while
        }
        else
        {
            ank.utils.Logger.err("[gITp] impossible de trouver le percepteur");
        } // end else if
    };
    _loc1.onInfosHouses = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0) == "+";
        if (sExtraData.length <= 1)
        {
            this.api.datacenter.Player.guildInfos.setNoHouses();
        }
        else
        {
            var _loc4 = sExtraData.substr(1).split("|");
            var _loc5 = new ank.utils.ExtendedArray();
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc4.length)
            {
                var _loc7 = _loc4[_loc6].split(";");
                var _loc8 = Number(_loc7[0]);
                var _loc9 = _loc7[1];
                var _loc10 = _loc7[2].split(",");
                var _loc11 = new com.ankamagames.types.Point(Number(_loc10[0]), Number(_loc10[1]));
                var _loc12 = new Array();
                var _loc13 = _loc7[3].split(",");
                var _loc14 = 0;
                
                while (++_loc14, _loc14 < _loc13.length)
                {
                    _loc12.push(Number(_loc13[_loc14]));
                } // end while
                var _loc15 = _loc7[4];
                var _loc16 = new dofus.datacenter.House(_loc8);
                _loc16.ownerName = _loc9;
                _loc16.coords = _loc11;
                _loc16.skills = _loc12;
                _loc16.guildRights = _loc15;
                _loc5.push(_loc16);
            } // end while
            this.api.datacenter.Player.guildInfos.setHouses(_loc5);
        } // end else if
    };
    _loc1.onRequestLocal = function (sExtraData)
    {
        this.api.kernel.showMessage(this.api.lang.getText("GUILD"), this.api.lang.getText("YOU_INVIT_B_IN_GUILD", [sExtraData]), "INFO_CANCEL", {name: "Guild", listener: this, params: {spriteID: this.api.datacenter.Player.ID}});
    };
    _loc1.onRequestDistant = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1];
        var _loc6 = _loc3[2];
        if (this.api.kernel.ChatManager.isBlacklisted(_loc5))
        {
            this.refuseInvitation(Number(_loc4));
            return;
        } // end if
        this.api.kernel.showMessage(undefined, this.api.lang.getText("CHAT_A_INVIT_YOU_IN_GUILD", [this.api.kernel.ChatManager.getLinkName(_loc5), _loc6]), "INFO_CHAT");
        this.api.kernel.showMessage(this.api.lang.getText("GUILD"), this.api.lang.getText("A_INVIT_YOU_IN_GUILD", [_loc5, _loc6]), "CAUTION_YESNOIGNORE", {name: "Guild", player: _loc5, listener: this, params: {spriteID: _loc4, player: _loc5}});
    };
    _loc1.onJoinError = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        switch (_loc3)
        {
            case "a":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_JOIN_ALREADY_IN_GUILD"), "ERROR_CHAT");
                break;
            } 
            case "d":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_JOIN_NO_RIGHTS"), "ERROR_CHAT");
                break;
            } 
            case "u":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_JOIN_UNKNOW"), "ERROR_CHAT");
                break;
            } 
            case "o":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_JOIN_OCCUPED"), "ERROR_CHAT");
                break;
            } 
            case "r":
            {
                var _loc4 = sExtraData.substr(1);
                this.api.kernel.showMessage(undefined, this.api.lang.getText("GUILD_JOIN_REFUSED", [_loc4]), "ERROR_CHAT");
                this.api.ui.unloadUIComponent("AskCancelGuild");
                break;
            } 
            case "c":
            {
                this.api.ui.unloadUIComponent("AskCancelGuild");
                this.api.ui.unloadUIComponent("AskYesNoIgnoreGuild");
                break;
            } 
        } // End of switch
    };
    _loc1.onJoinOk = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        switch (_loc3)
        {
            case "a":
            {
                this.api.ui.unloadUIComponent("AskCancelGuild");
                this.api.kernel.showMessage(undefined, this.api.lang.getText("A_JOIN_YOUR_GUILD", [sExtraData.substr(1)]), "INFO_CHAT");
                break;
            } 
            case "j":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("YOUR_R_NEW_IN_GUILD", [this.api.datacenter.Player.guildInfos.name]), "INFO_CHAT");
                break;
            } 
        } // End of switch
    };
    _loc1.onJoinDistantOk = function ()
    {
        this.api.ui.unloadUIComponent("AskYesNoIgnoreGuild");
    };
    _loc1.onLeave = function ()
    {
        this.api.ui.unloadUIComponent("CreateGuild");
    };
    _loc1.onBann = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = sExtraData.split("|");
            var _loc5 = _loc4[0];
            var _loc6 = _loc4[1];
            var _loc7 = _loc5 == this.api.datacenter.Player.Name;
            if (_loc7)
            {
                if (_loc5 != _loc6)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("YOU_BANN_A_FROM_GUILD", [_loc6]), "INFO_CHAT");
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("YOU_BANN_YOU_FROM_GUILD"), "INFO_CHAT");
                    this.api.ui.unloadUIComponent("Guild");
                    this.api.datacenter.Player.guildInfos = undefined;
                } // end else if
            }
            else
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("YOU_ARE_BANN_BY_A_FROM_GUILD", [_loc5]), "INFO_CHAT");
                this.api.ui.unloadUIComponent("Guild");
                delete this.api.datacenter.Player.guildInfos;
            } // end else if
        }
        else
        {
            var _loc8 = sExtraData.charAt(0);
            switch (_loc8)
            {
                case "d":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"), "ERROR_CHAT");
                    break;
                } 
                case "a":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_BANN_FROM_GUILD_NOT_MEMBER"), "ERROR_CHAT");
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onHireTaxCollector = function (bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            var _loc4 = sExtraData.charAt(0);
            switch (_loc4)
            {
                case "d":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"), "ERROR_CHAT");
                    break;
                } 
                case "a":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ALREADY_TAXCOLLECTOR_ON_MAP"), "ERROR_CHAT");
                    break;
                } 
                case "k":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"), "ERROR_CHAT");
                    break;
                } 
                case "m":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_HIRE_MAX_TAXCOLLECTORS"), "ERROR_CHAT");
                    break;
                } 
                case "b":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NOT_YOUR_TAXCOLLECTORS"), "ERROR_CHAT");
                    break;
                } 
                case "y":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_HIRE_TAXCOLLECTORS_TOO_TIRED"), "ERROR_CHAT");
                    break;
                } 
                case "h":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_HIRE_TAXCOLLECTORS_HERE"), "ERROR_CHAT");
                    break;
                } 
            } // End of switch
        } // end if
    };
    _loc1.onTaxCollectorAttacked = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0].charAt(0);
        var _loc5 = this.api.lang.getFullNameText(_loc3[0].substr(1).split(","));
        var _loc6 = Number(_loc3[1]);
        var _loc7 = _loc3[2];
        var _loc8 = _loc3[3];
        var _loc9 = "(" + _loc7 + ", " + _loc8 + ")";
        switch (_loc4)
        {
            case "A":
            {
                this.api.kernel.showMessage(undefined, "<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\' /><a href=\'asfunction:onHref,OpenGuildTaxCollectors\'>" + this.api.lang.getText("TAX_ATTACKED", [_loc5, _loc9]) + "</a>", "GUILD_CHAT");
                this.api.sounds.events.onTaxcollectorAttack();
                break;
            } 
            case "S":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("TAX_ATTACKED_SUVIVED", [_loc5, _loc9]), "GUILD_CHAT");
                break;
            } 
            case "D":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("TAX_ATTACKED_DIED", [_loc5, _loc9]), "GUILD_CHAT");
                break;
            } 
        } // End of switch
    };
    _loc1.onTaxCollectorInfo = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0].charAt(0);
        var _loc5 = this.api.lang.getFullNameText(_loc3[0].substr(1).split(","));
        var _loc6 = Number(_loc3[1]);
        var _loc7 = _loc3[2];
        var _loc8 = _loc3[3];
        var _loc9 = "(" + _loc7 + ", " + _loc8 + ")";
        var _loc10 = _loc3[4];
        switch (_loc4)
        {
            case "S":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("TAXCOLLECTOR_ADDED", [_loc5, _loc9, _loc10]), "GUILD_CHAT");
                break;
            } 
            case "R":
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("TAXCOLLECTOR_REMOVED", [_loc5, _loc9, _loc10]), "GUILD_CHAT");
                break;
            } 
            case "G":
            {
                var _loc11 = _loc3[5].split(";");
                var _loc12 = Number(_loc11[0]);
                var _loc13 = _loc12 + " " + this.api.lang.getText("EXPERIENCE_POINT");
                var _loc14 = 1;
                
                while (++_loc14, _loc14 < _loc11.length)
                {
                    var _loc15 = _loc11[_loc14].split(",");
                    var _loc16 = _loc15[0];
                    var _loc17 = _loc15[1];
                    _loc13 = _loc13 + (",<br/>" + _loc17 + " x " + this.api.lang.getItemUnicText(_loc16).n);
                } // end while
                _loc13 = _loc13 + ".";
                this.api.kernel.showMessage(undefined, this.api.lang.getText("TAXCOLLECTOR_RECOLTED", [_loc5, _loc9, _loc10, _loc13]), "GUILD_CHAT");
                break;
            } 
        } // End of switch
    };
    _loc1.onUserInterfaceOpen = function (sExtraData)
    {
        switch (sExtraData)
        {
            case "T":
            {
                if (this.api.datacenter.Player.guildInfos.name != undefined)
                {
                    this.api.ui.loadUIAutoHideComponent("Guild", "Guild", {currentTab: "GuildHouses"});
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ITEM_NEED_GUILD"), "ERROR_CHAT");
                } // end else if
                break;
            } 
            case "F":
            {
                if (this.api.datacenter.Player.guildInfos.name != undefined)
                {
                    this.api.ui.loadUIAutoHideComponent("Guild", "Guild", {currentTab: "MountParks"});
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("ITEM_NEED_GUILD"), "ERROR_CHAT");
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.cancel = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskCancelGuild":
            {
                this.refuseInvitation(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoIgnoreGuild":
            {
                this.acceptInvitation(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    };
    _loc1.no = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoIgnoreGuild":
            {
                this.refuseInvitation(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    };
    _loc1.ignore = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoIgnoreGuild":
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
