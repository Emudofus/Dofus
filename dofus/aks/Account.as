// Action script...

// [Initial MovieClip Action of sprite 925]
#initclip 137
class dofus.aks.Account extends dofus.aks.Handler
{
    var api, aks;
    function Account(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function logon(sLogin, sPassword)
    {
        if (api.datacenter.Basics.connexionKey == undefined)
        {
            this.onLogin(false, "n");
            return;
        } // end if
        if (sLogin == undefined)
        {
            sLogin = api.datacenter.Basics.login;
        }
        else
        {
            api.datacenter.Basics.login = sLogin;
        } // end else if
        if (sPassword == undefined)
        {
            sPassword = api.datacenter.Basics.password;
        }
        else
        {
            api.datacenter.Basics.password = sPassword;
        } // end else if
        aks.send(dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION, true, api.lang.getText("CONNECTING"));
        aks.send(sLogin + "\n" + ank.utils.Crypt.cryptPassword(sPassword, api.datacenter.Basics.connexionKey));
    } // End of the function
    function getCharacters()
    {
        aks.send("AL", true, api.lang.getText("WAITING_MSG_LOADING"));
    } // End of the function
    function setCharacter(sCharacID, nServerID)
    {
        aks.send("AS" + sCharacID + "|" + nServerID, true, api.lang.getText("WAITING_MSG_LOADING"));
    } // End of the function
    function addCharacter(sName, nClass, nColor1, nColor2, nColor3, nSex, nServerID)
    {
        aks.send("AA" + sName + "|" + nClass + "|" + nSex + "|" + nColor1 + "|" + nColor2 + "|" + nColor3 + "|" + nServerID, true, api.lang.getText("WAITING_MSG_RECORDING"));
    } // End of the function
    function deleteCharacter(nCharacID)
    {
        if (nCharacID == undefined)
        {
            return;
        } // end if
        aks.send("AD" + nCharacID, true, api.lang.getText("WAITING_MSG_DELETING"));
    } // End of the function
    function boost(nBonusID)
    {
        aks.send("AB" + nBonusID);
    } // End of the function
    function sendTicket(sTicket)
    {
        aks.send("AT" + sTicket);
    } // End of the function
    function onLogin(bSuccess, sExtraData)
    {
        api.ui.unloadUIComponent("CenterText");
        if (bSuccess)
        {
            api.datacenter.Basics.isLogged = true;
            api.ui.unloadUIComponent("Login");
            api.datacenter.Player.isAuthorized = sExtraData == "1";
            _level0.showLoader();
            _level0.loadLanguage();
        }
        else
        {
            var _loc6 = sExtraData.charAt(0);
            var _loc4;
            switch (_loc6)
            {
                case "n":
                {
                    _loc4 = api.lang.getText("CONNECT_NOT_FINISHED");
                    break;
                } 
                case "a":
                {
                    _loc4 = api.lang.getText("ALREADY_LOGGED");
                    break;
                } 
                case "c":
                {
                    _loc4 = api.lang.getText("ALREADY_LOGGED_GAME_SERVER");
                    break;
                } 
                case "v":
                {
                    _loc4 = api.lang.getText("BAD_VERSION", [dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION, sExtraData.substr(1)]);
                    aks.onBadVersion();
                    break;
                } 
                case "p":
                {
                    _loc4 = api.lang.getText("NOT_PLAYER");
                    break;
                } 
                case "b":
                {
                    _loc4 = api.lang.getText("BANNED");
                    break;
                } 
                case "d":
                {
                    _loc4 = api.lang.getText("U_DISCONNECT_ACCOUNT");
                    break;
                } 
                case "k":
                {
                    var _loc3 = sExtraData.substr(1).split("|");
                    for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
                    {
                        if (_loc3[_loc2] == 0)
                        {
                            _loc3[_loc2] = undefined;
                        } // end if
                    } // end of for
                    _loc4 = ank.utils.PatternDecoder.getDescription(api.lang.getText("KICKED"), _loc3);
                    break;
                } 
                case "w":
                {
                    _loc4 = api.lang.getText("SERVER_FULL");
                    break;
                } 
                default:
                {
                    _loc4 = api.lang.getText("ACCESS_DENIED");
                    break;
                } 
            } // End of switch
            aks.disconnect(false, false);
            api.sounds.onError();
            api.ui.loadUIComponent("AskOk", "AskOkOnLogin", {title: api.lang.getText("LOGIN"), text: _loc4});
            api.kernel.manualLogon();
        } // end else if
    } // End of the function
    function onCharactersList(bSuccess, sExtraData)
    {
        var _loc9 = new Array();
        var _loc8 = sExtraData.split("|");
        var _loc10 = Number(_loc8[0]);
        var _loc11 = _loc8[1] == "1";
        for (var _loc4 = 2; _loc4 < _loc8.length; ++_loc4)
        {
            var _loc2 = _loc8[_loc4].split(";");
            var _loc3 = new Object();
            var _loc6 = _loc2[0];
            var _loc5 = _loc2[1];
            _loc3.level = _loc2[2];
            _loc3.gfxID = _loc2[3];
            _loc3.color1 = _loc2[4];
            _loc3.color2 = _loc2[5];
            _loc3.color3 = _loc2[6];
            _loc3.accessories = _loc2[7];
            _loc3.merchant = _loc2[8];
            _loc3.serverID = _loc2[9];
            var _loc7 = api.kernel.CharactersManager.createCharacter(_loc6, _loc5, _loc3);
            _loc9.push(_loc7);
        } // end of for
        api.ui.unloadUIComponent("CreateCharacter");
        api.ui.unloadUIComponent("ChooseServer");
        api.ui.getUIComponent("MainMenu").quitMode = "menu";
        api.ui.loadUIComponent("ChooseCharacter", "ChooseCharacter", {spriteList: _loc9, remainingTime: _loc10, showComboBox: _loc11}, {bForceLoad: true});
    } // End of the function
    function onCharacterAdd(bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            switch (sExtraData)
            {
                case "s":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("SUBSCRIPTION_OUT"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
                case "f":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CREATE_CHARACTER_FULL"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
                case "a":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("NAME_ALEREADY_EXISTS"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
                case "n":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CREATE_CHARACTER_BAD_NAME"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
                default:
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CREATE_CHARACTER_ERROR"), "ERROR_BOX", {name: "CreateNameExists"});
                    break;
                } 
            } // End of switch
        } // end if
    } // End of the function
    function onSelectCharacter(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc5 = sExtraData.substr(0, 8);
            var _loc7 = sExtraData.substr(8, 3);
            var _loc9 = sExtraData.substr(11);
            var _loc6 = new Array();
            for (var _loc2 = 0; _loc2 < 8; _loc2 = _loc2 + 2)
            {
                var _loc3 = _loc5.charCodeAt(_loc2) - 48;
                var _loc4 = _loc5.charCodeAt(_loc2 + 1) - 48;
                _loc6.push((_loc3 & 15) << 4 | _loc4 & 15);
            } // end of for
            var _loc12 = _loc6.join(".");
            var _loc11 = (ank.utils.Compressor.decode64(_loc7.charAt(0)) & 63) << 12 | (ank.utils.Compressor.decode64(_loc7.charAt(1)) & 63) << 6 | ank.utils.Compressor.decode64(_loc7.charAt(2)) & 63;
            api.datacenter.Basics.aks_ticket = _loc9;
            api.ui.unloadUIComponent("ChooseCharacter");
            api.ui.loadUIComponent("Waiting", "Waiting");
            api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: api.lang.getText("CONNECTING")}, {bAlwaysOnTop: true, bForceLoad: true});
            aks.softDisconnect();
            api.network.Basics.onAuthorizedCommandPrompt(api.datacenter.Basics.aks_current_server.label);
            aks.connect(_loc12, _loc11, false);
        }
        else
        {
            delete api.datacenter.Basics.aks_current_server;
            switch (sExtraData.charAt(0))
            {
                case "d":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_DOWN"), "ERROR_BOX");
                    break;
                } 
                case "f":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_FULL"), "ERROR_BOX");
                    break;
                } 
                case "s":
                {
                    var _loc10 = api.lang.getServerInfos(sExtraData.substr(1)).n;
                    api.kernel.showMessage(undefined, api.lang.getText("CANT_CHOOSE_CHARACTER_SHOP_OTHER_SERVER", [_loc10]), "ERROR_BOX");
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function onTicketResponse(bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc2 = sExtraData.split("|");
            var _loc3 = new Object();
            var _loc4 = Number(_loc2[0]);
            var _loc5 = _loc2[1];
            _loc3.level = _loc2[2];
            _loc3.guild = _loc2[3];
            _loc3.sex = _loc2[4];
            _loc3.gfxID = _loc2[5];
            _loc3.color1 = _loc2[6];
            _loc3.color2 = _loc2[7];
            _loc3.color3 = _loc2[8];
            _loc3.items = _loc2[9];
            api.kernel.CharactersManager.setLocalPlayerData(_loc4, _loc5, _loc3);
            api.ui.unloadUIComponent("WaitingMessage");
            aks.Game.create();
        }
        else
        {
            aks.disconnect(false, true);
        } // end else if
    } // End of the function
    function onStats(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc3 = api.datacenter.Player;
        _loc3.BonusPoints = _loc2[20];
        _loc3.BonusPointsSpell = _loc2[21];
        _loc3.XPlow = _loc2[0];
        _loc3.XPhigh = _loc2[2];
        _loc3.XP = _loc2[1];
        _loc3.LP = _loc2[3];
        _loc3.LPmax = _loc2[4];
        _loc3.data.LP = _loc2[3];
        _loc3.data.LPmax = _loc2[4];
        _loc3.data.AP = _loc2[5];
        _loc3.AP = _loc2[5];
        _loc3.data.MP = _loc2[6];
        _loc3.MP = _loc2[6];
        _loc3.Kama = _loc2[7];
        _loc3.Force = _loc2[8];
        _loc3.ForceXtra = _loc2[9];
        _loc3.Vitality = _loc2[10];
        _loc3.VitalityXtra = _loc2[11];
        _loc3.Wisdom = _loc2[12];
        _loc3.WisdomXtra = _loc2[13];
        _loc3.Chance = _loc2[14];
        _loc3.ChanceXtra = _loc2[15];
        _loc3.Agility = _loc2[16];
        _loc3.AgilityXtra = _loc2[17];
        _loc3.Intelligence = _loc2[18];
        _loc3.IntelligenceXtra = _loc2[19];
        _loc3.RangeModerator = _loc2[22];
        _loc3.Energy = _loc2[23];
        _loc3.EnergyMax = _loc2[24];
        api.kernel.CharactersManager.setSpriteAlignment(_loc3.data, _loc2[25]);
        _loc3.MaxSummonedCreatures = _loc2[26];
        _loc3.Initiative = _loc2[27];
        _loc3.Discernment = _loc2[28];
    } // End of the function
    function onNewLevel(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        api.kernel.showMessage(api.lang.getText("INFORMATIONS"), api.lang.getText("NEW_LEVEL", [_loc2]), "ERROR_BOX", {name: "NewLevel"});
        api.datacenter.Player.Level = _loc2;
        api.datacenter.Player.data.Level = _loc2;
    } // End of the function
    function onRestrictions(sExtraData)
    {
        api.datacenter.Player.restrictions = parseInt(sExtraData, 36);
    } // End of the function
    function onHosts(sExtraData)
    {
        var _loc9 = new Array();
        var _loc8 = sExtraData.split("|");
        for (var _loc3 = 0; _loc3 < _loc8.length; ++_loc3)
        {
            var _loc2 = _loc8[_loc3].split(";");
            var _loc5 = Number(_loc2[0]);
            var _loc6 = Number(_loc2[1]);
            var _loc7 = Number(_loc2[2]);
            var _loc4 = new dofus.datacenter.Server(_loc5, _loc6, _loc7);
            _loc9.push(_loc4);
        } // end of for
        api.datacenter.Basics.aks_servers.replaceAll(0, _loc9);
    } // End of the function
} // End of Class
#endinitclip
