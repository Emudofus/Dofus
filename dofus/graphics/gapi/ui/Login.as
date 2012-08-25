// Action script...

// [Initial MovieClip Action of sprite 20774]
#initclip 39
if (!dofus.graphics.gapi.ui.Login)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.Login = function ()
    {
        super();
        this._mcGoToStatus._visible = false;
        this._lblGoToStatus._visible = false;
        this._mcNoGiftsBanner._visible = false;
        this.fillCommunityID();
    }).prototype;
    _loc1.__set__language = function (sLanguage)
    {
        this._sLanguage = sLanguage;
        //return (this.language());
    };
    _loc1.autoLogin = function (sLogin, sPass)
    {
        if (sLogin != undefined && (sPass != undefined && (sLogin != null && (sPass != null && (sLogin != "null" && (sPass != "null" && (sLogin != "" && sPass != "")))))))
        {
            this._tiAccount.text = sLogin;
            this._tiPassword.text = sPass;
            if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
            {
                this.getURL("JavaScript:WriteLog(\'AutoLogin;" + sLogin + "/" + sPass + "\')");
            } // end if
            delete _root.htmlLogin;
            delete _root.htmlPassword;
            this.click({target: this._btnOK});
        } // end if
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Login.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.api.datacenter.Basics.inGame = false;
        this._cbPorts._visible = false;
        this._lblRememberMe._visible = false;
        this._btnRememberMe._visible = false;
        this._mcAdvancedBackground._visible = false;
        this._btnTestServer._visible = dofus.Constants.TEST;
        if (!dofus.Constants.TEST && !dofus.Constants.ALPHA)
        {
            this._lblTestServer._visible = false;
            this._lblTestServerInfo._visible = false;
            this._mcBackgroundHidder._visible = false;
        } // end if
        this._mcBanner.gotoAndStop(random(5) + 1);
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initInput});
        this.addToQueue({object: this, method: this.loadFlags});
        this.addToQueue({object: this, method: this.initLanguages});
        this.addToQueue({object: this, method: this.constructPortsList});
        this.addToQueue({object: this, method: this.initSavedAccount});
        this.hideServerStatus();
        this._siServerStatus = new dofus.datacenter.ServerInformations();
        this._siServerStatus.addEventListener("onData", this);
        this._siServerStatus.addEventListener("onLoadError", this);
        this._siServerStatus.load();
        this.showLastAlertButton(false);
        this._xAlert = new XML();
        this._xAlert.ignoreWhite = true;
        var _owner = this;
        this._xAlert.onLoad = function (bSuccess)
        {
            _owner.onAlertLoad(bSuccess);
        };
        this._xAlert.load(this.api.lang.getConfigText("ALERTY_LINK"));
        this._mcServersStateHighlight._visible = false;
        this._mcServersStateHighlight.gotoAndStop(1);
        this._mcEvolutionsHighlight._visible = false;
        this._mcEvolutionsHighlight.gotoAndStop(1);
        this.addToQueue({object: this, method: this.autoLogin, params: [_root.htmlLogin, _root.htmlPassword]});
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            this.getURL("JavaScript:WriteLog(\'LoginScreen\')");
        } // end if
    };
    _loc1.initSavedAccount = function ()
    {
        this._btnRememberMe.selected = this.api.kernel.OptionsManager.getOption("RememberAccountName");
        if (!dofus.Constants.DEBUG && this.api.kernel.OptionsManager.getOption("RememberAccountName"))
        {
            this._tiAccount.text = this.api.kernel.OptionsManager.getOption("LastAccountNameUsed");
            this._tiPassword.setFocus();
        } // end if
    };
    _loc1.initPayingCommunity = function ()
    {
        var _loc2 = this.api.lang.getConfigText("FREE_COMMUNITIES");
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            if (_loc2[_loc3] == this.api.datacenter.Basics.aks_community_id)
            {
                this._btnMembers._visible = false;
                this._mcMembersBackground._visible = false;
                this.api.datacenter.Basics.aks_is_free_community = true;
                return;
            } // end if
        } // end while
        this.api.datacenter.Basics.aks_is_free_community = dofus.Constants.BETAVERSION > 0 ? (true) : (false);
    };
    _loc1.loadNews = function ()
    {
        var _loc2 = new ank.utils.rss.RSSLoader();
        _loc2.addEventListener("onRSSLoadError", this);
        _loc2.addEventListener("onBadRSSFile", this);
        _loc2.addEventListener("onRSSLoaded", this);
        _loc2.load(this.api.lang.getConfigText("RSS_LINK"));
    };
    _loc1.loadGifts = function ()
    {
        var _loc2 = new LoadVars();
        _loc2.owner = this;
        _loc2.onLoad = function (bSuccess)
        {
            this.owner.onGifts(this, bSuccess);
        };
        _loc2.load(this.api.lang.getConfigText("GIFTS_LINK"));
    };
    _loc1.loadFlags = function ()
    {
        var ref = this;
        var _loc5 = _global.CONFIG.languages;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc5.length)
        {
            var _loc7 = _loc5[_loc6];
            var _loc8 = this.attachMovie("UI_LoginLanguage" + _loc7.toUpperCase(), "_mcFlag" + _loc7.toUpperCase(), this.getNextHighestDepth());
            if ( == undefined)
            {
                var _loc4 = (this._mcBgFlags._width - _loc5.length * _loc8._width) / (_loc5.length + 1);
                var _loc2 = this._mcBgFlags._x + _loc4;
                var _loc3 = this._mcBgFlags._y + (this._mcBgFlags._height - _loc8._height) / 2;
            } // end if
            _loc8._x = _loc2;
            _loc8._y = _loc3;
            _loc8._visible = false;
            _loc8.onRelease = function ()
            {
                ref.click({target: this, ref: ref});
            };
            _loc8.onRollOver = function ()
            {
                ref.over({target: this, ref: ref});
            };
            _loc8.onRollOut = function ()
            {
                ref.out({target: this, ref: ref});
            };
            var _loc9 = this.attachMovie("UI_Login_flagsMask", "_mcMask" + _loc7.toUpperCase(), this.getNextHighestDepth());
            _loc9._x = _loc2;
            _loc9._y = _loc3;
            _loc9._visible = true;
            _loc2 = _loc2 + (_loc4 + _loc8._width);
        } // end while
    };
    _loc1.addListeners = function ()
    {
        this._btnShowLastAlert.addEventListener("click", this);
        var ref = this;
        this._btnDownload.addEventListener("click", this);
        this._btnOK.addEventListener("click", this);
        this._btnCopyrights.addEventListener("click", this);
        this._btnDetails.addEventListener("click", this);
        this._btnMembers.addEventListener("click", this);
        this._btnEvolutions.addEventListener("click", this);
        this._btnServersState.addEventListener("click", this);
        this._btnTestServer.addEventListener("click", this);
        this._btnForget.addEventListener("click", this);
        this._btnBackToNews.addEventListener("click", this);
        this._btnRememberMe.addEventListener("click", this);
        this._mcGoToStatus.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcSubscribe.onPress = function ()
        {
            ref.click({target: this});
        };
        this._cbPorts.addEventListener("itemSelected", this);
        this._lstNews.addEventListener("itemSelected", this);
        this.api.kernel.KeyManager.addShortcutsListener("onShortcut", this);
        this.disableMyFlag();
    };
    _loc1.initTexts = function ()
    {
        this._lblAccount.text = this.api.lang.getText("LOGIN_ACCOUNT");
        this._lblPassword.text = this.api.lang.getText("LOGIN_PASSWORD");
        var _loc2 = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION > 0 ? (" BETA " + dofus.Constants.BETAVERSION) : (""));
        var _loc3 = String(this.api.lang.getLangVersion());
        this._lblCopyright.text = this.api.lang.getText("COPYRIGHT") + " (" + _loc2 + " - " + _loc3 + ")";
        this._lblForget.text = this.api.lang.getText("LOGIN_FORGET");
        this._lblDetails.text = this.api.lang.getText("ADVANCED_LOGIN") + " >>";
        this._lblSubscribe.text = this.api.lang.getText("LOGIN_SUBSCRIBE");
        this._btnDownload.label = this.api.lang.getText("LOGIN_DOWNLOAD");
        this._btnMembers.label = this.api.lang.getText("LOGIN_MEMBERS");
        this._btnEvolutions.label = this.api.lang.getText("EVOLUTIONS");
        this._btnServersState.label = this.api.lang.getText("SERVERS_STATES");
        this._btnTestServer.label = dofus.Constants.TEST == true ? (this.api.lang.getText("NORMAL_SERVER_ACCESS")) : (this.api.lang.getText("TEST_SERVER_ACCESS"));
        if (dofus.Constants.ALPHA)
        {
            this._lblTestServer.text = this.api.lang.getText("ALPHA_BUILD_ALERT");
            this._lblTestServerInfo.text = this.api.lang.getText("ALPHA_BUILD_INFO");
            this._lblTestServerInfo.styleName = "GreenNormalCenterBoldLabel";
        }
        else
        {
            this._lblTestServer.text = this.api.lang.getText("TEST_SERVER_ALERT");
            this._lblTestServerInfo.text = this.api.lang.getText("TEST_SERVER_INFO");
            this._lblTestServerInfo.styleName = "WhiteNormalCenterBoldLabel";
        } // end else if
        this._lblServerStatusTitle.text = this.api.lang.getText("SERVERS_STATES");
        this._btnBackToNews.label = this.api.lang.getText("BACK_TO_NEWS");
        this._lblGoToStatus.text = this.api.lang.getText("GO_TO_STATUS");
        this._lblRememberMe.text = this.api.lang.getText("REMEMBER_ME");
        if (_global.CONFIG.isStreaming)
        {
            this._lblAccount.text = this.api.lang.getText("STREAMING_LOGIN_ACCOUNT");
            this._lblRememberMe.text = this.api.lang.getText("STREAMING_REMEMBER_ME");
        } // end if
        var ref = this;
        this._mcNoGiftsBanner._mcPurple.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcNoGiftsBanner._mcPurple.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcNoGiftsBanner._mcEmerald.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcNoGiftsBanner._mcEmerald.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcNoGiftsBanner._mcTurquoise.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcNoGiftsBanner._mcTurquoise.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcNoGiftsBanner._mcEbony.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcNoGiftsBanner._mcEbony.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcNoGiftsBanner._mcIvory.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcNoGiftsBanner._mcIvory.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcNoGiftsBanner._mcOchre.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcNoGiftsBanner._mcOchre.onRollOut = function ()
        {
            ref.out({target: this});
        };
        if (this.api.config.isStreaming)
        {
            this._lblDetails._visible = false;
            this._btnDetails._visible = false;
            this._btnRememberMe._x = this._phRememberMe._x + this._btnRememberMe._x - this._lblRememberMe._x;
            this._btnRememberMe._y = this._phRememberMe._y + this._btnRememberMe._y - this._lblRememberMe._y;
            this._lblRememberMe._x = this._phRememberMe._x;
            this._lblRememberMe._y = this._phRememberMe._y;
            this._lblRememberMe._visible = true;
            this._btnRememberMe._visible = true;
        } // end if
    };
    _loc1.initInput = function ()
    {
        this._tiAccount.tabIndex = 1;
        this._tiPassword.tabIndex = 2;
        this._btnOK.tabIndex = 3;
        this._tiPassword.password = true;
        var _loc2 = false;
        if (dofus.Constants.DEBUG)
        {
            this._tiAccount.restrict = "\\-a-zA-Z0-9|@";
            this._tiAccount.maxChars = 41;
            var _loc3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.loginInfos;
            if (_loc3 != undefined)
            {
                this._tiAccount.text = _loc3.account;
                this._tiPassword.text = _loc3.password;
                _loc2 = true;
            } // end if
        }
        else
        {
            this._tiAccount.restrict = "\\-a-zA-Z0-9@";
            this._tiAccount.maxChars = 20;
        } // end else if
        if (!_loc2)
        {
            this._tiAccount.setFocus();
        } // end if
        this._mcCaution._visible = !_global.CONFIG.isStreaming;
    };
    _loc1.initLanguages = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = _global.CONFIG.languages;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            this["_mcFlag" + String(_loc3[_loc4]).toUpperCase()]._visible = true;
        } // end while
    };
    _loc1.showAlert = function (xNode)
    {
        while (xNode != undefined)
        {
            var _loc3 =  + xNode.toString();
            xNode = xNode.nextSibling;
        } // end while
        var _loc4 = this.gapi.loadUIComponent("AskAlertServer", "AskAlertServer", {title: this.api.lang.getText("SERVER_ALERT"), text: _loc3, hideNext: this._bHideNext});
        _loc4.addEventListener("close", this);
    };
    _loc1.fillCommunityID = function ()
    {
        var _loc2 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.communityID;
        var _loc3 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.detectedCountry;
        if (_root.htmlLang != undefined)
        {
            _loc2 = this.getCommunityFromCountry(_root.htmlLang);
            _loc3 = _root.htmlLang;
        } // end if
        if (_loc2 != undefined && (!_global.isNaN(_loc2) && _loc2 > -1))
        {
            this.api.datacenter.Basics.aks_community_id = _loc2;
            this.api.datacenter.Basics.aks_detected_country = _loc3;
            this.updateFromCommunity();
        }
        else
        {
            var _loc4 = this.api.lang.getConfigText("DEFAULT_COMMUNITY");
            var _loc5 = _loc4.split(",");
            if (_loc5[0] == "??" || (_loc5[1] == "?" || (_loc5 == undefined || (_loc5[0] == undefined || (_loc5[1] == undefined || _global.isNaN(_loc5[1]))))))
            {
                var ref = this;
                this._lvCountry = new LoadVars();
                this._lvCountry.onLoad = function (bSuccess)
                {
                    ref.onCountryLoad(bSuccess);
                };
                this._lvCountry.load(this.api.lang.getConfigText("IP2COUNTRY_LINK"));
            }
            else
            {
                this.api.datacenter.Basics.aks_community_id = Number(_loc5[1]);
                this.api.datacenter.Basics.aks_detected_country = _loc5[0];
                this.updateFromCommunity();
            } // end else if
        } // end else if
    };
    _loc1.updateFromCommunity = function ()
    {
        this.addToQueue({object: this, method: this.loadNews});
        this.addToQueue({object: this, method: this.loadGifts});
        this.saveCommunityAndCountry();
        this.initPayingCommunity();
        if (_global.CONFIG.isStreaming)
        {
            this._btnMembers._visible = false;
            this._mcMembersBackground._visible = false;
            this.api.datacenter.Basics.aks_is_free_community = true;
        } // end if
        this.disableMyFlag();
    };
    _loc1.disableMyFlag = function ()
    {
        if (this.api.datacenter.Basics.aks_community_id == undefined || _global.isNaN(this.api.datacenter.Basics.aks_community_id))
        {
            return;
        } // end if
        switch (this.api.datacenter.Basics.aks_community_id)
        {
            case 0:
            {
                this._mcFlagFR.onRelease = undefined;
                this._mcFlagFR.onRollOver = undefined;
                this._mcFlagFR.onRollOut = undefined;
                break;
            } 
            case 1:
            {
                this._mcFlagUK.onRelease = undefined;
                this._mcFlagUK.onRollOver = undefined;
                this._mcFlagUK.onRollOut = undefined;
                break;
            } 
            case 2:
            {
                this._mcFlagEN.onRelease = undefined;
                this._mcFlagEN.onRollOver = undefined;
                this._mcFlagEN.onRollOut = undefined;
                break;
            } 
            case 3:
            {
                this._mcFlagDE.onRelease = undefined;
                this._mcFlagDE.onRollOver = undefined;
                this._mcFlagDE.onRollOut = undefined;
                break;
            } 
            case 4:
            {
                this._mcFlagES.onRelease = undefined;
                this._mcFlagES.onRollOver = undefined;
                this._mcFlagES.onRollOut = undefined;
                break;
            } 
            case 5:
            {
                this._mcFlagRU.onRelease = undefined;
                this._mcFlagRU.onRollOver = undefined;
                this._mcFlagRU.onRollOut = undefined;
                break;
            } 
            case 6:
            {
                this._mcFlagPT.onRelease = undefined;
                this._mcFlagPT.onRollOver = undefined;
                this._mcFlagPT.onRollOut = undefined;
                break;
            } 
            case 7:
            {
                this._mcFlagNL.onRelease = undefined;
                this._mcFlagNL.onRollOver = undefined;
                this._mcFlagNL.onRollOut = undefined;
                break;
            } 
            case 9:
            {
                this._mcFlagIT.onRelease = undefined;
                this._mcFlagIT.onRollOver = undefined;
                this._mcFlagIT.onRollOut = undefined;
                break;
            } 
        } // End of switch
    };
    _loc1.saveCommunityAndCountry = function ()
    {
        _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.communityID = this.api.datacenter.Basics.aks_community_id;
        _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.detectedCountry = this.api.datacenter.Basics.aks_detected_country;
    };
    _loc1.showServerStatus = function ()
    {
        this._mcBgServerStatus._visible = true;
        this._mcServerStateBackground._visible = true;
        this._lblServerStatusTitle._visible = true;
        this._taServerStatus._visible = true;
        this._btnBackToNews._visible = true;
        this._lstNews._visible = false;
        this._mcGoToStatus._visible = false;
        this._lblGoToStatus._visible = false;
    };
    _loc1.hideServerStatus = function ()
    {
        this._mcBgServerStatus._visible = false;
        this._mcServerStateBackground._visible = false;
        this._lblServerStatusTitle._visible = false;
        this._taServerStatus._visible = false;
        this._btnBackToNews._visible = false;
        this._lstNews._visible = true;
        if (this._bGoToStatusIsShown)
        {
            this.showGoToStatus();
        } // end if
    };
    _loc1.showGoToStatus = function ()
    {
        if (!this.api.lang.getConfigText("ENABLE_SERVER_STATUS"))
        {
            return;
        } // end if
        this._bGoToStatusIsShown = true;
        this._mcGoToStatus._visible = true;
        this._lblGoToStatus._visible = true;
    };
    _loc1.hideGoToStatus = function ()
    {
        this._bGoToStatusIsShown = false;
        this._mcGoToStatus._visible = false;
        this._lblGoToStatus._visible = false;
    };
    _loc1.showLastAlertButton = function (bShow)
    {
        this._btnShowLastAlert._visible = bShow;
        this._mcCaution._visible = bShow;
    };
    _loc1.switchLanguage = function (sLanguage)
    {
        this.api.config.language = sLanguage;
        this.api.kernel.clearCache();
    };
    _loc1.constructPortsList = function ()
    {
        var _loc2 = this.api.lang.getConfigText("SERVER_PORT");
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc2.length)
        {
            if (!this.api.config.isStreaming || Number(_loc2[_loc4]) > 1024)
            {
                _loc3.push({label: this.api.lang.getText("SERVER_PORT") + " : " + _loc2[_loc4], data: _loc2[_loc4]});
            } // end if
        } // end while
        this._cbPorts.dataProvider = _loc3;
        if (!this.api.config.isStreaming || Number(_loc2[this.api.kernel.OptionsManager.getOption("ServerPortIndex")]) > 1024)
        {
            this._cbPorts.selectedIndex = this.api.kernel.OptionsManager.getOption("ServerPortIndex");
            this._nServerPort = _loc2[this.api.kernel.OptionsManager.getOption("ServerPortIndex")];
        }
        else
        {
            var _loc5 = -1;
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc2.length)
            {
                if (Number(_loc2[_loc6]) > 1024)
                {
                    _loc5 = _loc6;
                } // end if
            } // end while
            if (_loc5 < 0)
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("ERROR_NO_PORT_AVAILABLE_BEYOND_1024"), "ERROR_BOX");
                return;
            }
            else
            {
                this._cbPorts.selectedIndex = _loc5;
                this._nServerPort = _loc2[_loc5];
                this.api.kernel.OptionsManager.setOption("ServerPortIndex", _loc5);
            } // end else if
        } // end else if
    };
    _loc1.getCommunityFromCountry = function (sCountry)
    {
        var _loc3 = this.api.lang.getServerCommunities();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4].c;
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5.length)
            {
                if (_loc5[_loc6] == sCountry)
                {
                    return (_loc3[_loc4].i);
                } // end if
            } // end while
        } // end while
        return (-1);
    };
    _loc1.onShortcut = function (sShortcut)
    {
        var _loc3 = this.api.ui.getUIComponent("ChooseNickName");
        var _loc4 = this.api.ui.getUIComponent("AskOkOnLogin");
        if (sShortcut == "ACCEPT_CURRENT_DIALOG" && (Selection.getFocus() != undefined && (_loc3 == undefined && _loc4 == undefined || _loc3 == null && _loc4 == null)))
        {
            this.onLogin(this._tiAccount.text, this._tiPassword.text);
            return (false);
        } // end if
        return (true);
    };
    _loc1.onAlertLoad = function (bSuccess)
    {
        if (bSuccess)
        {
            this._sAlertID = this._xAlert.firstChild.attributes.id;
            var _loc3 = String(this._xAlert.firstChild.attributes.ignoreVersion).split("|");
            this._bHideNext = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.lastAlertID == this._sAlertID;
            if (!this._bHideNext)
            {
                var _loc4 = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
                var _loc5 = true;
                var _loc6 = 0;
                
                while (++_loc6, _loc6 < _loc3.length)
                {
                    if (_loc3[_loc6] == _loc4 || _loc3[_loc6] == "*")
                    {
                        _loc5 = false;
                    } // end if
                } // end while
                if (_loc5)
                {
                    this.addToQueue({object: this, method: this.showAlert, params: [this._xAlert.firstChild.firstChild]});
                } // end if
            } // end if
            this.showLastAlertButton(true);
        } // end if
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_cbPorts":
            {
                var _loc3 = this._cbPorts.selectedItem;
                this._nServerPort = _loc3.data;
                this.api.kernel.OptionsManager.setOption("ServerPortIndex", this._cbPorts.selectedIndex);
                break;
            } 
            case "_lstNews":
            {
                var _loc4 = (ank.utils.rss.RSSItem)(oEvent.row.item);
                this.getURL(_loc4.getLink(), "_blank");
                break;
            } 
        } // End of switch
    };
    _loc1.onLogin = function (sLogin, sPassword)
    {
        if (!dofus.Constants.DEBUG && this._tiPassword.text != undefined)
        {
            this._tiPassword.text = "";
        } // end if
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
        if (dofus.Constants.DEBUG)
        {
            var _loc4 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
            _loc4.data.loginInfos = {account: sLogin, password: sPassword};
            _loc4.close();
        }
        else if (this.api.kernel.OptionsManager.getOption("RememberAccountName"))
        {
            this.api.kernel.OptionsManager.setOption("LastAccountNameUsed", sLogin);
        } // end else if
        this.api.datacenter.Player.login = sLogin;
        this.api.datacenter.Player.password = sPassword;
        if (this._nServerPort == undefined)
        {
            this._nServerPort = this.api.lang.getConfigText("SERVER_PORT")[0];
        } // end if
        if (_global.CONFIG.connexionServer != undefined)
        {
            this._nServerPort = _global.CONFIG.connexionServer.port;
            this._sServerIP = _global.CONFIG.connexionServer.ip;
        } // end if
        if (this._sServerIP == undefined)
        {
            var _loc5 = this.api.lang.getConfigText("SERVER_NAME");
            var _loc6 = new ank.utils.ExtendedArray();
            var _loc7 = Math.floor(Math.random() * _loc5.length);
            var _loc8 = 0;
            
            while (++_loc8, _loc8 < _loc5.length)
            {
                _loc6.push(_loc5[(_loc7 + _loc8) % _loc5.length]);
            } // end while
            this.api.datacenter.Basics.aks_connection_server = _loc6;
            this._sServerIP = String(_loc6.shift());
        } // end if
        this.api.datacenter.Basics.aks_connection_server_port = this._nServerPort;
        _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.lastServerName = this._sServerName;
        if (dofus.Constants.DEBUG)
        {
            this._lblConnect.text = this._sServerIP + " : " + this._nServerPort;
        } // end if
        if (this._sServerIP == undefined || this._nServerPort == undefined)
        {
            var _loc9 = this.api.lang.getText("NO_SERVER_ADDRESS");
            this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"), _loc9 == undefined ? ("Erreur interne\nContacte l\'équipe Dofus") : (_loc9), "ERROR_BOX", {name: "OnLogin"});
        }
        else
        {
            this.api.network.connect(this._sServerIP, this._nServerPort);
            this.api.ui.loadUIComponent("WaitingMessage", "WaitingMessage", {text: this.api.lang.getText("CONNECTING")}, {bAlwaysOnTop: true, bForceLoad: true});
        } // end else if
    };
    _loc1.close = function (oEvent)
    {
        this._bHideNext = oEvent.hideNext;
        SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).data.lastAlertID = oEvent.hideNext ? (this._sAlertID) : (undefined);
        this._tiAccount.tabEnabled = true;
        this._tiPassword.tabEnabled = true;
        this._btnOK.tabEnabled = true;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnShowLastAlert":
            {
                this.showAlert(this._xAlert.firstChild.firstChild);
                break;
            } 
            case "_btnDownload":
            {
                this.getURL(this.api.lang.getConfigText("DOWNLOAD_LINK"), "_blank");
                break;
            } 
            case "_btnCopyrights":
            {
                this.getURL(this.api.lang.getConfigText("ANKAMA_LINK"), "_blank");
                break;
            } 
            case "_btnOK":
            {
                this.onLogin(this._tiAccount.text, this._tiPassword.text);
                break;
            } 
            case "_mcSubscribe":
            {
                if (getTimer() - this._nLastRegisterTime < 1000)
                {
                    return;
                } // end if
                this._nLastRegisterTime = getTimer();
                if (this.api.lang.getConfigText("REGISTER_INGAME"))
                {
                    this._tiAccount.tabEnabled = false;
                    this._tiPassword.tabEnabled = false;
                    this._btnOK.tabEnabled = false;
                    var _loc3 = this.gapi.loadUIComponent("Register", "Register");
                    var _loc4 = (dofus.graphics.gapi.ui.Register)(_loc3);
                    _loc4.addEventListener("close", this);
                }
                else if (this.api.config.isStreaming)
                {
                    this.getURL("javascript:openLink(\'" + this.api.lang.getConfigText("REGISTER_POPUP_LINK") + "\')");
                }
                else
                {
                    this.getURL(this.api.lang.getConfigText("REGISTER_POPUP_LINK"), "_blank");
                } // end else if
                break;
            } 
            case "_btnForget":
            {
                if (!this.api.config.isStreaming)
                {
                    this.getURL(this.api.lang.getConfigText("FORGET_LINK"), "_blank");
                }
                else
                {
                    this.getURL("javascript:OpenPopUpRecoverPassword()");
                } // end else if
                break;
            } 
            case "_btnMembers":
            {
                this.getURL(this.api.lang.getConfigText("MEMBERS_LINK"), "_blank");
                break;
            } 
            case "_btnDetails":
            {
                if (this._btnDetails.selected)
                {
                    this._aOldFlagsState = [this._mcFlagFR._visible, this._mcFlagEN._visible, this._mcFlagUK._visible, this._mcFlagDE._visible, this._mcFlagES._visible, this._mcFlagRU._visible, this._mcFlagPT._visible, this._mcFlagNL._visible, false, this._mcFlagIT];
                    this._mcFlagFR._visible = false;
                    this._mcFlagEN._visible = false;
                    this._mcFlagUK._visible = false;
                    this._mcFlagDE._visible = false;
                    this._mcFlagES._visible = false;
                    this._mcFlagRU._visible = false;
                    this._mcFlagPT._visible = false;
                    this._mcFlagNL._visible = false;
                    this._mcFlagIT._visible = false;
                    this._mcMaskFR._visible = false;
                    this._mcMaskEN._visible = false;
                    this._mcMaskUK._visible = false;
                    this._mcMaskDE._visible = false;
                    this._mcMaskES._visible = false;
                    this._mcMaskRU._visible = false;
                    this._mcMaskPT._visible = false;
                    this._mcMaskNL._visible = false;
                    this._mcMaskIT._visible = false;
                }
                else
                {
                    this._mcFlagFR._visible = this._aOldFlagsState[0] === true;
                    this._mcFlagEN._visible = this._aOldFlagsState[1] === true;
                    this._mcFlagUK._visible = this._aOldFlagsState[2] === true;
                    this._mcFlagDE._visible = this._aOldFlagsState[3] === true;
                    this._mcFlagES._visible = this._aOldFlagsState[4] === true;
                    this._mcFlagRU._visible = this._aOldFlagsState[5] === true;
                    this._mcFlagPT._visible = this._aOldFlagsState[6] === true;
                    this._mcFlagNL._visible = this._aOldFlagsState[7] === true;
                    this._mcFlagIT._visible = this._aOldFlagsState[9] === true;
                    this._mcMaskFR._visible = this.api.datacenter.Basics.aks_community_id != 0;
                    this._mcMaskEN._visible = this.api.datacenter.Basics.aks_community_id != 2;
                    this._mcMaskUK._visible = this.api.datacenter.Basics.aks_community_id != 1;
                    this._mcMaskDE._visible = this.api.datacenter.Basics.aks_community_id != 3;
                    this._mcMaskES._visible = this.api.datacenter.Basics.aks_community_id != 4;
                    this._mcMaskRU._visible = this.api.datacenter.Basics.aks_community_id != 5;
                    this._mcMaskPT._visible = this.api.datacenter.Basics.aks_community_id != 6;
                    this._mcMaskNL._visible = this.api.datacenter.Basics.aks_community_id != 7;
                    this._mcMaskIT._visible = this.api.datacenter.Basics.aks_community_id != 9;
                } // end else if
                this._mcAdvancedBack._y = this._mcAdvancedBack._y + (this._btnDetails.selected ? (30) : (-30));
                this._lblRememberMe._visible = this._btnDetails.selected;
                this._btnRememberMe._visible = this._btnDetails.selected;
                this._mcAdvancedBackground._visible = this._btnDetails.selected;
                this._cbPorts._visible = this._btnDetails.selected;
                this._btnTestServer._visible = dofus.Constants.TEST ? (true) : (this._btnDetails.selected && (this.api.lang.getConfigText("TEST_SERVER_ACCESS") && !this.api.config.isStreaming));
                this._lblDetails.text = this._btnDetails.selected ? ("<< " + this.api.lang.getText("ADVANCED_LOGIN")) : (this.api.lang.getText("ADVANCED_LOGIN") + " >>");
                break;
            } 
            case "_btnEvolutions":
            {
                var _loc5 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
                _loc5.data.forumEvolutions = this._nForumEvolutionsPostCount;
                this._mcEvolutionsHighlight._visible = false;
                this._mcEvolutionsHighlight.gotoAndStop(1);
                this.getURL(this.api.lang.getConfigText("FORUM_EVOLUTIONS_LAST_POST"), "_blank");
                break;
            } 
            case "_btnServersState":
            {
                var _loc6 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
                _loc6.data.forumServersState = this._nForumServersStatePostCount;
                this._mcServersStateHighlight._visible = false;
                this._mcServersStateHighlight.gotoAndStop(1);
                this.getURL(this.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"), "_blank");
                break;
            } 
            case "_btnTestServer":
            {
                dofus.Constants.TEST = !dofus.Constants.TEST;
                this._visible = false;
                _level0._loader.reboot();
                break;
            } 
            case "_btnBackToNews":
            {
                this.hideServerStatus();
                break;
            } 
            case "_mcGoToStatus":
            {
                this.showServerStatus();
                break;
            } 
            case "_btnRememberMe":
            {
                this.api.kernel.OptionsManager.setOption("RememberAccountName", oEvent.target.selected);
                break;
            } 
            default:
            {
                if (String(oEvent.target._name).substring(0, 7) == "_mcFlag")
                {
                    var _loc7 = String(oEvent.target._name).substr(7, 2).toLowerCase();
                    if (this.api.config.isStreaming)
                    {
                        getURL("FSCommand:" add "language", _loc7);
                    }
                    else
                    {
                        switch (_loc7)
                        {
                            case "en":
                            {
                                this.switchLanguage("en");
                                this.api.datacenter.Basics.aks_detected_country = _loc7.toUpperCase();
                                this.api.datacenter.Basics.aks_community_id = 2;
                                this.saveCommunityAndCountry();
                                break;
                            } 
                            case "uk":
                            {
                                this.switchLanguage("en");
                                this.api.datacenter.Basics.aks_detected_country = "UK";
                                this.api.datacenter.Basics.aks_community_id = 1;
                                this.saveCommunityAndCountry();
                                break;
                            } 
                            default:
                            {
                                this.switchLanguage(_loc7);
                                this.api.datacenter.Basics.aks_detected_country = _loc7.toUpperCase();
                                this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(_loc7.toUpperCase());
                                this.saveCommunityAndCountry();
                                break;
                            } 
                        } // End of switch
                    } // end else if
                }
                else
                {
                    var _loc8 = oEvent.target.params.url;
                    if (_loc8 != undefined && _loc8 != "")
                    {
                        this.getURL(_loc8, "_blank");
                    } // end if
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.onRSSLoadError = function (oEvent)
    {
        ank.utils.Logger.err("Impossible de charger le fichier RSS");
    };
    _loc1.onBadRSSFile = function (oEvent)
    {
        ank.utils.Logger.err("Fichier RSS invalide");
    };
    _loc1.onRSSLoaded = function (oEvent)
    {
        var _loc3 = (ank.utils.rss.RSSLoader)(oEvent.target);
        var _loc4 = new ank.utils.ExtendedArray();
        _loc4.createFromArray(_loc3.getChannels()[0].getItems());
        this._lstNews.dataProvider = _loc4;
    };
    _loc1.onGifts = function (oLoadVars, bSuccess)
    {
        var _loc4 = 0;
        if (bSuccess && !_global.CONFIG.isStreaming)
        {
            var _loc5 = this.createEmptyMovieClip("_mcMaskGift", this.getNextHighestDepth());
            with (_loc5)
            {
                beginFill(0, 100);
                moveTo(43, 400);
                lineTo(703, 400);
                lineTo(703, 500);
                lineTo(43, 500);
                lineTo(43, 400);
            } // End of with
            this._mcGifts.setMask(_loc5);
            _loc4 = Number(oLoadVars.c);
            this._aGiftsURLs = new ank.utils.ExtendedArray();
            var _loc6 = 1;
            
            while (++_loc6, _loc6 <= _loc4)
            {
                var _loc7 = (ank.gapi.controls.Button)(this._mcGifts.attachMovie("Button", "btn" + _loc6, _loc6, {_x: (_loc6 - 1) * 131, _width: 110, _height: 92, backgroundDown: "ButtonTransparentUp", backgroundUp: "ButtonTransparentUp", styleName: "none"}));
                _loc7.addEventListener("over", this);
                _loc7.addEventListener("out", this);
                _loc7.addEventListener("click", this);
                _loc7.params = {description: oLoadVars["d" + _loc6], url: oLoadVars["u" + _loc6]};
                this._aGiftsURLs.push({id: _loc6, url: oLoadVars["g" + _loc6]});
                var _loc8 = (ank.gapi.controls.Loader)(this._mcGifts.attachMovie("Loader", "ldr" + _loc6, _loc6 + 100, {_x: (_loc6 - 1) * 131, _width: 110, _height: 92}));
                _loc8.addEventListener("error", this);
                _loc8.contentPath = dofus.Constants.GIFTS_PATH + oLoadVars["g" + _loc6];
            } // end while
            if (_loc4 > 5)
            {
                this._mcArrowRight.gotoAndPlay("on");
            } // end if
        } // end if
        if (_loc4 == 0 || !bSuccess)
        {
            this._mcArrowLeft._visible = false;
            this._mcArrowRight._visible = false;
            this._mcNoGiftsBanner._visible = true;
        } // end if
    };
    _loc1.onEnterFrame = function ()
    {
        if (this._ymouse > 400 && this._ymouse < 500)
        {
            var _loc2 = 742 / 2 - this._xmouse;
            if (Math.abs(_loc2) > 300)
            {
                var _loc3 = this._mcGifts._x + _loc2 / 40;
                if (_loc2 > 0)
                {
                    if (_loc3 > 55)
                    {
                        this._mcGifts._x = 55;
                        this._mcArrowLeft.gotoAndStop("off");
                        if (this._mcArrowRight._currentframe == 1)
                        {
                            this._mcArrowRight.gotoAndPlay("on");
                        } // end if
                    }
                    else
                    {
                        this._mcGifts._x = _loc3;
                        if (this._mcArrowLeft._currentframe == 1)
                        {
                            this._mcArrowLeft.gotoAndPlay("on");
                        } // end if
                        if (this._mcArrowRight._currentframe == 1)
                        {
                            this._mcArrowRight.gotoAndPlay("on");
                        } // end if
                    } // end else if
                }
                else if (_loc3 + this._mcGifts._width < 690)
                {
                    this._mcGifts._x = 690 - this._mcGifts._width;
                    this._mcArrowRight.gotoAndStop("off");
                    if (this._mcArrowLeft._currentframe == 1)
                    {
                        this._mcArrowLeft.gotoAndPlay("on");
                    } // end if
                }
                else
                {
                    this._mcGifts._x = _loc3;
                    if (this._mcArrowLeft._currentframe == 1)
                    {
                        this._mcArrowLeft.gotoAndPlay("on");
                    } // end if
                    if (this._mcArrowRight._currentframe == 1)
                    {
                        this._mcArrowRight.gotoAndPlay("on");
                    } // end if
                } // end if
            } // end else if
        } // end else if
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_mcPurple":
            {
                this.gapi.showTooltip(this.api.lang.getText("PURPLE_DOFUS"), oEvent.target, -50);
                break;
            } 
            case "_mcEmerald":
            {
                this.gapi.showTooltip(this.api.lang.getText("EMERALD_DOFUS"), oEvent.target, -50);
                break;
            } 
            case "_mcTurquoise":
            {
                this.gapi.showTooltip(this.api.lang.getText("TURQUOISE_DOFUS"), oEvent.target, -50);
                break;
            } 
            case "_mcEbony":
            {
                this.gapi.showTooltip(this.api.lang.getText("EBONY_DOFUS"), oEvent.target, -50);
                break;
            } 
            case "_mcIvory":
            {
                this.gapi.showTooltip(this.api.lang.getText("IVORY_DOFUS"), oEvent.target, -50);
                break;
            } 
            case "_mcOchre":
            {
                this.gapi.showTooltip(this.api.lang.getText("OCHRE_DOFUS"), oEvent.target, -50);
                break;
            } 
            default:
            {
                if (String(oEvent.target._name).substring(0, 7) == "_mcFlag")
                {
                    var _loc3 = String(oEvent.target._name).substr(7, 2);
                    var _loc4 = this.api.lang.getText("LANGUAGE_" + _loc3);
                    this.gapi.showTooltip(_loc4, this["_mcMask" + _loc3], -20);
                }
                else
                {
                    this.gapi.showTooltip(oEvent.target.params.description, oEvent.target, -40);
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.onEvolutionsPostCount = function (oLoadVars)
    {
        var _loc3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
        this._nForumEvolutionsPostCount = Number(oLoadVars.c);
        var _loc4 = _loc3.data.forumEvolutions;
        if (this._nForumEvolutionsPostCount > _loc4 || _loc4 == undefined)
        {
            this._mcEvolutionsHighlight._visible = true;
            this._mcEvolutionsHighlight.play();
        } // end if
    };
    _loc1.onServersStatePostCount = function (oLoadVars)
    {
        var _loc3 = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
        this._nForumServersStatePostCount = Number(oLoadVars.c);
        var _loc4 = _loc3.data.forumServersState;
        if (this._nForumServersStatePostCount > _loc4 || _loc4 == undefined)
        {
            this._mcServersStateHighlight._visible = true;
            this._mcServersStateHighlight.play();
        } // end if
    };
    _loc1.onData = function ()
    {
        var _loc2 = "<font color=\"#EBE3CB\">";
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._siServerStatus.problems.length)
        {
            var _loc4 = this._siServerStatus.problems[_loc3];
            _loc2 = _loc2 + (_loc4.date + "\n");
            _loc2 = _loc2 + (" <b>" + _loc4.type + "</b>\n");
            _loc2 = _loc2 + (" <i>" + this.api.lang.getText("STATE_WORD") + "</i>: " + _loc4.status + "\n");
            _loc2 = _loc2 + (" <i>" + this.api.lang.getText("INVOLVED_SERVERS") + "</i>: " + _loc4.servers.join(", ") + "\n");
            _loc2 = _loc2 + (" <i>" + this.api.lang.getText("HISTORY_WORD") + "</i>:\n");
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc4.history.length)
            {
                _loc2 = _loc2 + ("  <b>" + _loc4.history[_loc5].hour + "</b>");
                if (_loc4.history[_loc5].title != "undefined")
                {
                    _loc2 = _loc2 + (" : " + _loc4.history[_loc5].title + "\n   ");
                }
                else
                {
                    _loc2 = _loc2 + " - ";
                } // end else if
                if (_loc4.history[_loc5].content != undefined)
                {
                    _loc2 = _loc2 + _loc4.history[_loc5].content;
                    if (!_loc4.history[_loc5].translated)
                    {
                        _loc2 = _loc2 + this.api.lang.getText("TRANSLATION_IN_PROGRESS");
                    } // end if
                } // end if
                _loc2 = _loc2 + "\n";
            } // end while
            _loc2 = _loc2 + "\n";
        } // end while
        _loc2 = _loc2 + "</font>";
        this._taServerStatus.text = _loc2;
        if (this._siServerStatus.isOnFocus)
        {
            this.showServerStatus();
            this._bGoToStatusIsShown = true;
        }
        else if (this._siServerStatus.problems.length > 0)
        {
            this.showGoToStatus();
        }
        else
        {
            this.hideGoToStatus();
        } // end else if
    };
    _loc1.error = function (oEvent)
    {
        var _loc3 = oEvent.target._name.substr(3);
        var _loc4 = this._aGiftsURLs.findFirstItem("id", _loc3).item.url;
        this._mcGifts["ldr" + _loc3].removeEventListener("error", this);
        this._mcGifts["ldr" + _loc3].contentPath = _loc4;
    };
    _loc1.onCountryLoad = function (bSuccess)
    {
        var _loc3 = this._lvCountry.c;
        if (bSuccess && _loc3.length > 0)
        {
            this.api.datacenter.Basics.aks_detected_country = _loc3;
            this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(_loc3);
        }
        else
        {
            this.api.datacenter.Basics.aks_detected_country = this.api.config.language.toUpperCase();
            this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(this.api.datacenter.Basics.aks_detected_country);
        } // end else if
        this.updateFromCommunity();
    };
    _loc1.addProperty("language", function ()
    {
    }, _loc1.__set__language);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Login = function ()
    {
        super();
        this._mcGoToStatus._visible = false;
        this._lblGoToStatus._visible = false;
        this._mcNoGiftsBanner._visible = false;
        this.fillCommunityID();
    }).CLASS_NAME = "Login";
    _loc1._bHideNext = false;
    _loc1._nLastRegisterTime = 0;
} // end if
#endinitclip
