package com.ankamagames.dofus.kernel
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.frames.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.console.moduleLogger.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.updater.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.connection.frames.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.misc.interClient.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.types.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.replay.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tubul.types.*;
    import flash.display.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class Kernel extends Object
    {
        protected var _gamedataClassList:GameDataList = null;
        protected var _enumList:EnumList = null;
        protected var _apiList:ApiList = null;
        protected var _apiActionList:ApiActionList = null;
        protected var _ApiRolePlayActionList:ApiRolePlayActionList = null;
        private var _include_DebugTarget:DebugTarget = null;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Kernel));
        private static var _self:Kernel;
        private static var _worker:Worker = new Worker();
        public static var beingInReconection:Boolean;

        public function Kernel()
        {
            if (_self != null)
            {
                throw new SingletonError("Kernel is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function init(param1:Stage, param2:DisplayObject) : void
        {
            var stage:* = param1;
            var rootClip:* = param2;
            StageShareManager.stage = stage;
            StageShareManager.rootContainer = Dofus.getInstance();
            FrameIdManager.init();
            ApplicationDomainShareManager.currentApplicationDomain = ApplicationDomain.currentDomain;
            _worker.clear();
            HumanInputHandler.getInstance().handler = _worker;
            BoneIndexManager.getInstance().setAnimNameModifier(AnimationCleaner.cleanBones1AnimName);
            InterClientManager.getInstance().update();
            this.addInitialFrames(true);
            _log.info("Using protocole #" + Metadata.PROTOCOL_BUILD + ", build on " + Metadata.PROTOCOL_DATE + " (visibility " + Metadata.PROTOCOL_VISIBILITY + ")");
            if (AirScanner.hasAir())
            {
                try
                {
                    new UpdaterConnexionHandler();
                }
                catch (e:Error)
                {
                    _log.warn("Can\'t make connection to updater");
                }
            }
            return;
        }// end function

        public function postInit() : void
        {
            var _loc_2:int = 0;
            var _loc_3:String = null;
            this.initCaches();
            XmlConfig.getInstance().init(LangManager.getInstance().getCategory("config"));
            if (XmlConfig.getInstance().getEntry("config.buildType"))
            {
                _loc_2 = -1;
                _loc_3 = XmlConfig.getInstance().getEntry("config.buildType");
                switch(_loc_3.toLowerCase())
                {
                    case "debug":
                    {
                        _loc_2 = BuildTypeEnum.DEBUG;
                        break;
                    }
                    case "internal":
                    {
                        _loc_2 = BuildTypeEnum.INTERNAL;
                        break;
                    }
                    case "testing":
                    {
                        _loc_2 = BuildTypeEnum.TESTING;
                        break;
                    }
                    case "alpha":
                    {
                        _loc_2 = BuildTypeEnum.ALPHA;
                        break;
                    }
                    case "beta":
                    {
                        _loc_2 = BuildTypeEnum.BETA;
                        break;
                    }
                    case "release":
                    {
                        _loc_2 = BuildTypeEnum.RELEASE;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_2 != -1 && _loc_2 < BuildInfos.BUILD_TYPE)
                {
                    BuildInfos.BUILD_TYPE = _loc_2;
                }
            }
            BuildInfos.BUILD_VERSION.buildType = BuildInfos.BUILD_TYPE;
            this.initOptions();
            Atouin.getInstance().showWorld(false);
            DataMapProvider.init(AnimatedCharacter);
            Tiphon.getInstance().init(LangManager.getInstance().getEntry("config.gfx.path.skull"), LangManager.getInstance().getEntry("config.gfx.path.skin"), LangManager.getInstance().getEntry("config.gfx.path.animIndex"));
            Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_COURSE);
            Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_MARCHE);
            Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_STATIQUE);
            var _loc_1:* = LangManager.getInstance().getStringEntry("config.lang.usingIME").split(",");
            if (_loc_1.indexOf(LangManager.getInstance().getStringEntry("config.lang.current")) != -1)
            {
                Berilia.getInstance().useIME = true;
            }
            return;
        }// end function

        public function reset(param1:Array = null, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_4:Message = null;
            if (Constants.EVENT_MODE)
            {
                _log.error("eventmode : quit");
                Dofus.getInstance().reboot();
            }
            if (!param2)
            {
                AuthentificationManager.getInstance().destroy();
            }
            UiModuleManager.getInstance().reset();
            if (Console.isVisible())
            {
                Console.getInstance().close();
            }
            ModuleDebugManager.display(false);
            FightersStateManager.getInstance().endFight();
            CurrentPlayedFighterManager.getInstance().endFight();
            PlayedCharacterManager.getInstance().destroy();
            SpellWrapper.removeAllSpellWrapper();
            Atouin.getInstance().reset();
            InactivityManager.getInstance().stop();
            DofusEntities.reset();
            _worker.clear();
            ItemWrapper.clearCache();
            SpeakingItemManager.getInstance().destroy();
            TimeoutHTMLLoader.resetCache();
            OptionManager.reset();
            this.initOptions();
            this.addInitialFrames(param3);
            Kernel.beingInReconection = false;
            if (param1 != null && param1.length > 0)
            {
                for each (_loc_4 in param1)
                {
                    
                    _worker.process(_loc_4);
                }
            }
            SoundManager.getInstance().manager.reset();
            return;
        }// end function

        public function initOptions() : void
        {
            var _loc_6:SystemPopupUI = null;
            OptionManager.reset();
            var _loc_1:* = new AtouinOptions(Dofus.getInstance().getWorldContainer(), Kernel.getWorker());
            _loc_1.frustum = new Frustum(LangManager.getInstance().getIntEntry("config.atouin.frustum.marginLeft"), LangManager.getInstance().getIntEntry("config.atouin.frustum.marginTop"), LangManager.getInstance().getIntEntry("config.atouin.frustum.marginRight"), LangManager.getInstance().getIntEntry("config.atouin.frustum.marginBottom"));
            _loc_1.mapsPath = LangManager.getInstance().getEntry("config.atouin.path.maps");
            _loc_1.elementsIndexPath = LangManager.getInstance().getEntry("config.atouin.path.elements");
            _loc_1.elementsPath = LangManager.getInstance().getEntry("config.gfx.path.cellElement");
            _loc_1.jpgSubPath = LangManager.getInstance().getEntry("config.gfx.subpath.world.jpg");
            _loc_1.pngSubPath = LangManager.getInstance().getEntry("config.gfx.subpath.world.png");
            _loc_1.particlesScriptsPath = LangManager.getInstance().getEntry("config.atouin.path.emitters");
            if (_loc_1.jpgSubPath.charAt(0) == "!")
            {
                _loc_1.jpgSubPath = "jpg";
            }
            if (_loc_1.pngSubPath.charAt(0) == "!")
            {
                _loc_1.pngSubPath = "png";
            }
            Atouin.getInstance().setDisplayOptions(_loc_1);
            var _loc_2:* = new DofusOptions();
            Dofus.getInstance().setDisplayOptions(_loc_2);
            var _loc_3:* = new BeriliaOptions();
            Berilia.getInstance().setDisplayOptions(_loc_3);
            var _loc_4:* = new TiphonOptions();
            Tiphon.getInstance().setDisplayOptions(_loc_4);
            var _loc_5:* = new TubulOptions();
            SoundManager.getInstance().setDisplayOptions(_loc_5);
            PerformanceManager.init(Dofus.getInstance().options["optimize"]);
            if (_loc_2.allowLog)
            {
                _worker.addFrame(LogFrame.getInstance(Constants.LOG_UPLOAD_MODE));
                _loc_2.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onDofusOptionChange);
            }
            else if (Constants.LOG_UPLOAD_MODE)
            {
                _loc_6 = new SystemPopupUI("logWarning");
                _loc_6.title = "Attention";
                _loc_6.content = "Vous participez au programme d\'analyse des performances de Dofus 2.0 mais le système de log est désactivé dans les options (Options -> Support)";
                _loc_6.show();
            }
            return;
        }// end function

        private function onDofusOptionChange(event:PropertyChangeEvent) : void
        {
            if (event.propertyName == "allowLog" && !event.propertyValue && _worker.contains(LogFrame))
            {
                _worker.removeFrame(_worker.getFrame(LogFrame));
            }
            return;
        }// end function

        private function addInitialFrames(param1:Boolean = false) : void
        {
            if (param1)
            {
                _worker.addFrame(new InitializationFrame());
            }
            else
            {
                _worker.addFrame(new LoadingModuleFrame(true));
                UiModuleManager.getInstance().reset();
                UiModuleManager.getInstance().init(Constants.COMMON_GAME_MODULE.concat(Constants.PRE_GAME_MODULE), true);
            }
            if (!_worker.contains(LatencyFrame))
            {
                _worker.addFrame(new LatencyFrame());
            }
            if (!_worker.contains(ServerControlFrame))
            {
                _worker.addFrame(new ServerControlFrame());
            }
            if (!_worker.contains(AuthorizedFrame))
            {
                _worker.addFrame(new AuthorizedFrame());
            }
            if (!_worker.contains(DebugFrame))
            {
                _worker.addFrame(new DebugFrame());
            }
            _worker.addFrame(new UIInteractionFrame());
            _worker.addFrame(new ShortcutsFrame());
            _worker.addFrame(new DisconnectionHandlerFrame());
            return;
        }// end function

        private function initCaches() : void
        {
            UriCacheFactory.init(".swf", new DisplayObjectCache(100));
            UriCacheFactory.init(".png", new Cache(200, new LruGarbageCollector()));
            return;
        }// end function

        public static function getInstance() : Kernel
        {
            if (_self == null)
            {
                _self = new Kernel;
            }
            return _self;
        }// end function

        public static function getWorker() : Worker
        {
            return _worker;
        }// end function

        public static function panic(param1:uint = 0, param2:Array = null) : void
        {
            var _loc_3:Sprite = null;
            var _loc_4:TextField = null;
            var _loc_5:TextField = null;
            var _loc_6:LoadingScreen = null;
            _worker.clear();
            ConnectionsHandler.closeConnection();
            if (Math.random() * 1000 > 999)
            {
                _loc_3 = new Sprite();
                _loc_3.graphics.beginFill(6710886, 0.9);
                _loc_3.graphics.drawRect(-2000, -2000, 5000, 5000);
                _loc_3.graphics.endFill();
                StageShareManager.stage.addChild(_loc_3);
                _loc_4 = new TextField();
                _loc_4.selectable = false;
                _loc_4.defaultTextFormat = new TextFormat("Courier New", 12, 16777215, true, false, false, null, null, TextFormatAlign.CENTER);
                _loc_4.text = "FATAL ERROR 0x" + param1.toString(16).toUpperCase();
                _loc_4.width = StageShareManager.stage.stageWidth;
                _loc_4.y = StageShareManager.stage.stageHeight / 2 - _loc_4.textHeight / 2;
                StageShareManager.stage.addChild(_loc_4);
                _loc_5 = new TextField();
                _loc_5.selectable = false;
                _loc_5.defaultTextFormat = new TextFormat("Courier New", 11, 16777215, false, false, false, null, null, TextFormatAlign.CENTER);
                _loc_5.text = "A fatal error has occured.\n" + PanicMessages.getMessage(param1, param2);
                _loc_5.width = StageShareManager.stage.stageWidth;
                _loc_5.height = _loc_5.textHeight + 10;
                _loc_5.y = StageShareManager.stage.stageHeight / 2 + _loc_4.textHeight / 2 + 10;
                StageShareManager.stage.addChild(_loc_5);
            }
            else
            {
                _loc_6 = new LoadingScreen();
                _loc_6.useEmbedFont = false;
                if (param1 == 4)
                {
                    _loc_6.tip = "FATAL ERROR 0x" + param1.toString(16).toUpperCase() + " : " + I18n.getUiText("ui.error.clientServerDesync");
                }
                else
                {
                    _loc_6.tip = "FATAL ERROR 0x" + param1.toString(16).toUpperCase() + "\n" + "A fatal error has occured.\n" + PanicMessages.getMessage(param1, param2);
                }
                _loc_6.log(PanicMessages.getMessage(param1, param2), LoadingScreen.ERROR);
                _loc_6.value = -1;
                _loc_6.showLog(false);
                Dofus.getInstance().addChild(_loc_6);
            }
            return;
        }// end function

    }
}
