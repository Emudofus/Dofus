package
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.utils.display.IFramerateListener;
   import com.ankamagames.berilia.interfaces.IApplicationContainer;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.text.TextField;
   import com.ankamagames.dofus.types.DofusOptions;
   import flash.utils.ByteArray;
   import flash.filesystem.FileStream;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.events.InvokeEvent;
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
   import com.ankamagames.dofus.network.enums.PartStateEnum;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.types.Uri;
   import flash.system.ApplicationDomain;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.events.NativeWindowBoundsEvent;
   import flash.display.NativeWindowDisplayState;
   import flash.events.FullScreenEvent;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.NativeWindow;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import flash.display.StageDisplayState;
   import flash.display.Screen;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
   import com.ankamagames.jerakine.utils.crypto.SignatureKey;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.events.Event;
   import com.ankamagames.tiphon.engine.TiphonEventsManager;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.manager.RegSoundManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.misc.utils.errormanager.WebServiceDataHandler;
   import flash.desktop.NativeApplication;
   import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.dofus.misc.interClient.AppIdModifier;
   import flash.external.ExternalInterface;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.messages.Worker;
   import flash.display.Stage;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.FontManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import flash.system.LoaderContext;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.dofus.logic.game.fight.miscs.CustomAnimStatiqueAnimationModifier;
   import com.ankamagames.dofus.types.entities.BreedSkinModifier;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
   import com.ankamagames.dofus.types.entities.RiderBehavior;
   import com.ankamagames.berilia.components.CharacterWheel;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.jerakine.utils.display.FramerateCounter;
   import com.ankamagames.dofus.misc.BuildTypeParser;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.filters.DropShadowFilter;
   import com.ankamagames.dofus.console.moduleLogger.Console;
   import com.ankamagames.dofus.console.moduleLUA.ConsoleLUA;
   import com.ankamagames.berilia.utils.web.HttpServer;
   import flash.display.StageQuality;
   import com.ankamagames.tiphon.display.RasterizedAnimation;
   import com.ankamagames.jerakine.utils.memory.Memory;
   import com.ankamagames.berilia.components.MapViewer;
   import flash.system.Security;
   import com.ankamagames.jerakine.managers.ErrorManager;
   
   public class Dofus extends Sprite implements IFramerateListener, IApplicationContainer
   {
      
      public function Dofus()
      {
         super();
         var i:uint = 0;
         while(i < numChildren)
         {
            getChildAt(i).visible = false;
            i++;
         }
         MapViewer.FLAG_CURSOR = EmbedAssets.getClass("FLAG_CURSOR");
         var stage:Stage = this.stage;
         if(!stage)
         {
            stage = loaderInfo.loader.stage;
            AirScanner.init(getQualifiedClassName(loaderInfo.loader.parent) == "DofusLoader");
         }
         else
         {
            AirScanner.init(false);
         }
         _self = this;
         var hasAir:Boolean = AirScanner.hasAir();
         if(!hasAir)
         {
            stage.showDefaultContextMenu = false;
            Security.allowDomain("*");
            new DofusErrorHandler();
         }
         if(hasAir)
         {
            this._blockLoading = !(name == "root1");
         }
         ErrorManager.registerLoaderInfo(loaderInfo);
         mouseEnabled = false;
         tabChildren = false;
         if(hasAir)
         {
            try
            {
               new AppIdModifier();
            }
            catch(e:Error)
            {
            }
         }
         if(hasAir)
         {
            NativeApplication.nativeApplication.addEventListener(Event.EXITING,this.onExiting);
            NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE,this.onCall);
            stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE,this.onResize);
         }
         else if(AirScanner.isStreamingVersion())
         {
            stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
         }
         
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Dofus));
      
      private static var _self:Dofus;
      
      public static function getInstance() : Dofus
      {
         return _self;
      }
      
      private var _uiContainer:Sprite;
      
      private var _worldContainer:Sprite;
      
      private var _fpsDisplay:TextField;
      
      private var _buildType:String;
      
      private var _instanceId:uint;
      
      private var _doOptions:DofusOptions;
      
      private var _blockLoading:Boolean;
      
      private var _initialized:Boolean = false;
      
      private var _forcedLang:String;
      
      private var _stageWidth:int;
      
      private var _stageHeight:int;
      
      private var _displayState:String;
      
      private var _returnCode:int;
      
      public var REG_LOCAL_CONNECTION_ID:uint = 0;
      
      public function getRawSignatureData() : ByteArray
      {
         var _loc1_:FileStream = new FileStream();
         var _loc2_:File = File.applicationDirectory.resolvePath("DofusInvoker.d2sf");
         _loc1_.open(_loc2_,FileMode.READ);
         var _loc3_:ByteArray = new ByteArray();
         _loc1_.readBytes(_loc3_);
         _loc1_.close();
         return _loc3_;
      }
      
      private function onCall(param1:InvokeEvent) : void
      {
         var file:File = null;
         var stream:FileStream = null;
         var content:String = null;
         var xml:XMLDocument = null;
         var gameNode:XMLNode = null;
         var upperVersion:String = null;
         var configNode:XMLNode = null;
         var versionSplitted:Array = null;
         var version:String = null;
         var part:ContentPart = null;
         var e:InvokeEvent = param1;
         if(!this._initialized)
         {
            CommandLineArguments.getInstance().setArguments(e.arguments);
            new DofusErrorHandler();
            this.initWindow();
            try
            {
               file = new File(File.applicationDirectory.nativePath + File.separator + "uplauncherComponents.xml");
               if(file.exists)
               {
                  PartManager.getInstance().createEmptyPartList();
                  stream = new FileStream();
                  stream.open(file,FileMode.READ);
                  content = stream.readMultiByte(file.size,"utf-8");
                  xml = new XMLDocument();
                  xml.ignoreWhite = true;
                  xml.parseXML(content);
                  gameNode = xml.firstChild;
                  upperVersion = null;
                  for each(configNode in gameNode.childNodes)
                  {
                     version = configNode.attributes["version"];
                     part = new ContentPart();
                     part.id = configNode.attributes["name"];
                     part.state = version?PartStateEnum.PART_UP_TO_DATE:PartStateEnum.PART_NOT_INSTALLED;
                     PartManager.getInstance().updatePart(part);
                     if((version) && (upperVersion == null) || version > upperVersion)
                     {
                        upperVersion = version;
                     }
                  }
                  versionSplitted = upperVersion.split(".");
                  if(versionSplitted.length >= 5)
                  {
                     BuildInfos.BUILD_VERSION = new Version(versionSplitted[0],versionSplitted[1],versionSplitted[2]);
                     BuildInfos.BUILD_VERSION.revision = versionSplitted[3];
                     BuildInfos.BUILD_REVISION = versionSplitted[3];
                     BuildInfos.BUILD_VERSION.patch = versionSplitted[4];
                     BuildInfos.BUILD_PATCH = versionSplitted[4];
                  }
               }
               else
               {
                  file = new File(File.applicationDirectory.nativePath + File.separator + "games_base.xml");
                  if(file.exists)
                  {
                     stream = new FileStream();
                     stream.open(file,FileMode.READ);
                     content = stream.readMultiByte(file.size,"utf-8");
                     xml = new XMLDocument();
                     xml.ignoreWhite = true;
                     xml.parseXML(content);
                     gameNode = xml.firstChild.firstChild;
                     for each(configNode in gameNode.childNodes)
                     {
                        if(configNode.nodeName == "version")
                        {
                           version = configNode.firstChild.nodeValue;
                           version = version.split("_")[0];
                           versionSplitted = version.split(".");
                           if(versionSplitted.length >= 5)
                           {
                              BuildInfos.BUILD_VERSION = new Version(versionSplitted[0],versionSplitted[1],versionSplitted[2]);
                              BuildInfos.BUILD_VERSION.revision = versionSplitted[3];
                              BuildInfos.BUILD_REVISION = versionSplitted[3];
                              BuildInfos.BUILD_VERSION.patch = versionSplitted[4];
                              BuildInfos.BUILD_PATCH = versionSplitted[4];
                           }
                        }
                     }
                  }
                  else
                  {
                     BuildInfos.BUILD_VERSION.revision = BuildInfos.BUILD_REVISION;
                     BuildInfos.BUILD_VERSION.patch = BuildInfos.BUILD_PATCH;
                  }
               }
            }
            catch(e:Error)
            {
               BuildInfos.BUILD_VERSION.revision = BuildInfos.BUILD_REVISION;
               BuildInfos.BUILD_VERSION.patch = BuildInfos.BUILD_PATCH;
            }
            if(BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
            {
               Uri.enableSecureURI();
            }
            if(this.stage)
            {
               this.init(this.stage);
            }
            _log.debug("Support des Workers : " + ApplicationDomain.currentDomain.hasDefinition("flash.system::Worker"));
            try
            {
               file = new File(CustomSharedObject.getCustomSharedObjectDirectory() + File.separator + "path.d2p");
               if(!file.exists)
               {
                  stream = new FileStream();
                  stream.open(file,FileMode.WRITE);
                  stream.writeUTF(File.applicationDirectory.nativePath);
                  stream.close();
               }
            }
            catch(e:Error)
            {
            }
            this._initialized = true;
         }
         if(!this._initialized)
         {
            return;
         }
      }
      
      private function onResize(param1:NativeWindowBoundsEvent) : void
      {
         this._displayState = stage.nativeWindow.displayState;
         if(this._displayState != NativeWindowDisplayState.MAXIMIZED)
         {
            this._stageHeight = stage.nativeWindow.height;
            this._stageWidth = stage.nativeWindow.width;
         }
      }
      
      private function onFullScreen(param1:FullScreenEvent) : void
      {
         var _loc2_:Boolean = OptionManager.getOptionManager("dofus").fullScreen;
         if(_loc2_ != param1.fullScreen)
         {
            OptionManager.getOptionManager("dofus").fullScreen = param1.fullScreen;
         }
         StageShareManager.justExitFullScreen = !param1.fullScreen;
      }
      
      private function initWindow() : void
      {
         var _loc1_:Number = stage.stageWidth / stage.stageHeight;
         var _loc2_:NativeWindow = stage.nativeWindow;
         var _loc3_:Number = _loc2_.width - stage.stageWidth;
         var _loc4_:Number = _loc2_.height - stage.stageHeight;
         StageShareManager.chrome.x = _loc3_;
         StageShareManager.chrome.y = _loc4_;
         var _loc5_:CustomSharedObject = CustomSharedObject.getLocal("clientData");
         var _loc6_:String = SystemManager.getSingleton().os;
         var _loc7_:* = false;
         if(!(_loc5_.data == null) && _loc5_.data.width > 0 && _loc5_.data.height > 0)
         {
            if(_loc5_.data.displayState == NativeWindowDisplayState.MAXIMIZED && _loc6_ == OperatingSystem.WINDOWS && !(stage.displayState == StageDisplayState["FULL_SCREEN_INTERACTIVE"]))
            {
               stage.nativeWindow.maximize();
               this._displayState = NativeWindowDisplayState.MAXIMIZED;
            }
            if(_loc5_.data.width > 0 && _loc5_.data.height > 0)
            {
               _loc2_.width = _loc5_.data.width;
               if(_loc6_ == OperatingSystem.LINUX)
               {
                  _loc2_.height = _loc5_.data.height - 28;
               }
               else
               {
                  _loc2_.height = _loc5_.data.height;
               }
               this._stageWidth = _loc2_.width;
               this._stageHeight = _loc2_.height;
               _loc7_ = true;
            }
         }
         if(!_loc7_)
         {
            if(Screen.mainScreen.visibleBounds.width > Screen.mainScreen.visibleBounds.height)
            {
               if(_loc6_ == OperatingSystem.WINDOWS)
               {
                  _loc2_.height = Screen.mainScreen.visibleBounds.height * 0.8 + _loc4_;
                  _loc2_.width = _loc1_ * (_loc2_.height - _loc4_) + _loc3_;
               }
               else
               {
                  _loc2_.height = Screen.mainScreen.visibleBounds.height * 0.8;
                  _loc2_.width = _loc1_ * (_loc2_.height - _loc4_);
               }
            }
            else if(_loc6_ == OperatingSystem.WINDOWS)
            {
               _loc2_.width = Screen.mainScreen.visibleBounds.width * 0.8 + _loc3_;
               _loc2_.height = (_loc2_.width - _loc3_) / _loc1_ + _loc4_;
            }
            else
            {
               _loc2_.width = Screen.mainScreen.visibleBounds.width * 0.8;
               _loc2_.height = _loc2_.width / _loc1_;
            }
            
            this._stageHeight = stage.nativeWindow.height;
            this._stageWidth = stage.nativeWindow.width;
         }
         _loc2_.x = (Screen.mainScreen.visibleBounds.width - _loc2_.width) / 2 + Screen.mainScreen.visibleBounds.x;
         _loc2_.y = (Screen.mainScreen.visibleBounds.height - _loc2_.height) / 2 + Screen.mainScreen.visibleBounds.y;
         _loc2_.visible = true;
      }
      
      public function getUiContainer() : DisplayObjectContainer
      {
         return this._uiContainer;
      }
      
      public function getWorldContainer() : DisplayObjectContainer
      {
         return this._worldContainer;
      }
      
      public function get options() : DofusOptions
      {
         return this._doOptions;
      }
      
      public function get instanceId() : uint
      {
         return this._instanceId;
      }
      
      public function get forcedLang() : String
      {
         return this._forcedLang;
      }
      
      public function setDisplayOptions(param1:DofusOptions) : void
      {
         this._doOptions = param1;
         this._doOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onOptionChange);
         this._doOptions.flashQuality = this._doOptions.flashQuality;
         this._doOptions.fullScreen = this._doOptions.fullScreen;
      }
      
      public function init(param1:DisplayObject, param2:uint = 0, param3:String = null, param4:Array = null) : void
      {
         if(param4)
         {
            CommandLineArguments.getInstance().setArguments(param4);
         }
         this._instanceId = param2;
         this._forcedLang = param3;
         var _loc5_:Sprite = new Sprite();
         _loc5_.name = "catchMouseEventCtr";
         _loc5_.graphics.beginFill(0);
         _loc5_.graphics.drawRect(0,0,StageShareManager.startWidth,StageShareManager.startHeight);
         _loc5_.graphics.endFill();
         addChild(_loc5_);
         var _loc6_:CustomSharedObject = CustomSharedObject.getLocal("appVersion");
         if(!_loc6_.data.lastBuildVersion || !(_loc6_.data.lastBuildVersion == BuildInfos.BUILD_REVISION) && BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
         {
            this.clearCache(true);
         }
         _loc6_ = CustomSharedObject.getLocal("appVersion");
         _loc6_.data.lastBuildVersion = BuildInfos.BUILD_REVISION;
         _loc6_.flush();
         _loc6_.close();
         SignedFileAdapter.defaultSignatureKey = SignatureKey.fromByte(new Constants.SIGNATURE_KEY_DATA() as ByteArray);
         this.initKernel(this.stage,param1);
         this.initWorld();
         this.initUi();
         if(BuildInfos.BUILD_TYPE > BuildTypeEnum.ALPHA)
         {
            this.initDebug();
         }
         if(AirScanner.hasAir())
         {
            stage["nativeWindow"].addEventListener(Event.CLOSE,this.onClosed);
         }
         TiphonEventsManager.addListener(Tiphon.getInstance(),TiphonEvent.EVT_EVENT);
         SoundManager.getInstance().manager = new RegSoundManager();
         (SoundManager.getInstance().manager as RegSoundManager).forceSoundsDebugMode = true;
         Atouin.getInstance().addListener(SoundManager.getInstance().manager);
      }
      
      private function onExiting(param1:Event) : void
      {
         this.saveClientSize();
         if(WebServiceDataHandler.getInstance().quit())
         {
            param1.preventDefault();
            param1.stopPropagation();
            WebServiceDataHandler.getInstance().addEventListener(WebServiceDataHandler.ALL_DATA_SENT,this.quitHandler);
         }
      }
      
      public function quit(param1:int = 0) : void
      {
         this._returnCode = param1;
         if(!WebServiceDataHandler.getInstance().quit())
         {
            this.quitHandler();
         }
         else
         {
            _log.trace("We have data to send to the webservice. waiting...");
            WebServiceDataHandler.getInstance().addEventListener(WebServiceDataHandler.ALL_DATA_SENT,this.quitHandler);
            WebServiceDataHandler.getInstance().sendWaitingException();
         }
      }
      
      private function quitHandler(param1:Event = null) : void
      {
         if(param1 != null)
         {
            param1.currentTarget.removeEventListener(WebServiceDataHandler.ALL_DATA_SENT,this.quitHandler);
            _log.trace("Data sent. Good to go. Bye bye");
         }
         if(Constants.EVENT_MODE)
         {
            this.reboot();
         }
         else if(AirScanner.hasAir())
         {
            stage.nativeWindow.close();
            if(NativeApplication.nativeApplication.openedWindows.length == 0)
            {
               NativeApplication.nativeApplication.exit(this._returnCode);
            }
         }
         
      }
      
      public function onClose() : void
      {
         RegConnectionManager.getInstance().send(ProtocolEnum.SAY_GOODBYE,RegConnectionManager.getInstance().socketClientID);
         InterClientManager.destroy();
      }
      
      public function clearCache(param1:Boolean = false, param2:Boolean = false) : void
      {
         var soList:Array = null;
         var file:File = null;
         var fileName:String = null;
         var selective:Boolean = param1;
         var reboot:Boolean = param2;
         StoreDataManager.getInstance().reset();
         var soFolder:File = new File(CustomSharedObject.getCustomSharedObjectDirectory());
         if((soFolder) && (soFolder.exists))
         {
            CustomSharedObject.closeAll();
            soList = soFolder.getDirectoryListing();
            for each(file in soList)
            {
               fileName = FileUtils.getFileStartName(file.name);
               if(fileName != "Dofus_Guest")
               {
                  if(selective)
                  {
                     switch(true)
                     {
                        case fileName.indexOf("Module_") == 0:
                        case fileName == "dofus":
                        case fileName.indexOf("Dofus_") == 0:
                        case fileName == "atouin":
                        case fileName == "berilia":
                        case fileName == "chat":
                        case fileName == "tiphon":
                        case fileName == "tubul":
                        case fileName.indexOf("externalNotifications_") == 0:
                        case fileName == "averagePrices":
                        case fileName == "Berilia_binds":
                        case fileName == "maps":
                        case fileName == "logs":
                        case fileName == "uid":
                        case fileName == "appVersion":
                           continue;
                     }
                  }
                  try
                  {
                     if(file.isDirectory)
                     {
                        file.deleteDirectory(true);
                     }
                     else
                     {
                        file.deleteFile();
                     }
                  }
                  catch(e:Error)
                  {
                     continue;
                  }
               }
            }
         }
         if(reboot)
         {
            if(AirScanner.hasAir())
            {
               AppIdModifier.getInstance().invalideCache();
               this.reboot();
            }
            else if(ExternalInterface.available)
            {
               ExternalInterface.call("eval","window.location.reload()");
            }
            
         }
      }
      
      public function reboot() : void
      {
         this.saveClientSize();
         var _loc1_:Worker = Kernel.getWorker();
         if(_loc1_)
         {
            _loc1_.clear();
         }
         _log.fatal("REBOOT");
         if(AirScanner.hasAir())
         {
            NativeApplication.nativeApplication["exit"](42);
            return;
         }
         throw new Error("Reboot not implemented with flash");
      }
      
      public function renameApp(param1:String) : void
      {
         if(AirScanner.hasAir())
         {
            stage["nativeWindow"].title = param1;
         }
      }
      
      private function initKernel(param1:Stage, param2:DisplayObject) : void
      {
         Kernel.getInstance().init(param1,param2);
         LangManager.getInstance().handler = Kernel.getWorker();
         FontManager.getInstance().handler = Kernel.getWorker();
         Berilia.getInstance().handler = Kernel.getWorker();
         LangManager.getInstance().lang = "frFr";
      }
      
      private function initWorld() : void
      {
         if(this._worldContainer)
         {
            removeChild(this._worldContainer);
         }
         this._worldContainer = new Sprite();
         addChild(this._worldContainer);
         this._worldContainer.mouseEnabled = false;
      }
      
      private function initUi() : void
      {
         if(this._uiContainer)
         {
            removeChild(this._uiContainer);
         }
         this._uiContainer = new Sprite();
         addChild(this._uiContainer);
         this._uiContainer.mouseEnabled = false;
         var _loc1_:* = BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG;
         Berilia.getInstance().verboseException = _loc1_;
         Berilia.getInstance().init(this._uiContainer,_loc1_,BuildInfos.BUILD_REVISION,!_loc1_);
         if(AirScanner.isStreamingVersion())
         {
            Berilia.embedIcons.SLOT_DEFAULT_ICON = EmbedAssets.getBitmap("DefaultBeriliaSlotIcon",true).bitmapData;
         }
         var _loc2_:Uri = new Uri("SharedDefinitions.swf");
         _loc2_.loaderContext = new LoaderContext(false,new ApplicationDomain());
         var _loc3_:Boolean = File.applicationDirectory.resolvePath("noHttpServer").exists;
         UiModuleManager.getInstance(BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || (_loc3_)).sharedDefinitionContainer = _loc2_;
         EntityDisplayer.setAnimationModifier(1,new CustomAnimStatiqueAnimationModifier());
         EntityDisplayer.setAnimationModifier(2,new CustomAnimStatiqueAnimationModifier());
         EntityDisplayer.setSkinModifier(1,new BreedSkinModifier());
         EntityDisplayer.setSkinModifier(2,new BreedSkinModifier());
         EntityDisplayer.setAnimationModifier(2,new CustomAnimStatiqueAnimationModifier());
         EntityDisplayer.setSubEntityDefaultBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,new AnimStatiqueSubEntityBehavior());
         EntityDisplayer.setSubEntityDefaultBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
         CharacterWheel.setAnimationModifier(1,new CustomAnimStatiqueAnimationModifier());
         CharacterWheel.setAnimationModifier(2,new CustomAnimStatiqueAnimationModifier());
         CharacterWheel.setSkinModifier(1,new BreedSkinModifier());
         CharacterWheel.setSkinModifier(2,new BreedSkinModifier());
         CharacterWheel.setSubEntityDefaultBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,new AnimStatiqueSubEntityBehavior());
         CharacterWheel.setSubEntityDefaultBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
         EntityDisplayer.lookAdaptater = EntityLookAdapter.tiphonizeLook;
      }
      
      private function initDebug() : void
      {
         FramerateCounter.refreshRate = 250;
         FramerateCounter.addListener(this);
         this._buildType = BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE);
         this._fpsDisplay = new TextField();
         this._fpsDisplay.mouseEnabled = false;
         this._fpsDisplay.selectable = false;
         this._fpsDisplay.defaultTextFormat = new TextFormat("Verdana",12,16777215,true,false,false,null,null,TextFormatAlign.RIGHT);
         this._fpsDisplay.text = this._buildType + "\nr" + BuildInfos.BUILD_REVISION;
         this._fpsDisplay.filters = [new DropShadowFilter(0,0,0,1,2,2,5,3)];
         this._fpsDisplay.width = 300;
         this._fpsDisplay.x = 1280 - this._fpsDisplay.width;
         addChild(this._fpsDisplay);
         if(Constants.EVENT_MODE)
         {
            this._fpsDisplay.visible = false;
         }
      }
      
      public function toggleFPS() : void
      {
         this._fpsDisplay.visible = !this._fpsDisplay.visible;
      }
      
      private function onClosed(param1:Event) : void
      {
         Console.getInstance().close();
         ConsoleLUA.getInstance().close();
         HttpServer.getInstance().close();
      }
      
      private function onOptionChange(param1:PropertyChangeEvent) : void
      {
         if(param1.propertyName == "flashQuality")
         {
            if(param1.propertyValue == 0)
            {
               StageShareManager.stage.quality = StageQuality.LOW;
            }
            else if(param1.propertyValue == 1)
            {
               StageShareManager.stage.quality = StageQuality.MEDIUM;
            }
            else if(param1.propertyValue == 2)
            {
               StageShareManager.stage.quality = StageQuality.HIGH;
            }
            
            
         }
         if(param1.propertyName == "fullScreen")
         {
            StageShareManager.setFullScreen(param1.propertyValue,false);
         }
      }
      
      public function onFps(param1:uint) : void
      {
         var _loc2_:Object = null;
         if(this._fpsDisplay.visible)
         {
            _loc2_ = RasterizedAnimation.countFrames();
            this._fpsDisplay.htmlText = "<font color=\'#FFFFFF\'>" + param1 + " fps - " + this._buildType + "\n<font color=\'#B9B6ED\'>" + Memory.humanReadableUsage() + " - r" + BuildInfos.BUILD_REVISION + "\n<font color=\'#92D5D8\'> Anim/Img en cache - " + _loc2_.animations + "/" + _loc2_.frames;
         }
      }
      
      private function saveClientSize() : void
      {
         var _loc1_:CustomSharedObject = CustomSharedObject.getLocal("clientData");
         _loc1_.data.height = this._stageHeight;
         _loc1_.data.width = this._stageWidth;
         _loc1_.data.displayState = this._displayState;
         _loc1_.flush();
         _loc1_.close();
      }
      
      public var strProgress:Number = 0;
      
      public var strComplete:Boolean = false;
      
      public function strLoaderComplete() : void
      {
         this.strComplete = true;
      }
      
      public function getLoadingProgress() : Number
      {
         return this.strProgress;
      }
   }
}
