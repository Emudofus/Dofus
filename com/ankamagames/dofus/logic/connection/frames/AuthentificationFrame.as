package com.ankamagames.dofus.logic.connection.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import flash.system.LoaderContext;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.approach.managers.PartManagerV2;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.connection.managers.SpecialBetaAuthentification;
    import flash.events.Event;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
    import com.ankamagames.dofus.network.messages.connection.HelloConnectMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationSuccessMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationFailedForBadVersionMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationFailedBannedMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationFailedMessage;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameRegistrationMessage;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameRefusedMessage;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameAcceptedMessage;
    import com.ankamagames.dofus.logic.connection.actions.NicknameChoiceRequestAction;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameChoiceRequestMessage;
    import com.ankamagames.dofus.logic.game.approach.actions.SubscribersGiftListRequestAction;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.dofus.logic.game.approach.actions.NewsLoginRequestAction;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.utils.crypto.Signature;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.jerakine.utils.crypto.Base64;
    import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.dofus.Constants;
    import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.jerakine.network.ServerConnection;
    import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.network.messages.connection.IdentificationSuccessWithLoginTokenMessage;
    import com.ankamagames.dofus.logic.common.frames.AuthorizedFrame;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.utils.system.CommandLineArguments;
    import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
    import com.ankamagames.dofus.logic.connection.managers.StoreUserDataManager;
    import com.ankamagames.dofus.logic.common.frames.ChangeCharacterFrame;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
    import com.ankamagames.dofus.internalDatacenter.connection.SubscriberGift;

    public class AuthentificationFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationFrame));
        private static var _lastTicket:String;

        private var _loader:IResourceLoader;
        private var _contextLoader:LoaderContext;
        private var _dispatchModuleHook:Boolean;
        private var _connexionSequence:Array;
        private var commonMod:Object;
        private var _lastLoginHash:String;
        private var _lva:LoginValidationAction;
        private var _streamingBetaAccess:Boolean = false;

        public function AuthentificationFrame(dispatchModuleHook:Boolean=true)
        {
            this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            super();
            this._dispatchModuleHook = dispatchModuleHook;
            this._contextLoader = new LoaderContext();
            this._contextLoader.checkPolicyFile = true;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            var lengthTou:String;
            var newLengthTou:String;
            var files:Array;
            this.processInvokeArgs();
            if (this._dispatchModuleHook)
            {
                PartManagerV2.getInstance().init();
                if (!(AirScanner.isStreamingVersion()))
                {
                    lengthTou = OptionManager.getOptionManager("dofus")["legalAgreementTou"];
                    newLengthTou = ((XmlConfig.getInstance().getEntry("config.lang.current") + "#") + (I18n.getUiText("ui.legal.tou1") + I18n.getUiText("ui.legal.tou2")).length);
                    files = new Array();
                    if (lengthTou != newLengthTou)
                    {
                        files.push("tou");
                    };
                    if (files.length > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.AgreementsRequired, files);
                    };
                };
                KernelEventsManager.getInstance().processCallback(HookList.AuthentificationStart);
            };
            return (true);
        }

        private function onStreamingBetaAuthentification(e:Event):void
        {
            var _local_2:Object;
            if (SpecialBetaAuthentification(e.target).haveAccess)
            {
                goto _label_3;
                
            _label_1: 
                this.process(this._lva);
                //unresolved jump
                
            _label_2: 
                goto _label_1;
                
            _label_3: 
                this._streamingBetaAccess = true;
                goto _label_2;
                var _local_0 = this;
            }
            else
            {
                if (UiModuleManager.getInstance().isDevMode)
                {
                    goto _label_5;
                    
                _label_4: 
                    goto _label_7;
                    
                _label_5: 
                    UiModuleManager.getInstance().isDevMode = false;
                    goto _label_9;
                    
                _label_6: 
                    return;
                    
                _label_7: 
                    _local_2 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                    goto _label_13;
                };
                
            _label_8: 
                this._streamingBetaAccess = false;
                goto _label_11;
                
            _label_9: 
                this.process(this._lva);
                goto _label_6;
                var _local_4 = _local_4;
                goto _label_8;
                
            _label_10: 
                return;
                
            _label_11: 
                KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed, 0);
                goto _label_4;
                
            _label_12: 
                _local_2.openPopup(I18n.getUiText("ui.popup.information"), "You are trying to access to a private beta but your account is not allowed.", [I18n.getUiText("ui.common.ok")]);
                goto _label_10;
                return;
                
            _label_13: 
                goto _label_12;
            };
            return;
        }

        public function process(msg:Message):Boolean
        {
            var lva:LoginValidationAction;
            var connexionPorts:Array;
            var ports:String;
            var connectionHostsEntry:String;
            var connexionHosts:Array;
            var tmpHosts:Array;
            var dst:DataStoreType;
            var defaultPort:uint;
            var firstConnexionSequence:Array;
            var connInfo:Object;
            var scfMsg:ServerConnectionFailedMessage;
            var hcmsg:HelloConnectMessage;
            var iMsg:IdentificationMessage;
            var ismsg:IdentificationSuccessMessage;
            var updaterV2:Boolean;
            var iffbvmsg:IdentificationFailedForBadVersionMessage;
            var ifbmsg:IdentificationFailedBannedMessage;
            var ifmsg:IdentificationFailedMessage;
            var nrmsg:NicknameRegistrationMessage;
            var nrfmsg:NicknameRefusedMessage;
            var namsg:NicknameAcceptedMessage;
            var ncra:NicknameChoiceRequestAction;
            var ncrmsg:NicknameChoiceRequestMessage;
            var sglra:SubscribersGiftListRequestAction;
            var uri:Uri;
            var lang:String;
            var nlra:NewsLoginRequestAction;
            var uri2:Uri;
            var lang2:String;
            var sba:SpecialBetaAuthentification;
            var porc:String;
            var connectionHostsSignatureEntry:String;
            var output:ByteArray;
            var signedData:ByteArray;
            var signature:Signature;
            var validHosts:Boolean;
            var tmpHost:String;
            var randomHost:Object;
            var host:String;
            var port:uint;
            var rawParam:String;
            var params:Array;
            var tmp:Array;
            var param:String;
            var tmp2:Array;
            var formerPort:uint;
            var retryConnInfo:Object;
            var lengthModsTou:String;
            var newLengthModsTou:String;
            var files:Array;
            switch (true)
            {
                case (msg is LoginValidationAction):
                    lva = LoginValidationAction(msg);
                    if (this._lastLoginHash != MD5.hash(lva.username))
                    {
                        this._streamingBetaAccess = false;
                        UiModuleManager.getInstance().isDevMode = XmlConfig.getInstance().getEntry("config.dev.mode");
                    };
                    if ((((BuildInfos.BUILD_TYPE < BuildTypeEnum.TESTING)) && (((((AirScanner.isStreamingVersion()) && (!(this._streamingBetaAccess)))) || (((UiModuleManager.getInstance().isDevMode) && (!((this._lastLoginHash == MD5.hash(lva.username))))))))))
                    {
                        this._lastLoginHash = MD5.hash(lva.username);
                        this._lva = lva;
                        sba = new SpecialBetaAuthentification(lva.username, ((AirScanner.isStreamingVersion()) ? SpecialBetaAuthentification.STREAMING : SpecialBetaAuthentification.MODULES));
                        sba.addEventListener(Event.INIT, this.onStreamingBetaAuthentification);
                        return (true);
                    };
                    this._lastLoginHash = MD5.hash(lva.username);
                    connexionPorts = new Array();
                    ports = XmlConfig.getInstance().getEntry("config.connection.port");
                    for each (porc in ports.split(","))
                    {
                        connexionPorts.push(int(porc));
                    };
                    connectionHostsEntry = XmlConfig.getInstance().getEntry("config.connection.host");
                    if (BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
                    {
                        connectionHostsSignatureEntry = XmlConfig.getInstance().getEntry("config.connection.host.signature");
                        output = new ByteArray();
                        try
                        {
                            signedData = Base64.decodeToByteArray(connectionHostsSignatureEntry);
                        }
                        catch(error:Error)
                        {
                            _log.warn("Host signature has not been properly encoded in Base64.");
                            commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.popup.connectionFailed.unauthenticatedHost"), [I18n.getUiText("ui.common.ok")]);
                            KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
                            return (false);
                        };
                        signedData.position = signedData.length;
                        signedData.writeUTFBytes(connectionHostsEntry);
                        signedData.position = 0;
                        signature = new Signature(SignedFileAdapter.defaultSignatureKey);
                        validHosts = signature.verify(signedData, output);
                        if (!(validHosts))
                        {
                            _log.warn("Host signature could not be verified, connection refused.");
                            this.commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.popup.connectionFailed.unauthenticatedHost"), [I18n.getUiText("ui.common.ok")]);
                            KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
                            return (false);
                        };
                    };
                    connexionHosts = connectionHostsEntry.split(",");
                    tmpHosts = [];
                    for each (tmpHost in connexionHosts)
                    {
                        tmpHosts.push({
                            "host":tmpHost,
                            "random":Math.random()
                        });
                    };
                    tmpHosts.sortOn("random", Array.NUMERIC);
                    connexionHosts = [];
                    for each (randomHost in tmpHosts)
                    {
                        connexionHosts.push(randomHost.host);
                    };
                    dst = new DataStoreType("Dofus_ComputerOptions", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
                    defaultPort = uint(StoreDataManager.getInstance().getData(dst, "connectionPortDefault"));
                    this._connexionSequence = [];
                    firstConnexionSequence = [];
                    for each (host in connexionHosts)
                    {
                        for each (port in connexionPorts)
                        {
                            if (defaultPort == port)
                            {
                                firstConnexionSequence.push({
                                    "host":host,
                                    "port":port
                                });
                            }
                            else
                            {
                                this._connexionSequence.push({
                                    "host":host,
                                    "port":port
                                });
                            };
                        };
                    };
                    this._connexionSequence = firstConnexionSequence.concat(this._connexionSequence);
                    if (Constants.EVENT_MODE)
                    {
                        rawParam = Constants.EVENT_MODE_PARAM;
                        if (((rawParam) && (!((rawParam.charAt(0) == "!")))))
                        {
                            rawParam = Base64.decode(rawParam);
                            params = [];
                            tmp = rawParam.split(",");
                            for each (param in tmp)
                            {
                                tmp2 = param.split(":");
                                params[tmp2[0]] = tmp2[1];
                            };
                            if (params["login"])
                            {
                                trace("Attention, login pris depuis le fichier de config");
                                lva.username = params["login"];
                            };
                            if (params["password"])
                            {
                                trace("Attention, password pris depuis le fichier de config");
                                lva.password = params["password"];
                            };
                        };
                    };
                    AuthentificationManager.getInstance().setValidationAction(lva);
                    connInfo = this._connexionSequence.shift();
                    ConnectionsHandler.connectToLoginServer(connInfo.host, connInfo.port);
                    return (true);
                case (msg is ServerConnectionFailedMessage):
                    scfMsg = ServerConnectionFailedMessage(msg);
                    if (scfMsg.failedConnection == ConnectionsHandler.getConnection().getSubConnection(scfMsg))
                    {
                        PlayerManager.getInstance().destroy();
                        (ConnectionsHandler.getConnection().mainConnection as ServerConnection).stopConnectionTimeout();
                        formerPort = scfMsg.failedConnection.port;
                        if (this._connexionSequence)
                        {
                            retryConnInfo = this._connexionSequence.shift();
                            if (retryConnInfo)
                            {
                                ConnectionsHandler.connectToLoginServer(retryConnInfo.host, retryConnInfo.port);
                            }
                            else
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionFailed, DisconnectionReasonEnum.UNEXPECTED);
                            };
                        };
                    };
                    return (true);
                case (msg is HelloConnectMessage):
                    hcmsg = HelloConnectMessage(msg);
                    AuthentificationManager.getInstance().setPublicKey(hcmsg.key);
                    AuthentificationManager.getInstance().setSalt(hcmsg.salt);
                    iMsg = AuthentificationManager.getInstance().getIdentificationMessage();
                    _log.info(((((((((("Current version : " + iMsg.version.major) + ".") + iMsg.version.minor) + ".") + iMsg.version.release) + ".") + iMsg.version.revision) + ".") + iMsg.version.patch));
                    ConnectionsHandler.getConnection().send(iMsg);
                    KernelEventsManager.getInstance().processCallback(HookList.ConnectionTimerStart);
                    TimeManager.getInstance().reset();
                    return (true);
                case (msg is IdentificationSuccessMessage):
                    ismsg = IdentificationSuccessMessage(msg);
                    if ((ismsg is IdentificationSuccessWithLoginTokenMessage))
                    {
                        AuthentificationManager.getInstance().nextToken = IdentificationSuccessWithLoginTokenMessage(ismsg).loginToken;
                    };
                    if (ismsg.login)
                    {
                        AuthentificationManager.getInstance().username = ismsg.login;
                    };
                    PlayerManager.getInstance().accountId = ismsg.accountId;
                    PlayerManager.getInstance().communityId = ismsg.communityId;
                    PlayerManager.getInstance().hasRights = ismsg.hasRights;
                    PlayerManager.getInstance().nickname = ismsg.nickname;
                    PlayerManager.getInstance().subscriptionEndDate = ismsg.subscriptionEndDate;
                    PlayerManager.getInstance().secretQuestion = ismsg.secretQuestion;
                    PlayerManager.getInstance().accountCreation = ismsg.accountCreation;
                    try
                    {
                        _log.info((((((("Timestamp subscription end date : " + PlayerManager.getInstance().subscriptionEndDate) + " ( ") + TimeManager.getInstance().formatDateIRL(PlayerManager.getInstance().subscriptionEndDate, true)) + " ") + TimeManager.getInstance().formatClock(PlayerManager.getInstance().subscriptionEndDate, false, true)) + " )"));
                    }
                    catch(e:Error)
                    {
                    };
                    AuthorizedFrame(Kernel.getWorker().getFrame(AuthorizedFrame)).hasRights = ismsg.hasRights;
                    updaterV2 = (CommandLineArguments.getInstance().getArgument("updater_version") == "v2");
                    if ((((PlayerManager.getInstance().subscriptionEndDate > 0)) || (PlayerManager.getInstance().hasRights)))
                    {
                        if (updaterV2)
                        {
                            PartManagerV2.getInstance().activateComponent("all");
                            PartManagerV2.getInstance().activateComponent("subscribed");
                        }
                        else
                        {
                            PartManager.getInstance().checkAndDownload("all");
                            PartManager.getInstance().checkAndDownload("subscribed");
                        };
                    };
                    if (PlayerManager.getInstance().hasRights)
                    {
                        if (updaterV2)
                        {
                            PartManagerV2.getInstance().activateComponent("admin");
                        }
                        else
                        {
                            PartManager.getInstance().checkAndDownload("admin");
                        };
                        lengthModsTou = OptionManager.getOptionManager("dofus")["legalAgreementModsTou"];
                        newLengthModsTou = ((XmlConfig.getInstance().getEntry("config.lang.current") + "#") + I18n.getUiText("ui.legal.modstou").length);
                        files = new Array();
                        if (lengthModsTou != newLengthModsTou)
                        {
                            files.push("modstou");
                        };
                        if (files.length > 0)
                        {
                            PlayerManager.getInstance().allowAutoConnectCharacter = false;
                            KernelEventsManager.getInstance().processCallback(HookList.AgreementsRequired, files);
                        };
                    }
                    else
                    {
                        if (updaterV2)
                        {
                            if (PartManagerV2.getInstance().hasComponent("admin"))
                            {
                                PartManagerV2.getInstance().activateComponent("admin", false);
                            };
                        };
                    };
                    StoreUserDataManager.getInstance().savePlayerData();
                    Kernel.getWorker().removeFrame(this);
                    Kernel.getWorker().addFrame(new ChangeCharacterFrame());
                    Kernel.getWorker().addFrame(new ServerSelectionFrame());
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationSuccess, ((ismsg.login) ? ismsg.login : ""));
                    return (true);
                case (msg is IdentificationFailedForBadVersionMessage):
                    iffbvmsg = IdentificationFailedForBadVersionMessage(msg);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedForBadVersion, iffbvmsg.reason, iffbvmsg.requiredVersion);
                    if (!(this._dispatchModuleHook))
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    };
                    return (true);
                case (msg is IdentificationFailedBannedMessage):
                    ifbmsg = IdentificationFailedBannedMessage(msg);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedWithDuration, ifbmsg.reason, ifbmsg.banEndDate);
                    if (!(this._dispatchModuleHook))
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    };
                    return (true);
                case (msg is IdentificationFailedMessage):
                    ifmsg = IdentificationFailedMessage(msg);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed, ifmsg.reason);
                    if (!(this._dispatchModuleHook))
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    };
                    return (true);
                case (msg is NicknameRegistrationMessage):
                    nrmsg = NicknameRegistrationMessage(msg);
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameRegistration);
                    return (true);
                case (msg is NicknameRefusedMessage):
                    nrfmsg = NicknameRefusedMessage(msg);
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameRefused, nrfmsg.reason);
                    return (true);
                case (msg is NicknameAcceptedMessage):
                    namsg = NicknameAcceptedMessage(msg);
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameAccepted);
                    return (true);
                case (msg is NicknameChoiceRequestAction):
                    ncra = NicknameChoiceRequestAction(msg);
                    ncrmsg = new NicknameChoiceRequestMessage();
                    ncrmsg.initNicknameChoiceRequestMessage(ncra.nickname);
                    ConnectionsHandler.getConnection().send(ncrmsg);
                    return (true);
                case (msg is SubscribersGiftListRequestAction):
                    if (CommandLineArguments.getInstance().hasArgument("functional-test"))
                    {
                        return (true);
                    };
                    sglra = SubscribersGiftListRequestAction(msg);
                    lang = XmlConfig.getInstance().getEntry("config.lang.current");
                    if ((((((((((((((lang == "de")) || ((lang == "en")))) || ((lang == "es")))) || ((lang == "pt")))) || ((lang == "fr")))) || ((lang == "uk")))) || ((lang == "ru"))))
                    {
                        uri = new Uri((((XmlConfig.getInstance().getEntry("config.subscribersGift") + "subscriberGifts_") + lang) + ".xml"));
                    }
                    else
                    {
                        uri = new Uri((XmlConfig.getInstance().getEntry("config.subscribersGift") + "subscriberGifts_en.xml"));
                    };
                    uri.loaderContext = this._contextLoader;
                    this._loader.load(uri);
                    return (true);
                case (msg is NewsLoginRequestAction):
                    nlra = NewsLoginRequestAction(msg);
                    lang2 = XmlConfig.getInstance().getEntry("config.lang.current");
                    if ((((((((((((((((lang2 == "de")) || ((lang2 == "en")))) || ((lang2 == "es")))) || ((lang2 == "pt")))) || ((lang2 == "fr")))) || ((lang2 == "uk")))) || ((lang2 == "it")))) || ((lang2 == "ru"))))
                    {
                        uri2 = new Uri((((XmlConfig.getInstance().getEntry("config.loginNews") + "news_") + lang2) + ".xml"));
                    }
                    else
                    {
                        uri2 = new Uri((XmlConfig.getInstance().getEntry("config.loginNews") + "news_en.xml"));
                    };
                    uri2.loaderContext = this._contextLoader;
                    this._loader.load(uri2);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            Berilia.getInstance().unloadUi("Login");
            this._loader.removeEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            return (true);
        }

        private function processInvokeArgs():void
        {
            var value:String;
            var lvwta:LoginValidationWithTicketAction;
            if (CommandLineArguments.getInstance().hasArgument("ticket"))
            {
                while (true)
                {
                    value = CommandLineArguments.getInstance().getArgument("ticket");
                    goto _label_1;
                };
                var _local_0 = this;
                
            _label_1: 
                if (_lastTicket == value)
                {
                    return;
                    
                _label_2: 
                    _lastTicket = value;
                    goto _label_4;
                    
                _label_3: 
                    goto _label_2;
                    
                _label_4: 
                    lvwta = LoginValidationWithTicketAction.create(value, true);
                    goto _label_8;
                    
                _label_5: 
                    return;
                };
                
            _label_6: 
                _log.info("Use ticket from launch param's");
                goto _label_3;
                var _local_3 = _local_3;
                
            _label_7: 
                _local_0.process(lvwta);
                goto _label_5;
                goto _label_6;
                
            _label_8: 
                goto _label_7;
            };
            return;
        }

        private function onLoad(e:ResourceLoadedEvent):void
        {
            goto _label_3;
            goto _label_7;
            
        _label_1: 
            var news:XML;
            //unresolved jump
            var _local_0 = this;
            
        _label_2: 
            var id:uint;
            goto _label_1;
            var _local_5 = _local_5;
            
        _label_3: 
            var xml:XML;
            //unresolved jump
            
        _label_4: 
            var subGiftList:Array = new Array();
            _loop_1:
            for (;;)
            {
                var i:int;
                while (var gift:XML, true)
                {
                    var subGift:SubscriberGift;
                    continue _loop_1;
                };
                
            _label_5: 
                goto _label_4;
                
            _label_6: 
                var link:String;
                goto _label_2;
                goto _label_8;
                
            _label_7: 
                goto _label_5;
                var onLoad$0 = onLoad$0;
            };
            try
            {
                
            _label_8: 
                xml = e.resource;
                while ((var xmlString:String = xml.toXMLString()), true)
                {
                    //unresolved jump
                };
                var _local_6 = _local_6;
            }
            catch(error:Error)
            {
                while (_log.error((((("Cannot read xml " + e.uri) + "(") + error.message) + ")")), true)
                {
                    return;
                };
                var _local_4 = _local_4;
                return;
            };
            if (xmlString.substring(1, 17) == "subscribersGifts")
            {
                i = 0;
                for each (gift in xml..gift)
                {
                    //unresolved jump
                    
                _label_9: 
                    subGift = new SubscriberGift(i, gift.description, gift.uri, gift.link);
                    //unresolved jump
                    
                _label_10: 
                    i = (i + 1);
                    goto _label_9;
                    
                _label_11: 
                    subGiftList.push(subGift);
                };
                KernelEventsManager.getInstance().processCallback(HookList.SubscribersList, subGiftList);
            }
            else
            {
                if (xmlString.substring(1, 9) == "newsList")
                {
                    id = 0;
                    _loop_2:
                    for each (news in xml..news)
                    {
                        if (news.@id > id)
                        {
                            for (;;)
                            {
                                link = news.link;
                                //unresolved jump
                                var text:String = news.text;
                                continue;
                                
                            _label_12: 
                                continue _loop_2;
                                
                            _label_13: 
                                id = news.@id;
                                goto _label_12;
                            };
                            var _local_3 = _local_3;
                        };
                    };
                    while (KernelEventsManager.getInstance().processCallback(HookList.NewsLogin, text, link), true)
                    {
                        return;
                    };
                };
            };
            return;
        }

        private function onLoadError(e:ResourceErrorEvent):void
        {
            while (true)
            {
                _log.error((((("Cannot load xml " + e.uri) + "(") + e.errorMsg) + ")"));
                return;
            };
            var _local_0 = this;
            return;
        }


    }
}//package com.ankamagames.dofus.logic.connection.frames

