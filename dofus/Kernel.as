// Action script...

// [Initial MovieClip Action of sprite 20773]
#initclip 38
if (!dofus.Kernel)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    var _loc1 = (_global.dofus.Kernel = function (oAPI)
    {
        super();
        this.initialize(oAPI);
        if (this.AudioManager == null)
        {
            dofus.sounds.AudioManager.initialize(_root.createEmptyMovieClip("SoundNest", 99999), oAPI);
            this.AudioManager = dofus.sounds.AudioManager.getInstance();
        } // end if
        if ((this.CharactersManager = dofus.managers.CharactersManager.getInstance()) == null)
        {
            this.CharactersManager = new dofus.managers.CharactersManager(oAPI);
        } // end if
        if ((this.ChatManager = dofus.managers.ChatManager.getInstance()) == null)
        {
            this.ChatManager = new dofus.managers.ChatManager(oAPI);
        } // end if
        if ((this.MapsServersManager = dofus.managers.MapsServersManager.getInstance()) == null)
        {
            this.MapsServersManager = new dofus.managers.MapsServersManager();
        } // end if
        if ((this.DocumentsServersManager = dofus.managers.DocumentsServersManager.getInstance()) == null)
        {
            this.DocumentsServersManager = new dofus.managers.DocumentsServersManager();
        } // end if
        if ((this.TutorialServersManager = dofus.managers.TutorialServersManager.getInstance()) == null)
        {
            this.TutorialServersManager = new dofus.managers.TutorialServersManager();
        } // end if
        if ((this.GameManager = dofus.managers.GameManager.getInstance()) == null)
        {
            this.GameManager = new dofus.managers.GameManager(oAPI);
        } // end if
        if ((this.KeyManager = dofus.managers.KeyManager.getInstance()) == null)
        {
            this.KeyManager = new dofus.managers.KeyManager(oAPI);
        } // end if
        if ((this.NightManager = dofus.managers.NightManager.getInstance()) == null)
        {
            this.NightManager = new dofus.managers.NightManager(oAPI);
        } // end if
        if ((this.AreasManager = dofus.managers.AreasManager.getInstance()) == null)
        {
            this.AreasManager = new dofus.managers.AreasManager();
        } // end if
        if ((this.TutorialManager = dofus.managers.TutorialManager.getInstance()) == null)
        {
            this.TutorialManager = new dofus.managers.TutorialManager(oAPI);
        } // end if
        this.Console = new dofus.utils.consoleParsers.ChatConsoleParser(oAPI);
        this.DebugConsole = new dofus.utils.consoleParsers.DebugConsoleParser(oAPI);
        if ((this.OptionsManager = dofus.managers.OptionsManager.getInstance()) == null)
        {
            this.OptionsManager = new dofus.managers.OptionsManager(oAPI);
        } // end if
        if ((this.AdminManager = dofus.managers.AdminManager.getInstance()) == null)
        {
            this.AdminManager = new dofus.managers.AdminManager(oAPI);
        } // end if
        if ((this.DebugManager = dofus.managers.DebugManager.getInstance()) == null)
        {
            this.DebugManager = new dofus.managers.DebugManager(oAPI);
        } // end if
        if ((this.TipsManager = dofus.managers.TipsManager.getInstance()) == null)
        {
            this.TipsManager = new dofus.managers.TipsManager(oAPI);
        } // end if
        if ((this.SpellsBoostsManager = dofus.managers.SpellsBoostsManager.getInstance()) == null)
        {
            this.SpellsBoostsManager = new dofus.managers.SpellsBoostsManager(oAPI);
        } // end if
        if ((this.SpeakingItemsManager = dofus.managers.SpeakingItemsManager.getInstance()) == null)
        {
            this.SpeakingItemsManager = new dofus.managers.SpeakingItemsManager(oAPI);
        } // end if
        if ((this.StreamingDisplayManager = dofus.managers.StreamingDisplayManager.getInstance()) == null)
        {
            this.StreamingDisplayManager = new dofus.managers.StreamingDisplayManager(oAPI);
        } // end if
        dofus.managers.UIdManager.getInstance().update();
        this._sendScreenInfoTimer = _global.setInterval(this, "sendScreenInfo", 1000);
    }).prototype;
    _loc1.sendScreenInfo = function ()
    {
        if (!this.api.datacenter.Basics.inGame || (this.api.datacenter.Game.isFight || this.api.datacenter.Game.isRunning))
        {
            return;
        } // end if
        _global.clearInterval(this._sendScreenInfoTimer);
        this.OptionsManager.setOption("sendResolution", true);
        this.api.network.Infos.sendScreenInfo();
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
    };
    _loc1.start = function ()
    {
        this.api.ui.setScreenSize(742, 556);
        if (this.OptionsManager.getOption("DisplayStyle") == "medium" && (System.capabilities.screenResolutionY < 950 && System.capabilities.playerType != "StandAlone"))
        {
            this.OptionsManager.setOption("DisplayStyle", "normal");
        }
        else
        {
            this.setDisplayStyle(this.OptionsManager.getOption("DisplayStyle"), true);
        } // end else if
        if (this.api.config.isStreaming)
        {
            if (this.api.config.streamingMethod == "explod")
            {
                this.api.gfx.setStreaming(true, dofus.Constants.GFX_OBJECTS_PATH, dofus.Constants.GFX_GROUNDS_PATH);
            } // end if
            this.api.gfx.setStreamingMethod(this.api.config.streamingMethod);
        } // end if
        this.setQuality(this.OptionsManager.getOption("DefaultQuality"));
        this.manualLogon();
    };
    _loc1.quit = function (bAsk)
    {
        if (bAsk == undefined)
        {
            bAsk = true;
        } // end if
        if (!bAsk)
        {
            if (System.capabilities.playerType == "StandAlone")
            {
                getURL("FSCommand:" add "quit", "");
            }
            else
            {
                _level0._loader.closeBrowserWindow();
            } // end else if
        }
        else
        {
            this.showMessage(undefined, this.api.lang.getText("DO_U_QUIT"), "CAUTION_YESNO", {name: "Quit"});
        } // end else if
    };
    _loc1.disconnect = function ()
    {
        this.showMessage(undefined, this.api.lang.getText("DO_U_DISCONNECT"), "CAUTION_YESNO", {name: "Disconnect"});
    };
    _loc1.reboot = function ()
    {
        this.api.network.disconnect(false, false);
        this.addToQueue({object: _level0._loader, method: _level0._loader.reboot});
    };
    _loc1.setQuality = function (quality)
    {
        _root._quality = quality;
    };
    _loc1.setDisplayStyle = function (sStyle, bDontShowError)
    {
        if (System.capabilities.playerType == "StandAlone" && System.capabilities.os.indexOf("Windows") != -1)
        {
            var _loc4 = new ank.external.display.ScreenResolution();
            switch (sStyle)
            {
                case "normal":
                {
                    _loc4.disable();
                    break;
                } 
                case "medium":
                {
                    _loc4.addEventListener("onScreenResolutionError", this);
                    _loc4.addEventListener("onScreenResolutionSuccess", this);
                    if (bDontShowError != true)
                    {
                        _loc4.addEventListener("onExternalError", this);
                    } // end if
                    _loc4.enable(800, 600, 32);
                    break;
                } 
                case "maximized":
                {
                    _loc4.addEventListener("onScreenResolutionError", this);
                    _loc4.addEventListener("onScreenResolutionSuccess", this);
                    if (bDontShowError != true)
                    {
                        _loc4.addEventListener("onExternalError", this);
                    } // end if
                    _loc4.enable(1024, 768, 32);
                    break;
                } 
            } // End of switch
        }
        else
        {
            _level0._loader.setDisplayStyle(sStyle);
        } // end else if
    };
    _loc1.changeServer = function (bNotConfirm)
    {
        if (bNotConfirm == true)
        {
            this.api.network.disconnect(true, false, true);
        }
        else
        {
            this.showMessage(undefined, this.api.lang.getText("DO_U_SWITCH_CHARACTER"), "CAUTION_YESNO", {name: "ChangeCharacter"});
        } // end else if
    };
    _loc1.showMessage = function (sTitle, sMsg, sType, oParams, sUniqId)
    {
        switch (sType)
        {
            case "CAUTION_YESNO":
            {
                if (sTitle == undefined)
                {
                    sTitle = this.api.lang.getText("CAUTION");
                } // end if
                var _loc7 = this.api.ui.loadUIComponent("AskYesNo", "AskYesNo" + (oParams.name != undefined ? (oParams.name) : ("")), {title: sTitle, text: sMsg, params: oParams.params}, {bForceLoad: true});
                _loc7.addEventListener("yes", oParams.listener == undefined ? (this) : (oParams.listener));
                _loc7.addEventListener("no", oParams.listener == undefined ? (this) : (oParams.listener));
                break;
            } 
            case "CAUTION_YESNOIGNORE":
            {
                if (sTitle == undefined)
                {
                    sTitle = this.api.lang.getText("CAUTION");
                } // end if
                var _loc8 = this.api.ui.loadUIComponent("AskYesNoIgnore", "AskYesNoIgnore" + (oParams.name != undefined ? (oParams.name) : ("")), {title: sTitle, text: sMsg, player: oParams.player, params: oParams.params}, {bForceLoad: true});
                _loc8.addEventListener("yes", oParams.listener == undefined ? (this) : (oParams.listener));
                _loc8.addEventListener("no", oParams.listener == undefined ? (this) : (oParams.listener));
                _loc8.addEventListener("ignore", oParams.listener == undefined ? (this) : (oParams.listener));
                break;
            } 
            case "ERROR_BOX":
            {
                if (sTitle == undefined)
                {
                    sTitle = this.api.lang.getText("ERROR_WORD");
                } // end if
                this.api.ui.loadUIComponent("AskOK", "AskOK" + (oParams.name != undefined ? (oParams.name) : ("")), {title: sTitle, text: sMsg, params: oParams.params}, {bForceLoad: true});
                break;
            } 
            case "INFO_CANCEL":
            {
                if (sTitle == undefined)
                {
                    sTitle = this.api.lang.getText("INFORMATION");
                } // end if
                var _loc9 = this.api.ui.loadUIComponent("AskCancel", "AskCancel" + (oParams.name != undefined ? (oParams.name) : ("")), {title: sTitle, text: sMsg, params: oParams.params}, {bForceLoad: true});
                _loc9.addEventListener("cancel", oParams.listener == undefined ? (this) : (oParams.listener));
                break;
            } 
            case "ERROR_CHAT":
            {
                this.ChatManager.addText(sTitle == undefined ? (sMsg) : ("<b>" + sTitle + "</b> : " + sMsg), dofus.Constants.ERROR_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "MESSAGE_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.MSG_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "EMOTE_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.EMOTE_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "THINK_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.THINK_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "INFO_FIGHT_CHAT":
            {
                if (!this.api.kernel.OptionsManager.getOption("ChatEffects"))
                {
                    return;
                } // end if
            } 
            case "INFO_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.INFO_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "PVP_CHAT":
            {
                sMsg = this.api.kernel.ChatManager.parseInlinePos(sMsg);
                this.ChatManager.addText(sMsg, dofus.Constants.PVP_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "WHISP_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.MSGCHUCHOTE_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "PARTY_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.GROUP_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "GUILD_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.GUILD_CHAT_COLOR, false, sUniqId);
                break;
            } 
            case "GUILD_CHAT_SOUND":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.GUILD_CHAT_COLOR, true, sUniqId);
                break;
            } 
            case "RECRUITMENT_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.RECRUITMENT_CHAT_COLOR, false, sUniqId);
                break;
            } 
            case "TRADE_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.TRADE_CHAT_COLOR, false, sUniqId);
                break;
            } 
            case "MEETIC_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.MEETIC_CHAT_COLOR, false, sUniqId);
                break;
            } 
            case "ADMIN_CHAT":
            {
                this.ChatManager.addText(sMsg, dofus.Constants.ADMIN_CHAT_COLOR, false, sUniqId);
                break;
            } 
            case "DEBUG_LOG":
            {
                this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#FFFFFF\">" + sMsg + "</font>");
                this.api.ui.getUIComponent("Debug").setLogsText(this.api.datacenter.Basics.aks_a_logs);
                break;
            } 
            case "DEBUG_ERROR":
            {
                this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#FF0000\">" + sMsg + "</font>");
                this.api.ui.getUIComponent("Debug").refresh();
                break;
            } 
            case "DEBUG_INFO":
            {
                this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#00FF00\">" + sMsg + "</font>");
                this.api.ui.getUIComponent("Debug").refresh();
                break;
            } 
        } // End of switch
    };
    _loc1.manualLogon = function ()
    {
        this.api.ui.loadUIComponent("MainMenu", "MainMenu", {quitMode: System.capabilities.playerType == "PlugIn" ? ("no") : ("quit")}, {bStayIfPresent: true, bAlwaysOnTop: true});
        this.addToQueue({object: this.api.ui, method: this.api.ui.loadUIComponent, params: ["Login", "Login", {language: this.api.config.language}, {bStayIfPresent: true}]});
        this.addToQueue({object: _level0._loader, method: _level0._loader.onCoreDisplayed});
    };
    _loc1.askClearCache = function ()
    {
        this.showMessage(undefined, this.api.lang.getText("DO_U_CLEAR_CACHE"), "CAUTION_YESNO", {name: "ClearCache"});
    };
    _loc1.clearCache = function ()
    {
        _level0._loader.clearCache();
        this.reboot();
    };
    _loc1.findMovieClipPath = function ()
    {
        if (this.api.ui.getUIComponent("Dragger") != undefined)
        {
            this.api.ui.unloadUIComponent("Dragger");
        }
        else
        {
            var _loc2 = this.api.ui.loadUIComponent("Dragger", "Dragger", undefined, {bForceLoad: true, bAlwaysOnTop: true});
            _loc2.api = this.api;
            _loc2.onRelease = function ()
            {
                this.stopDrag();
                this.api.network.Basics.onAuthorizedCommand(true, "2" + new ank.utils.ExtendedString(this._dropTarget).replace("/", "."));
                this.startDrag(true);
            };
            _loc2.startDrag(true);
        } // end else if
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoQuit":
            {
                this.quit(false);
                break;
            } 
            case "AskYesNoDisconnect":
            {
                this.api.network.disconnect(false, false);
                break;
            } 
            case "AskYesNoChangeCharacter":
            {
                this.api.network.disconnect(true, false, true);
                break;
            } 
            case "AskYesNoClearCache":
            {
                this.clearCache();
                break;
            } 
        } // End of switch
    };
    _loc1.onInitAndLoginFinished = function ()
    {
        this.MapsServersManager.initialize(this.api);
        this.DocumentsServersManager.initialize(this.api);
        this.TutorialServersManager.initialize(this.api);
        this.AreasManager.initialize(this.api);
        this.AdminManager.initialize(this.api);
        var _loc2 = this.api.lang.getTimeZoneText();
        this.NightManager.initialize(_loc2.tz, _loc2.m, _loc2.z, this.api.gfx);
        this.XTRA_LANG_FILES_LOADED = true;
        this.api.network.Account.getServersList();
    };
    _loc1.onScreenResolutionError = function (oEvent)
    {
        var _loc3 = (ank.external.display.ScreenResolution)(oEvent.target);
        _loc3.removeListeners();
    };
    _loc1.onScreenResolutionSuccess = function (oEvent)
    {
        var _loc3 = (ank.external.display.ScreenResolution)(oEvent.target);
        _loc3.removeListeners();
    };
    _loc1.onExternalError = function (oEvent)
    {
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1.XTRA_LANG_FILES_LOADED = false;
} // end if
#endinitclip
