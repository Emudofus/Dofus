package ui
{
    import d2api.DataApi;
    import d2api.SystemApi;
    import d2api.ConfigApi;
    import d2api.UiApi;
    import d2api.SoundApi;
    import d2api.ConnectionApi;
    import flash.utils.Dictionary;
    import d2components.Input;
    import d2components.Texture;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.StateContainer;
    import d2components.InputComboBox;
    import d2components.Label;
    import d2components.EntityDisplayer;
    import d2components.ComboBox;
    import d2components.Grid;
    import d2hooks.NicknameRegistration;
    import d2hooks.SubscribersList;
    import d2hooks.UiUnloaded;
    import d2hooks.SelectedServerFailed;
    import d2hooks.KeyUp;
    import d2enums.ComponentHookList;
    import d2actions.SubscribersGiftListRequest;
    import flash.ui.Keyboard;
    import d2hooks.QualitySelectionRequired;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2enums.BuildTypeEnum;
    import d2actions.LoginValidation;
    import d2actions.LoginAsGuest;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2hooks.*;
    import d2actions.*;
    import flash.utils.*;

    public class Login 
    {

        private const GAMEMODE_LOG_IN:int = 0;
        private const GAMEMODE_PLAY_AS_GUEST:int = 1;

        public var output:Object;
        public var dataApi:DataApi;
        public var sysApi:SystemApi;
        public var configApi:ConfigApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var soundApi:SoundApi;
        public var connectionApi:ConnectionApi;
        private var _guestModeAvailable:Boolean = false;
        private var _currentMode:uint = 0;
        private var _aPorts:Array;
        private var _aPortsName:Array;
        private var _componentsList:Dictionary;
        private var _previousFocus:Input;
        private var _giftButtonsData:Dictionary;
        public var tx_logo:Texture;
        public var tx_background:Texture;
        public var ctr_tabs:GraphicContainer;
        public var btn_registeredTab:ButtonContainer;
        public var btn_guestTab:ButtonContainer;
        public var ctr_noTab:GraphicContainer;
        public var ctr_center:GraphicContainer;
        public var ctr_inputs:StateContainer;
        public var cbx_login:InputComboBox;
        public var input_pass:Input;
        public var lbl_login:Label;
        public var lbl_pass:Label;
        public var lbl_capsLock:Label;
        public var tx_capsLockMsg:Texture;
        public var btn_passForgotten:ButtonContainer;
        public var btn_createAccount:ButtonContainer;
        public var ctr_guestMode:GraphicContainer;
        public var ed_decoQuality:EntityDisplayer;
        public var lbl_guestModeInfo:Label;
        public var btn_play:ButtonContainer;
        public var btn_options:ButtonContainer;
        public var ctr_options:GraphicContainer;
        public var btn_rememberLogin:ButtonContainer;
        public var cb_connectionType:ComboBox;
        public var cb_socket:ComboBox;
        public var ctr_gifts:GraphicContainer;
        public var btn_members:ButtonContainer;
        public var btn_lowa:ButtonContainer;
        public var gd_shop:Grid;
        public var gd_guestMode:Grid;
        public var btn_manualConnection:ButtonContainer;
        public var btn_serverConnection:ButtonContainer;
        public var btn_characterConnection:ButtonContainer;
        public var btn_guestSelection:ButtonContainer;

        public function Login()
        {
            this._componentsList = new Dictionary(true);
            this._giftButtonsData = new Dictionary(true);
            super();
        }

        public function main(popup:String=null):void
        {
            var porc:String;
            var serverport:uint;
            var loginMustBeSaved:int;
            var lastLogins:Array;
            var deprecatedLogin:String;
            var logins:Array;
            this.cbx_login.input.tabEnabled = true;
            this.input_pass.tabEnabled = true;
            this.btn_play.soundId = "-1";
            this.soundApi.playIntroMusic();
            this.sysApi.addHook(NicknameRegistration, this.onNicknameRegistration);
            this.sysApi.addHook(SubscribersList, this.onSubscribersList);
            this.sysApi.addHook(UiUnloaded, this.onUiUnloaded);
            this.sysApi.addHook(SelectedServerFailed, this.onSelectedServerFailed);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addComponentHook(this.btn_rememberLogin, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_rememberLogin, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_rememberLogin, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.cbx_login, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.input_pass, "onChange");
            this.uiApi.addComponentHook(this.cbx_login.input, "onChange");
            this.sysApi.sendAction(new SubscribersGiftListRequest());
            this.ctr_gifts.visible = false;
            if (this.sysApi.isStreaming())
            {
                this._guestModeAvailable = true;
            };
            if (this._guestModeAvailable)
            {
                this.ctr_tabs.visible = true;
                this.ctr_noTab.visible = false;
            }
            else
            {
                this.ctr_tabs.visible = false;
                this.ctr_noTab.visible = true;
            };
            this.ctr_options.visible = false;
            if (this.connectionApi.hasGuestAccount())
            {
                this.lbl_guestModeInfo.text = this.uiApi.getText("ui.guest.guestAccountExisting");
            }
            else
            {
                this.lbl_guestModeInfo.text = this.uiApi.getText("ui.guest.guestModeInfo");
            };
            this.uiApi.setRadioGroupSelectedItem("tabHGroup", this.btn_registeredTab, this.uiApi.me());
            this.btn_registeredTab.selected = true;
            var cachePortIsStillOk:Boolean;
            var cachePort:int = this.sysApi.getPort();
            this._aPorts = new Array();
            this._aPortsName = new Array();
            var ports:String = this.sysApi.getConfigKey("connection.port");
            for each (porc in ports.split(","))
            {
                this._aPorts.push(int(porc));
                this._aPortsName.push(("" + porc));
                if (cachePort == int(porc))
                {
                    cachePortIsStillOk = true;
                };
            };
            this.cb_socket.dataProvider = this._aPortsName;
            if (((cachePort) && (cachePortIsStillOk)))
            {
                serverport = cachePort;
            }
            else
            {
                serverport = this._aPorts[0];
                this.sysApi.setPort(this._aPorts[0]);
            };
            this.cb_socket.value = this._aPortsName[this._aPorts.indexOf(serverport)];
            this.cb_connectionType.dataProvider = [{
                "label":this.uiApi.getText("ui.connection.connectionToServerChoice"),
                "type":0
            }, {
                "label":this.uiApi.getText("ui.connection.connectionToCharacterChoice"),
                "type":1
            }, {
                "label":this.uiApi.getText("ui.connection.connectionDirectAccess"),
                "type":2
            }];
            var autoConnectType:uint = this.configApi.getConfigProperty("dofus", "autoConnectType");
            this.cb_connectionType.value = this.cb_connectionType.dataProvider[autoConnectType];
            var logoUrl:String = (this.sysApi.getConfigEntry("config.content.path") + "/gfx/illusUi/logo_dofus.swf|");
            switch (this.sysApi.getCurrentLanguage())
            {
                case "ja":
                    logoUrl = (logoUrl + "tx_logo_JP");
                    break;
                case "ru":
                    logoUrl = (logoUrl + "tx_logo_RU");
                    this.tx_background.uri = this.uiApi.createUri((this.uiApi.me().getConstant("assets") + "login_tx_background_russe"));
                    break;
                case "fr":
                default:
                    logoUrl = (logoUrl + "tx_logo_FR");
            };
            this.tx_logo.uri = this.uiApi.createUri(logoUrl);
            this.cbx_login.input.restrict = "A-Za-z0-9\\-\\|.@_";
            if (this.sysApi.isEventMode())
            {
                this.uiApi.setFullScreen(true, true);
                this.cbx_login.input.text = this.uiApi.getText("ui.connection.eventModeLogin");
                this.input_pass.text = "**********";
                this.cbx_login.disabled = true;
                this.input_pass.disabled = true;
                this.ctr_inputs.state = "DISABLED";
                this.btn_rememberLogin.disabled = true;
                this.btn_rememberLogin.mouseEnabled = false;
                this.btn_manualConnection.disabled = true;
                this.btn_serverConnection.disabled = true;
                this.btn_characterConnection.disabled = true;
                this.cb_connectionType.disabled = true;
            }
            else
            {
                if ((((this.sysApi.getConfigKey("boo") == "1")) && ((this.sysApi.getBuildType() > 1))))
                {
                    this.input_pass.text = ((this.sysApi.getData("LastPassword")) ? this.sysApi.getData("LastPassword") : "");
                }
                else
                {
                    this.lbl_pass.text = this.uiApi.getText("ui.login.password");
                };
                loginMustBeSaved = this.sysApi.getData("saveLogin");
                if (loginMustBeSaved == 0)
                {
                    Connection.loginMustBeSaved = 1;
                    this.btn_rememberLogin.selected = true;
                    this.sysApi.setData("saveLogin", 1);
                }
                else
                {
                    Connection.loginMustBeSaved = loginMustBeSaved;
                    this.btn_rememberLogin.selected = (loginMustBeSaved == 1);
                };
                lastLogins = this.sysApi.getData("LastLogins");
                if (((lastLogins) && ((lastLogins.length > 0))))
                {
                    this.cbx_login.input.text = lastLogins[0];
                    this.cbx_login.dataProvider = lastLogins;
                    this.input_pass.focus();
                }
                else
                {
                    deprecatedLogin = this.sysApi.getData("LastLogin");
                    if (((deprecatedLogin) && ((deprecatedLogin.length > 0))))
                    {
                        this.sysApi.setData("LastLogin", "");
                        logins = new Array();
                        logins.push(deprecatedLogin);
                        this.sysApi.setData("LastLogins", logins);
                        this.sysApi.setData("saveLogin", 1);
                        Connection.loginMustBeSaved = 1;
                        this.btn_rememberLogin.selected = true;
                        this.cbx_login.input.text = deprecatedLogin;
                        this.cbx_login.dataProvider = logins;
                        this.input_pass.focus();
                    }
                    else
                    {
                        if (((this._guestModeAvailable) && (!(this.sysApi.isLoggingWithTicket()))))
                        {
                            this.uiApi.setRadioGroupSelectedItem("tabHGroup", this.btn_guestTab, this.uiApi.me());
                            this.btn_guestTab.selected = true;
                            this.onRelease(this.btn_guestTab);
                        };
                        this.lbl_login.text = this.uiApi.getText("ui.login.username");
                        this.cbx_login.input.focus();
                    };
                };
            };
            if (popup == "unexpectedSocketClosure")
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.unexpectedSocketClosure"), this.uiApi.getText("ui.popup.unexpectedSocketClosure.text"), [this.uiApi.getText("ui.common.ok")]);
            };
            this.lbl_capsLock.multiline = false;
            this.lbl_capsLock.wordWrap = false;
            this.lbl_capsLock.fullWidth();
            this.tx_capsLockMsg.width = (this.lbl_capsLock.textfield.width + 15);
            if (((!(Keyboard.capsLock)) || ((this.sysApi.getOs() == "Mac OS"))))
            {
                this.lbl_capsLock.visible = false;
                this.tx_capsLockMsg.visible = false;
            };
            this.sysApi.dispatchHook(QualitySelectionRequired);
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
        }

        public function disableUi(disable:Boolean):void
        {
            this.cbx_login.input.mouseEnabled = !(disable);
            this.cbx_login.input.mouseChildren = !(disable);
            this.input_pass.mouseEnabled = !(disable);
            this.input_pass.mouseChildren = !(disable);
            if (disable)
            {
                this.ctr_inputs.state = "DISABLED";
                if (this.cbx_login.input.haveFocus)
                {
                    this._previousFocus = this.cbx_login.input;
                }
                else
                {
                    if (this.input_pass.haveFocus)
                    {
                        this._previousFocus = this.input_pass;
                    };
                };
                this.btn_play.focus();
            }
            else
            {
                this.ctr_inputs.state = "NORMAL";
                if (this._previousFocus)
                {
                    this._previousFocus.focus();
                    this._previousFocus = null;
                };
            };
            this.btn_play.disabled = disable;
            this.btn_rememberLogin.disabled = disable;
            this.btn_rememberLogin.mouseEnabled = !(disable);
            this.cbx_login.disabled = disable;
            this.cb_connectionType.disabled = disable;
            this.btn_manualConnection.disabled = disable;
            this.btn_serverConnection.disabled = disable;
            this.btn_characterConnection.disabled = disable;
        }

        public function updateLoginLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._componentsList[componentsRef.btn_removeLogin.name]))
            {
                this.uiApi.addComponentHook(componentsRef.btn_removeLogin, "onRelease");
                this.uiApi.addComponentHook(componentsRef.btn_removeLogin, "onRollOut");
                this.uiApi.addComponentHook(componentsRef.btn_removeLogin, "onRollOver");
            };
            this._componentsList[componentsRef.btn_removeLogin.name] = data;
            if (data)
            {
                componentsRef.lbl_loginName.text = data;
                componentsRef.btn_removeLogin.visible = true;
                if (selected)
                {
                    componentsRef.btn_login.selected = true;
                }
                else
                {
                    componentsRef.btn_login.selected = false;
                };
            }
            else
            {
                componentsRef.lbl_loginName.text = "";
                componentsRef.btn_removeLogin.visible = false;
                componentsRef.btn_login.selected = false;
            };
        }

        private function login():void
        {
            var sLogin:String;
            var sPass:String;
            var username:String;
            var usernameLength:uint;
            var i:uint;
            var directConnection:Boolean;
            this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
            if ((((this._currentMode == this.GAMEMODE_LOG_IN)) || (!(this._guestModeAvailable))))
            {
                sLogin = this.cbx_login.input.text;
                sPass = this.input_pass.text;
                if ((((sLogin.length == 0)) || ((sPass.length == 0))))
                {
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.wrongCredentials"), [this.uiApi.getText("ui.common.ok")], []);
                    this.disableUi(false);
                }
                else
                {
                    if ((((this.sysApi.getConfigKey("boo") == "1")) && ((this.sysApi.getBuildType() > BuildTypeEnum.BETA))))
                    {
                        this.sysApi.setData("LastPassword", sPass);
                    }
                    else
                    {
                        this.sysApi.setData("LastPassword", null);
                    };
                    if (this.sysApi.isEventMode())
                    {
                        username = this.sysApi.getData("EventModeLogins");
                        if (((!(username)) || ((username.length == 0))))
                        {
                            username = "$";
                            usernameLength = (10 + (Math.random() * 10));
                            i = 0;
                            while (i < usernameLength)
                            {
                                username = (username + String.fromCharCode(Math.floor((97 + (Math.random() * 26)))));
                                i++;
                            };
                            this.sysApi.setData("EventModeLogins", username);
                        };
                        this.sysApi.sendAction(new LoginValidation(username, "pass", true));
                    }
                    else
                    {
                        directConnection = (this.cb_connectionType.selectedItem.type == 2);
                        if (directConnection)
                        {
                            this.connectionApi.allowAutoConnectCharacter(true);
                        };
                        this.sysApi.sendAction(new LoginValidation(sLogin, sPass, !((this.cb_connectionType.selectedItem.type == 0))));
                    };
                };
            }
            else
            {
                this.sysApi.sendAction(new LoginAsGuest());
            };
        }

        public function updateShopGift(data:*, componentsRef:*, selected:Boolean):void
        {
            var intPriceCrossed:int;
            if (data)
            {
                if (!(this._giftButtonsData[componentsRef.btn_article.name]))
                {
                    this.uiApi.addComponentHook(componentsRef.btn_article, "onRollOver");
                    this.uiApi.addComponentHook(componentsRef.btn_article, "onRollOut");
                    this.uiApi.addComponentHook(componentsRef.btn_article, "onRelease");
                    this._giftButtonsData[componentsRef.btn_article.name] = data;
                };
                if (data.visualUri)
                {
                    componentsRef.bgTexturebtn_article.uri = this.uiApi.createUri(data.visualUri);
                };
                componentsRef.bgTexturebtn_article.height = 120;
                componentsRef.bgTexturebtn_article.width = 120;
                intPriceCrossed = data.price;
                if (data.priceCrossed)
                {
                    intPriceCrossed = data.priceCrossed.split(".")[0];
                };
                if (((data.priceCrossed) && ((intPriceCrossed > data.price))))
                {
                    componentsRef.lbl_banner.text = data.price;
                    componentsRef.tx_banner.gotoAndStop = 2;
                    componentsRef.lbl_price.text = intPriceCrossed;
                    componentsRef.tx_crossprice.visible = true;
                    componentsRef.tx_money.visible = true;
                    componentsRef.lbl_banner.x = 15;
                }
                else
                {
                    if (data.promotionTag)
                    {
                        componentsRef.lbl_banner.text = this.uiApi.getText("ui.shop.sales");
                        componentsRef.tx_banner.gotoAndStop = 2;
                    }
                    else
                    {
                        if (data.newTag)
                        {
                            componentsRef.lbl_banner.text = this.uiApi.getText("ui.common.new");
                            componentsRef.tx_banner.gotoAndStop = 1;
                        }
                        else
                        {
                            componentsRef.tx_banner.visible = false;
                            componentsRef.lbl_banner.visible = false;
                        };
                    };
                    componentsRef.lbl_price.text = data.price;
                };
            }
            else
            {
                componentsRef.ctr_article.visible = false;
            };
        }

        private function randomSort(a:*, b:*):Number
        {
            if (Math.random() < 0.5)
            {
                return (-1);
            };
            return (1);
        }

        public function onRelease(target:Object):void
        {
            var _local_2:int;
            var loginToDelete:String;
            var oldLogins:Array;
            var logins:Array;
            var oldLog:String;
            switch (target)
            {
                case this.btn_play:
                    if (!(this.btn_play.disabled))
                    {
                        this.disableUi(true);
                        this.login();
                    };
                    break;
                case this.btn_rememberLogin:
                    _local_2 = ((this.btn_rememberLogin.selected) ? 1 : -1);
                    Connection.loginMustBeSaved = _local_2;
                    this.sysApi.setData("saveLogin", _local_2);
                    break;
                case this.btn_passForgotten:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.findPassword"));
                    break;
                case this.btn_createAccount:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.createAccount"));
                    break;
                case this.btn_options:
                    if (this.ctr_options.visible)
                    {
                        this.ctr_options.visible = false;
                    }
                    else
                    {
                        this.ctr_options.visible = true;
                    };
                    break;
                case this.btn_members:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.members"));
                    break;
                case this.btn_lowa:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.lowa"));
                    break;
                case this.btn_guestTab:
                    this.ctr_guestMode.visible = true;
                    this.ctr_center.visible = false;
                    this.ctr_inputs.visible = false;
                    this.cb_connectionType.disabled = true;
                    this._currentMode = this.GAMEMODE_PLAY_AS_GUEST;
                    this.ed_decoQuality.look = this.sysApi.getEntityLookFromString("{1483}");
                    this.ed_decoQuality.direction = 0;
                    break;
                case this.btn_registeredTab:
                    this.ctr_guestMode.visible = false;
                    this.ctr_center.visible = true;
                    this.ctr_inputs.visible = true;
                    this.cb_connectionType.disabled = false;
                    this._currentMode = this.GAMEMODE_LOG_IN;
                    this.ed_decoQuality.direction = 1;
                    break;
                default:
                    if (target.name.indexOf("btn_removeLogin") != -1)
                    {
                        loginToDelete = this._componentsList[target.name];
                        oldLogins = this.sysApi.getData("LastLogins");
                        logins = new Array();
                        for each (oldLog in oldLogins)
                        {
                            if (oldLog != loginToDelete)
                            {
                                logins.push(oldLog);
                            };
                        };
                        this.sysApi.setData("LastLogins", logins);
                        this.cbx_login.dataProvider = logins;
                        this.cbx_login.selectedIndex = 0;
                    }
                    else
                    {
                        if (target.name.indexOf("btn_article") != -1)
                        {
                            if (this._giftButtonsData[target.name].onCliqueUri)
                            {
                                this.sysApi.goToUrl(this._giftButtonsData[target.name].onCliqueUri);
                            }
                            else
                            {
                                this.modCommon.openPopup(this.uiApi.getText("ui.popup.loginAdsIGShop.title"), this.uiApi.getText("ui.popup.loginAdsIGShop.text"), [this.uiApi.getText("ui.common.ok")], []);
                            };
                        };
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            switch (target)
            {
                case this.btn_manualConnection:
                    tooltipText = this.uiApi.getText("ui.connection.connectionTypeManual");
                    break;
                case this.btn_serverConnection:
                    tooltipText = this.uiApi.getText("ui.connection.connectionTypeServer");
                    break;
                case this.btn_characterConnection:
                    tooltipText = this.uiApi.getText("ui.connection.connectionTypeCharacter");
                    break;
                case this.btn_rememberLogin:
                    tooltipText = this.uiApi.getText("ui.connection.rememberLogin.info");
                    break;
                default:
                    if (target.name.indexOf("btn_removeLogin") != -1)
                    {
                        tooltipText = this.uiApi.getText("ui.login.deleteLogin");
                        this.cbx_login.closeOnClick = false;
                    }
                    else
                    {
                        if (target.name.indexOf("btn_article") != -1)
                        {
                            tooltipText = this._giftButtonsData[target.name].name;
                        };
                    };
            };
            if (((tooltipText) && ((tooltipText.length > 1))))
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", 6, 1, 0, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
            if (target.name.indexOf("btn_removeLogin") != -1)
            {
                this.cbx_login.closeOnClick = true;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            switch (target)
            {
                case this.cb_socket:
                    this.sysApi.setPort(this._aPorts[this.cb_socket.selectedIndex]);
                    break;
                case this.cb_connectionType:
                    this.configApi.setConfigProperty("dofus", "autoConnectType", this.cb_connectionType.selectedItem.type);
                    break;
                case this.cbx_login:
                    if (selectMethod != GridItemSelectMethodEnum.AUTO)
                    {
                        this.lbl_login.text = "";
                    };
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (!(this.btn_play.disabled))
                    {
                        this.disableUi(true);
                        this.login();
                        return (true);
                    };
                    break;
            };
            return (false);
        }

        private function onNicknameRegistration():void
        {
            this.disableUi(true);
            this.uiApi.loadUi("pseudoChoice");
        }

        private function onUiUnloaded(name:String):void
        {
            if ((((name.indexOf("popup") == 0)) && (this._previousFocus)))
            {
                this._previousFocus.focus();
                this._previousFocus = null;
            };
        }

        private function onSubscribersList(giftsList:Object):void
        {
            this.ctr_gifts.visible = true;
            if (giftsList.length < 4)
            {
                this.gd_shop.x = ((this.tx_background.width / 2) - ((giftsList.length * (this.gd_shop.slotWidth + 25)) / 2));
            };
            this.gd_shop.dataProvider = giftsList;
        }

        public function onSelectedServerFailed():void
        {
            this.disableUi(false);
        }

        public function onChange(target:Object):void
        {
            if (target == this.input_pass)
            {
                if (((!((this.lbl_pass.text == ""))) && (!((this.input_pass.text == "")))))
                {
                    this.lbl_pass.text = "";
                };
                if ((((this.lbl_pass.text == "")) && ((this.input_pass.text == ""))))
                {
                    this.lbl_pass.text = this.uiApi.getText("ui.login.password");
                };
            };
            if (target == this.cbx_login.input)
            {
                if (((!((this.lbl_login.text == ""))) && (!((this.cbx_login.input.text == "")))))
                {
                    this.lbl_login.text = "";
                };
                if ((((this.lbl_login.text == "")) && ((this.cbx_login.input.text == ""))))
                {
                    this.lbl_login.text = this.uiApi.getText("ui.login.username");
                };
            };
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (keyCode == 9)
            {
                if (this.cbx_login.input.haveFocus)
                {
                    this.input_pass.focus();
                    this.input_pass.setSelection(0, this.input_pass.text.length);
                }
                else
                {
                    if (this.input_pass.haveFocus)
                    {
                        this.cbx_login.input.focus();
                        this.cbx_login.input.setSelection(0, this.cbx_login.input.text.length);
                    };
                };
            }
            else
            {
                if (keyCode == 20)
                {
                    if (Keyboard.capsLock)
                    {
                        this.tx_capsLockMsg.visible = true;
                        this.lbl_capsLock.visible = true;
                    }
                    else
                    {
                        this.tx_capsLockMsg.visible = false;
                        this.lbl_capsLock.visible = false;
                    };
                };
            };
        }


    }
}//package ui

