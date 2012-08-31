// Action script...

// [Initial MovieClip Action of sprite 994]
#initclip 211
class dofus.graphics.gapi.ui.Login extends ank.gapi.core.UIAdvancedComponent
{
    var _sLanguage, __get__language, addToQueue, _xAlert, api, _mcPlacer, attachMovie, _lstServers, _xServers, _btnShowLastAlert, _btnFrench, _btnEnglish, _btnDownload, _btnSubscribe, _btnForget, _btnOK, _btnCopyrights, _lblShowLastAlert, _lblAccount, _lblPassword, _lblCopyright, _tiAccount, _tiPassword, gapi, _mcCaution, _sAlertID, _sServerIP, _nServerPort, _sServerName, getURL, __set__language;
    function Login()
    {
        super();
    } // End of the function
    function set language(sLanguage)
    {
        _sLanguage = sLanguage;
        //return (this.language());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Login.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: initInput});
        this.addToQueue({object: this, method: initLanguagesButtons});
        this.showLastAlertButton(false);
        _xAlert = new XML();
        _xAlert.ignoreWhite = true;
        var _owner = this;
        _xAlert.onLoad = function (bSuccess)
        {
            _owner.onAlertLoad(bSuccess);
        };
        _xAlert.load(api.config.playHostLink + dofus.Constants.HTTP_ALERT_PATH + _sLanguage + "_" + dofus.Constants.HTTP_ALERT_FILE);
        _mcPlacer._visible = false;
        if (dofus.Constants.DEBUG)
        {
            this.attachMovie("List", "_lstServers", 10, {_x: _mcPlacer._x + 1, _y: _mcPlacer._y + 1, _height: _mcPlacer._height - 2, _width: _mcPlacer._width - 2, styleName: "ServersList"});
            _lstServers.addEventListener("itemSelected", this);
            _xServers = new XML();
            _xServers.ignoreWhite = true;
            _xServers.onLoad = function (bSuccess)
            {
                _owner.onServersListLoad(bSuccess);
            };
            _xServers.load(api.config.playHostLink + dofus.Constants.HTTP_SERVERS_LIST_FILE);
        } // end if
    } // End of the function
    function addListeners()
    {
        _btnShowLastAlert.addEventListener("click", this);
        _btnFrench.addEventListener("click", this);
        _btnEnglish.addEventListener("click", this);
        _btnDownload.addEventListener("click", this);
        _btnSubscribe.addEventListener("click", this);
        _btnForget.addEventListener("click", this);
        _btnOK.addEventListener("click", this);
        _btnCopyrights.addEventListener("click", this);
        Key.addListener(this);
    } // End of the function
    function initTexts()
    {
        _lblShowLastAlert.__set__text(api.lang.getText("SERVER_ALERT"));
        _lblAccount.__set__text(api.lang.getText("LOGIN_ACCOUNT"));
        _lblPassword.__set__text(api.lang.getText("LOGIN_PASSWORD"));
        _lblCopyright.__set__text(api.lang.getText("COPYRIGHT"));
        _btnForget.__set__label(api.lang.getText("LOGIN_FORGET"));
        _btnSubscribe.__set__label(api.lang.getText("LOGIN_SUBSCRIBE"));
        _btnDownload.__set__label(api.lang.getText("LOGIN_DOWNLOAD"));
    } // End of the function
    function initInput()
    {
        _tiAccount.__set__tabIndex(1);
        _tiPassword.__set__tabIndex(2);
        _btnOK.tabIndex = 3;
        _tiPassword.__set__password(true);
        _tiAccount.setFocus();
    } // End of the function
    function initLanguagesButtons()
    {
        switch (_sLanguage)
        {
            case "fr":
            {
                _btnFrench.__set__enabled(false);
                _btnFrench.__set__selected(true);
                _btnEnglish.__set__enabled(true);
                _btnEnglish.__set__selected(false);
                break;
            } 
            case "en":
            {
                _btnFrench.__set__enabled(true);
                _btnFrench.__set__selected(false);
                _btnEnglish.__set__enabled(false);
                _btnEnglish.__set__selected(true);
                break;
            } 
            default:
            {
                _btnFrench.__set__enabled(true);
                _btnEnglish.__set__enabled(true);
            } 
        } // End of switch
    } // End of the function
    function showAlert(xNode)
    {
        var _loc3;
        while (xNode != undefined)
        {
            _loc3 = _loc3 + xNode.toString();
            xNode = xNode.nextSibling;
        } // end while
        var _loc4 = gapi.loadUIComponent("AskAlertServer", "AskAlertServer", {title: api.lang.getText("SERVER_ALERT"), text: _loc3, hideNext: _bHideNext});
        _loc4.addEventListener("close", this);
    } // End of the function
    function showLastAlertButton(bShow)
    {
        _btnShowLastAlert._visible = bShow;
        _lblShowLastAlert._visible = bShow;
        _mcCaution._visible = bShow;
    } // End of the function
    function switchLanguage(sLanguage)
    {
        api.config.language = sLanguage;
        api.kernel.clearCache();
    } // End of the function
    function onKeyDown()
    {
        if (Key.getCode() == 13 && Selection.getFocus() != undefined)
        {
            this.onLogin(_tiAccount.__get__text(), _tiPassword.__get__text());
        } // end if
    } // End of the function
    function onAlertLoad(bSuccess)
    {
        if (bSuccess)
        {
            _sAlertID = _xAlert.firstChild.attributes.id;
            _bHideNext = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.lastAlertID == _sAlertID;
            if (!_bHideNext)
            {
                this.addToQueue({object: this, method: showAlert, params: [_xAlert.firstChild.firstChild]});
            } // end if
            this.showLastAlertButton(true);
        } // end if
    } // End of the function
    function onServersListLoad(bSuccess)
    {
        if (bSuccess)
        {
            var _loc10 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.lastServerName;
            var _loc9 = new ank.utils.ExtendedArray();
            var _loc11 = _xServers.firstChild;
            var _loc6 = 0;
            var _loc5;
            var _loc3 = _loc11.firstChild;
            while (_loc3 != undefined)
            {
                var _loc4 = new Object();
                _loc4.ip = _loc3.attributes.ip;
                _loc4.port = _loc3.attributes.port;
                _loc4.name = _loc3.attributes.name;
                if (_loc10 == _loc3.attributes.name)
                {
                    _sServerIP = _loc3.attributes.ip;
                    _nServerPort = _loc3.attributes.port;
                    _sServerName = _loc3.attributes.name;
                    _loc5 = _loc6;
                }
                else if (String(_loc3.attributes.def).indexOf("true") != -1 && _loc5 == undefined)
                {
                    _sServerIP = _loc3.attributes.ip;
                    _nServerPort = _loc3.attributes.port;
                    _sServerName = _loc3.attributes.name;
                    _loc5 = _loc6;
                } // end else if
                _loc9.push({label: _loc4.name, data: _loc4});
                _loc3 = _loc3.nextSibling;
                ++_loc6;
            } // end while
            _lstServers.__set__dataProvider(_loc9);
            if (_loc5 != undefined)
            {
                _lstServers.__set__selectedIndex(_loc5);
            } // end if
        } // end if
    } // End of the function
    function itemSelected(oEvent)
    {
        var _loc2 = oEvent.target.item.data;
        _sServerIP = _loc2.ip;
        _nServerPort = _loc2.port;
        _sServerName = _loc2.name;
    } // End of the function
    function onLogin(sLogin, sPassword)
    {
        _tiPassword.__set__text("");
        if (sLogin == undefined)
        {
            return;
        } // end if
        if (sPassword == undefined)
        {
            return;
        } // end if
        if (sLogin.length == 0)
        {
            return;
        } // end if
        if (sPassword.length == 0)
        {
            return;
        } // end if
        api.datacenter.Player.login = sLogin;
        api.datacenter.Player.password = sPassword;
        if (_sServerIP == undefined)
        {
            _sServerIP = api.lang.getConfigText("SERVER_NAME");
        } // end if
        if (_nServerPort == undefined)
        {
            _nServerPort = api.lang.getConfigText("SERVER_PORT");
        } // end if
        _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.lastServerName = _sServerName;
        if (_sServerIP == undefined || _nServerPort == undefined)
        {
            var _loc3 = api.lang.getText("NO_SERVER_ADDRESS");
            api.kernel.showMessage(api.lang.getText("CONNECTION"), _loc3 == undefined ? ("Erreur interne\nContacte l\'équipe Dofus") : (_loc3), "ERROR_BOX", {name: "OnLogin"});
        }
        else
        {
            api.network.connect(_sServerIP, _nServerPort);
            api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: api.lang.getText("CONNECTING")}, {bAlwaysOnTop: true, bForceLoad: true});
        } // end else if
    } // End of the function
    function close(oEvent)
    {
        _bHideNext = oEvent.hideNext;
        SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.lastAlertID = oEvent.hideNext ? (_sAlertID) : (undefined);
    } // End of the function
    null[] = oEvent.target._name === "_btnForget" ? (// Jump to 679, function (oEvent)
    {
        if (oEvent.target._name !== "_btnShowLastAlert")
        {
        }
        else
        {
        } // end else if
    }) : (// Jump to 679, this.showAlert(_xAlert.firstChild.firstChild), // Jump to 679, this.switchLanguage("fr"), // Jump to 679, this.switchLanguage("en"), // Jump to 679, // Jump to 679, // Jump to 679, this.onLogin(_tiAccount.__get__text(), _tiPassword.__get__text()), // Jump to 679, "click");
    static var CLASS_NAME = "Login";
    var _bHideNext = false;
} // End of Class
#endinitclip
