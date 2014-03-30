package com.ankamagames.dofus.logic.connection.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.system.LoaderContext;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManagerV2;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import flash.events.Event;
   import com.ankamagames.dofus.logic.connection.managers.SpecialBetaAuthentification;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.messages.Message;
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
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
   import com.ankamagames.dofus.internalDatacenter.connection.SubscriberGift;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class AuthentificationFrame extends Object implements Frame
   {
      
      public function AuthentificationFrame(dispatchModuleHook:Boolean=true) {
         this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         super();
         this._dispatchModuleHook = dispatchModuleHook;
         this._contextLoader = new LoaderContext();
         this._contextLoader.checkPolicyFile = true;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoad);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationFrame));
      
      private static var _lastTicket:String;
      
      private var _loader:IResourceLoader;
      
      private var _contextLoader:LoaderContext;
      
      private var _dispatchModuleHook:Boolean;
      
      private var _connexionSequence:Array;
      
      private var commonMod:Object;
      
      private var _lastLoginHash:String;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         var lengthTou:String = null;
         var newLengthTou:String = null;
         var files:Array = null;
         this.processInvokeArgs();
         if(this._dispatchModuleHook)
         {
            PartManagerV2.getInstance().init();
            if(!AirScanner.isStreamingVersion())
            {
               lengthTou = OptionManager.getOptionManager("dofus")["legalAgreementTou"];
               newLengthTou = XmlConfig.getInstance().getEntry("config.lang.current") + "#" + (I18n.getUiText("ui.legal.tou1") + I18n.getUiText("ui.legal.tou2")).length;
               files = new Array();
               if(lengthTou != newLengthTou)
               {
                  files.push("tou");
               }
               if(files.length > 0)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.AgreementsRequired,files);
               }
            }
            KernelEventsManager.getInstance().processCallback(HookList.AuthentificationStart);
         }
         return true;
      }
      
      private var _lva:LoginValidationAction;
      
      private var _streamingBetaAccess:Boolean = false;
      
      private function onStreamingBetaAuthentification(e:Event) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function process(msg:Message) : Boolean {
         var lva:LoginValidationAction = null;
         var connexionPorts:Array = null;
         var ports:String = null;
         var connectionHostsEntry:String = null;
         var connexionHosts:Array = null;
         var tmpHosts:Array = null;
         var dst:DataStoreType = null;
         var defaultPort:uint = 0;
         var firstConnexionSequence:Array = null;
         var connInfo:Object = null;
         var scfMsg:ServerConnectionFailedMessage = null;
         var hcmsg:HelloConnectMessage = null;
         var iMsg:IdentificationMessage = null;
         var ismsg:IdentificationSuccessMessage = null;
         var updaterV2:Boolean = false;
         var iffbvmsg:IdentificationFailedForBadVersionMessage = null;
         var ifbmsg:IdentificationFailedBannedMessage = null;
         var ifmsg:IdentificationFailedMessage = null;
         var nrmsg:NicknameRegistrationMessage = null;
         var nrfmsg:NicknameRefusedMessage = null;
         var namsg:NicknameAcceptedMessage = null;
         var ncra:NicknameChoiceRequestAction = null;
         var ncrmsg:NicknameChoiceRequestMessage = null;
         var sglra:SubscribersGiftListRequestAction = null;
         var uri:Uri = null;
         var lang:String = null;
         var nlra:NewsLoginRequestAction = null;
         var uri2:Uri = null;
         var lang2:String = null;
         var sba:SpecialBetaAuthentification = null;
         var porc:String = null;
         var connectionHostsSignatureEntry:String = null;
         var output:ByteArray = null;
         var signedData:ByteArray = null;
         var signature:Signature = null;
         var validHosts:Boolean = false;
         var tmpHost:String = null;
         var randomHost:Object = null;
         var host:String = null;
         var port:uint = 0;
         var rawParam:String = null;
         var params:Array = null;
         var tmp:Array = null;
         var param:String = null;
         var tmp2:Array = null;
         var formerPort:uint = 0;
         var retryConnInfo:Object = null;
         var lengthModsTou:String = null;
         var newLengthModsTou:String = null;
         var files:Array = null;
         switch(true)
         {
            case msg is LoginValidationAction:
               lva = LoginValidationAction(msg);
               if(this._lastLoginHash != MD5.hash(lva.username))
               {
                  this._streamingBetaAccess = false;
                  UiModuleManager.getInstance().isDevMode = XmlConfig.getInstance().getEntry("config.dev.mode");
               }
               if((BuildInfos.BUILD_TYPE < BuildTypeEnum.TESTING) && ((AirScanner.isStreamingVersion()) && (!this._streamingBetaAccess) || (UiModuleManager.getInstance().isDevMode) && (!(this._lastLoginHash == MD5.hash(lva.username)))))
               {
                  this._lastLoginHash = MD5.hash(lva.username);
                  this._lva = lva;
                  sba = new SpecialBetaAuthentification(lva.username,AirScanner.isStreamingVersion()?SpecialBetaAuthentification.STREAMING:SpecialBetaAuthentification.MODULES);
                  sba.addEventListener(Event.INIT,this.onStreamingBetaAuthentification);
                  return true;
               }
               this._lastLoginHash = MD5.hash(lva.username);
               connexionPorts = new Array();
               ports = XmlConfig.getInstance().getEntry("config.connection.port");
               for each (porc in ports.split(","))
               {
                  connexionPorts.push(int(porc));
               }
               connectionHostsEntry = XmlConfig.getInstance().getEntry("config.connection.host");
               if(BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
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
                     commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.popup.connectionFailed.unauthenticatedHost"),[I18n.getUiText("ui.common.ok")]);
                     KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
                     return false;
                  }
                  signedData.position = signedData.length;
                  signedData.writeUTFBytes(connectionHostsEntry);
                  signedData.position = 0;
                  signature = new Signature(SignedFileAdapter.defaultSignatureKey);
                  validHosts = signature.verify(signedData,output);
                  if(!validHosts)
                  {
                     _log.warn("Host signature could not be verified, connection refused.");
                     this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.popup.connectionFailed.unauthenticatedHost"),[I18n.getUiText("ui.common.ok")]);
                     KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
                     return false;
                  }
               }
               connexionHosts = connectionHostsEntry.split(",");
               tmpHosts = [];
               for each (tmpHost in connexionHosts)
               {
                  tmpHosts.push(
                     {
                        "host":tmpHost,
                        "random":Math.random()
                     });
               }
               tmpHosts.sortOn("random",Array.NUMERIC);
               connexionHosts = [];
               for each (randomHost in tmpHosts)
               {
                  connexionHosts.push(randomHost.host);
               }
               dst = new DataStoreType("Dofus_ComputerOptions",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
               defaultPort = uint(StoreDataManager.getInstance().getData(dst,"connectionPortDefault"));
               this._connexionSequence = [];
               firstConnexionSequence = [];
               for each (host in connexionHosts)
               {
                  for each (port in connexionPorts)
                  {
                     if(defaultPort == port)
                     {
                        firstConnexionSequence.push(
                           {
                              "host":host,
                              "port":port
                           });
                     }
                     else
                     {
                        this._connexionSequence.push(
                           {
                              "host":host,
                              "port":port
                           });
                     }
                  }
               }
               this._connexionSequence = firstConnexionSequence.concat(this._connexionSequence);
               if(Constants.EVENT_MODE)
               {
                  rawParam = Constants.EVENT_MODE_PARAM;
                  if((rawParam) && (!(rawParam.charAt(0) == "!")))
                  {
                     rawParam = Base64.decode(rawParam);
                     params = [];
                     tmp = rawParam.split(",");
                     for each (param in tmp)
                     {
                        tmp2 = param.split(":");
                        params[tmp2[0]] = tmp2[1];
                     }
                     if(params["login"])
                     {
                        trace("Attention, login pris depuis le fichier de config");
                        lva.username = params["login"];
                     }
                     if(params["password"])
                     {
                        trace("Attention, password pris depuis le fichier de config");
                        lva.password = params["password"];
                     }
                  }
               }
               AuthentificationManager.getInstance().setValidationAction(lva);
               connInfo = this._connexionSequence.shift();
               ConnectionsHandler.connectToLoginServer(connInfo.host,connInfo.port);
               return true;
            case msg is ServerConnectionFailedMessage:
               scfMsg = ServerConnectionFailedMessage(msg);
               if(scfMsg.failedConnection == ConnectionsHandler.getConnection().getSubConnection(scfMsg))
               {
                  PlayerManager.getInstance().destroy();
                  (ConnectionsHandler.getConnection().mainConnection as ServerConnection).stopConnectionTimeout();
                  formerPort = scfMsg.failedConnection.port;
                  if(this._connexionSequence)
                  {
                     retryConnInfo = this._connexionSequence.shift();
                     if(retryConnInfo)
                     {
                        ConnectionsHandler.connectToLoginServer(retryConnInfo.host,retryConnInfo.port);
                     }
                     else
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionFailed,DisconnectionReasonEnum.UNEXPECTED);
                     }
                  }
               }
               return true;
            case msg is HelloConnectMessage:
               hcmsg = HelloConnectMessage(msg);
               AuthentificationManager.getInstance().setPublicKey(hcmsg.key);
               AuthentificationManager.getInstance().setSalt(hcmsg.salt);
               iMsg = AuthentificationManager.getInstance().getIdentificationMessage();
               _log.info("Current version : " + iMsg.version.major + "." + iMsg.version.minor + "." + iMsg.version.release + "." + iMsg.version.revision + "." + iMsg.version.patch);
               ConnectionsHandler.getConnection().send(iMsg);
               KernelEventsManager.getInstance().processCallback(HookList.ConnectionTimerStart);
               TimeManager.getInstance().reset();
               return true;
            case msg is IdentificationSuccessMessage:
               ismsg = IdentificationSuccessMessage(msg);
               if(ismsg is IdentificationSuccessWithLoginTokenMessage)
               {
                  AuthentificationManager.getInstance().nextToken = IdentificationSuccessWithLoginTokenMessage(ismsg).loginToken;
               }
               if(ismsg.login)
               {
                  AuthentificationManager.getInstance().username = ismsg.login;
               }
               PlayerManager.getInstance().accountId = ismsg.accountId;
               PlayerManager.getInstance().communityId = ismsg.communityId;
               PlayerManager.getInstance().hasRights = ismsg.hasRights;
               PlayerManager.getInstance().nickname = ismsg.nickname;
               PlayerManager.getInstance().subscriptionEndDate = ismsg.subscriptionEndDate;
               PlayerManager.getInstance().secretQuestion = ismsg.secretQuestion;
               PlayerManager.getInstance().accountCreation = ismsg.accountCreation;
               try
               {
                  _log.info("Timestamp subscription end date : " + PlayerManager.getInstance().subscriptionEndDate + " ( " + TimeManager.getInstance().formatDateIRL(PlayerManager.getInstance().subscriptionEndDate,true) + " " + TimeManager.getInstance().formatClock(PlayerManager.getInstance().subscriptionEndDate,false,true) + " )");
               }
               catch(e:Error)
               {
               }
               AuthorizedFrame(Kernel.getWorker().getFrame(AuthorizedFrame)).hasRights = ismsg.hasRights;
               updaterV2 = CommandLineArguments.getInstance().getArgument("updater_version") == "v2";
               if((PlayerManager.getInstance().subscriptionEndDate > 0) || (PlayerManager.getInstance().hasRights))
               {
                  if(updaterV2)
                  {
                     PartManagerV2.getInstance().activateComponent("all");
                     PartManagerV2.getInstance().activateComponent("subscribed");
                  }
                  else
                  {
                     PartManager.getInstance().checkAndDownload("all");
                     PartManager.getInstance().checkAndDownload("subscribed");
                  }
               }
               if(PlayerManager.getInstance().hasRights)
               {
                  if(updaterV2)
                  {
                     PartManagerV2.getInstance().activateComponent("admin");
                  }
                  else
                  {
                     PartManager.getInstance().checkAndDownload("admin");
                  }
                  lengthModsTou = OptionManager.getOptionManager("dofus")["legalAgreementModsTou"];
                  newLengthModsTou = XmlConfig.getInstance().getEntry("config.lang.current") + "#" + I18n.getUiText("ui.legal.modstou").length;
                  files = new Array();
                  if(lengthModsTou != newLengthModsTou)
                  {
                     files.push("modstou");
                  }
                  if(files.length > 0)
                  {
                     PlayerManager.getInstance().allowAutoConnectCharacter = false;
                     KernelEventsManager.getInstance().processCallback(HookList.AgreementsRequired,files);
                  }
               }
               else
               {
                  if(updaterV2)
                  {
                     if(PartManagerV2.getInstance().hasComponent("admin"))
                     {
                        PartManagerV2.getInstance().activateComponent("admin",false);
                     }
                  }
               }
               StoreUserDataManager.getInstance().savePlayerData();
               Kernel.getWorker().removeFrame(this);
               Kernel.getWorker().addFrame(new ChangeCharacterFrame());
               Kernel.getWorker().addFrame(new ServerSelectionFrame());
               KernelEventsManager.getInstance().processCallback(HookList.IdentificationSuccess,ismsg.login?ismsg.login:"");
               return true;
            case msg is IdentificationFailedForBadVersionMessage:
               iffbvmsg = IdentificationFailedForBadVersionMessage(msg);
               PlayerManager.getInstance().destroy();
               ConnectionsHandler.closeConnection();
               KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedForBadVersion,iffbvmsg.reason,iffbvmsg.requiredVersion);
               if(!this._dispatchModuleHook)
               {
                  this._dispatchModuleHook = true;
                  this.pushed();
               }
               return true;
            case msg is IdentificationFailedBannedMessage:
               ifbmsg = IdentificationFailedBannedMessage(msg);
               PlayerManager.getInstance().destroy();
               ConnectionsHandler.closeConnection();
               KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedWithDuration,ifbmsg.reason,ifbmsg.banEndDate);
               if(!this._dispatchModuleHook)
               {
                  this._dispatchModuleHook = true;
                  this.pushed();
               }
               return true;
            case msg is IdentificationFailedMessage:
               ifmsg = IdentificationFailedMessage(msg);
               PlayerManager.getInstance().destroy();
               ConnectionsHandler.closeConnection();
               KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed,ifmsg.reason);
               if(!this._dispatchModuleHook)
               {
                  this._dispatchModuleHook = true;
                  this.pushed();
               }
               return true;
            case msg is NicknameRegistrationMessage:
               nrmsg = NicknameRegistrationMessage(msg);
               KernelEventsManager.getInstance().processCallback(HookList.NicknameRegistration);
               return true;
            case msg is NicknameRefusedMessage:
               nrfmsg = NicknameRefusedMessage(msg);
               KernelEventsManager.getInstance().processCallback(HookList.NicknameRefused,nrfmsg.reason);
               return true;
            case msg is NicknameAcceptedMessage:
               namsg = NicknameAcceptedMessage(msg);
               KernelEventsManager.getInstance().processCallback(HookList.NicknameAccepted);
               return true;
            case msg is NicknameChoiceRequestAction:
               ncra = NicknameChoiceRequestAction(msg);
               ncrmsg = new NicknameChoiceRequestMessage();
               ncrmsg.initNicknameChoiceRequestMessage(ncra.nickname);
               ConnectionsHandler.getConnection().send(ncrmsg);
               return true;
            case msg is SubscribersGiftListRequestAction:
               if(CommandLineArguments.getInstance().hasArgument("functional-test"))
               {
                  return true;
               }
               sglra = SubscribersGiftListRequestAction(msg);
               lang = XmlConfig.getInstance().getEntry("config.lang.current");
               if((lang == "de") || (lang == "en") || (lang == "es") || (lang == "pt") || (lang == "fr") || (lang == "uk") || (lang == "ru"))
               {
                  uri = new Uri(XmlConfig.getInstance().getEntry("config.subscribersGift") + "subscriberGifts_" + lang + ".xml");
               }
               else
               {
                  uri = new Uri(XmlConfig.getInstance().getEntry("config.subscribersGift") + "subscriberGifts_en.xml");
               }
               uri.loaderContext = this._contextLoader;
               this._loader.load(uri);
               return true;
            case msg is NewsLoginRequestAction:
               nlra = NewsLoginRequestAction(msg);
               lang2 = XmlConfig.getInstance().getEntry("config.lang.current");
               if((lang2 == "de") || (lang2 == "en") || (lang2 == "es") || (lang2 == "pt") || (lang2 == "fr") || (lang2 == "uk") || (lang2 == "it") || (lang2 == "ru"))
               {
                  uri2 = new Uri(XmlConfig.getInstance().getEntry("config.loginNews") + "news_" + lang2 + ".xml");
               }
               else
               {
                  uri2 = new Uri(XmlConfig.getInstance().getEntry("config.loginNews") + "news_en.xml");
               }
               uri2.loaderContext = this._contextLoader;
               this._loader.load(uri2);
               return true;
         }
      }
      
      public function pulled() : Boolean {
         Berilia.getInstance().unloadUi("Login");
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoad);
         return true;
      }
      
      private function processInvokeArgs() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onLoad(e:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
