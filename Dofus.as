package 
{
    import Dofus.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.console.moduleLogger.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.manager.*;
    import com.ankamagames.dofus.logic.game.approach.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.interClient.*;
    import com.ankamagames.dofus.misc.utils.errormanager.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.updater.*;
    import com.ankamagames.dofus.types.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.protocolAudio.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.files.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.events.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import flash.xml.*;

    public class Dofus extends Sprite implements IFramerateListener, IApplicationContainer
    {
        private var _uiContainer:Sprite;
        private var _worldContainer:Sprite;
        private var _fpsDisplay:TextField;
        private var _buildType:String;
        private var _instanceId:uint;
        private var _doOptions:DofusOptions;
        private var _invokeArguments:Array;
        private var _blockLoading:Boolean;
        private var _initialized:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Dofus));
        private static var _self:Dofus;

        public function Dofus()
        {
            var stage:* = this.stage;
            if (!stage)
            {
                stage = loaderInfo.loader.stage;
            }
            _self = this;
            var r:* = stage.stageWidth / stage.stageHeight;
            if (Screen.mainScreen.bounds.width < Screen.mainScreen.bounds.height)
            {
                stage.stageWidth = Screen.mainScreen.bounds.width * 0.8;
                stage.stageHeight = stage.stageWidth / r;
            }
            else
            {
                stage.stageHeight = Screen.mainScreen.bounds.height * 0.8;
                stage.stageWidth = r * stage.stageHeight;
            }
            if (AirScanner.hasAir())
            {
                stage["nativeWindow"].x = (Screen.mainScreen.bounds.width - stage.stageWidth) / 2;
                stage["nativeWindow"].y = (Screen.mainScreen.bounds.height - stage.stageHeight) / 2;
                stage["nativeWindow"].visible = true;
            }
            else
            {
                scaleX = 800 / 1280;
                scaleY = 600 / 1024;
            }
            new DofusErrorHandler();
            if (AirScanner.hasAir())
            {
                this._blockLoading = name != "root1";
            }
            ErrorManager.registerLoaderInfo(loaderInfo);
            mouseEnabled = false;
            tabChildren = false;
            try
            {
                new AppIdModifier();
            }
            catch (e:Error)
            {
            }
            NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, this.onCall);
            return;
        }// end function

        private function onCall(event:InvokeEvent) : void
        {
            arguments = new activation;
            var file:File;
            var stream:FileStream;
            var content:String;
            var xml:XMLDocument;
            var gameNode:XMLNode;
            var upperVersion:String;
            var configNode:XMLNode;
            var versionSplitted:Array;
            var version:String;
            var part:ContentPart;
            var e:* = event;
            var arguments:* = arguments;
            if (!this._initialized)
            {
                CommandLineArguments.getInstance().setArguments(arguments);
                this._invokeArguments = arguments;
                if (!this._invokeArguments)
                {
                    this._invokeArguments = [];
                }
                try
                {
                    file = new File(File.applicationDirectory.nativePath + File.separator + "uplauncherComponents.xml");
                    if (exists)
                    {
                        PartManager.getInstance().createEmptyPartList();
                        stream = new FileStream();
                        open(, FileMode.READ);
                        content = readMultiByte(size, "utf-8");
                        xml = new XMLDocument();
                        ignoreWhite = true;
                        parseXML();
                        gameNode = firstChild;
                        upperVersion;
                        var _loc_4:int = 0;
                        var _loc_5:* = childNodes;
                        while (_loc_5 in _loc_4)
                        {
                            
                            configNode = _loc_5[_loc_4];
                            version = attributes["version"];
                            part = new ContentPart();
                            id = attributes["name"];
                            state =  ? (PartStateEnum.PART_UP_TO_DATE) : (PartStateEnum.PART_NOT_INSTALLED);
                            PartManager.getInstance().updatePart();
                            if ( &&  == null ||  > )
                            {
                                upperVersion = ;
                            }
                        }
                        versionSplitted = split(".");
                        if (length >= 5)
                        {
                            BuildInfos.BUILD_VERSION = new Version([0], [1], [2]);
                            BuildInfos.BUILD_VERSION.revision = [3];
                            BuildInfos.BUILD_REVISION = [3];
                            BuildInfos.BUILD_VERSION.patch = [4];
                            BuildInfos.BUILD_PATCH = [4];
                        }
                    }
                    else
                    {
                        file = new File(File.applicationDirectory.nativePath + File.separator + "games_base.xml");
                        if (exists)
                        {
                            stream = new FileStream();
                            open(, FileMode.READ);
                            content = readMultiByte(size, "utf-8");
                            xml = new XMLDocument();
                            ignoreWhite = true;
                            parseXML();
                            gameNode = firstChild.firstChild;
                            var _loc_4:int = 0;
                            var _loc_5:* = childNodes;
                            while (_loc_5 in _loc_4)
                            {
                                
                                configNode = _loc_5[_loc_4];
                                if (nodeName == "version")
                                {
                                    version = firstChild.nodeValue;
                                    version = split("_")[0];
                                    versionSplitted = split(".");
                                    if (length >= 5)
                                    {
                                        BuildInfos.BUILD_VERSION = new Version([0], [1], [2]);
                                        BuildInfos.BUILD_VERSION.revision = [3];
                                        BuildInfos.BUILD_REVISION = [3];
                                        BuildInfos.BUILD_VERSION.patch = [4];
                                        BuildInfos.BUILD_PATCH = [4];
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
                catch (e:Error)
                {
                    BuildInfos.BUILD_VERSION.revision = BuildInfos.BUILD_REVISION;
                    BuildInfos.BUILD_VERSION.patch = BuildInfos.BUILD_PATCH;
                }
                if (BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
                {
                    Uri.enableSecureURI();
                }
                if (this.stage)
                {
                    this.init(this.stage);
                }
                try
                {
                    file = new File(CustomSharedObject.getCustomSharedObjectDirectory() + File.separator + "path.d2p");
                    if (!exists)
                    {
                        stream = new FileStream();
                        open(, FileMode.WRITE);
                        writeUTF(File.applicationDirectory.nativePath);
                        close();
                    }
                }
                catch (e:Error)
                {
                }
                this._initialized = true;
            }
            return;
        }// end function

        public function getUiContainer() : DisplayObjectContainer
        {
            return this._uiContainer;
        }// end function

        public function getWorldContainer() : DisplayObjectContainer
        {
            return this._worldContainer;
        }// end function

        public function get options() : DofusOptions
        {
            return this._doOptions;
        }// end function

        public function get invokeArgs() : Array
        {
            return this._invokeArguments;
        }// end function

        public function get instanceId() : uint
        {
            return this._instanceId;
        }// end function

        public function setDisplayOptions(param1:DofusOptions) : void
        {
            this._doOptions = param1;
            this._doOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onOptionChange);
            this._doOptions.flashQuality = this._doOptions.flashQuality;
            return;
        }// end function

        private function onOptionChange(event:PropertyChangeEvent) : void
        {
            if (event.propertyName == "flashQuality")
            {
                if (event.propertyValue == 0)
                {
                    StageShareManager.stage.quality = StageQuality.LOW;
                }
                else if (event.propertyValue == 1)
                {
                    StageShareManager.stage.quality = StageQuality.MEDIUM;
                }
                else if (event.propertyValue == 2)
                {
                    StageShareManager.stage.quality = StageQuality.HIGH;
                }
            }
            return;
        }// end function

        public function init(param1:DisplayObject, param2:uint = 0) : void
        {
            if (this._blockLoading)
            {
                throw new SecurityError("You cannot load Dofus.");
            }
            this._instanceId = param2;
            var _loc_3:* = new Sprite();
            _loc_3.name = "catchMouseEventCtr";
            _loc_3.graphics.beginFill(0);
            _loc_3.graphics.drawRect(0, 0, StageShareManager.startWidth, StageShareManager.startHeight);
            _loc_3.graphics.endFill();
            addChild(_loc_3);
            var _loc_4:* = CustomSharedObject.getLocal("appVersion");
            if (!CustomSharedObject.getLocal("appVersion").data.lastBuildVersion || _loc_4.data.lastBuildVersion != BuildInfos.BUILD_REVISION && BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
            {
                this.clearCache(true);
            }
            _loc_4 = CustomSharedObject.getLocal("appVersion");
            _loc_4.data.lastBuildVersion = BuildInfos.BUILD_REVISION;
            _loc_4.flush();
            _loc_4.close();
            SignedFileAdapter.defaultSignatureKey = SignatureKey.fromByte(new Constants.SIGNATURE_KEY_DATA as ByteArray);
            this.initKernel(this.stage, param1);
            this.initWorld();
            this.initUi();
            if (BuildInfos.BUILD_TYPE > BuildTypeEnum.ALPHA)
            {
                this.initDebug();
            }
            if (AirScanner.hasAir())
            {
                stage["nativeWindow"].addEventListener(Event.CLOSE, this.onClosed);
            }
            TiphonEventsManager.addListener(Tiphon.getInstance(), TiphonEvent.EVT_EVENT);
            SoundManager.getInstance().manager = new RegSoundManager();
            (SoundManager.getInstance().manager as RegSoundManager).forceSoundsDebugMode = true;
            Atouin.getInstance().addListener(SoundManager.getInstance().manager);
            return;
        }// end function

        public function quit() : void
        {
            if (Constants.EVENT_MODE)
            {
                this.reboot();
            }
            else if (AirScanner.hasAir())
            {
                stage["nativeWindow"].close();
            }
            return;
        }// end function

        public function onClose() : void
        {
            RegConnectionManager.getInstance().send(ProtocolEnum.SAY_GOODBYE, RegConnectionManager.getInstance().socketClientID);
            InterClientManager.destroy();
            return;
        }// end function

        public function clearCache(param1:Boolean = false, param2:Boolean = false) : void
        {
            var soList:Array;
            var file:File;
            var fileName:String;
            var selective:* = param1;
            var reboot:* = param2;
            StoreDataManager.getInstance().reset();
            var soFolder:* = new File(CustomSharedObject.getCustomSharedObjectDirectory());
            if (soFolder && soFolder.exists)
            {
                CustomSharedObject.closeAll();
                soList = soFolder.getDirectoryListing();
                var _loc_4:int = 0;
                var _loc_5:* = soList;
                do
                {
                    
                    file = _loc_5[_loc_4];
                    fileName = FileUtils.getFileStartName(file.name);
                    if (selective)
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
                            case fileName == "Berilia_binds":
                            case fileName == "maps":
                            case fileName == "logs":
                            case fileName == "uid":
                            case fileName == "appVersion":
                            {
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    try
                    {
                        if (file.isDirectory)
                        {
                            file.deleteDirectory(true);
                        }
                        else
                        {
                            file.deleteFile();
                        }
                    }
                    catch (e:Error)
                    {
                    }
                }while (_loc_5 in _loc_4)
            }
            if (reboot)
            {
                AppIdModifier.getInstance().invalideCache();
                this.reboot();
            }
            return;
        }// end function

        public function reboot() : void
        {
            var _loc_1:* = Kernel.getWorker();
            if (_loc_1)
            {
                _loc_1.clear();
            }
            _log.fatal("REBOOT");
            if (AirScanner.hasAir())
            {
                var _loc_2:* = NativeApplication.nativeApplication;
                _loc_2.NativeApplication.nativeApplication["exit"](42);
            }
            else
            {
                throw new Error("Reboot not implemented with flash");
            }
            return;
        }// end function

        public function renameApp(param1:String) : void
        {
            _log.debug("rename : Dofus - " + param1);
            if (AirScanner.hasAir())
            {
                stage["nativeWindow"].title = param1;
            }
            return;
        }// end function

        private function initKernel(param1:Stage, param2:DisplayObject) : void
        {
            Kernel.getInstance().init(param1, param2);
            LangManager.getInstance().handler = Kernel.getWorker();
            FontManager.getInstance().handler = Kernel.getWorker();
            Berilia.getInstance().handler = Kernel.getWorker();
            LangManager.getInstance().lang = "frFr";
            return;
        }// end function

        private function initWorld() : void
        {
            if (this._worldContainer)
            {
                removeChild(this._worldContainer);
            }
            this._worldContainer = new Sprite();
            addChild(this._worldContainer);
            this._worldContainer.mouseEnabled = false;
            return;
        }// end function

        private function initUi() : void
        {
            if (this._uiContainer)
            {
                removeChild(this._uiContainer);
            }
            this._uiContainer = new Sprite();
            addChild(this._uiContainer);
            this._uiContainer.mouseEnabled = false;
            var _loc_1:* = BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG;
            Berilia.getInstance().verboseException = _loc_1;
            Berilia.getInstance().init(this._uiContainer, _loc_1, BuildInfos.BUILD_REVISION, !_loc_1);
            var _loc_2:* = new Uri("SharedDefinitions.swf");
            _loc_2.loaderContext = new LoaderContext(false, new ApplicationDomain());
            UiModuleManager.getInstance().sharedDefinitionContainer = _loc_2;
            EntityDisplayer.animationModifier = new CustomAnimStatiqueAnimationModifier();
            EntityDisplayer.setSubEntityDefaultBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET, new AnimStatiqueSubEntityBehavior());
            EntityDisplayer.setSubEntityDefaultBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, new RiderBehavior());
            CharacterWheel.animationModifier = new CustomAnimStatiqueAnimationModifier();
            CharacterWheel.setSubEntityDefaultBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET, new AnimStatiqueSubEntityBehavior());
            CharacterWheel.setSubEntityDefaultBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, new RiderBehavior());
            EntityDisplayer.lookAdaptater = EntityLookAdapter.tiphonizeLook;
            return;
        }// end function

        private function initDebug() : void
        {
            FramerateCounter.refreshRate = 250;
            FramerateCounter.addListener(this);
            this._buildType = BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE);
            this._fpsDisplay = new TextField();
            this._fpsDisplay.mouseEnabled = false;
            this._fpsDisplay.selectable = false;
            this._fpsDisplay.defaultTextFormat = new TextFormat("Verdana", 12, 16777215, true, false, false, null, null, TextFormatAlign.RIGHT);
            this._fpsDisplay.text = this._buildType + "\nr" + BuildInfos.BUILD_REVISION;
            this._fpsDisplay.filters = [new DropShadowFilter(0, 0, 0, 1, 2, 2, 5, 3)];
            this._fpsDisplay.width = 300;
            this._fpsDisplay.x = 1280 - this._fpsDisplay.width;
            addChild(this._fpsDisplay);
            if (Constants.EVENT_MODE)
            {
                this._fpsDisplay.visible = false;
            }
            return;
        }// end function

        public function toggleFPS() : void
        {
            this._fpsDisplay.visible = !this._fpsDisplay.visible;
            return;
        }// end function

        private function onClosed(event:Event) : void
        {
            Console.getInstance().close();
            HttpServer.getInstance().close();
            return;
        }// end function

        public function onFps(param1:uint) : void
        {
            var _loc_2:Object = null;
            if (this._fpsDisplay.visible)
            {
                _loc_2 = RasterizedAnimation.countFrames();
                this._fpsDisplay.htmlText = "<font color=\'#FFFFFF\'>" + param1 + " fps - " + this._buildType + "\n<font color=\'#B9B6ED\'>" + Memory.humanReadableUsage() + " - r" + BuildInfos.BUILD_REVISION + "\n<font color=\'#92D5D8\'> Anim/Img en cache - " + _loc_2.animations + "/" + _loc_2.frames;
            }
            return;
        }// end function

        public static function getInstance() : Dofus
        {
            return _self;
        }// end function

    }
}
