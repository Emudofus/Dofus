// Action script...

// [Initial MovieClip Action of sprite 906]
#initclip 118
class dofus.utils.ChatConsoleParser extends dofus.utils.AbstractConsoleParser
{
    var _aWhisperHistory, _nWhisperHistoryPointer, api;
    function ChatConsoleParser(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        _aWhisperHistory = new Array();
        _nWhisperHistoryPointer = 0;
    } // End of the function
    function process(sCmd)
    {
        super.process(sCmd);
        if (sCmd.charAt(0) == "/")
        {
            var _loc4 = sCmd.split(" ");
            var _loc8 = _loc4[0].substr(1).toUpperCase();
            _loc4.splice(0, 1);
            switch (_loc8)
            {
                case "HELP":
                case "H":
                case "?":
                {
                    api.kernel.showMessage(undefined, api.lang.getText("COMMANDS_HELP"), "INFO_CHAT");
                    break;
                } 
                case "VERSION":
                case "VER":
                case "ABOUT":
                {
                    var _loc9 = "--------------------------------------------------------------\n";
                    _loc9 = _loc9 + ("<b></b>DOFUS Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + "</b> (build " + dofus.Constants.BUILD_NUMBER + ")\n");
                    _loc9 = _loc9 + ("(c) ANKAMA (" + dofus.Constants.VERSIONDATE + ")\n");
                    _loc9 = _loc9 + ("Flash player " + System.capabilities.version + "\n");
                    _loc9 = _loc9 + "--------------------------------------------------------------";
                    api.kernel.showMessage(undefined, _loc9, "INFO_CHAT");
                    break;
                } 
                case "T":
                {
                    api.network.Chat.send(_loc4.join(" "), "#");
                    break;
                } 
                case "G":
                {
                    if (api.datacenter.Player.guildInfos != undefined)
                    {
                        api.network.Chat.send(_loc4.join(" "), "%");
                    } // end if
                    break;
                } 
                case "W":
                case "MSG":
                case "WHISPER":
                {
                    if (_loc4.length < 2)
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("SYNTAX_ERROR", [" /w &lt;" + api.lang.getText("NAME") + "&gt; &lt;" + api.lang.getText("MSG") + "&gt;"]), "ERROR_CHAT");
                        break;
                    } // end if
                    var _loc13 = _loc4[0];
                    _loc4.shift();
                    var _loc14 = _loc4.join(" ");
                    this.pushWhisper("/w " + _loc13 + " ");
                    api.network.Chat.send(_loc14, _loc13);
                    break;
                } 
                case "WHOAMI":
                {
                    api.network.Basics.whoAmI();
                    break;
                } 
                case "WHOIS":
                {
                    if (_loc4.length == 0)
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("SYNTAX_ERROR", [" /whois &lt;" + api.lang.getText("NAME") + "&gt;"]), "ERROR_CHAT");
                        break;
                    } // end if
                    api.network.Basics.whoIs(_loc4[0]);
                    break;
                } 
                case "F":
                case "FRIEND":
                case "FRIENDS":
                {
                    switch (_loc4[0].toUpperCase())
                    {
                        case "A":
                        case "+":
                        {
                            api.network.Friends.addFriend(_loc4[1]);
                            break;
                        } 
                        case "D":
                        case "R":
                        case "-":
                        {
                            api.network.Friends.removeFriend(_loc4[1]);
                            break;
                        } 
                        case "L":
                        {
                            api.network.Friends.getFriendsList();
                            break;
                        } 
                        default:
                        {
                            api.kernel.showMessage(undefined, api.lang.getText("SYNTAX_ERROR", [" /f &lt;A/D/L&gt; &lt;" + api.lang.getText("NAME") + "&gt;"]), "ERROR_CHAT");
                        } 
                    } // End of switch
                    break;
                } 
                case "PING":
                {
                    api.network.ping();
                    break;
                } 
                case "MAPID":
                {
                    api.kernel.showMessage(undefined, "carte : " + api.datacenter.Map.id, "INFO_CHAT");
                    break;
                } 
                case "CELLID":
                {
                    api.kernel.showMessage(undefined, "cellule : " + api.datacenter.Player.data.cellNum, "INFO_CHAT");
                    break;
                } 
                case "TIME":
                {
                    api.kernel.showMessage(undefined, "Heure : " + api.kernel.NightManager.time, "INFO_CHAT");
                    break;
                } 
                case "LIST":
                case "PLAYERS":
                {
                    if (!api.datacenter.Game.isFight)
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_DO_COMMAND_HERE", [_loc8]), "ERROR_CHAT");
                        return;
                    } // end if
                    var _loc5 = new Array();
                    var _loc3 = api.datacenter.Sprites.getItems();
                    for (var _loc10 in _loc3)
                    {
                        if (_loc3[_loc10] instanceof dofus.datacenter.Character)
                        {
                            _loc5.push("- " + _loc3[_loc10].name);
                        } // end if
                    } // end of for...in
                    api.kernel.showMessage(undefined, api.lang.getText("PLAYERS_LIST") + " :\n" + _loc5.join("\n"), "INFO_CHAT");
                    break;
                } 
                case "KICK":
                {
                    if (!api.datacenter.Game.isFight || api.datacenter.Game.isRunning)
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_DO_COMMAND_HERE", [_loc8]), "ERROR_CHAT");
                        return;
                    } // end if
                    var _loc6 = String(_loc4[0]);
                    _loc3 = api.datacenter.Sprites.getItems();
                    var _loc7;
                    for (var _loc10 in _loc3)
                    {
                        if (_loc3[_loc10] instanceof dofus.datacenter.Character && _loc3[_loc10].name == _loc6)
                        {
                            _loc7 = _loc3[_loc10].id;
                            break;
                        } // end if
                    } // end of for...in
                    false;
                    if (_loc7 != undefined)
                    {
                        api.network.Game.leave(_loc7);
                    }
                    else
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_KICK_A", [_loc6]), "ERROR_CHAT");
                    } // end else if
                    break;
                } 
                case "SPECTATOR":
                case "S":
                {
                    if (!api.datacenter.Game.isRunning || api.datacenter.Game.isSpectator)
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_DO_COMMAND_HERE", [_loc8]), "ERROR_CHAT");
                        return;
                    } // end if
                    api.network.Fights.setSecret();
                    break;
                } 
                case "AWAY":
                {
                    api.network.Basics.away();
                    break;
                } 
                default:
                {
                    var _loc12 = api.lang.getEmoteID(_loc8.toLowerCase());
                    if (_loc12 != undefined)
                    {
                        api.network.Emotes.useEmote(_loc12);
                    }
                    else
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("UNKNOW_COMMAND", [_loc8]), "ERROR_CHAT");
                    } // end else if
                    break;
                } 
            } // End of switch
        }
        else if (api.datacenter.Player.canChatToAll)
        {
            api.network.Chat.send(sCmd, "*");
        } // end else if
    } // End of the function
    function pushWhisper(sCmd)
    {
        var _loc2 = _aWhisperHistory.slice(-1);
        if (_loc2[0] != sCmd)
        {
            var _loc3 = _aWhisperHistory.push(sCmd);
            if (_loc3 > 50)
            {
                _aWhisperHistory.shift();
            } // end if
        } // end if
        this.initializePointers();
    } // End of the function
    function getWhisperHistoryUp()
    {
        if (_nWhisperHistoryPointer > 0)
        {
            --_nWhisperHistoryPointer;
        } // end if
        var _loc2 = _aWhisperHistory[_nWhisperHistoryPointer];
        return (_loc2 != undefined ? (_loc2) : (""));
    } // End of the function
    function getWhisperHistoryDown()
    {
        if (_nWhisperHistoryPointer < _aWhisperHistory.length)
        {
            ++_nWhisperHistoryPointer;
        } // end if
        var _loc2 = _aWhisperHistory[_nWhisperHistoryPointer];
        return (_loc2 != undefined ? (_loc2) : (""));
    } // End of the function
    function initializePointers()
    {
        super.initializePointers();
        _nWhisperHistoryPointer = _aWhisperHistory.length;
    } // End of the function
} // End of Class
#endinitclip
