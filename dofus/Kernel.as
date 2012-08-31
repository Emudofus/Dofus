// Action script...

// [Initial MovieClip Action of sprite 830]
#initclip 42
class dofus.Kernel extends dofus.utils.ApiElement
{
    var CharactersManager, ChatManager, MapsServersManager, DocumentsServersManager, TutorialServersManager, GameManager, KeyManager, NightManager, AreasManager, TutorialManager, Console, DebugConsole, OptionsManager, api, addToQueue, __get__api;
    function Kernel(oAPI)
    {
        super();
        this.initialize(oAPI);
        CharactersManager = new dofus.managers.CharactersManager(oAPI);
        ChatManager = new dofus.managers.ChatManager(oAPI);
        MapsServersManager = new dofus.managers.MapsServersManager();
        DocumentsServersManager = new dofus.managers.DocumentsServersManager();
        TutorialServersManager = new dofus.managers.TutorialServersManager();
        GameManager = new dofus.managers.GameManager(oAPI);
        KeyManager = new dofus.managers.KeyManager(oAPI);
        NightManager = new dofus.managers.NightManager();
        AreasManager = new dofus.managers.AreasManager();
        TutorialManager = new dofus.managers.TutorialManager(oAPI);
        Console = new dofus.utils.ChatConsoleParser(oAPI);
        DebugConsole = new dofus.utils.DebugConsoleParser(oAPI);
        OptionsManager = new dofus.managers.OptionsManager(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
    } // End of the function
    function start()
    {
        api.ui.setScreenSize(742, 556);
        if (OptionsManager.getOption("DisplayStyle") == "medium" && System.capabilities.screenResolutionY < 950)
        {
            OptionsManager.setOption("DisplayStyle", "normal");
        }
        else
        {
            this.setDisplayStyle(OptionsManager.getOption("DisplayStyle"));
        } // end else if
        this.manualLogon();
    } // End of the function
    function quit(bAsk)
    {
        if (bAsk == undefined)
        {
            bAsk = true;
        } // end if
        if (!bAsk)
        {
            if (System.capabilities.playerType == "StandAlone")
            {
                fscommand("quit");
            }
            else
            {
                _level0.closeBrowserWindow();
            } // end else if
        }
        else
        {
            this.showMessage(undefined, api.lang.getText("DO_U_QUIT"), "CAUTION_YESNO", {name: "Quit"});
        } // end else if
    } // End of the function
    function disconnect()
    {
        this.showMessage(undefined, api.lang.getText("DO_U_DISCONNECT"), "CAUTION_YESNO", {name: "Disconnect"});
    } // End of the function
    function reboot()
    {
        api.network.disconnect(false, false);
        this.addToQueue({object: _level0, method: _level0.reboot});
    } // End of the function
    function setDisplayStyle(sStyle)
    {
        _level0.setDisplayStyle(sStyle);
    } // End of the function
    function changeCharacter()
    {
        this.showMessage(undefined, api.lang.getText("DO_U_QUIT"), "CAUTION_YESNO", {name: "ChangeCharacter"});
    } // End of the function
    function showMessage(sTitle, sMsg, sType, oParams)
    {
        switch (sType)
        {
            case "CAUTION_YESNO":
            {
                if (sTitle == undefined)
                {
                    sTitle = api.lang.getText("CAUTION");
                } // end if
                var _loc5 = api.ui.loadUIComponent("AskYesNo", "AskYesNo" + (oParams.name != undefined ? (oParams.name) : ("")), {title: sTitle, text: sMsg, params: oParams.params}, {bForceLoad: true});
                _loc5.addEventListener("yes", oParams.listener == undefined ? (this) : (oParams.listener));
                _loc5.addEventListener("no", oParams.listener == undefined ? (this) : (oParams.listener));
                break;
            } 
            case "ERROR_BOX":
            {
                if (sTitle == undefined)
                {
                    sTitle = api.lang.getText("ERROR_WORD");
                } // end if
                api.ui.loadUIComponent("AskOK", "AskOK" + (oParams.name != undefined ? (oParams.name) : ("")), {title: sTitle, text: sMsg, params: oParams.params}, {bForceLoad: true});
                break;
            } 
            case "INFO_CANCEL":
            {
                if (sTitle == undefined)
                {
                    sTitle = api.lang.getText("INFORMATION");
                } // end if
                _loc5 = api.ui.loadUIComponent("AskCancel", "AskCancel" + (oParams.name != undefined ? (oParams.name) : ("")), {title: sTitle, text: sMsg, params: oParams.params}, {bForceLoad: true});
                _loc5.addEventListener("cancel", oParams.listener == undefined ? (this) : (oParams.listener));
                break;
            } 
            case "ERROR_CHAT":
            {
                ChatManager.addText(sTitle == undefined ? (sMsg) : ("<b>" + sTitle + "</b> : " + sMsg), dofus.Constants.ERROR_CHAT_COLOR);
                break;
            } 
            case "MESSAGE_CHAT":
            {
                ChatManager.addText(sMsg, dofus.Constants.MSG_CHAT_COLOR);
                break;
            } 
            case "INFO_FIGHT_CHAT":
            {
                if (!api.kernel.OptionsManager.getOption("ChatEffects"))
                {
                    return;
                } // end if
            } 
            case "INFO_CHAT":
            {
                ChatManager.addText(sMsg, dofus.Constants.INFO_CHAT_COLOR);
                break;
            } 
            case "WHISP_CHAT":
            {
                ChatManager.addText(sMsg, dofus.Constants.MSGCHUCHOTE_CHAT_COLOR);
                break;
            } 
            case "GUILD_CHAT":
            {
                ChatManager.addText(sMsg, dofus.Constants.GUILD_CHAT_COLOR, false);
                break;
            } 
            case "GUILD_CHAT_SOUND":
            {
                ChatManager.addText(sMsg, dofus.Constants.GUILD_CHAT_COLOR, true);
                break;
            } 
            case "DEBUG_LOG":
            {
                api.datacenter.Basics.aks_a_logs = api.datacenter.Basics.aks_a_logs + ("<br><font color=\"#FFFFFF\">" + sMsg + "</font>");
                api.ui.getUIComponent("Debug").setLogsText(api.datacenter.Basics.aks_a_logs);
                break;
            } 
            case "DEBUG_ERROR":
            {
                api.datacenter.Basics.aks_a_logs = api.datacenter.Basics.aks_a_logs + ("<br><font color=\"#FF0000\">" + sMsg + "</font>");
                api.ui.getUIComponent("Debug").setLogsText(api.datacenter.Basics.aks_a_logs);
                break;
            } 
            case "DEBUG_INFO":
            {
                api.datacenter.Basics.aks_a_logs = api.datacenter.Basics.aks_a_logs + ("<br><font color=\"#00FF00\">" + sMsg + "</font>");
                api.ui.getUIComponent("Debug").setLogsText(api.datacenter.Basics.aks_a_logs);
                break;
            } 
        } // End of switch
    } // End of the function
    function manualLogon()
    {
        api.ui.loadUIComponent("MainMenu", "MainMenu", {quitMode: System.capabilities.playerType == "PlugIn" ? ("no") : ("quit")}, {bStayIfPresent: true, bAlwaysOnTop: true});
        this.addToQueue({object: api.ui, method: api.ui.loadUIComponent, params: ["Login", "Login", {language: api.config.language}, {bStayIfPresent: true}]});
        _level0.clearlog();
    } // End of the function
    function askClearCache()
    {
        this.showMessage(undefined, api.lang.getText("DO_U_CLEAR_CACHE"), "CAUTION_YESNO", {name: "ClearCache"});
    } // End of the function
    function clearCache()
    {
        _level0.clearLangSharedObjects();
        this.reboot();
    } // End of the function
    function yes(oEvent)
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
                api.network.disconnect(false, false);
                break;
            } 
            case "AskYesNoChangeCharacter":
            {
                api.network.disconnect(true, false);
                break;
            } 
            case "AskYesNoClearCache":
            {
                this.clearCache();
                break;
            } 
        } // End of switch
    } // End of the function
    function onInitAndLoginFinished()
    {
        MapsServersManager.initialize(this.__get__api());
        DocumentsServersManager.initialize(this.__get__api());
        TutorialServersManager.initialize(this.__get__api());
        AreasManager.initialize(this.__get__api());
        var _loc2 = api.lang.getTimeZoneText();
        NightManager.initialize(_loc2.tz, _loc2.m, _loc2.z, api.gfx);
        api.network.Account.getCharacters();
    } // End of the function
} // End of Class
#endinitclip
