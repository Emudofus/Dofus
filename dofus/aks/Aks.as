// Action script...

// [Initial MovieClip Action of sprite 20690]
#initclip 211
if (!dofus.aks.Aks)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).prototype;
    _loc1.debug = function (txt)
    {
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this.Basics = new dofus.aks.Basics(this, oAPI);
        this.Account = new dofus.aks.Account(this, oAPI);
        this.Friends = new dofus.aks.Friends(this, oAPI);
        this.Enemies = new dofus.aks.Enemies(this, oAPI);
        this.Chat = new dofus.aks.Chat(this, oAPI);
        this.Dialog = new dofus.aks.Dialog(this, oAPI);
        this.Exchange = new dofus.aks.Exchange(this, oAPI);
        this.Game = new dofus.aks.Game(this, oAPI);
        this.GameActions = new dofus.aks.GameActions(this, oAPI);
        this.Houses = new dofus.aks.Houses(this, oAPI);
        this.Infos = new dofus.aks.Infos(this, oAPI);
        this.Items = new dofus.aks.Items(this, oAPI);
        this.Job = new dofus.aks.Job(this, oAPI);
        this.Key = new dofus.aks.Key(this, oAPI);
        this.Spells = new dofus.aks.Spells(this, oAPI);
        this.Storages = new dofus.aks.Storages(this, oAPI);
        this.Emotes = new dofus.aks.Emotes(this, oAPI);
        this.Documents = new dofus.aks.Documents(this, oAPI);
        this.Guild = new dofus.aks.Guild(this, oAPI);
        this.Waypoints = new dofus.aks.Waypoints(this, oAPI);
        this.Subareas = new dofus.aks.Subareas(this, oAPI);
        this.Specialization = new dofus.aks.Specialization(this, oAPI);
        this.Fights = new dofus.aks.Fights(this, oAPI);
        this.Tutorial = new dofus.aks.Tutorial(this, oAPI);
        this.Quests = new dofus.aks.Quests(this, oAPI);
        this.Party = new dofus.aks.Party(this, oAPI);
        this.Subway = new dofus.aks.Subway(this, oAPI);
        this.Mount = new dofus.aks.Mount(this, oAPI);
        this.Conquest = new dofus.aks.Conquest(this, oAPI);
        this.Ping = new Object();
        this.Lag = new Object();
        this.Deco = new Object();
        this._bLag = false;
        this._bAutoReco = this.api.lang.getConfigText("AUTO_RECONNECT") == true;
        this._oDataProcessor = new dofus.aks.DataProcessor(this, oAPI);
        this._xSocket = new XMLSocket();
        this._aLastPings = new Array();
        var aks = this;
        this._xSocket.onClose = function ()
        {
            aks.onClose();
            aks.resetKeys();
        };
        this._xSocket.onConnect = function (bSuccess)
        {
            aks.onConnect(bSuccess);
        };
        this._xSocket.onData = function (sData)
        {
            aks.onData(sData);
        };
        this._oLoader = new LoadVars();
        this._oLoader.onLoad = function (success)
        {
            aks.onLoad(success);
        };
    };
    _loc1.connect = function (sHost, nPort, bSaveHost)
    {
        if (bSaveHost == undefined)
        {
            bSaveHost = true;
        } // end if
        if (this._bConnected)
        {
            return (null);
        } // end if
        if (this._bConnecting)
        {
            return (null);
        } // end if
        this.api.ui.loadUIComponent("Waiting", "Waiting", undefined, {bStayIfPresent: true});
        if (sHost == undefined)
        {
            sHost = this.api.datacenter.Basics.serverHost;
        }
        else if (bSaveHost)
        {
            this.api.datacenter.Basics.serverHost = sHost;
        } // end else if
        if (nPort == undefined)
        {
            nPort = this.api.datacenter.Basics.serverPort;
        }
        else if (bSaveHost)
        {
            this.api.datacenter.Basics.serverPort = nPort;
        } // end else if
        this._bConnecting = true;
        this._aLastPings = new Array();
        var _loc5 = this._xSocket.connect(sHost, nPort);
        return (_loc5);
    };
    _loc1.softDisconnect = function ()
    {
        if (this._bConnected)
        {
            this._xSocket.close();
        } // end if
        this.resetKeys();
        this._bConnected = false;
    };
    _loc1.disconnect = function (bReconnect, bShowMessage, bRecoTempo)
    {
        this.softDisconnect();
        if (!bRecoTempo)
        {
            this.onClose(bReconnect, bShowMessage, true);
        }
        else
        {
            ank.utils.Timer.setTimer(this.Deco, "disconnect", this, this.onClose, 1000, [bReconnect, bShowMessage, true]);
        } // end else if
    };
    _loc1.send = function (sData, bWaiting, sWaitingMessage, bNoLimit, bNoCyphering)
    {
        if (bNoLimit != true && sData.length > dofus.Constants.MAX_MESSAGE_LENGTH)
        {
            sData = sData.substring(0, dofus.Constants.MAX_MESSAGE_LENGTH - 1);
        } // end if
        this.api.kernel.GameManager.signalActivity();
        if (bWaiting || bWaiting == undefined)
        {
            if (sWaitingMessage != undefined)
            {
                this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: sWaitingMessage}, {bAlwaysOnTop: true, bForceLoad: true});
            } // end if
            this._sDebug = sData;
            this.api.ui.loadUIComponent("Waiting", "Waiting");
            this._isWaitingForData = true;
            if (this.api.datacenter.Basics.inGame && this._bAutoReco)
            {
                ank.utils.Timer.setTimer(this.Lag, "lag", this, this.onLag, Number(this.api.lang.getConfigText("DELAY_RECO_MESSAGE")));
            } // end if
        } // end if
        if (dofus.Constants.DEBUG && dofus.Constants.DEBUG_DATAS)
        {
        } // end if
        if (!bNoCyphering)
        {
            sData = this.prepareData(sData);
        } // end if
        if (sData.charAt(sData.length - 1) != "\n")
        {
            sData = sData + "\n";
        } // end if
        this._xSocket.send(sData);
        if (bWaiting || bWaiting == undefined)
        {
            this._nLastWaitingSend = getTimer();
        } // end if
        if (dofus.Constants.DEBUG && (dofus.Constants.DEBUG_DATAS && dofus.Constants.DEBUG_ENCRYPTION))
        {
        } // end if
    };
    _loc1.processCommand = function (sCmd)
    {
        this._oDataProcessor.process(sCmd);
    };
    _loc1.startUsingKey = function (nKeyID)
    {
        this._nCurrentKey = nKeyID;
    };
    _loc1.resetKeys = function ()
    {
        this._nCurrentKey = 0;
        this._aKeys = new Array();
    };
    _loc1.unprepareData = function (s)
    {
        if (this._nCurrentKey == 0 || (this._nCurrentKey == undefined || _global.isNaN(this._nCurrentKey)))
        {
            return (s);
        } // end if
        var _loc3 = this._aKeys[_global.parseInt(s.substr(0, 1), 16)];
        if (_loc3 == undefined)
        {
            return (s);
        } // end if
        var _loc4 = s.substr(1, 1).toUpperCase();
        var _loc5 = dofus.aks.Aks.decypherData(s.substr(2), _loc3, _global.parseInt(_loc4, 16) * 2);
        if (dofus.aks.Aks.checksum(_loc5) != _loc4)
        {
            return (s);
        } // end if
        return (_loc5);
    };
    _loc1.prepareData = function (s)
    {
        if (this._nCurrentKey == 0 || (this._nCurrentKey == undefined || _global.isNaN(this._nCurrentKey)))
        {
            return (s);
        } // end if
        if (this._aKeys[this._nCurrentKey] == undefined)
        {
            return (s);
        } // end if
        var _loc3 = dofus.aks.Aks.HEX_CHARS[this._nCurrentKey];
        var _loc4 = dofus.aks.Aks.checksum(s);
        _loc3 = _loc3 + _loc4;
        return (_loc3 + dofus.aks.Aks.cypherData(s, this._aKeys[this._nCurrentKey], _global.parseInt(_loc4, 16) * 2));
    };
    (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).prepareKey = function (d)
    {
        var _loc3 = new String();
        var _loc4 = 0;
        
        while (_loc4 = _loc4 + 2, _loc4 < d.length)
        {
            _loc3 = _loc3 + String.fromCharCode(_global.parseInt(d.substr(_loc4, 2), 16));
        } // end while
        _loc3 = _global.unescape(_loc3);
        return (_loc3);
    };
    (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).checksum = function (s)
    {
        var _loc3 = 0;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < s.length)
        {
            _loc3 = _loc3 + s.charCodeAt(_loc4) % 16;
        } // end while
        return (dofus.aks.Aks.HEX_CHARS[_loc3 % 16]);
    };
    (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).d2h = function (d)
    {
        if (d > 255)
        {
            d = 255;
        } // end if
        return (dofus.aks.Aks.HEX_CHARS[Math.floor(d / 16)] + dofus.aks.Aks.HEX_CHARS[d % 16]);
    };
    (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).preEscape = function (s)
    {
        var _loc3 = new String();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < s.length)
        {
            var _loc5 = s.charAt(_loc4);
            var _loc6 = s.charCodeAt(_loc4);
            if (_loc6 < 32 || (_loc6 > 127 || (_loc5 == "%" || _loc5 == "+")))
            {
                _loc3 = _loc3 + _global.escape(_loc5);
                continue;
            } // end if
            _loc3 = _loc3 + _loc5;
        } // end while
        return (_loc3);
    };
    (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).cypherData = function (d, k, c)
    {
        var _loc5 = new String();
        var _loc6 = k.length;
        d = dofus.aks.Aks.preEscape(d);
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < d.length)
        {
            _loc5 = _loc5 + dofus.aks.Aks.d2h(d.charCodeAt(_loc7) ^ k.charCodeAt((_loc7 + c) % _loc6));
        } // end while
        return (_loc5);
    };
    (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).decypherData = function (d, k, c)
    {
        var _loc5 = new String();
        var _loc6 = k.length;
        var _loc7 = 0;
        var _loc8 = 0;
        var _loc9 = 0;
        
        while (_loc9 = _loc9 + 2, _loc9 < d.length)
        {
            _loc5 = _loc5 + String.fromCharCode(_global.parseInt(d.substr(_loc9, 2), 16) ^ k.charCodeAt((_loc7++ + c) % _loc6));
        } // end while
        _loc5 = _global.unescape(_loc5);
        return (_loc5);
    };
    _loc1.addKeyToCollection = function (nKeyID, sKey)
    {
        if (this._aKeys == undefined)
        {
            this._aKeys = new Array();
        } // end if
        this._aKeys[nKeyID] = dofus.aks.Aks.prepareKey(sKey);
    };
    _loc1.ping = function ()
    {
        this.api.datacenter.Basics.lastPingTimer = getTimer();
        this.send("ping");
    };
    _loc1.quickPing = function ()
    {
        this.send("qping");
    };
    _loc1.getAveragePing = function ()
    {
        var _loc2 = 0;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aLastPings.length)
        {
            _loc2 = _loc2 + this._aLastPings[_loc3];
        } // end while
        return (Math.round(_loc2 / this._aLastPings.length));
    };
    _loc1.getAveragePingPacketsCount = function ()
    {
        return (this._aLastPings.length);
    };
    _loc1.getAveragePingBufferSize = function ()
    {
        return (dofus.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS);
    };
    _loc1.getRandomNetworkKey = function ()
    {
        var _loc2 = "";
        var _loc3 = Math.round(Math.random() * 20) + 10;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3)
        {
            _loc2 = _loc2 + this.getRandomChar();
        } // end while
        var _loc5 = dofus.aks.Aks.checksum(_loc2) + _loc2;
        return (_loc5 + dofus.aks.Aks.checksum(_loc5));
    };
    _loc1.isValidNetworkKey = function (sKey)
    {
        if (sKey == undefined || (sKey.length == 0 || (sKey == "" || (dofus.aks.Aks.checksum(sKey.substr(0, sKey.length - 1)) != sKey.substr(sKey.length - 1) || dofus.aks.Aks.checksum(sKey.substr(1, sKey.length - 2)) != sKey.substr(0, 1)))))
        {
            return (false);
        } // end if
        return (true);
    };
    _loc1.defaultProcessAction = function (sType, sAction, bError, sData)
    {
        this.api.network.send(String(sData.substr(0, 2) + dofus.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS), false);
    };
    _loc1.getRandomChar = function ()
    {
        var _loc2 = Math.ceil(Math.random() * 100);
        if (_loc2 <= 40)
        {
            return (String.fromCharCode(Math.floor(Math.random() * 26) + 65));
        }
        else if (_loc2 <= 80)
        {
            return (String.fromCharCode(Math.floor(Math.random() * 26) + 97));
        }
        else
        {
            return (String.fromCharCode(Math.floor(Math.random() * 10) + 48));
        } // end else if
    };
    _loc1.onLag = function ()
    {
        this._bLag = true;
        this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: this.api.lang.getText("WAIT_FOR_SERVER")}, {bAlwaysOnTop: true, bForceLoad: true});
        if (this._bAutoReco)
        {
            ank.utils.Timer.setTimer(this.Deco, "deco", this, this.onDeco, Number(this.api.lang.getConfigText("DELAY_RECO_START")));
        } // end if
    };
    _loc1.onDeco = function ()
    {
        if (this._bConnected)
        {
            this.resetKeys();
            this._xSocket.close();
            this._bConnected = false;
        } // end if
        this.onClose(true, false, false);
    };
    _loc1.onConnect = function (bSuccess)
    {
        this._bConnecting = false;
        if (!bSuccess)
        {
            if (this.api.datacenter.Basics.aks_rescue_count > 0)
            {
                --this.api.datacenter.Basics.aks_rescue_count;
                ank.utils.Timer.setTimer(this, "connect", this, this.connect, _global.CONFIG.rdelay, [this.api.datacenter.Basics.aks_gameserver_ip, this.api.datacenter.Basics.aks_gameserver_port, false]);
                this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: this.api.lang.getText("TRYING_TO_RECONNECT", [this.api.datacenter.Basics.aks_rescue_count])}, {bAlwaysOnTop: true, bForceLoad: true});
                return;
            }
            else if (this.api.datacenter.Basics.aks_rescue_count == 0)
            {
                this.onClose(false, true);
                return;
            } // end else if
            if (this.api.ui.getUIComponent("Login") && (this.api.datacenter.Basics.aks_connection_server && this.api.datacenter.Basics.aks_connection_server.length))
            {
                var _loc3 = String(this.api.datacenter.Basics.aks_connection_server.shift());
                ank.utils.Timer.setTimer(this, "connect", this, this.connect, _global.CONFIG.rdelay, [_loc3, this.api.datacenter.Basics.aks_connection_server_port, false]);
                return;
            } // end if
            this.api.ui.unloadUIComponent("Waiting");
            this.api.ui.unloadUIComponent("WaitingMessage");
            this.api.ui.unloadUIComponent("ChooseCharacter");
            this.api.kernel.manualLogon();
            this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"), this.api.lang.getText("CANT_CONNECT"), "ERROR_BOX", {name: "OnConnect"});
            this.softDisconnect();
        }
        else
        {
            this.api.ui.unloadUIComponent("Waiting");
            this.api.ui.unloadUIComponent("WaitingMessage");
            if (!this.api.datacenter.Basics.isLogged)
            {
                this.api.ui.loadUIComponent("MainMenu", "MainMenu", {quitMode: System.capabilities.playerType == "PlugIn" ? ("no") : ("quit")}, {bStayIfPresent: true, bAlwaysOnTop: true});
            } // end if
            this._bConnected = true;
        } // end else if
    };
    _loc1.onData = function (sData)
    {
        ank.utils.Timer.removeTimer(this.Lag, "lag");
        if (this._bLag)
        {
            dofus.utils.Api.getInstance().ui.unloadUIComponent("WaitingMessage");
            ank.utils.Timer.removeTimer(this.Deco, "deco");
            this._bLag = false;
        } // end if
        if (dofus.Constants.DEBUG && (dofus.Constants.DEBUG_DATAS && dofus.Constants.DEBUG_ENCRYPTION))
        {
        } // end if
        sData = this.unprepareData(sData);
        if (dofus.Constants.DEBUG && dofus.Constants.DEBUG_DATAS)
        {
        } // end if
        if (this._isWaitingForData)
        {
            this._isWaitingForData = false;
            this.api.ui.unloadUIComponent("Waiting");
            var _loc3 = getTimer() - this._nLastWaitingSend;
            if (_loc3 > 100)
            {
            } // end if
            this._aLastPings.push(_loc3);
            if (this._aLastPings.length > dofus.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS)
            {
                this._aLastPings.shift();
            } // end if
        } // end if
        this._oDataProcessor.process(sData);
    };
    _loc1.onLoad = function (success)
    {
        if (!success)
        {
            this.sendNextDisconnectionState();
        } // end if
    };
    _loc1.sendNextDisconnectionState = function ()
    {
        if (this._aDisconnectionUrl.length <= 0)
        {
            return;
        } // end if
        var _loc2 = this._aDisconnectionUrl.shift() + this._sDisconnectionParams;
        this._oLoader.load(_loc2);
    };
    _loc1.onClose = function (bReconnect, bShowMessage, bManual)
    {
        if (bManual == undefined)
        {
            bManual = false;
        } // end if
        if (!bManual && (this.api.datacenter.Basics.aks_current_server != undefined && (!this.api.datacenter.Basics.aks_server_will_disconnect && this.api.lang.getConfigText("FORWARD_UNWANTED_DISCONNECTION"))))
        {
            this._aDisconnectionUrl = String(this.api.lang.getConfigText("FORWARD_UNWANTED_DISCONNECTION_URL")).split("|");
            this._sDisconnectionParams = new String();
            this._sDisconnectionParams = this._sDisconnectionParams + ("?serverid=" + this.api.datacenter.Basics.aks_current_server);
            this._sDisconnectionParams = this._sDisconnectionParams + ("&serverip=" + this.api.datacenter.Basics.aks_gameserver_ip);
            this._sDisconnectionParams = this._sDisconnectionParams + ("&serverport=" + this.api.datacenter.Basics.aks_gameserver_port);
            this._sDisconnectionParams = this._sDisconnectionParams + ("&login=" + this.api.datacenter.Basics.login);
            this.sendNextDisconnectionState();
        } // end if
        this._bConnecting = false;
        this._bConnected = false;
        if (this.api.datacenter.Basics.aks_current_server != undefined && (this.api.datacenter.Basics.aks_rescue_count == -1 && (!bManual && (this.api.lang.getConfigText("AUTO_RECONNECT") && !this.api.datacenter.Basics.aks_server_will_disconnect))))
        {
            ank.utils.Timer.removeTimer(this.Deco, "deco");
            this.api.datacenter.Basics.aks_rescue_count = _global.CONFIG.rcount;
            ank.utils.Timer.setTimer(this, "connect", this, this.connect, _global.CONFIG.rdelay, [this.api.datacenter.Basics.aks_gameserver_ip, this.api.datacenter.Basics.aks_gameserver_port, false]);
            this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: this.api.lang.getText("TRYING_TO_RECONNECT", [this.api.datacenter.Basics.aks_rescue_count])}, {bAlwaysOnTop: true, bForceLoad: true});
            return;
        } // end if
        if (bReconnect == undefined)
        {
            bReconnect = false;
        } // end if
        if (bShowMessage == undefined)
        {
            bShowMessage = !this.api.datacenter.Basics.aks_server_will_disconnect;
        } // end if
        if (this.api.datacenter.Basics.isLogged)
        {
            this.api.ui.clear();
            this.api.gfx.clear();
            this.api.kernel.TutorialManager.clear();
            ank.utils.Timer.clear();
        }
        else
        {
            this.api.ui.unloadUIComponent("CenterText");
            this.api.ui.unloadUIComponent("ChooseNickName");
        } // end else if
        this.api.sounds.stopAllSounds();
        if (bReconnect)
        {
            this.connect();
        }
        else if (this.api.datacenter.Basics.isLogged)
        {
            this.api.ui.setScreenSize(742, 550);
            this.api.kernel.manualLogon();
            this.api.kernel.ChatManager.clear();
        } // end else if
        if (bShowMessage)
        {
            var _loc5 = this.api.lang.getText("DISCONNECT");
            if (this.api.datacenter.Basics.serverMessageID != -1)
            {
                _loc5 = _loc5 + ("\n\n" + this.api.lang.getText("SRV_MSG_" + this.api.datacenter.Basics.serverMessageID, this.api.datacenter.Basics.serverMessageParams));
                this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"), _loc5, "ERROR_BOX", {name: "OnClose"});
            }
            else if (this.api.lang.getConfigText("SIMPLE_AUTO_RECONNECT"))
            {
                _loc5 = _loc5 + ("\n\n" + this.api.lang.getText("ATTEMPT_RECONNECT"));
                var _loc6 = {name: "OnClose", listener: this, params: {login: this.api.datacenter.Player.login, pass: this.api.datacenter.Player.password}};
                this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"), _loc5, "CAUTION_YESNO", _loc6);
            }
            else
            {
                this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"), _loc5, "ERROR_BOX", {name: "OnClose"});
            } // end else if
        } // end else if
        this.api.datacenter.clear();
    };
    _loc1.onHelloConnectionServer = function (sKey)
    {
        this.api.datacenter.Basics.connexionKey = sKey;
        this.Account.logon(this.api.datacenter.Player.login, this.api.datacenter.Player.password);
        this.api.network.Account.getQueuePosition();
    };
    _loc1.onHelloGameServer = function (sExtraData)
    {
        this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: this.api.lang.getText("CONNECTING")}, {bAlwaysOnTop: true, bForceLoad: true});
        if (this.api.datacenter.Basics.aks_rescue_count == -1)
        {
            this.Account.sendTicket(this.api.datacenter.Basics.aks_ticket);
        }
        else
        {
            this.Account.rescue(this.api.datacenter.Basics.aks_ticket);
        } // end else if
        this.api.datacenter.Basics.aks_rescue_count = -1;
    };
    _loc1.onPong = function ()
    {
        var _loc2 = getTimer() - this.api.datacenter.Basics.lastPingTimer;
        this.api.kernel.showMessage(undefined, "Ping : " + _loc2 + "ms", this.api.ui.getUIComponent("Debug") == undefined ? ("INFO_CHAT") : ("DEBUG_LOG"));
    };
    _loc1.onQuickPong = function ()
    {
    };
    _loc1.onServerMessage = function (sExtraData)
    {
        var _loc3 = sExtraData.charAt(0);
        switch (_loc3)
        {
            case "0":
            {
                var _loc4 = sExtraData.substr(1).split("|");
                var _loc5 = Number(_loc4[0]);
                var _loc6 = _loc4[1].split(";");
                this.api.datacenter.Basics.serverMessageID = _loc5;
                this.api.datacenter.Basics.serverMessageParams = _loc6;
                break;
            } 
            case "1":
            {
                var _loc7 = sExtraData.substr(1).split("|");
                var _loc8 = _loc7[0];
                var _loc9 = _loc7[1].split(";");
                var _loc10 = String(_loc7[2]).length > 0 ? (_loc7[2]) : (undefined);
                switch (Number(_loc8))
                {
                    case 23:
                    {
                        var _loc11 = Number(_loc9[0]);
                        _loc9[0] = this.api.lang.getSpellText(_loc11).n;
                        break;
                    } 
                    case 12:
                    {
                        this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("SRV_MSG_12"), "ERROR_CHAT");
                        this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("SRV_MSG_12") + "\n\n" + this.api.lang.getText("DO_U_RELEASE_NOW"), "CAUTION_YESNO", {name: _loc10, listener: this});
                        return;
                        break;
                    } 
                } // End of switch
                this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("SRV_MSG_" + _loc8, _loc9), "ERROR_BOX", {name: _loc10});
                break;
            } 
        } // End of switch
    };
    _loc1.onBadVersion = function ()
    {
        this.api.kernel.quit(false);
    };
    _loc1.onServerWillDisconnect = function ()
    {
        this.api.datacenter.Basics.aks_server_will_disconnect = true;
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoOnClose":
            {
                this.api.ui.getUIComponent("Login").autoLogin(oEvent.params.login, oEvent.params.pass);
                break;
            } 
            default:
            {
                this.api.network.Game.freeMySoul();
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).EVALUATE_AVERAGE_PING_ON_COMMANDS = 50;
    _loc1._bConnected = false;
    _loc1._bConnecting = false;
    (_global.dofus.aks.Aks = function (oAPI)
    {
        super();
        this.initialize(oAPI);
    }).HEX_CHARS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
} // end if
#endinitclip
