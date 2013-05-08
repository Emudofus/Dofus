package com.ankamagames.dofus.logic.connection.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.system.LoaderContext;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.misc.Chrono;
   import com.ankamagames.dofus.datacenter.items.Item;
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
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.network.ServerConnection;
   import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.messages.connection.IdentificationSuccessWithLoginTokenMessage;
   import com.ankamagames.dofus.logic.common.frames.AuthorizedFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
   import com.ankamagames.dofus.logic.connection.managers.StoreUserDataManager;
   import com.ankamagames.dofus.logic.common.frames.ChangeCharacterFrame;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import com.ankamagames.dofus.internalDatacenter.connection.SubscriberGift;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;


   public class AuthentificationFrame extends Object implements Frame
   {
         

      public function AuthentificationFrame(dispatchModuleHook:Boolean=true) {
         this.commonMod=UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         super();
         this._dispatchModuleHook=dispatchModuleHook;
         this._contextLoader=new LoaderContext();
         this._contextLoader.checkPolicyFile=true;
         this._loader=ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
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

      public function get priority() : int {
         return Priority.NORMAL;
      }

      private function test() : void {
         var _loc2_:* = true;
         var _loc3_:* = false;
         Chrono.start();
         var o:Array = Item.getItems();
         Chrono.stop();
         trace("ok");
      }

      public function pushed() : Boolean {
         var lengthEula:String = null;
         var lengthTou:String = null;
         var newLengthEula:String = null;
         var newLengthTou:String = null;
         var files:Array = null;
         this.test();
         this.processInvokeArgs();
         if(this._dispatchModuleHook)
         {
            if(!AirScanner.isStreamingVersion())
            {
               lengthEula=OptionManager.getOptionManager("dofus")["legalAgreementEula"];
               lengthTou=OptionManager.getOptionManager("dofus")["legalAgreementTou"];
               newLengthEula=XmlConfig.getInstance().getEntry("config.lang.current")+"#"+I18n.getUiText("ui.legal.eula").length;
               newLengthTou=XmlConfig.getInstance().getEntry("config.lang.current")+"#"+(I18n.getUiText("ui.legal.tou1")+I18n.getUiText("ui.legal.tou2")).length;
               files=new Array();
               if(lengthEula!=newLengthEula)
               {
                  files.push("eula");
               }
               if(lengthTou!=newLengthTou)
               {
                  files.push("tou");
               }
               if(files.length>0)
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
         var _loc3_:* = false;
         var _loc4_:* = true;
         var commonMod2:Object = null;
         if(SpecialBetaAuthentification(e.target).haveAccess)
         {
            this._streamingBetaAccess=true;
            this.process(this._lva);
         }
         else
         {
            _log.fatal("Pas de droits, pas de chocolat");
            this._streamingBetaAccess=false;
            KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed,0);
            commonMod2=UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            commonMod2.openPopup(I18n.getUiText("ui.popup.information"),"You are trying to access to a private beta but your account is not allowed.If you wish have an access, please contact Ankama.",[I18n.getUiText("ui.common.ok")]);
         }
      }

      public function process(msg:Message) : Boolean {
         var lva:LoginValidationAction = null;
         var connexionPorts:Array = null;
         var ports:String = null;
         var connexionHosts:Array = null;
         var tmpHosts:Array = null;
         var dst:DataStoreType = null;
         var defaultPort:uint = 0;
         var firstConnexionSequence:Array = null;
         var connInfo:Object = null;
         var scfMsg:ServerConnectionFailedMessage = null;
         var hcmsg:HelloConnectMessage = null;
         var ismsg:IdentificationSuccessMessage = null;
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
               lva=LoginValidationAction(msg);
               if((BuildInfos.BUILD_TYPE>BuildTypeEnum.TESTING)&&((AirScanner.isStreamingVersion())||(XmlConfig.getInstance().getEntry("config.dev.mode")))&&(!this._streamingBetaAccess))
               {
                  this._lva=lva;
                  sba=new SpecialBetaAuthentification(lva.username,AirScanner.isStreamingVersion()?SpecialBetaAuthentification.STREAMING:SpecialBetaAuthentification.MODULES);
                  sba.addEventListener(Event.INIT,this.onStreamingBetaAuthentification);
                  return true;
               }
               connexionPorts=new Array();
               ports=XmlConfig.getInstance().getEntry("config.connection.port");
               for each (porc in ports.split(","))
               {
                  connexionPorts.push(int(porc));
               }
               connexionHosts=String(XmlConfig.getInstance().getEntry("config.connection.host")).split(",");
               tmpHosts=[];
               for each (tmpHost in connexionHosts)
               {
                  tmpHosts.push(
                     {
                        host:tmpHost,
                        random:Math.random()
                     }
                  );
               }
               tmpHosts.sortOn("random",Array.NUMERIC);
               connexionHosts=[];
               for each (randomHost in tmpHosts)
               {
                  connexionHosts.push(randomHost.host);
               }
               dst=new DataStoreType("Dofus_ComputerOptions",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
               defaultPort=uint(StoreDataManager.getInstance().getData(dst,"connectionPortDefault"));
               this._connexionSequence=[];
               firstConnexionSequence=[];
               for each (host in connexionHosts)
               {
                  for each (port in connexionPorts)
                  {
                     if(defaultPort==port)
                     {
                        firstConnexionSequence.push(
                           {
                              host:host,
                              port:port
                           }
                        );
                     }
                     else
                     {
                        this._connexionSequence.push(
                           {
                              host:host,
                              port:port
                           }
                        );
                     }
                  }
               }
               this._connexionSequence=firstConnexionSequence.concat(this._connexionSequence);
               if(Constants.EVENT_MODE)
               {
                  rawParam=Constants.EVENT_MODE_PARAM;
                  if((rawParam)&&(!(rawParam.charAt(0)=="!")))
                  {
                     rawParam=Base64.decode(rawParam);
                     params=[];
                     tmp=rawParam.split(",");
                     for each (param in tmp)
                     {
                        tmp2=param.split(":");
                        params[tmp2[0]]=tmp2[1];
                     }
                     if(params["login"])
                     {
                        trace("Attention, login pris depuis le fichier de config");
                        lva.username=params["login"];
                     }
                     if(params["password"])
                     {
                        trace("Attention, password pris depuis le fichier de config");
                        lva.password=params["password"];
                     }
                  }
               }
               AuthentificationManager.getInstance().setValidationAction(lva);
               connInfo=this._connexionSequence.shift();
               ConnectionsHandler.connectToLoginServer(connInfo.host,connInfo.port);
               return true;
            case msg is ServerConnectionFailedMessage:
               scfMsg=ServerConnectionFailedMessage(msg);
               if(scfMsg.failedConnection==ConnectionsHandler.getConnection())
               {
                  PlayerManager.getInstance().destroy();
                  (ConnectionsHandler.getConnection() as ServerConnection).stopConnectionTimeout();
                  formerPort=scfMsg.failedConnection.port;
                  if(this._connexionSequence)
                  {
                     retryConnInfo=this._connexionSequence.shift();
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
               hcmsg=HelloConnectMessage(msg);
               AuthentificationManager.getInstance().setPublicKey(hcmsg.key);
               AuthentificationManager.getInstance().setSalt(hcmsg.salt);
               ConnectionsHandler.getConnection().send(AuthentificationManager.getInstance().getIdentificationMessage());
               KernelEventsManager.getInstance().processCallback(HookList.ConnectionTimerStart);
               TimeManager.getInstance().reset();
               return true;
            case msg is IdentificationSuccessMessage:
               ismsg=IdentificationSuccessMessage(msg);
               if(ismsg is IdentificationSuccessWithLoginTokenMessage)
               {
                  AuthentificationManager.getInstance().nextToken=IdentificationSuccessWithLoginTokenMessage(ismsg).loginToken;
               }
               if(ismsg.login)
               {
                  AuthentificationManager.getInstance().username=ismsg.login;
               }
               PlayerManager.getInstance().accountId=ismsg.accountId;
               PlayerManager.getInstance().communityId=ismsg.communityId;
               PlayerManager.getInstance().hasRights=ismsg.hasRights;
               PlayerManager.getInstance().nickname=ismsg.nickname;
               PlayerManager.getInstance().subscriptionEndDate=ismsg.subscriptionEndDate;
               PlayerManager.getInstance().secretQuestion=ismsg.secretQuestion;
               PlayerManager.getInstance().accountCreation=ismsg.accountCreation;
               AuthorizedFrame(Kernel.getWorker().getFrame(AuthorizedFrame)).hasRights=ismsg.hasRights;
               if((PlayerManager.getInstance().subscriptionEndDate<0)||(PlayerManager.getInstance().hasRights))
               {
                  PartManager.getInstance().checkAndDownload("all");
                  PartManager.getInstance().checkAndDownload("subscribed");
               }
               if(PlayerManager.getInstance().hasRights)
               {
                  PartManager.getInstance().checkAndDownload("admin");
               }
               if(PlayerManager.getInstance().hasRights)
               {
                  PartManager.getInstance().checkAndDownload("admin");
                  lengthModsTou=OptionManager.getOptionManager("dofus")["legalAgreementModsTou"];
                  newLengthModsTou=XmlConfig.getInstance().getEntry("config.lang.current")+"#"+I18n.getUiText("ui.legal.modstou").length;
                  files=new Array();
                  if(lengthModsTou!=newLengthModsTou)
                  {
                     files.push("modstou");
                  }
                  if(files.length>0)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.AgreementsRequired,files);
                  }
               }
               StoreUserDataManager.getInstance().savePlayerData();
               Kernel.getWorker().removeFrame(this);
               Kernel.getWorker().addFrame(new ChangeCharacterFrame());
               Kernel.getWorker().addFrame(new ServerSelectionFrame());
               KernelEventsManager.getInstance().processCallback(HookList.IdentificationSuccess);
               return true;
            case msg is IdentificationFailedForBadVersionMessage:
               iffbvmsg=IdentificationFailedForBadVersionMessage(msg);
               PlayerManager.getInstance().destroy();
               ConnectionsHandler.closeConnection();
               KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedForBadVersion,iffbvmsg.reason,iffbvmsg.requiredVersion);
               if(!this._dispatchModuleHook)
               {
                  this._dispatchModuleHook=true;
                  this.pushed();
               }
               return true;
            case msg is IdentificationFailedBannedMessage:
               ifbmsg=IdentificationFailedBannedMessage(msg);
               PlayerManager.getInstance().destroy();
               ConnectionsHandler.closeConnection();
               KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedWithDuration,ifbmsg.reason,ifbmsg.banEndDate);
               if(!this._dispatchModuleHook)
               {
                  this._dispatchModuleHook=true;
                  this.pushed();
               }
               return true;
            case msg is IdentificationFailedMessage:
               ifmsg=IdentificationFailedMessage(msg);
               PlayerManager.getInstance().destroy();
               ConnectionsHandler.closeConnection();
               KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed,ifmsg.reason);
               if(!this._dispatchModuleHook)
               {
                  this._dispatchModuleHook=true;
                  this.pushed();
               }
               return true;
            case msg is NicknameRegistrationMessage:
               nrmsg=NicknameRegistrationMessage(msg);
               KernelEventsManager.getInstance().processCallback(HookList.NicknameRegistration);
               return true;
            case msg is NicknameRefusedMessage:
               nrfmsg=NicknameRefusedMessage(msg);
               KernelEventsManager.getInstance().processCallback(HookList.NicknameRefused,nrfmsg.reason);
               return true;
            case msg is NicknameAcceptedMessage:
               namsg=NicknameAcceptedMessage(msg);
               KernelEventsManager.getInstance().processCallback(HookList.NicknameAccepted);
               return true;
            case msg is NicknameChoiceRequestAction:
               ncra=NicknameChoiceRequestAction(msg);
               ncrmsg=new NicknameChoiceRequestMessage();
               ncrmsg.initNicknameChoiceRequestMessage(ncra.nickname);
               ConnectionsHandler.getConnection().send(ncrmsg);
               return true;
            case msg is SubscribersGiftListRequestAction:
               sglra=SubscribersGiftListRequestAction(msg);
               lang=XmlConfig.getInstance().getEntry("config.lang.current");
               if((lang=="de")||(lang=="en")||(lang=="es")||(lang=="pt")||(lang=="fr")||(lang=="uk")||(lang=="ru"))
               {
                  uri=new Uri(XmlConfig.getInstance().getEntry("config.subscribersGift")+"subscriberGifts_"+lang+".xml");
               }
               else
               {
                  uri=new Uri(XmlConfig.getInstance().getEntry("config.subscribersGift")+"subscriberGifts_en.xml");
               }
               uri.loaderContext=this._contextLoader;
               this._loader.load(uri);
               return true;
            case msg is NewsLoginRequestAction:
               nlra=NewsLoginRequestAction(msg);
               lang2=XmlConfig.getInstance().getEntry("config.lang.current");
               if((lang2=="de")||(lang2=="en")||(lang2=="es")||(lang2=="pt")||(lang2=="fr")||(lang2=="uk")||(lang2=="it")||(lang2=="ru"))
               {
                  uri2=new Uri(XmlConfig.getInstance().getEntry("config.loginNews")+"news_"+lang2+".xml");
               }
               else
               {
                  uri2=new Uri(XmlConfig.getInstance().getEntry("config.loginNews")+"news_en.xml");
               }
               uri2.loaderContext=this._contextLoader;
               this._loader.load(uri2);
               return true;
            default:
               return false;
         }
      }

      public function pulled() : Boolean {
         Berilia.getInstance().unloadUi("Login");
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoad);
         return true;
      }

      private function processInvokeArgs() : void {
         var _loc3_:* = true;
         var _loc4_:* = false;
         var value:String = null;
         var lvwta:LoginValidationWithTicketAction = null;
         if(CommandLineArguments.getInstance().hasArgument("ticket"))
         {
            value=CommandLineArguments.getInstance().getArgument("ticket");
            if(_lastTicket==value)
            {
               return;
            }
            _log.info("Use ticket from launch param\'s");
            _lastTicket=value;
            lvwta=LoginValidationWithTicketAction.create(value,true);
            this.process(lvwta);
         }
      }

      private function onLoad(e:ResourceLoadedEvent) : void {
         var _loc14_:* = true;
         var _loc15_:* = false;
         var i:* = 0;
         var gift:XML = null;
         var subGift:SubscriberGift = null;
         var text:String = null;
         var link:String = null;
         var id:uint = 0;
         var news:XML = null;
         var subGiftList:Array = new Array();
         var xml:XML = e.resource;
         var xmlString:String = xml.toXMLString();
         if(xmlString.substring(1,17)=="subscribersGifts")
         {
            i=0;
            for each (gift in xml..gift)
            {
               i++;
               subGift=new SubscriberGift(i,gift.description,gift.uri,gift.link);
               subGiftList.push(subGift);
            }
            KernelEventsManager.getInstance().processCallback(HookList.SubscribersList,subGiftList);
         }
         else
         {
            if(xmlString.substring(1,9)=="newsList")
            {
               id=0;
               for each (news in xml..news)
               {
                  if(news.@id>id)
                  {
                     text=news.text;
                     link=news.link;
                     id=news.@id;
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.NewsLogin,text,link);
            }
         }
      }

      private function onLoadError(e:ResourceErrorEvent) : void {
         var _loc2_:* = false;
         var _loc3_:* = true;
         _log.error("Cannot load xml "+e.uri+"("+e.errorMsg+")");
      }
   }

}