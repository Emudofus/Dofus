// Action script...

// [Initial MovieClip Action of sprite 20990]
#initclip 255
if (!dofus.utils.consoleParsers.ChatConsoleParser)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    if (!dofus.utils.consoleParsers)
    {
        _global.dofus.utils.consoleParsers = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.consoleParsers.ChatConsoleParser = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).prototype;
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this._aWhisperHistory = new Array();
        this._nWhisperHistoryPointer = 0;
    };
    _loc1.process = function (sCmd, oParams)
    {
        super.process(sCmd, oParams);
        sCmd = this.parseSpecialDatas(sCmd);
        if (sCmd.charAt(0) == "/")
        {
            var _loc5 = sCmd.split(" ");
            var _loc6 = _loc5[0].substr(1).toUpperCase();
            _loc5.splice(0, 1);
            while (_loc5[0].length == 0)
            {
                _loc5.splice(0, 1);
            } // end while
            switch (_loc6)
            {
                case "HELP":
                case "H":
                case "?":
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("COMMANDS_HELP"), "INFO_CHAT");
                    break;
                } 
                case "VERSION":
                case "VER":
                case "ABOUT":
                {
                    var _loc7 = "--------------------------------------------------------------\n";
                    _loc7 = _loc7 + ("<b>DOFUS Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + "</b> (build " + dofus.Constants.BUILD_NUMBER + ")");
                    if (dofus.Constants.BETAVERSION > 0)
                    {
                        _loc7 = _loc7 + (" <b><font color=\"#FF0000\">BETA VERSION " + dofus.Constants.BETAVERSION + "</font></b>");
                    } // end if
                    _loc7 = _loc7 + ("\n(c) ANKAMA GAMES (" + dofus.Constants.VERSIONDATE + ")\n");
                    _loc7 = _loc7 + ("Flash player " + System.capabilities.version + "\n");
                    _loc7 = _loc7 + "--------------------------------------------------------------";
                    this.api.kernel.showMessage(undefined, _loc7, "INFO_CHAT");
                    break;
                } 
                case "T":
                {
                    this.api.network.Chat.send(_loc5.join(" "), "#", oParams);
                    break;
                } 
                case "G":
                {
                    if (this.api.datacenter.Player.guildInfos != undefined)
                    {
                        this.api.network.Chat.send(_loc5.join(" "), "%", oParams);
                    } // end if
                    break;
                } 
                case "P":
                {
                    if (this.api.ui.getUIComponent("Party") != undefined)
                    {
                        this.api.network.Chat.send(_loc5.join(" "), "$", oParams);
                    } // end if
                    break;
                } 
                case "A":
                {
                    this.api.network.Chat.send(_loc5.join(" "), "!", oParams);
                    break;
                } 
                case "R":
                {
                    this.api.network.Chat.send(_loc5.join(" "), "?", oParams);
                    break;
                } 
                case "B":
                {
                    this.api.network.Chat.send(_loc5.join(" "), ":", oParams);
                    break;
                } 
                case "I":
                {
                    this.api.network.Chat.send(_loc5.join(" "), "^", oParams);
                    break;
                } 
                case "Q":
                {
                    this.api.network.Chat.send(_loc5.join(" "), "@", oParams);
                } 
                case "M":
                {
                    this.api.network.Chat.send(_loc5.join(" "), "¤ ", oParams);
                    break;
                } 
                case "W":
                case "MSG":
                case "WHISPER":
                {
                    if (_loc5.length < 2)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", [" /w &lt;" + this.api.lang.getText("NAME") + "&gt; &lt;" + this.api.lang.getText("MSG") + "&gt;"]), "ERROR_CHAT");
                        break;
                    } // end if
                    var _loc8 = _loc5[0];
                    if (_loc8.length < 2)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", [" /w &lt;" + this.api.lang.getText("NAME") + "&gt; &lt;" + this.api.lang.getText("MSG") + "&gt;"]), "ERROR_CHAT");
                        break;
                    } // end if
                    _loc5.shift();
                    var _loc9 = _loc5.join(" ");
                    this.pushWhisper("/w " + _loc8 + " ");
                    this.api.network.Chat.send(_loc9, _loc8, oParams);
                    break;
                } 
                case "WHOAMI":
                {
                    this.api.network.Basics.whoAmI();
                    break;
                } 
                case "WHOIS":
                {
                    if (_loc5.length == 0)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", [" /whois &lt;" + this.api.lang.getText("NAME") + "&gt;"]), "ERROR_CHAT");
                        break;
                    } // end if
                    this.api.network.Basics.whoIs(_loc5[0]);
                    break;
                } 
                case "F":
                case "FRIEND":
                case "FRIENDS":
                {
                    switch (_loc5[0].toUpperCase())
                    {
                        case "A":
                        case "+":
                        {
                            this.api.network.Friends.addFriend(_loc5[1]);
                            break;
                        } 
                        case "D":
                        case "R":
                        case "-":
                        {
                            this.api.network.Friends.removeFriend(_loc5[1]);
                            break;
                        } 
                        case "L":
                        {
                            this.api.network.Friends.getFriendsList();
                            break;
                        } 
                        default:
                        {
                            this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", [" /f &lt;A/D/L&gt; &lt;" + this.api.lang.getText("NAME") + "&gt;"]), "ERROR_CHAT");
                            break;
                        } 
                    } // End of switch
                    break;
                } 
                case "IGNORE":
                case "ENEMY":
                {
                    switch (_loc5[0].toUpperCase())
                    {
                        case "A":
                        case "+":
                        {
                            this.api.network.Enemies.addEnemy(_loc5[1]);
                            break;
                        } 
                        case "D":
                        case "R":
                        case "-":
                        {
                            this.api.network.Enemies.removeEnemy(_loc5[1]);
                            break;
                        } 
                        case "L":
                        {
                            this.api.network.Enemies.getEnemiesList();
                            break;
                        } 
                        default:
                        {
                            this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", [" /f &lt;A/D/L&gt; &lt;" + this.api.lang.getText("NAME") + "&gt;"]), "ERROR_CHAT");
                            break;
                        } 
                    } // End of switch
                    break;
                } 
                case "PING":
                {
                    this.api.network.ping();
                    break;
                } 
                case "GOD":
                case "GODMODE":
                {
                    var _loc10 = ["Bill", "Tyn", "Nyx", "Lichen", "Simsoft"];
                    this.api.kernel.showMessage(undefined, _loc10[Math.floor(Math.random() * _loc10.length)], "INFO_CHAT");
                    break;
                } 
                case "APING":
                {
                    this.api.kernel.showMessage(undefined, "Average ping : " + this.api.network.getAveragePing() + "ms (on " + this.api.network.getAveragePingPacketsCount() + " packets)", "INFO_CHAT");
                    break;
                } 
                case "MAPID":
                {
                    this.api.kernel.showMessage(undefined, "MAP ID : " + this.api.datacenter.Map.id, "INFO_CHAT");
                    if (this.api.datacenter.Player.isAuthorized)
                    {
                        this.api.kernel.showMessage(undefined, "Area : " + this.api.datacenter.Map.area, "INFO_CHAT");
                        this.api.kernel.showMessage(undefined, "Sub area : " + this.api.datacenter.Map.subarea, "INFO_CHAT");
                        this.api.kernel.showMessage(undefined, "Super Area : " + this.api.datacenter.Map.superarea, "INFO_CHAT");
                    } // end if
                    break;
                } 
                case "CELLID":
                {
                    this.api.kernel.showMessage(undefined, "CELL ID : " + this.api.datacenter.Player.data.cellNum, "INFO_CHAT");
                    break;
                } 
                case "TIME":
                {
                    this.api.kernel.showMessage(undefined, this.api.kernel.NightManager.date + " - " + this.api.kernel.NightManager.time, "INFO_CHAT");
                    break;
                } 
                case "LIST":
                case "PLAYERS":
                {
                    if (!this.api.datacenter.Game.isFight)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_DO_COMMAND_HERE", [_loc6]), "ERROR_CHAT");
                        return;
                    } // end if
                    var _loc11 = new Array();
                    var _loc12 = this.api.datacenter.Sprites.getItems();
                    for (var k in _loc12)
                    {
                        if (_loc12[k] instanceof dofus.datacenter.Character)
                        {
                            _loc11.push("- " + _loc12[k].name);
                        } // end if
                    } // end of for...in
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("PLAYERS_LIST") + " :\n" + _loc11.join("\n"), "INFO_CHAT");
                    break;
                } 
                case "KICK":
                {
                    if (!this.api.datacenter.Game.isFight || this.api.datacenter.Game.isRunning)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_DO_COMMAND_HERE", [_loc6]), "ERROR_CHAT");
                        return;
                    } // end if
                    var _loc13 = String(_loc5[0]);
                    var _loc14 = this.api.datacenter.Sprites.getItems();
                    for (var k in _loc14)
                    {
                        if (_loc14[k] instanceof dofus.datacenter.Character && _loc14[k].name == _loc13)
                        {
                            var _loc15 = _loc14[k].id;
                            break;
                        } // end if
                    } // end of for...in
                    if (_loc15 != undefined)
                    {
                        this.api.network.Game.leave(_loc15);
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_KICK_A", [_loc13]), "ERROR_CHAT");
                    } // end else if
                    break;
                } 
                case "SPECTATOR":
                case "S":
                {
                    if (!this.api.datacenter.Game.isRunning || this.api.datacenter.Game.isSpectator)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_DO_COMMAND_HERE", [_loc6]), "ERROR_CHAT");
                        return;
                    } // end if
                    this.api.network.Fights.blockSpectators();
                    break;
                } 
                case "AWAY":
                {
                    this.api.network.Basics.away();
                    break;
                } 
                case "INVISIBLE":
                {
                    this.api.network.Basics.invisible();
                    break;
                } 
                case "INVITE":
                {
                    var _loc16 = String(_loc5[0]);
                    if (_loc16.length == 0 || _loc16 == undefined)
                    {
                        break;
                    } // end if
                    this.api.network.Party.invite(_loc16);
                    break;
                } 
                case "CONSOLE":
                {
                    if (this.api.datacenter.Player.isAuthorized)
                    {
                        this.api.ui.loadUIComponent("Debug", "Debug", undefined, {bAlwaysOnTop: true});
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", [_loc6]), "ERROR_CHAT");
                    } // end else if
                    break;
                } 
                case "DEBUG":
                {
                    if (this.api.datacenter.Player.isAuthorized)
                    {
                        this.api.kernel.DebugManager.toggleDebug();
                    } // end if
                    break;
                } 
                case "CHANGECHARACTER":
                {
                    this.api.kernel.changeServer();
                    break;
                } 
                case "LOGOUT":
                {
                    this.api.kernel.disconnect();
                    break;
                } 
                case "QUIT":
                {
                    this.api.kernel.quit();
                    break;
                } 
                case "THINK":
                case "METHINK":
                case "PENSE":
                case "TH":
                {
                    if (_loc5.length < 1)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", [" /" + _loc6.toLowerCase() + " &lt;" + this.api.lang.getText("TEXT_WORD") + "&gt;"]), "ERROR_CHAT");
                        break;
                    } // end if
                    var _loc17 = "!THINK!" + _loc5.join(" ");
                    if (this.api.datacenter.Player.canChatToAll)
                    {
                        this.api.network.Chat.send(_loc17, "*", oParams);
                    } // end if
                    break;
                } 
                case "ME":
                case "EM":
                case "MOI":
                case "EMOTE":
                {
                    if (!this.api.lang.getConfigText("EMOTES_ENABLED"))
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", [_loc6]), "ERROR_CHAT");
                        break;
                    } // end if
                    if (_loc5.length < 1)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", [" /" + _loc6.toLowerCase() + " &lt;" + this.api.lang.getText("TEXT_WORD") + "&gt;"]), "ERROR_CHAT");
                        break;
                    } // end if
                    var _loc18 = _loc5.join(" ");
                    if (this.api.datacenter.Player.canChatToAll)
                    {
                        this.api.network.Chat.send(dofus.Constants.EMOTE_CHAR + _loc18 + dofus.Constants.EMOTE_CHAR, "*", oParams);
                    } // end if
                    break;
                } 
                case "KB":
                {
                    this.api.ui.loadUIComponent("KnownledgeBase", "KnownledgeBase");
                    break;
                } 
                case "RELEASE":
                {
                    if (this.api.datacenter.Player.data.isTomb)
                    {
                        this.api.network.Game.freeMySoul();
                    }
                    else if (this.api.datacenter.Player.data.isSlow)
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("ERROR_ALREADY_A_GHOST"), "ERROR_CHAT");
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("ERROR_NOT_DEAD_AT_LEAST_FOR_NOW"), "ERROR_CHAT");
                    } // end else if
                    break;
                } 
                case "SELECTION":
                {
                    if (_loc5[0] == "enable" || _loc5[0] == "on")
                    {
                        (dofus.graphics.gapi.ui.Banner)(this.api.ui.getUIComponent("Banner")).setSelectable(true);
                    }
                    else if (_loc5[0] == "disable" || _loc5[0] == "off")
                    {
                        (dofus.graphics.gapi.ui.Banner)(this.api.ui.getUIComponent("Banner")).setSelectable(false);
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("SYNTAX_ERROR", ["/selection [enable|on|disable|off]"]), "ERROR_CHAT");
                    } // end else if
                    break;
                } 
                case "WTF":
                {
                    break;
                } 
                case "CLS":
                case "CLEAR":
                {
                    this.api.kernel.ChatManager.clear();
                    this.api.kernel.ChatManager.refresh(true);
                    break;
                } 
                case "SPEAKINGITEM":
                {
                    if (this.api.datacenter.Player.isAuthorized)
                    {
                        this.api.kernel.showMessage(undefined, "Count : " + this.api.kernel.SpeakingItemsManager.nextMsgDelay, "ERROR_CHAT");
                        break;
                    } // end if
                } 
                default:
                {
                    var _loc19 = this.api.lang.getEmoteID(_loc6.toLowerCase());
                    if (_loc19 != undefined)
                    {
                        this.api.network.Emotes.useEmote(_loc19);
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, this.api.lang.getText("UNKNOW_COMMAND", [_loc6]), "ERROR_CHAT");
                    } // end else if
                    break;
                } 
            } // End of switch
        }
        else if (this.api.datacenter.Player.canChatToAll)
        {
            this.api.network.Chat.send(sCmd, "*", oParams);
        } // end else if
    };
    _loc1.pushWhisper = function (sCmd)
    {
        var _loc3 = this._aWhisperHistory.slice(-1);
        if (_loc3[0] != sCmd)
        {
            var _loc4 = this._aWhisperHistory.push(sCmd);
            if (_loc4 > 50)
            {
                this._aWhisperHistory.shift();
            } // end if
        } // end if
        this.initializePointers();
    };
    _loc1.getWhisperHistoryUp = function ()
    {
        if (this._nWhisperHistoryPointer > 0)
        {
            --this._nWhisperHistoryPointer;
        } // end if
        var _loc2 = this._aWhisperHistory[this._nWhisperHistoryPointer];
        return (_loc2 != undefined ? (_loc2) : (""));
    };
    _loc1.getWhisperHistoryDown = function ()
    {
        if (this._nWhisperHistoryPointer < this._aWhisperHistory.length)
        {
            ++this._nWhisperHistoryPointer;
        } // end if
        var _loc2 = this._aWhisperHistory[this._nWhisperHistoryPointer];
        return (_loc2 != undefined ? (_loc2) : (""));
    };
    _loc1.initializePointers = function ()
    {
        super.initializePointers();
        this._nWhisperHistoryPointer = this._aWhisperHistory.length;
    };
    _loc1.parseSpecialDatas = function (s)
    {
        ank.utils.Extensions.addExtensions();
        var _loc3 = this.api.lang.getText("INLINE_VARIABLE_POSITION").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc3, "[" + this.api.datacenter.Map.x + ", " + this.api.datacenter.Map.y + "]");
        var _loc4 = this.api.lang.getText("INLINE_VARIABLE_AREA").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc4, this.api.lang.getMapAreaText(this.api.datacenter.Map.area).n);
        var _loc5 = this.api.lang.getText("INLINE_VARIABLE_SUBAREA").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc5, this.api.lang.getMapSubAreaText(this.api.datacenter.Map.subarea).n);
        var _loc6 = this.api.lang.getText("INLINE_VARIABLE_MYSELF").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc6, this.api.datacenter.Player.Name);
        var _loc7 = this.api.lang.getText("INLINE_VARIABLE_LEVEL").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc7, String(this.api.datacenter.Player.Level));
        var _loc8 = this.api.lang.getText("INLINE_VARIABLE_GUILD").split(",");
        var _loc9 = this.api.datacenter.Player.guildInfos.name;
        if (_loc9 == undefined)
        {
            _loc9 = this.api.lang.getText("INLINE_VARIABLE_GUILD_ERROR");
        } // end if
        s = new ank.utils.ExtendedString(s).replace(_loc8, _loc9);
        var _loc10 = this.api.lang.getText("INLINE_VARIABLE_MAXLIFE").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc10, String(this.api.datacenter.Player.LPmax));
        var _loc11 = this.api.lang.getText("INLINE_VARIABLE_LIFE").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc11, String(this.api.datacenter.Player.LP));
        var _loc12 = this.api.lang.getText("INLINE_VARIABLE_LIFEPERCENT").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc12, String(Math.round(this.api.datacenter.Player.LP / this.api.datacenter.Player.LPmax * 100)));
        var _loc13 = this.api.lang.getText("INLINE_VARIABLE_EXPERIENCE").split(",");
        s = new ank.utils.ExtendedString(s).replace(_loc13, String(Math.floor((this.api.datacenter.Player.XP - this.api.datacenter.Player.XPlow) / (this.api.datacenter.Player.XPhigh - this.api.datacenter.Player.XPlow) * 100)) + "%");
        var _loc14 = this.api.lang.getText("INLINE_VARIABLE_STATS").split(",");
        if (new ank.utils.ExtendedString(s).replace(_loc14, "X").length != s.length)
        {
            var _loc15 = this.api.lang.getText("INLINE_VARIABLE_STATS_RESULT", [String(this.api.datacenter.Player.Vitality) + (this.api.datacenter.Player.VitalityXtra != 0 ? (" (" + ((this.api.datacenter.Player.VitalityXtra > 0 ? ("+") : ("")) + String(this.api.datacenter.Player.VitalityXtra)) + ")") : ("")), String(this.api.datacenter.Player.Wisdom) + (this.api.datacenter.Player.WisdomXtra != 0 ? (" (" + ((this.api.datacenter.Player.WisdomXtra > 0 ? ("+") : ("")) + String(this.api.datacenter.Player.WisdomXtra)) + ")") : ("")), String(this.api.datacenter.Player.Force) + (this.api.datacenter.Player.ForceXtra != 0 ? (" (" + ((this.api.datacenter.Player.ForceXtra > 0 ? ("+") : ("")) + String(this.api.datacenter.Player.ForceXtra)) + ")") : ("")), String(this.api.datacenter.Player.Intelligence) + (this.api.datacenter.Player.IntelligenceXtra != 0 ? (" (" + ((this.api.datacenter.Player.IntelligenceXtra > 0 ? ("+") : ("")) + String(this.api.datacenter.Player.IntelligenceXtra)) + ")") : ("")), String(this.api.datacenter.Player.Chance) + (this.api.datacenter.Player.ChanceXtra != 0 ? (" (" + ((this.api.datacenter.Player.ChanceXtra > 0 ? ("+") : ("")) + String(this.api.datacenter.Player.ChanceXtra)) + ")") : ("")), String(this.api.datacenter.Player.Agility) + (this.api.datacenter.Player.AgilityXtra != 0 ? (" (" + ((this.api.datacenter.Player.AgilityXtra > 0 ? ("+") : ("")) + String(this.api.datacenter.Player.AgilityXtra)) + ")") : ("")), String(this.api.datacenter.Player.Initiative), String(this.api.datacenter.Player.AP), String(this.api.datacenter.Player.MP)]);
            s = new ank.utils.ExtendedString(s).replace(_loc14, _loc15);
        } // end if
        return (s);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
