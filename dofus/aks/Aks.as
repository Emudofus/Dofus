// Action script...

// [Initial MovieClip Action of sprite 921]
#initclip 133
class dofus.aks.Aks extends dofus.utils.ApiElement
{
    var Basics, Account, Friends, Chat, Dialog, Exchange, Game, GameActions, Houses, Infos, Items, Job, Key, Spells, Storages, Emotes, Documents, Guild, Waypoints, Areas, Specialization, Fights, Tutorial, _oDataProcessor, _xSocket, aks, api;
    function Aks(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        Basics = new dofus.aks.Basics(this, oAPI);
        Account = new dofus.aks.Account(this, oAPI);
        Friends = new dofus.aks.Friends(this, oAPI);
        Chat = new dofus.aks.Chat(this, oAPI);
        Dialog = new dofus.aks.Dialog(this, oAPI);
        Exchange = new dofus.aks.Exchange(this, oAPI);
        Game = new dofus.aks.Game(this, oAPI);
        GameActions = new dofus.aks.GameActions(this, oAPI);
        Houses = new dofus.aks.Houses(this, oAPI);
        Infos = new dofus.aks.Infos(this, oAPI);
        Items = new dofus.aks.Items(this, oAPI);
        Job = new dofus.aks.Job(this, oAPI);
        Key = new dofus.aks.Key(this, oAPI);
        Spells = new dofus.aks.Spells(this, oAPI);
        Storages = new dofus.aks.Storages(this, oAPI);
        Emotes = new dofus.aks.Emotes(this, oAPI);
        Documents = new dofus.aks.Documents(this, oAPI);
        Guild = new dofus.aks.Guild(this, oAPI);
        Waypoints = new dofus.aks.Waypoints(this, oAPI);
        Areas = new dofus.aks.Areas(this, oAPI);
        Specialization = new dofus.aks.Specialization(this, oAPI);
        Fights = new dofus.aks.Fights(this, oAPI);
        Tutorial = new dofus.aks.Tutorial(this, oAPI);
        _oDataProcessor = new dofus.aks.DataProcessor(this, oAPI);
        _xSocket = new XMLSocket();
        _xSocket.aks = this;
        _xSocket.onClose = function ()
        {
            aks.onClose();
        };
        _xSocket.onConnect = function (bSuccess)
        {
            aks.onConnect(bSuccess);
        };
        _xSocket.onData = function (sData)
        {
            aks._oDataProcessor.process(sData);
        };
    } // End of the function
    function connect(sHost, nPort, bSaveHost)
    {
        if (bSaveHost == undefined)
        {
            bSaveHost = true;
        } // end if
        if (_bConnected)
        {
            return (null);
        } // end if
        if (_bConnecting)
        {
            return (null);
        } // end if
        api.ui.loadUIComponent("Waiting", "Waiting");
        if (sHost == undefined)
        {
            sHost = api.datacenter.Basics.serverHost;
        }
        else if (bSaveHost)
        {
            api.datacenter.Basics.serverHost = sHost;
        } // end else if
        if (nPort == undefined)
        {
            nPort = api.datacenter.Basics.serverPort;
        }
        else if (bSaveHost)
        {
            api.datacenter.Basics.serverPort = nPort;
        } // end else if
        _bConnecting = true;
        return (_xSocket.connect(sHost, nPort));
    } // End of the function
    function softDisconnect()
    {
        _xSocket.close();
        _bConnected = false;
    } // End of the function
    function disconnect(bReconnect, bShowMessage)
    {
        _xSocket.close();
        this.onClose(bReconnect, bShowMessage);
    } // End of the function
    function send(sData, bWaiting, sWaitingMessage)
    {
        if (sData.length > dofus.Constants.MAX_DATA_LENGTH)
        {
            sData = sData.substring(0, dofus.Constants.MAX_DATA_LENGTH - 1);
        } // end if
        if (sData.charCodeAt(sData.length - 1) != 10)
        {
            sData = sData + "\n";
        } // end if
        if (bWaiting || bWaiting == undefined)
        {
            if (sWaitingMessage != undefined)
            {
                api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: sWaitingMessage}, {bAlwaysOnTop: true, bForceLoad: true});
            } // end if
            api.ui.loadUIComponent("Waiting", "Waiting");
        } // end if
        _xSocket.send(sData);
        ank.utils.Logger.log("<< " + sData);
    } // End of the function
    function processCommand(sCmd)
    {
        _oDataProcessor.process(sCmd);
    } // End of the function
    function ping()
    {
        api.datacenter.Basics.lastPingTimer = getTimer();
        this.send("ping");
    } // End of the function
    function onConnect(bSuccess)
    {
        _bConnecting = false;
        if (!bSuccess)
        {
            api.ui.unloadUIComponent("Waiting");
            api.ui.unloadUIComponent("WaitingMessage");
            api.ui.unloadUIComponent("ChooseCharacter");
            api.kernel.manualLogon();
            api.sounds.onError();
            api.kernel.showMessage(api.lang.getText("CONNECTION"), api.lang.getText("CANT_CONNECT"), "ERROR_BOX", {name: "OnConnect"});
        }
        else
        {
            if (!api.datacenter.Basics.isLogged)
            {
                api.ui.loadUIComponent("MainMenu", "MainMenu", {quitMode: System.capabilities.playerType == "PlugIn" ? ("no") : ("quit")}, {bStayIfPresent: true, bAlwaysOnTop: true});
            } // end if
            _bConnected = true;
        } // end else if
    } // End of the function
    function onClose(bReconnect, bShowMessage)
    {
        _bConnecting = false;
        _bConnected = false;
        if (bReconnect == undefined)
        {
            bReconnect = false;
        } // end if
        if (bShowMessage == undefined)
        {
            bShowMessage = true;
        } // end if
        if (api.datacenter.Basics.isLogged)
        {
            api.ui.clear();
            api.gfx.clear();
            api.kernel.MapsServersManager.clearLongRetry();
            api.kernel.TutorialManager.clear();
            ank.utils.Timer.clear();
        }
        else
        {
            api.ui.unloadUIComponent("CenterText");
        } // end else if
        api.sounds.stopAllSound();
        api.sounds.stopMusicFader();
        if (bReconnect)
        {
            this.connect();
        }
        else if (api.datacenter.Basics.isLogged)
        {
            api.ui.setScreenSize(742, 550);
            api.kernel.manualLogon();
            api.kernel.ChatManager.clear();
        } // end else if
        if (bShowMessage)
        {
            var _loc2 = api.lang.getText("DISCONNECT");
            if (api.datacenter.Basics.serverMessageID != -1)
            {
                _loc2 = _loc2 + ("\n\n" + api.lang.getText("SRV_MSG_" + api.datacenter.Basics.serverMessageID));
            } // end if
            api.kernel.showMessage(api.lang.getText("CONNECTION"), _loc2, "ERROR_BOX", {name: "OnClose"});
        } // end if
        api.datacenter.clear();
    } // End of the function
    function onHelloConnectionServer(sKey)
    {
        api.datacenter.Basics.connexionKey = sKey;
        Account.logon(api.datacenter.Player.login, api.datacenter.Player.password);
    } // End of the function
    function onHelloGameServer(sExtraData)
    {
        Account.sendTicket(api.datacenter.Basics.aks_ticket);
    } // End of the function
    function onPong()
    {
        var _loc2 = getTimer() - api.datacenter.Basics.lastPingTimer;
        api.kernel.showMessage(undefined, "Ping : " + _loc2 + "ms", api.ui.getUIComponent("Debug") == undefined ? ("INFO_CHAT") : ("DEBUG_LOG"));
    } // End of the function
    function onServerMessage(sExtraData)
    {
        var _loc4 = sExtraData.charAt(0);
        switch (_loc4)
        {
            case "0":
            {
                api.datacenter.Basics.serverMessageID = Number(sExtraData.substr(1));
                break;
            } 
            case "1":
            {
                var _loc2 = sExtraData.substr(1).split("|");
                var _loc6 = _loc2[0];
                var _loc3 = _loc2[1].split(";");
                api.kernel.showMessage(api.lang.getText("INFORMATIONS"), api.lang.getText("SRV_MSG_" + _loc6, _loc3), "ERROR_BOX");
                break;
            } 
        } // End of switch
    } // End of the function
    function onBadVersion()
    {
    } // End of the function
    var _bConnected = false;
    var _bConnecting = false;
} // End of Class
#endinitclip
