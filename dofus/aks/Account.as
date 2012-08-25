// Action script...

// [Initial MovieClip Action of sprite 20761]
#initclip 26
if (!dofus.aks.Account)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Account = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
        this.WaitQueueTimer = new Object();
    }).prototype;
    _loc1.logon = function (sLogin, sPassword)
    {
        if (this.api.datacenter.Basics.connexionKey == undefined)
        {
            this.onLogin(false, "n");
            return;
        } // end if
        if (sLogin == undefined)
        {
            sLogin = this.api.datacenter.Basics.login;
        }
        else
        {
            this.api.datacenter.Basics.login = sLogin;
        } // end else if
        if (sPassword == undefined)
        {
            sPassword = this.api.datacenter.Basics.password;
        }
        else
        {
            this.api.datacenter.Basics.password = sPassword;
        } // end else if
        this.aks.send(dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION > 0 ? ("." + dofus.Constants.BETAVERSION) : ("")) + (this.api.config.isStreaming ? ("s") : ("")), true, this.api.lang.getText("CONNECTING"));
        if (this.api.lang.getConfigText("CRYPTO_METHOD") == 2)
        {
            var _loc4 = new ank.utils.Md5();
            var _loc5 = "#2" + _loc4.hex_md5(_loc4.hex_md5(sPassword) + this.api.datacenter.Basics.connexionKey);
            this.aks.send(sLogin + "\n" + _loc5);
        }
        else
        {
            this.aks.send(sLogin + "\n" + ank.utils.Crypt.cryptPassword(sPassword, this.api.datacenter.Basics.connexionKey));
        } // end else if
    };
    _loc1.setNickName = function (sNickName)
    {
        this.aks.send(sNickName, true, this.api.lang.getText("WAITING_MSG_LOADING"));
    };
    _loc1.getCharacters = function ()
    {
        this.aks.send("AL", true, this.api.lang.getText("CONNECTING"));
    };
    _loc1.getCharactersForced = function ()
    {
        this.aks.send("ALf", true, this.api.lang.getText("CONNECTING"));
    };
    _loc1.getServersList = function ()
    {
        this.aks.send("Ax", true, this.api.lang.getText("WAITING_MSG_LOADING"));
    };
    _loc1.setServer = function (nServerID)
    {
        if (nServerID == undefined)
        {
            return;
        } // end if
        this.api.datacenter.Basics.aks_incoming_server_id = nServerID;
        this.aks.send("AX" + nServerID, true, this.api.lang.getText("WAITING_MSG_LOADING"));
    };
    _loc1.searchForFriend = function (sNick)
    {
        this.aks.send("AF" + sNick);
    };
    _loc1.setCharacter = function (sCharacID)
    {
        this.api.network.send("AS" + sCharacID, true, this.api.lang.getText("WAITING_MSG_LOADING"));
        this.api.ui.unloadUIComponent("ChooseCharacter");
        this.getQueuePosition();
    };
    _loc1.addCharacter = function (sName, nClass, nColor1, nColor2, nColor3, nSex)
    {
        this.aks.send("AA" + sName + "|" + nClass + "|" + nSex + "|" + nColor1 + "|" + nColor2 + "|" + nColor3, true, this.api.lang.getText("WAITING_MSG_RECORDING"));
    };
    _loc1.deleteCharacter = function (nCharacID, sSecretAnswer)
    {
        if (nCharacID == undefined)
        {
            return;
        } // end if
        if (sSecretAnswer == undefined)
        {
            sSecretAnswer = "";
        } // end if
        var _loc4 = new ank.utils.ExtendedString(_global.escape(sSecretAnswer));
        this.aks.send("AD" + nCharacID + "|" + _loc4.replace(["|", "\r", "\n", String.fromCharCode(0)], ["", "", "", ""]), true, this.api.lang.getText("WAITING_MSG_DELETING"));
    };
    _loc1.resetCharacter = function (nCharacID)
    {
        this.aks.send("AR" + nCharacID);
    };
    _loc1.boost = function (nBonusID)
    {
        this.aks.send("AB" + nBonusID);
    };
    _loc1.sendTicket = function (sTicket)
    {
        this.aks.send("AT" + sTicket);
    };
    _loc1.rescue = function (sTicket)
    {
        var _loc3 = "";
        if (this.api.datacenter.Game.isFight)
        {
            _loc3 = this.api.datacenter.Game.isRunning ? ("|1") : ("|0");
        } // end if
        this.aks.send("Ar" + sTicket + _loc3);
    };
    _loc1.getGifts = function ()
    {
        this.aks.send("Ag" + this.api.config.language);
    };
    _loc1.attributeGiftToCharacter = function (nGiftID, nCharacterID)
    {
        this.aks.send("AG" + nGiftID + "|" + nCharacterID);
    };
    _loc1.getQueuePosition = function ()
    {
        this.aks.send("Af", false);
        ank.utils.Timer.setTimer(this.WaitQueueTimer, "WaitQueue", this, this.getQueuePosition, Number(this.api.lang.getConfigText("DELAY_WAIT_QUEUE_REFRESH")));
    };
    _loc1.getRandomCharacterName = function ()
    {
        this.aks.send("AP", false);
    };
    _loc1.useKey = function (nKeyID)
    {
        this.aks.send("Ak" + dofus.aks.Aks.HEX_CHARS[nKeyID], false);
    };
    _loc1.requestRegionalVersion = function ()
    {
        this.aks.send("AV", true, this.api.lang.getText("WAITING_MSG_LOADING"));
    };
    _loc1.sendIdentity = function ()
    {
        if (this.api.datacenter.Basics.aks_current_server == undefined)
        {
            _global.clearInterval(this._nIdentityTimer);
            return;
        } // end if
        if (!this.api.datacenter.Basics.aks_can_send_identity)
        {
            return;
        } // end if
        dofus.managers.UIdManager.getInstance().update();
        var _loc2 = this.api.datacenter.Basics.aks_identity;
        var _loc3 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
        var _loc4 = _loc3.data.identity;
        if (!this.api.network.isValidNetworkKey(_loc4))
        {
            _loc4 = this.api.network.getRandomNetworkKey();
            _loc3.data.identity = _loc4;
            _loc3.flush();
        }
        else if (_loc2 != _loc4)
        {
            this.api.datacenter.Basics.aks_identity = _loc4;
            this.aks.send("Ai" + this.api.datacenter.Basics.aks_identity, false);
        } // end else if
        _loc3.close();
    };
    _loc1.validCharacterMigration = function (nCharacterID, sName)
    {
        this.aks.send("AM" + nCharacterID + ";" + sName, false);
    };
    _loc1.deleteCharacterMigration = function (nCharacterID)
    {
        this.aks.send("AM-" + nCharacterID, false);
    };
    _loc1.askCharacterMigration = function (nCharacterID, sName)
    {
        this.aks.send("AM?" + nCharacterID + ";" + sName, false);
    };
    _loc1.onRegionalVersion = function (sExtraData)
    {
        var _loc3 = this.api.lang.getConfigText("MAXIMUM_ALLOWED_VERSION");
        var _loc4 = Number(sExtraData);
        if (_loc3 > 0)
        {
            if ((_loc4 <= 0 || _loc4 > _loc3) && !this.api.datacenter.Player.isAuthorized)
            {
                var _loc5 = {name: "SwitchToEnglish", listener: this};
                this.api.kernel.showMessage(undefined, this.api.lang.getText("SWITCH_TO_ENGLISH"), "CAUTION_YESNO", _loc5);
                return;
            } // end if
        } // end if
        this.api.datacenter.Basics.aks_current_regional_version = _loc4 > 0 && !_global.isNaN(_loc4) ? (_loc4) : (Number.MAX_VALUE);
        this.getGifts();
        _global.clearInterval(this._nIdentityTimer);
        this._nIdentityTimer = _global.setInterval(this, "sendIdentity", (Math.round(Math.random() * 120) + 60) * 1000);
        this.sendIdentity();
        this.getCharacters();
        this.api.network.Account.getQueuePosition();
    };
    _loc1.onCharacterDelete = function (bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            this.api.ui.unloadUIComponent("WaitingMessage");
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CHARACTER_DELETION_FAILED"), "ERROR_BOX");
        } // end if
    };
    _loc1.onSecretQuestion = function (sExtraData)
    {
        this.api.datacenter.Basics.aks_secret_question = sExtraData;
    };
    _loc1.onKey = function (sExtraData)
    {
        var _loc3 = _global.parseInt(sExtraData.substr(0, 1), 16);
        var _loc4 = sExtraData.substr(1);
        this.aks.addKeyToCollection(_loc3, _loc4);
        this.useKey(_loc3);
        this.aks.startUsingKey(_loc3);
    };
    _loc1.onDofusPseudo = function (sExtraData)
    {
        this.api.datacenter.Basics.dofusPseudo = sExtraData;
    };
    _loc1.onCommunity = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        if (_loc3 >= 0)
        {
            this.api.datacenter.Basics.communityId = _loc3;
        } // end if
    };
    _loc1.onLogin = function (bSuccess, sExtraData)
    {
        ank.utils.Timer.removeTimer(this.WaitQueueTimer, "WaitQueue");
        this.api.ui.unloadUIComponent("CenterText");
        this.api.ui.unloadUIComponent("WaitingMessage");
        this.api.ui.unloadUIComponent("WaitingQueue");
        if (bSuccess)
        {
            this.api.datacenter.Basics.isLogged = true;
            this.api.ui.unloadUIComponent("Login");
            this.api.ui.unloadUIComponent("ChooseNickName");
            this.api.datacenter.Player.isAuthorized = sExtraData == "1";
            _level0._loader.loadXtra();
        }
        else
        {
            var _loc4 = sExtraData.charAt(0);
            var _loc6 = false;
            switch (_loc4)
            {
                case "n":
                {
                    var _loc5 = this.api.lang.getText("CONNECT_NOT_FINISHED");
                    break;
                } 
                case "a":
                {
                    _loc5 = this.api.lang.getText("ALREADY_LOGGED");
                    break;
                } 
                case "c":
                {
                    _loc5 = this.api.lang.getText("ALREADY_LOGGED_GAME_SERVER");
                    break;
                } 
                case "v":
                {
                    _loc5 = this.api.lang.getText("BAD_VERSION", [dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION > 0 ? (" Beta " + dofus.Constants.BETAVERSION) : ("")), sExtraData.substr(1)]);
                    _loc6 = true;
                    break;
                } 
                case "p":
                {
                    _loc5 = this.api.lang.getText("NOT_PLAYER");
                    break;
                } 
                case "b":
                {
                    _loc5 = this.api.lang.getText("BANNED");
                    break;
                } 
                case "d":
                {
                    _loc5 = this.api.lang.getText("U_DISCONNECT_ACCOUNT");
                    break;
                } 
                case "k":
                {
                    var _loc7 = sExtraData.substr(1).split("|");
                    var _loc8 = 0;
                    
                    while (++_loc8, _loc8 < _loc7.length)
                    {
                        if (_loc7[_loc8] == 0)
                        {
                            _loc7[_loc8] = undefined;
                        } // end if
                    } // end while
                    _loc5 = ank.utils.PatternDecoder.getDescription(this.api.lang.getText("KICKED"), _loc7);
                    break;
                } 
                case "w":
                {
                    _loc5 = this.api.lang.getText("SERVER_FULL");
                    break;
                } 
                case "o":
                {
                    _loc5 = this.api.lang.getText("OLD_ACCOUNT", [this.api.datacenter.Basics.login]);
                    break;
                } 
                case "e":
                {
                    _loc5 = this.api.lang.getText("OLD_ACCOUNT_USE_NEW", [this.api.datacenter.Basics.login]);
                    break;
                } 
                case "m":
                {
                    _loc5 = this.api.lang.getText("MAINTAIN_ACCOUNT");
                    break;
                } 
                case "r":
                {
                    this.api.ui.loadUIComponent("ChooseNickName", "ChooseNickName");
                    return;
                } 
                case "s":
                {
                    this.api.ui.getUIComponent("ChooseNickName").nickAlreadyUsed = true;
                    return;
                    break;
                } 
                case "f":
                {
                    if (this.api.config.isStreaming)
                    {
                        _loc5 = this.api.lang.getText("ACCESS_DENIED_MINICLIP");
                        break;
                    } // end if
                } 
                default:
                {
                    _loc5 = this.api.lang.getText("ACCESS_DENIED");
                    break;
                } 
            } // End of switch
            if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
            {
                getURL("JavaScript:WriteLog(\'LoginError;" + _loc5 + "\')", "_self");
            } // end if
            this.aks.disconnect(false, false);
            var _loc9 = this.api.ui.loadUIComponent("AskOk", _loc6 ? ("AskOkOnLoginCloseClient") : ("AskOkOnLogin"), {title: this.api.lang.getText("LOGIN"), text: _loc5});
            _loc9.addEventListener("ok", this);
            this.api.kernel.manualLogon();
        } // end else if
    };
    _loc1.onServersList = function (bSuccess, sExtraData)
    {
        this.api.ui.unloadUIComponent("WaitingMessage");
        var _loc4 = this.api.datacenter.Basics.aks_servers;
        this.api.ui.getUIComponent("MainMenu").quitMode = "menu";
        var _loc5 = sExtraData.split("|");
        var _loc6 = Number(_loc5[0]);
        var _loc7 = -1;
        this.api.datacenter.Player.subscriber = _loc6 > 0;
        this.api.ui.getUIComponent("MainMenu").updateSubscribeButton();
        var _loc8 = 0;
        var _loc9 = 1;
        
        while (++_loc9, _loc9 < _loc5.length)
        {
            var _loc10 = _loc5[_loc9].split(",");
            var _loc11 = Number(_loc10[0]);
            var _loc12 = Number(_loc10[1]);
            if (_loc12 > 0)
            {
                _loc7 = _loc11;
            } // end if
            _loc8 = _loc8 + _loc12;
            var _loc13 = 0;
            
            while (++_loc13, _loc13 < _loc4.length)
            {
                if (_loc4[_loc13].id == _loc11)
                {
                    _loc4[_loc13].charactersCount = _loc12;
                    break;
                } // end if
            } // end while
        } // end while
        if (_loc7 == -1)
        {
            _loc7 = _loc4[Math.floor(Math.random() * (_loc4.length - 1))].id;
            if (!_loc7)
            {
                _loc7 = -1;
            } // end if
        } // end if
        this.api.ui.unloadUIComponent("CreateCharacter");
        this.api.ui.unloadUIComponent("ChooseCharacter");
        this.api.ui.unloadUIComponent("AutomaticServer");
        this.api.ui.unloadUIComponent("ChooseServer");
        if (!this.api.datacenter.Basics.forceAutomaticServerSelection && (_loc8 > 0 || (this.api.config.isStreaming || this.api.datacenter.Basics.forceManualServerSelection)))
        {
            if (this.api.datacenter.Basics.forceManualServerSelection)
            {
                this.api.datacenter.Basics.hasForcedManualSelection = true;
            }
            else if (_loc7 != -1 && this.api.config.isStreaming)
            {
                var _loc14 = new dofus.datacenter.Server(_loc7, 1, 0);
                if (_loc14.isAllowed())
                {
                    this.api.datacenter.Basics.aks_current_server = _loc14;
                    this.api.network.Account.setServer(_loc7);
                    return;
                } // end if
            } // end else if
            this.api.datacenter.Basics.forceManualServerSelection = false;
            this.api.ui.loadUIComponent("ChooseServer", "ChooseServer", {servers: _loc4, remainingTime: _loc6});
        }
        else
        {
            this.api.datacenter.Basics.forceAutomaticServerSelection = false;
            this.api.ui.loadUIComponent("AutomaticServer", "AutomaticServer", {servers: _loc4, remainingTime: _loc6});
        } // end else if
    };
    _loc1.onHosts = function (sExtraData)
    {
        var _loc3 = this.api.datacenter.Basics.aks_servers;
        var _loc4 = new Array();
        var _loc5 = sExtraData.split("|");
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc5.length)
        {
            var _loc7 = _loc5[_loc6].split(";");
            var _loc8 = Number(_loc7[0]);
            var _loc9 = Number(_loc7[1]);
            var _loc10 = Number(_loc7[2]);
            var _loc11 = _loc7[3] == "1";
            var _loc12 = new dofus.datacenter.Server(_loc8, _loc9, _loc10, _loc11);
            if (_global.CONFIG.onlyHardcore && _loc12.typeNum != dofus.datacenter.Server.SERVER_HARDCORE)
            {
                continue;
            } // end if
            var _loc13 = _loc3.findFirstItem("id", _loc8).item;
            if (_loc13 != undefined)
            {
                _loc12.charactersCount = _loc13.charactersCount;
            } // end if
            _loc4.push(_loc12);
        } // end while
        this.api.datacenter.Basics.aks_servers.createFromArray(_loc4);
    };
    _loc1.onCharactersList = function (bSuccess, sExtraData, bIsMigration)
    {
        this.api.ui.unloadUIComponent("WaitingMessage");
        this.api.ui.unloadUIComponent("WaitingQueue");
        var _loc5 = new Array();
        var _loc6 = sExtraData.split("|");
        var _loc7 = Number(_loc6[0]);
        var _loc8 = Number(_loc6[1]);
        var _loc9 = new Array();
        this.api.datacenter.Sprites.clear();
        var _loc10 = 2;
        
        while (++_loc10, _loc10 < _loc6.length)
        {
            var _loc11 = _loc6[_loc10].split(";");
            var _loc12 = new Object();
            var _loc13 = _loc11[0];
            var _loc14 = _loc11[1];
            _loc12.level = _loc11[2];
            _loc12.gfxID = _loc11[3];
            _loc12.color1 = _loc11[4];
            _loc12.color2 = _loc11[5];
            _loc12.color3 = _loc11[6];
            _loc12.accessories = _loc11[7];
            _loc12.merchant = _loc11[8];
            _loc12.serverID = _loc11[9];
            _loc12.isDead = _loc11[10];
            _loc12.deathCount = _loc11[11];
            _loc12.lvlMax = _loc11[12];
            var _loc15 = this.api.kernel.CharactersManager.createCharacter(_loc13, _loc14, _loc12);
            _loc15.sortID = Number(_loc13);
            _loc5.push(_loc15);
            _loc9.push(Number(_loc13));
        } // end while
        _loc5.sortOn("sortID", Array.NUMERIC);
        this.api.ui.unloadUIComponent("ChooseCharacter");
        this.api.ui.unloadUIComponent("CreateCharacter");
        this.api.ui.unloadUIComponent("ChooseServer");
        this.api.ui.unloadUIComponent("AutomaticServer");
        ank.utils.Timer.removeTimer(this.WaitQueueTimer, "WaitQueue");
        this.api.ui.getUIComponent("MainMenu").quitMode = "menu";
        if (this.api.datacenter.Basics.hasCreatedCharacter)
        {
            this.api.datacenter.Basics.hasCreatedCharacter = false;
            if (this.api.datacenter.Basics.oldCharList == undefined && _loc9.length == 1 || this.api.datacenter.Basics.oldCharList.length + 1 == _loc9.length)
            {
                var _loc16 = 0;
                
                while (++_loc16, _loc16 < _loc9.length)
                {
                    var _loc17 = false;
                    var _loc18 = 0;
                    
                    while (++_loc18, _loc18 < this.api.datacenter.Basics.oldCharList.length)
                    {
                        if (_loc9[_loc16] == this.api.datacenter.Basics.oldCharList[_loc18])
                        {
                            _loc17 = true;
                            break;
                        } // end if
                    } // end while
                    if (!_loc17)
                    {
                        this.setCharacter(_loc9[_loc16]);
                        return;
                    } // end if
                } // end while
            } // end if
        } // end if
        this.api.datacenter.Basics.oldCharList = _loc9;
        if ((!bIsMigration || this.api.datacenter.Basics.ignoreMigration) && ((this.api.datacenter.Basics.createCharacter || !_loc8) && !this.api.datacenter.Basics.ignoreCreateCharacter))
        {
            this.api.ui.loadUIComponent("CreateCharacter", "CreateCharacter", {remainingTime: _loc7});
        }
        else
        {
            this.api.ui.unloadUIComponent("CharactersMigration");
            if (!bIsMigration || this.api.datacenter.Basics.ignoreMigration)
            {
                this.api.datacenter.Basics.createCharacter = false;
                this.api.ui.loadUIComponent("ChooseCharacter", "ChooseCharacter", {spriteList: _loc5, remainingTime: _loc7, characterCount: _loc8}, {bForceLoad: true});
            }
            else
            {
                this.api.datacenter.Basics.ignoreMigration = false;
                this.api.datacenter.Basics.createCharacter = false;
                this.api.ui.loadUIComponent("CharactersMigration", "CharactersMigration", {spriteList: _loc5, remainingTime: _loc7, characterCount: _loc8}, {bForceLoad: true});
            } // end else if
        } // end else if
        if (this.api.datacenter.Basics.aks_gifts_stack.length != 0 && _loc5.length > 0)
        {
            this.api.ui.getUIComponent("CreateCharacter")._visible = false;
            this.api.ui.getUIComponent("ChooseCharacter")._visible = false;
            this.api.ui.loadUIComponent("Gifts", "Gifts", {gift: this.api.datacenter.Basics.aks_gifts_stack.shift(), spriteList: _loc5}, {bForceLoad: true});
        } // end if
    };
    _loc1.onMiniClipInfo = function ()
    {
        this.api.datacenter.Basics.first_connection_from_miniclip = true;
    };
    _loc1.onCharacterAdd = function (bSuccess, sExtraData)
    {
        this.api.ui.unloadUIComponent("WaitingMessage");
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            getURL("JavaScript:WriteLog(\'CharacterValidation;" + bSuccess + "\')", "_self");
        } // end if
        if (!bSuccess)
        {
            switch (sExtraData)
            {
                case "s":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("SUBSCRIPTION_OUT"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
                case "f":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CREATE_CHARACTER_FULL"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
                case "a":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NAME_ALEREADY_EXISTS"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
                case "n":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CREATE_CHARACTER_BAD_NAME"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
                default:
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CREATE_CHARACTER_ERROR"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
            } // End of switch
        }
        else
        {
            this.api.datacenter.Basics.createCharacter = false;
        } // end else if
    };
    _loc1.onSelectServer = function (bSuccess, bUseIp, sExtraData)
    {
        this.api.ui.unloadUIComponent("WaitingMessage");
        if (bSuccess)
        {
            if (bUseIp)
            {
                var _loc8 = sExtraData.substr(0, 8);
                var _loc9 = sExtraData.substr(8, 3);
                var _loc7 = sExtraData.substr(11);
                var _loc10 = new Array();
                var _loc11 = 0;
                
                while (_loc11 = _loc11 + 2, _loc11 < 8)
                {
                    var _loc12 = _loc8.charCodeAt(_loc11) - 48;
                    var _loc13 = _loc8.charCodeAt(_loc11 + 1) - 48;
                    _loc10.push((_loc12 & 15) << 4 | _loc13 & 15);
                } // end while
                var _loc5 = _loc10.join(".");
                var _loc6 = (ank.utils.Compressor.decode64(_loc9.charAt(0)) & 63) << 12 | (ank.utils.Compressor.decode64(_loc9.charAt(1)) & 63) << 6 | ank.utils.Compressor.decode64(_loc9.charAt(2)) & 63;
            }
            else
            {
                var _loc14 = sExtraData.split(";");
                var _loc15 = _loc14[0].split(":");
                _loc5 = _loc15[0];
                _loc6 = _loc15[1];
                _loc7 = _loc14[1];
            } // end else if
            var _loc16 = this.api.config.getCustomIP(this.api.datacenter.Basics.aks_incoming_server_id);
            if (_loc16 != undefined)
            {
                _loc5 = _loc16.ip;
                _loc6 = _loc16.port;
            } // end if
            this.api.datacenter.Basics.aks_ticket = _loc7;
            this.api.datacenter.Basics.aks_gameserver_ip = _loc5;
            this.api.datacenter.Basics.aks_gameserver_port = _loc6;
            this.api.datacenter.Basics.ignoreMigration = false;
            this.api.datacenter.Basics.ignoreCreateCharacter = false;
            this.api.ui.unloadUIComponent("ChooseServer");
            this.api.ui.unloadUIComponent("AutomaticServer");
            this.api.ui.loadUIComponent("Waiting", "Waiting");
            this.aks.softDisconnect();
            this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: this.api.lang.getText("CONNECTING")}, {bAlwaysOnTop: true, bForceLoad: true});
            this.api.network.Basics.onAuthorizedCommandPrompt(this.api.datacenter.Basics.aks_current_server.label);
            if (_global.CONFIG.delay != undefined)
            {
                ank.utils.Timer.setTimer(this, "connect", this.aks, this.aks.connect, _global.CONFIG.delay, [_loc5, _loc6, false]);
            }
            else
            {
                this.aks.connect(_loc5, _loc6, false);
            } // end else if
        }
        else
        {
            delete this.api.datacenter.Basics.aks_current_server;
            this.api.datacenter.Basics.createCharacter = false;
            switch (sExtraData.charAt(0))
            {
                case "d":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_DOWN"), "ERROR_BOX");
                    break;
                } 
                case "f":
                {
                    var _loc17 = this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_FULL");
                    if (sExtraData.substr(1).length > 0)
                    {
                        var _loc18 = sExtraData.substr(1).split("|");
                        _loc17 = _loc17 + "<br/><br/>";
                        _loc17 = _loc17 + (this.api.lang.getText("SERVERS_ACCESSIBLES") + " : <br/>");
                        var _loc19 = 0;
                        
                        while (++_loc19, _loc19 < _loc18.length)
                        {
                            var _loc20 = new dofus.datacenter.Server(_loc18[_loc19]);
                            _loc17 = _loc17 + _loc20.label;
                            _loc17 = _loc17 + (_loc19 == _loc18.length - 1 ? (".") : (", "));
                        } // end while
                    } // end if
                    this.api.kernel.showMessage(undefined, _loc17, "ERROR_BOX");
                    break;
                } 
                case "F":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("SERVER_FULL"), "ERROR_BOX");
                    break;
                } 
                case "s":
                {
                    var _loc21 = this.api.lang.getServerInfos(Number(sExtraData.substr(1))).n;
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_CHOOSE_CHARACTER_SHOP_OTHER_SERVER", [_loc21]), "ERROR_BOX");
                    break;
                } 
                case "r":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_SELECT_THIS_SERVER"), "ERROR_BOX");
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onRescue = function (bSuccess)
    {
        this.api.datacenter.Player.data.GameActionsManager.clear();
        this.api.ui.unloadUIComponent("WaitingMessage");
        this.api.ui.unloadUIComponent("WaitingQueue");
        ank.utils.Timer.removeTimer(this.WaitQueueTimer, "WaitQueue");
        if (!bSuccess)
        {
            this.api.datacenter.Basics.aks_rescue_count = -1;
            this.aks.disconnect(false, true);
        } // end if
    };
    _loc1.onTicketResponse = function (bSuccess, sExtraData)
    {
        this.api.ui.unloadUIComponent("WaitingMessage");
        if (bSuccess)
        {
            var _loc4 = _global.parseInt(sExtraData.substr(0, 1), 16);
            if (_global.isNaN(_loc4))
            {
                _loc4 = -1;
            } // end if
            if (_loc4 > 0)
            {
                this.aks.addKeyToCollection(_loc4, sExtraData.substr(1));
                this.useKey(_loc4);
                this.aks.startUsingKey(_loc4);
            }
            else if (_loc4 == 0)
            {
                this.useKey(0);
            }
            else if (_loc4 == -1)
            {
            } // end else if
            this.api.datacenter.Basics.aks_current_regional_version = Number.POSITIVE_INFINITY;
            this.api.datacenter.Basics.aks_can_send_identity = true;
            this.requestRegionalVersion();
        }
        else
        {
            this.aks.disconnect(false, true);
        } // end else if
    };
    _loc1.onCharacterSelected = function (bSuccess, sExtraData)
    {
        this.api.datacenter.Basics.inGame = true;
        this.api.ui.unloadUIComponent("WaitingMessage");
        this.api.ui.unloadUIComponent("ChooseCharacter");
        this.api.ui.unloadUIComponent("WaitingQueue");
        ank.utils.Timer.removeTimer(this.WaitQueueTimer, "WaitQueue");
        if (bSuccess)
        {
            var _loc4 = sExtraData.split("|");
            var _loc5 = new Object();
            var _loc6 = Number(_loc4[0]);
            var _loc7 = _loc4[1];
            _loc5.level = _loc4[2];
            _loc5.guild = _loc4[3];
            _loc5.sex = _loc4[4];
            _loc5.gfxID = _loc4[5];
            _loc5.color1 = _loc4[6];
            _loc5.color2 = _loc4[7];
            _loc5.color3 = _loc4[8];
            _loc5.items = _loc4[9];
            this.api.kernel.CharactersManager.setLocalPlayerData(_loc6, _loc7, _loc5);
            this.aks.Game.create();
            if (this.api.datacenter.Player.isAuthorized)
            {
                this.api.kernel.AdminManager.characterEnteringGame();
            } // end if
        }
        else
        {
            this.aks.disconnect(false, true);
        } // end else if
    };
    _loc1.onStats = function (sExtraData)
    {
        this.api.ui.unloadUIComponent("WaitingMessage");
        var _loc3 = sExtraData.split("|");
        var _loc4 = this.api.datacenter.Player;
        var _loc5 = _loc3[0].split(",");
        _loc4.XP = _loc5[0];
        _loc4.XPlow = _loc5[1];
        _loc4.XPhigh = _loc5[2];
        _loc4.Kama = _loc3[1];
        _loc4.BonusPoints = _loc3[2];
        _loc4.BonusPointsSpell = _loc3[3];
        _loc5 = _loc3[4].split(",");
        var _loc6 = 0;
        if (_loc5[0].indexOf("~"))
        {
            var _loc7 = _loc5[0].split("~");
            _loc4.haveFakeAlignment = _loc7[0] != _loc7[1];
            _loc5[0] = _loc7[0];
            _loc6 = Number(_loc7[1]);
        } // end if
        var _loc8 = Number(_loc5[0]);
        var _loc9 = Number(_loc5[1]);
        _loc4.alignment = new dofus.datacenter.Alignment(_loc8, _loc9);
        _loc4.fakeAlignment = new dofus.datacenter.Alignment(_loc6, _loc9);
        _loc4.data.alignment = _loc4.alignment.clone();
        var _loc10 = Number(_loc5[2]);
        var _loc11 = Number(_loc5[3]);
        var _loc12 = Number(_loc5[4]);
        var _loc13 = _loc5[5] == "1" ? (true) : (false);
        var _loc14 = _loc4.rank.disgrace;
        _loc4.rank = new dofus.datacenter.Rank(_loc10, _loc11, _loc12, _loc13);
        _loc4.data.rank = _loc4.rank.clone();
        if (_loc14 != undefined && (_loc14 != _loc12 && _loc12 > 0))
        {
            this.api.kernel.GameManager.showDisgraceSanction();
        } // end if
        _loc5 = _loc3[5].split(",");
        _loc4.LP = _loc5[0];
        _loc4.data.LP = _loc5[0];
        _loc4.LPmax = _loc5[1];
        _loc4.data.LPmax = _loc5[1];
        _loc5 = _loc3[6].split(",");
        _loc4.Energy = _loc5[0];
        _loc4.EnergyMax = _loc5[1];
        _loc4.Initiative = _loc3[7];
        _loc4.Discernment = _loc3[8];
        var _loc15 = new Array();
        var _loc16 = 3;
        
        while (--_loc16, _loc16 > -1)
        {
            _loc15[_loc16] = new Array();
        } // end while
        var _loc17 = 9;
        
        while (++_loc17, _loc17 < 51)
        {
            _loc5 = _loc3[_loc17].split(",");
            var _loc18 = Number(_loc5[0]);
            var _loc19 = Number(_loc5[1]);
            var _loc20 = Number(_loc5[2]);
            var _loc21 = Number(_loc5[3]);
            switch (_loc17)
            {
                case 9:
                {
                    _loc15[0].push({id: _loc17, o: 7, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "Star"});
                    if (!this.api.datacenter.Game.isFight)
                    {
                        _loc4.AP = _loc18 + _loc19 + _loc20;
                    } // end if
                    break;
                } 
                case 10:
                {
                    _loc15[0].push({id: _loc17, o: 8, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconMP"});
                    if (!this.api.datacenter.Game.isFight)
                    {
                        _loc4.MP = _loc18 + _loc19 + _loc20;
                    } // end if
                    break;
                } 
                case 11:
                {
                    _loc15[0].push({id: _loc17, o: 3, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconEarthBonus"});
                    _loc4.Force = _loc18;
                    _loc4.ForceXtra = _loc19 + _loc20;
                    break;
                } 
                case 12:
                {
                    _loc15[0].push({id: _loc17, o: 1, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconVita"});
                    _loc4.Vitality = _loc18;
                    _loc4.VitalityXtra = _loc19 + _loc20;
                    break;
                } 
                case 13:
                {
                    _loc15[0].push({id: _loc17, o: 2, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconWisdom"});
                    _loc4.Wisdom = _loc18;
                    _loc4.WisdomXtra = _loc19 + _loc20;
                    break;
                } 
                case 14:
                {
                    _loc15[0].push({id: _loc17, o: 5, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconWaterBonus"});
                    _loc4.Chance = _loc18;
                    _loc4.ChanceXtra = _loc19 + _loc20;
                    break;
                } 
                case 15:
                {
                    _loc15[0].push({id: _loc17, o: 6, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconAirBonus"});
                    _loc4.Agility = _loc18;
                    _loc4.AgilityXtra = _loc19 + _loc20;
                    _loc4.AgilityTotal = _loc18 + _loc19 + _loc20 + _loc21;
                    break;
                } 
                case 16:
                {
                    _loc15[0].push({id: _loc17, o: 4, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconFireBonus"});
                    _loc4.Intelligence = _loc18;
                    _loc4.IntelligenceXtra = _loc19 + _loc20;
                    break;
                } 
                case 17:
                {
                    _loc15[0].push({id: _loc17, o: 9, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    _loc4.RangeModerator = _loc18 + _loc19 + _loc20;
                    break;
                } 
                case 18:
                {
                    _loc15[0].push({id: _loc17, o: 10, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    _loc4.MaxSummonedCreatures = _loc18 + _loc19 + _loc20;
                    break;
                } 
                case 19:
                {
                    _loc15[1].push({id: _loc17, o: 1, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 20:
                {
                    _loc15[1].push({id: _loc17, o: 2, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 21:
                {
                    _loc15[1].push({id: _loc17, o: 3, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 22:
                {
                    _loc15[1].push({id: _loc17, o: 4, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 23:
                {
                    _loc15[1].push({id: _loc17, o: 7, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 24:
                {
                    _loc15[1].push({id: _loc17, o: 5, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 25:
                {
                    _loc15[1].push({id: _loc17, o: 6, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 26:
                {
                    _loc15[1].push({id: _loc17, o: 8, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 27:
                {
                    _loc15[1].push({id: _loc17, o: 9, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    _loc4.CriticalHitBonus = _loc18 + _loc19 + _loc20 + _loc21;
                    break;
                } 
                case 28:
                {
                    _loc15[1].push({id: _loc17, o: 10, s: _loc18, i: _loc19, d: _loc20, b: _loc21});
                    break;
                } 
                case 29:
                {
                    _loc15[1].push({id: _loc17, o: 11, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "Star"});
                    break;
                } 
                case 30:
                {
                    _loc15[1].push({id: _loc17, o: 12, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconMP"});
                    break;
                } 
                case 31:
                {
                    _loc15[2].push({id: _loc17, o: 1, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconNeutral"});
                    break;
                } 
                case 32:
                {
                    _loc15[2].push({id: _loc17, o: 2, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconNeutral"});
                    break;
                } 
                case 33:
                {
                    _loc15[3].push({id: _loc17, o: 11, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconNeutral"});
                    break;
                } 
                case 34:
                {
                    _loc15[3].push({id: _loc17, o: 12, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconNeutral"});
                    break;
                } 
                case 35:
                {
                    _loc15[2].push({id: _loc17, o: 3, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconEarth"});
                    break;
                } 
                case 36:
                {
                    _loc15[2].push({id: _loc17, o: 4, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconEarth"});
                    break;
                } 
                case 37:
                {
                    _loc15[3].push({id: _loc17, o: 13, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconEarth"});
                    break;
                } 
                case 38:
                {
                    _loc15[3].push({id: _loc17, o: 14, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconEarth"});
                    break;
                } 
                case 39:
                {
                    _loc15[2].push({id: _loc17, o: 7, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconWater"});
                    break;
                } 
                case 40:
                {
                    _loc15[2].push({id: _loc17, o: 8, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconWater"});
                    break;
                } 
                case 41:
                {
                    _loc15[3].push({id: _loc17, o: 17, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconWater"});
                    break;
                } 
                case 42:
                {
                    _loc15[3].push({id: _loc17, o: 18, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconWater"});
                    break;
                } 
                case 43:
                {
                    _loc15[2].push({id: _loc17, o: 9, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconAir"});
                    break;
                } 
                case 44:
                {
                    _loc15[2].push({id: _loc17, o: 10, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconAir"});
                    break;
                } 
                case 45:
                {
                    _loc15[3].push({id: _loc17, o: 19, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconAir"});
                    break;
                } 
                case 46:
                {
                    _loc15[3].push({id: _loc17, o: 20, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconAir"});
                    break;
                } 
                case 47:
                {
                    _loc15[2].push({id: _loc17, o: 5, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconFire"});
                    break;
                } 
                case 48:
                {
                    _loc15[2].push({id: _loc17, o: 6, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconFire"});
                    break;
                } 
                case 49:
                {
                    _loc15[3].push({id: _loc17, o: 15, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconFire"});
                    break;
                } 
                case 50:
                {
                    _loc15[3].push({id: _loc17, o: 16, s: _loc18, i: _loc19, d: _loc20, b: _loc21, p: "IconFire"});
                    break;
                } 
            } // End of switch
        } // end while
        _loc4.FullStats = _loc15;
        this.api.network.Basics.getDate();
    };
    _loc1.onNewLevel = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("NEW_LEVEL", [_loc3]), "ERROR_BOX", {name: "NewLevel"});
        this.api.datacenter.Player.Level = _loc3;
        this.api.datacenter.Player.data.Level = _loc3;
        this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_GAIN_LEVEL);
    };
    _loc1.onRestrictions = function (sExtraData)
    {
        this.api.datacenter.Player.restrictions = _global.parseInt(sExtraData, 36);
    };
    _loc1.onGiftsList = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = _loc3[2];
        var _loc7 = _loc3[3];
        var _loc8 = _loc3[4];
        var _loc9 = _loc3[5];
        var _loc10 = new LoadVars();
        _loc10.decode("&text=" + _loc6);
        var _loc11 = _loc10.text;
        _loc10 = new LoadVars();
        _loc10.decode("&desc=" + _loc7);
        var _loc12 = _loc10.desc;
        _loc10 = new LoadVars();
        _loc10.decode("&gfxurl=" + _loc8);
        var _loc13 = _loc10.gfxurl;
        var _loc14 = new Array();
        var _loc15 = _loc9.split(";");
        var _loc16 = 0;
        
        while (++_loc16, _loc16 < _loc15.length)
        {
            if (_loc15[_loc16] != "")
            {
                var _loc17 = this.api.kernel.CharactersManager.getItemObjectFromData(_loc15[_loc16]);
                _loc14.push(_loc17);
            } // end if
        } // end while
        var _loc18 = new Object();
        _loc18.type = _loc4;
        _loc18.id = _loc5;
        _loc18.title = _loc11;
        _loc18.desc = _loc12;
        _loc18.gfxUrl = _loc13;
        _loc18.items = _loc14;
        this.api.datacenter.Basics.aks_gifts_stack.push(_loc18);
    };
    _loc1.onGiftStored = function (bSuccess)
    {
        this.api.ui.unloadUIComponent("WaitingMessage");
        this.api.ui.getUIComponent("Gifts").checkNextGift();
    };
    _loc1.onQueue = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        if (_loc3 > 1)
        {
            this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: this.api.lang.getText("CONNECTING") + " ( " + this.api.lang.getText("WAIT_QUEUE_POSITION", [_loc3]) + " )"}, {bAlwaysOnTop: true, bForceLoad: true});
        } // end if
    };
    _loc1.onNewQueue = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = Number(_loc3[2]);
        switch (_loc3[3])
        {
            case "0":
            {
                var _loc7 = false;
                break;
            } 
            case "1":
            {
                _loc7 = true;
                break;
            } 
        } // End of switch
        var _loc8 = Number(_loc3[4]);
        if (_loc4 > 1)
        {
            this.api.ui.loadUIComponent("WaitingQueue", "WaitingQueue", {queueInfos: {position: _loc4, totalAbo: _loc5, totalNonAbo: _loc6, subscriber: _loc7, queueId: _loc8}}, {bAlwaysOnTop: true, bForceLoad: true});
        } // end if
    };
    _loc1.onCharacterNameGenerated = function (bSuccess, sCharacterNameOrError)
    {
        if (bSuccess)
        {
            if (this.api.ui.getUIComponent("CreateCharacter"))
            {
                this.api.ui.getUIComponent("CreateCharacter").characterName = sCharacterNameOrError;
            } // end if
            if (this.api.ui.getUIComponent("CharactersMigration"))
            {
                this.api.ui.getUIComponent("CharactersMigration").setNewName = sCharacterNameOrError;
            } // end if
        }
        else
        {
            switch (sCharacterNameOrError)
            {
                case "1":
                {
                    break;
                } 
                case "2":
                {
                    this.api.datacenter.Basics.aks_can_generate_names = false;
                    if (this.api.ui.getUIComponent("CreateCharacter"))
                    {
                        this.api.ui.getUIComponent("CreateCharacter").hideGenerateRandomName();
                    } // end if
                    if (this.api.ui.getUIComponent("CharactersMigration"))
                    {
                        this.api.ui.getUIComponent("CharactersMigration").hideGenerateRandomName();
                    } // end if
                    break;
                } 
            } // End of switch
        } // end else if
    };
    _loc1.onCharactersMigrationAskConfirm = function (sData)
    {
        var _loc3 = sData.split(";");
        var _loc4 = _global.parseInt(_loc3[0], 10);
        var _loc5 = _loc3[1];
        var _loc6 = {name: "ConfirmMigration", params: {nCharacterID: _loc4, sName: _loc5}, listener: this};
        this.api.kernel.showMessage(undefined, this.api.lang.getText("CONFIRM_MIGRATION", [_loc5]), "CAUTION_YESNO", _loc6);
    };
    _loc1.onFriendServerList = function (sData)
    {
        var _loc3 = sData.split(";");
        var _loc4 = new Array();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            var _loc6 = _loc3[_loc5].split(",");
            _loc4.push({server: _loc6[0], count: _loc6[1]});
        } // end while
        this.api.ui.getUIComponent("ServerList").setSearchResult(_loc4);
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoSwitchToEnglish":
            {
                this.api.config.language = "en";
                this.api.kernel.clearCache();
                break;
            } 
            case "AskYesNoConfirmMigration":
            {
                this.validCharacterMigration(oEvent.target.params.nCharacterID, oEvent.target.params.sName);
                break;
            } 
        } // End of switch
    };
    _loc1.no = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoSwitchToEnglish":
            {
                this.api.kernel.changeServer(true);
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
