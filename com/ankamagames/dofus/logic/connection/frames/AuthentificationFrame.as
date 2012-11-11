package com.ankamagames.dofus.logic.connection.frames
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.internalDatacenter.connection.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.connection.actions.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.logic.game.approach.actions.*;
    import com.ankamagames.dofus.logic.game.approach.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.connection.*;
    import com.ankamagames.dofus.network.messages.connection.register.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.messages.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class AuthentificationFrame extends Object implements Frame
    {
        private var _loader:IResourceLoader;
        private var _contextLoader:LoaderContext;
        private var _dispatchModuleHook:Boolean;
        private var _connexionSequence:Array;
        private var commonMod:Object;
        private var _lva:LoginValidationAction;
        private var _streamingBetaAccess:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationFrame));
        private static var _lastTicket:String;

        public function AuthentificationFrame(param1:Boolean = true)
        {
            this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            this._dispatchModuleHook = param1;
            this._contextLoader = new LoaderContext();
            this._contextLoader.checkPolicyFile = true;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.processInvokeArgs();
            if (this._dispatchModuleHook)
            {
                _loc_1 = OptionManager.getOptionManager("dofus")["legalAgreementEula"];
                _loc_2 = OptionManager.getOptionManager("dofus")["legalAgreementTou"];
                _loc_3 = XmlConfig.getInstance().getEntry("config.lang.current") + "#" + I18n.getUiText("ui.legal.eula").length;
                _loc_4 = XmlConfig.getInstance().getEntry("config.lang.current") + "#" + (I18n.getUiText("ui.legal.tou1") + I18n.getUiText("ui.legal.tou2")).length;
                _loc_5 = new Array();
                if (_loc_1 != _loc_3)
                {
                    _loc_5.push("eula");
                }
                if (_loc_2 != _loc_4)
                {
                    _loc_5.push("tou");
                }
                if (_loc_5.length > 0)
                {
                    KernelEventsManager.getInstance().processCallback(HookList.AgreementsRequired, _loc_5);
                }
                KernelEventsManager.getInstance().processCallback(HookList.AuthentificationStart);
            }
            return true;
        }// end function

        private function onStreamingBetaAuthentification(event:Event) : void
        {
            var _loc_2:* = null;
            if (StreamingBetaAuthentification(event.target).haveAccess)
            {
                this._streamingBetaAccess = true;
                this.process(this._lva);
            }
            else
            {
                _log.fatal("Pas de droits, pas de chocolat");
                this._streamingBetaAccess = false;
                KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed, 0);
                _loc_2 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                _loc_2.openPopup(I18n.getUiText("ui.popup.information"), "You are trying to access to a private beta but your account is not allowed.If you wish have an access, please contact Ankama.", [I18n.getUiText("ui.common.ok")]);
            }
            return;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = 0;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = null;
            var _loc_40:* = 0;
            var _loc_41:* = null;
            switch(true)
            {
                case param1 is LoginValidationAction:
                {
                    _loc_2 = LoginValidationAction(param1);
                    _loc_3 = BuildInfos.BUILD_TYPE;
                    if (BuildInfos.BUILD_TYPE < BuildTypeEnum.TESTING && AirScanner.isStreamingVersion() && !this._streamingBetaAccess)
                    {
                        this._lva = _loc_2;
                        _loc_29 = new StreamingBetaAuthentification(_loc_2.username);
                        _loc_29.addEventListener(Event.INIT, this.onStreamingBetaAuthentification);
                        return true;
                    }
                    _loc_4 = new Array();
                    _loc_5 = XmlConfig.getInstance().getEntry("config.connection.port");
                    for each (_loc_30 in _loc_5.split(","))
                    {
                        
                        _loc_4.push(int(_loc_30));
                    }
                    _loc_6 = XmlConfig.getInstance().getEntry("config.connection.host").split(",");
                    _loc_7 = [];
                    for each (_loc_31 in _loc_6)
                    {
                        
                        _loc_7.push({host:_loc_31, random:Math.random()});
                    }
                    _loc_7.sortOn("random", Array.NUMERIC);
                    _loc_6 = [];
                    for each (_loc_32 in _loc_7)
                    {
                        
                        _loc_6.push(_loc_32.host);
                    }
                    _loc_8 = new DataStoreType("Dofus_ComputerOptions", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
                    _loc_9 = uint(StoreDataManager.getInstance().getData(_loc_8, "connectionPortDefault"));
                    this._connexionSequence = [];
                    _loc_10 = [];
                    for each (_loc_33 in _loc_6)
                    {
                        
                        for each (_loc_34 in _loc_4)
                        {
                            
                            if (_loc_9 == _loc_34)
                            {
                                _loc_10.push({host:_loc_33, port:_loc_34});
                                continue;
                            }
                            this._connexionSequence.push({host:_loc_33, port:_loc_34});
                        }
                    }
                    this._connexionSequence = _loc_10.concat(this._connexionSequence);
                    if (Constants.EVENT_MODE)
                    {
                        _loc_35 = Constants.EVENT_MODE_PARAM;
                        if (_loc_35 && _loc_35.charAt(0) != "!")
                        {
                            _loc_35 = Base64.decode(_loc_35);
                            _loc_36 = [];
                            _loc_37 = _loc_35.split(",");
                            for each (_loc_38 in _loc_37)
                            {
                                
                                _loc_39 = _loc_38.split(":");
                                _loc_36[_loc_39[0]] = _loc_39[1];
                            }
                            if (_loc_36["login"])
                            {
                                _loc_2.username = _loc_36["login"];
                            }
                            if (_loc_36["password"])
                            {
                                _loc_2.password = _loc_36["password"];
                            }
                        }
                    }
                    AuthentificationManager.getInstance().setValidationAction(_loc_2);
                    _loc_11 = this._connexionSequence.shift();
                    ConnectionsHandler.connectToLoginServer(_loc_11.host, _loc_11.port);
                    return true;
                }
                case param1 is ServerConnectionFailedMessage:
                {
                    _loc_12 = ServerConnectionFailedMessage(param1);
                    if (_loc_12.failedConnection == ConnectionsHandler.getConnection())
                    {
                        PlayerManager.getInstance().destroy();
                        (ConnectionsHandler.getConnection() as ServerConnection).stopConnectionTimeout();
                        _loc_40 = _loc_12.failedConnection.port;
                        if (this._connexionSequence)
                        {
                            _loc_41 = this._connexionSequence.shift();
                            if (_loc_41)
                            {
                                ConnectionsHandler.connectToLoginServer(_loc_41.host, _loc_41.port);
                            }
                            else
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionFailed, DisconnectionReasonEnum.UNEXPECTED);
                            }
                        }
                    }
                    return true;
                }
                case param1 is HelloConnectMessage:
                {
                    _loc_13 = HelloConnectMessage(param1);
                    AuthentificationManager.getInstance().setPublicKey(_loc_13.key);
                    AuthentificationManager.getInstance().setSalt(_loc_13.salt);
                    ConnectionsHandler.getConnection().send(AuthentificationManager.getInstance().getIdentificationMessage());
                    KernelEventsManager.getInstance().processCallback(HookList.ConnectionTimerStart);
                    TimeManager.getInstance().reset();
                    return true;
                }
                case param1 is IdentificationSuccessMessage:
                {
                    _loc_14 = IdentificationSuccessMessage(param1);
                    if (_loc_14 is IdentificationSuccessWithLoginTokenMessage)
                    {
                        AuthentificationManager.getInstance().nextToken = IdentificationSuccessWithLoginTokenMessage(_loc_14).loginToken;
                    }
                    if (_loc_14.login)
                    {
                        AuthentificationManager.getInstance().username = _loc_14.login;
                    }
                    PlayerManager.getInstance().accountId = _loc_14.accountId;
                    PlayerManager.getInstance().communityId = _loc_14.communityId;
                    PlayerManager.getInstance().hasRights = _loc_14.hasRights;
                    PlayerManager.getInstance().nickname = _loc_14.nickname;
                    PlayerManager.getInstance().subscriptionEndDate = _loc_14.subscriptionEndDate;
                    PlayerManager.getInstance().secretQuestion = _loc_14.secretQuestion;
                    PlayerManager.getInstance().accountCreation = _loc_14.accountCreation;
                    AuthorizedFrame(Kernel.getWorker().getFrame(AuthorizedFrame)).hasRights = _loc_14.hasRights;
                    if (PlayerManager.getInstance().subscriptionEndDate > 0 || PlayerManager.getInstance().hasRights)
                    {
                        PartManager.getInstance().checkAndDownload("all");
                        PartManager.getInstance().checkAndDownload("subscribed");
                    }
                    if (PlayerManager.getInstance().hasRights)
                    {
                        PartManager.getInstance().checkAndDownload("admin");
                    }
                    StoreUserDataManager.getInstance().savePlayerData();
                    Kernel.getWorker().removeFrame(this);
                    Kernel.getWorker().addFrame(new ChangeCharacterFrame());
                    Kernel.getWorker().addFrame(new ServerSelectionFrame());
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationSuccess);
                    return true;
                }
                case param1 is IdentificationFailedForBadVersionMessage:
                {
                    _loc_15 = IdentificationFailedForBadVersionMessage(param1);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedForBadVersion, _loc_15.reason, _loc_15.requiredVersion);
                    if (!this._dispatchModuleHook)
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    }
                    return true;
                }
                case param1 is IdentificationFailedBannedMessage:
                {
                    _loc_16 = IdentificationFailedBannedMessage(param1);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedWithDuration, _loc_16.reason, _loc_16.banEndDate);
                    if (!this._dispatchModuleHook)
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    }
                    return true;
                }
                case param1 is IdentificationFailedMessage:
                {
                    _loc_17 = IdentificationFailedMessage(param1);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed, _loc_17.reason);
                    if (!this._dispatchModuleHook)
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    }
                    return true;
                }
                case param1 is NicknameRegistrationMessage:
                {
                    _loc_18 = NicknameRegistrationMessage(param1);
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameRegistration);
                    return true;
                }
                case param1 is NicknameRefusedMessage:
                {
                    _loc_19 = NicknameRefusedMessage(param1);
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameRefused, _loc_19.reason);
                    return true;
                }
                case param1 is NicknameAcceptedMessage:
                {
                    _loc_20 = NicknameAcceptedMessage(param1);
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameAccepted);
                    return true;
                }
                case param1 is NicknameChoiceRequestAction:
                {
                    _loc_21 = NicknameChoiceRequestAction(param1);
                    _loc_22 = new NicknameChoiceRequestMessage();
                    _loc_22.initNicknameChoiceRequestMessage(_loc_21.nickname);
                    ConnectionsHandler.getConnection().send(_loc_22);
                    return true;
                }
                case param1 is SubscribersGiftListRequestAction:
                {
                    _loc_23 = SubscribersGiftListRequestAction(param1);
                    _loc_25 = XmlConfig.getInstance().getEntry("config.lang.current");
                    if (_loc_25 == "de" || _loc_25 == "en" || _loc_25 == "es" || _loc_25 == "pt" || _loc_25 == "fr" || _loc_25 == "uk" || _loc_25 == "ru")
                    {
                        _loc_24 = new Uri(XmlConfig.getInstance().getEntry("config.subscribersGift") + "subscriberGifts_" + _loc_25 + ".xml");
                    }
                    else
                    {
                        _loc_24 = new Uri(XmlConfig.getInstance().getEntry("config.subscribersGift") + "subscriberGifts_en.xml");
                    }
                    _loc_24.loaderContext = this._contextLoader;
                    this._loader.load(_loc_24);
                    return true;
                }
                case param1 is NewsLoginRequestAction:
                {
                    _loc_26 = NewsLoginRequestAction(param1);
                    _loc_28 = XmlConfig.getInstance().getEntry("config.lang.current");
                    if (_loc_28 == "de" || _loc_28 == "en" || _loc_28 == "es" || _loc_28 == "pt" || _loc_28 == "fr" || _loc_28 == "uk" || _loc_28 == "it" || _loc_28 == "ru")
                    {
                        _loc_27 = new Uri(XmlConfig.getInstance().getEntry("config.loginNews") + "news_" + _loc_28 + ".xml");
                    }
                    else
                    {
                        _loc_27 = new Uri(XmlConfig.getInstance().getEntry("config.loginNews") + "news_en.xml");
                    }
                    _loc_27.loaderContext = this._contextLoader;
                    this._loader.load(_loc_27);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            Berilia.getInstance().unloadUi("Login");
            this._loader.removeEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            return true;
        }// end function

        private function processInvokeArgs() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            _log.error("Parse launch param\'s");
            for each (_loc_3 in Dofus.getInstance().invokeArgs)
            {
                
                if (_loc_3.charAt(0) == "-")
                {
                    _loc_3 = _loc_3.substr(1);
                }
                _loc_2 = _loc_3.indexOf("=");
                if (_loc_2 == -1)
                {
                    _loc_1 = null;
                }
                else
                {
                    _loc_1 = _loc_3.substr((_loc_2 + 1));
                    _loc_3 = _loc_3.substr(0, _loc_2);
                }
                _log.trace("Param [" + _loc_3 + "] = [" + _loc_1 + "]");
                switch(_loc_3)
                {
                    case "ticket":
                    {
                        if (_lastTicket == _loc_1)
                        {
                            break;
                        }
                        _lastTicket = _loc_1;
                        _loc_4 = LoginValidationWithTicketAction.create(_loc_1, true);
                        this.process(_loc_4);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function onLoad(event:ResourceLoadedEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = event.resource;
            var _loc_4:* = _loc_3.toXMLString();
            if (_loc_3.toXMLString().substring(1, 17) == "subscribersGifts")
            {
                _loc_5 = 0;
                for each (_loc_6 in _loc_3..gift)
                {
                    
                    _loc_5++;
                    _loc_7 = new SubscriberGift(_loc_5, _loc_6.description, _loc_6.uri, _loc_6.link);
                    _loc_2.push(_loc_7);
                }
                KernelEventsManager.getInstance().processCallback(HookList.SubscribersList, _loc_2);
            }
            else if (_loc_4.substring(1, 9) == "newsList")
            {
                _loc_10 = 0;
                for each (_loc_11 in _loc_3..news)
                {
                    
                    if (_loc_11.@id > _loc_10)
                    {
                        _loc_8 = _loc_11.text;
                        _loc_9 = _loc_11.link;
                        _loc_10 = _loc_11.@id;
                    }
                }
                KernelEventsManager.getInstance().processCallback(HookList.NewsLogin, _loc_8, _loc_9);
            }
            return;
        }// end function

        private function onLoadError(event:ResourceErrorEvent) : void
        {
            _log.error("Cannot load xml " + event.uri + "(" + event.errorMsg + ")");
            return;
        }// end function

    }
}
