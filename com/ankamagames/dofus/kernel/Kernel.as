package com.ankamagames.dofus.kernel
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.Sprite;
   import flash.text.TextField;
   import com.ankamagames.dofus.misc.utils.LoadingScreen;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.lists.GameDataList;
   import com.ankamagames.dofus.misc.lists.EnumList;
   import com.ankamagames.dofus.misc.lists.ApiList;
   import com.ankamagames.dofus.misc.lists.ApiActionList;
   import com.ankamagames.dofus.misc.lists.ApiRolePlayActionList;
   import com.ankamagames.dofus.misc.utils.DebugTarget;
   import flash.display.Stage;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   import com.ankamagames.jerakine.utils.misc.ApplicationDomainShareManager;
   import flash.system.ApplicationDomain;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.tiphon.engine.BoneIndexManager;
   import com.ankamagames.dofus.misc.utils.AnimationCleaner;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import com.ankamagames.dofus.network.Metadata;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.kernel.updater.UpdaterConnexionHandler;
   import com.ankamagames.dofus.datacenter.sounds.SoundUi;
   import com.ankamagames.dofus.datacenter.sounds.SoundUiElement;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.tiphon.types.Skin;
   import com.ankamagames.dofus.misc.utils.SkinPartTransformProvider;
   import com.ankamagames.dofus.logic.game.common.managers.AlmanaxManager;
   import com.ankamagames.berilia.managers.UiSoundManager;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.console.moduleLogger.Console;
   import com.ankamagames.dofus.console.moduleLogger.ModuleDebugManager;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.berilia.types.graphic.TimeoutHTMLLoader;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.jerakine.utils.system.SystemPopupUI;
   import com.ankamagames.atouin.types.AtouinOptions;
   import com.ankamagames.atouin.types.Frustum;
   import com.ankamagames.jerakine.messages.*;
   import com.ankamagames.jerakine.managers.*;
   import com.ankamagames.dofus.types.DofusOptions;
   import com.ankamagames.berilia.types.BeriliaOptions;
   import com.ankamagames.tiphon.types.TiphonOptions;
   import com.ankamagames.tubul.types.TubulOptions;
   import com.ankamagames.jerakine.replay.LogFrame;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.dofus.logic.connection.frames.InitializationFrame;
   import com.ankamagames.dofus.logic.common.frames.LoadingModuleFrame;
   import com.ankamagames.dofus.logic.common.frames.LatencyFrame;
   import com.ankamagames.dofus.logic.common.frames.ServerControlFrame;
   import com.ankamagames.dofus.logic.common.frames.AuthorizedFrame;
   import com.ankamagames.dofus.logic.game.common.frames.DebugFrame;
   import com.ankamagames.berilia.frames.UIInteractionFrame;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.dofus.logic.common.frames.DisconnectionHandlerFrame;
   import com.ankamagames.dofus.logic.common.frames.CleanupCrewFrame;
   import com.ankamagames.berilia.utils.UriCacheFactory;
   import com.ankamagames.jerakine.newCache.impl.DisplayObjectCache;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class Kernel extends Object
   {
      
      public function Kernel() {
         super();
         if(_self != null)
         {
            throw new SingletonError("Kernel is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Kernel));
      
      private static var _self:Kernel;
      
      private static var _worker:Worker = new Worker();
      
      public static var beingInReconection:Boolean;
      
      public static function getInstance() : Kernel {
         if(_self == null)
         {
            _self = new Kernel();
         }
         return _self;
      }
      
      public static function getWorker() : Worker {
         return _worker;
      }
      
      public static function panic(param1:uint=0, param2:Array=null) : void {
         var _loc3_:Sprite = null;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         var _loc6_:LoadingScreen = null;
         _worker.clear();
         ConnectionsHandler.closeConnection();
         if(Math.random() * 1000 > 999)
         {
            _loc3_ = new Sprite();
            _loc3_.graphics.beginFill(6710886,0.9);
            _loc3_.graphics.drawRect(-2000,-2000,5000,5000);
            _loc3_.graphics.endFill();
            StageShareManager.stage.addChild(_loc3_);
            _loc4_ = new TextField();
            _loc4_.selectable = false;
            _loc4_.defaultTextFormat = new TextFormat("Courier New",12,16777215,true,false,false,null,null,TextFormatAlign.CENTER);
            _loc4_.text = "FATAL ERROR 0x" + param1.toString(16).toUpperCase();
            _loc4_.width = StageShareManager.stage.stageWidth;
            _loc4_.y = StageShareManager.stage.stageHeight / 2 - _loc4_.textHeight / 2;
            StageShareManager.stage.addChild(_loc4_);
            _loc5_ = new TextField();
            _loc5_.selectable = false;
            _loc5_.defaultTextFormat = new TextFormat("Courier New",11,16777215,false,false,false,null,null,TextFormatAlign.CENTER);
            _loc5_.text = "A fatal error has occured.\n" + PanicMessages.getMessage(param1,param2);
            _loc5_.width = StageShareManager.stage.stageWidth;
            _loc5_.height = _loc5_.textHeight + 10;
            _loc5_.y = StageShareManager.stage.stageHeight / 2 + _loc4_.textHeight / 2 + 10;
            StageShareManager.stage.addChild(_loc5_);
         }
         else
         {
            _loc6_ = new LoadingScreen();
            _loc6_.useEmbedFont = false;
            if(param1 == 4)
            {
               _loc6_.tip = "FATAL ERROR 0x" + param1.toString(16).toUpperCase() + " : " + I18n.getUiText("ui.error.clientServerDesync");
            }
            else
            {
               _loc6_.tip = "FATAL ERROR 0x" + param1.toString(16).toUpperCase() + "\n" + "A fatal error has occured.\n" + PanicMessages.getMessage(param1,param2);
            }
            _loc6_.log(PanicMessages.getMessage(param1,param2),LoadingScreen.ERROR);
            _loc6_.value = -1;
            _loc6_.showLog(false);
            Dofus.getInstance().addChild(_loc6_);
         }
      }
      
      protected var _gamedataClassList:GameDataList = null;
      
      protected var _enumList:EnumList = null;
      
      protected var _apiList:ApiList = null;
      
      protected var _apiActionList:ApiActionList = null;
      
      protected var _ApiRolePlayActionList:ApiRolePlayActionList = null;
      
      private var _include_DebugTarget:DebugTarget = null;
      
      public function init(param1:Stage, param2:DisplayObject) : void {
         var stage:Stage = param1;
         var rootClip:DisplayObject = param2;
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
         if(AirScanner.hasAir())
         {
            try
            {
            }
            catch(e:Error)
            {
               _log.warn("Can\'t make connection to updater");
            }
         }
      }
      
      public function postInit() : void {
         var _loc2_:SoundUi = null;
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:SoundUiElement = null;
         this.initCaches();
         XmlConfig.getInstance().init(LangManager.getInstance().getCategory("config"));
         if(XmlConfig.getInstance().getEntry("config.buildType"))
         {
            _loc4_ = -1;
            _loc5_ = XmlConfig.getInstance().getEntry("config.buildType");
            switch(_loc5_.toLowerCase())
            {
               case "debug":
                  _loc4_ = BuildTypeEnum.DEBUG;
                  break;
               case "internal":
                  _loc4_ = BuildTypeEnum.INTERNAL;
                  break;
               case "testing":
                  _loc4_ = BuildTypeEnum.TESTING;
                  break;
               case "alpha":
                  _loc4_ = BuildTypeEnum.ALPHA;
                  break;
               case "beta":
                  _loc4_ = BuildTypeEnum.BETA;
                  break;
               case "release":
                  _loc4_ = BuildTypeEnum.RELEASE;
                  break;
            }
            if(!(_loc4_ == -1) && _loc4_ < BuildInfos.BUILD_TYPE)
            {
               BuildInfos.BUILD_TYPE = _loc4_;
            }
         }
         BuildInfos.BUILD_VERSION.buildType = BuildInfos.BUILD_TYPE;
         this.initOptions();
         Atouin.getInstance().showWorld(false);
         DataMapProvider.init(AnimatedCharacter);
         Tiphon.getInstance().init(LangManager.getInstance().getEntry("config.gfx.path.skull"),LangManager.getInstance().getEntry("config.gfx.path.skin"),LangManager.getInstance().getEntry("config.gfx.path.animIndex"));
         Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_COURSE);
         Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_MARCHE);
         Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_STATIQUE);
         Skin.skinPartTransformProvider = new SkinPartTransformProvider();
         AlmanaxManager.getInstance();
         UiSoundManager.getInstance().playSound = SoundManager.getInstance().manager.playUISound;
         var _loc1_:Array = SoundUi.getSoundUis();
         for each (_loc2_ in _loc1_)
         {
            UiSoundManager.getInstance().registerUi(_loc2_.uiName,_loc2_.openFile,_loc2_.closeFile);
            for each (_loc6_ in _loc2_.subElements)
            {
               UiSoundManager.getInstance().registerUiElement(_loc2_.uiName,_loc6_.name,_loc6_.hook,_loc6_.file);
            }
         }
         _loc3_ = LangManager.getInstance().getStringEntry("config.lang.usingIME").split(",");
         if(_loc3_.indexOf(LangManager.getInstance().getStringEntry("config.lang.current")) != -1)
         {
            Berilia.getInstance().useIME = true;
         }
      }
      
      public function reset(param1:Array=null, param2:Boolean=false, param3:Boolean=false) : void {
         var _loc4_:Message = null;
         if(Constants.EVENT_MODE)
         {
            _log.error("eventmode : quit");
            Dofus.getInstance().reboot();
         }
         if(!param2)
         {
            AuthentificationManager.getInstance().destroy();
         }
         UiModuleManager.getInstance().reset();
         if(Console.isVisible())
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
         if(!(param1 == null) && param1.length > 0)
         {
            for each (_loc4_ in param1)
            {
               _worker.process(_loc4_);
            }
         }
         SoundManager.getInstance().manager.reset();
         if((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().initialized))
         {
            ExternalNotificationManager.getInstance().reset();
         }
      }
      
      public function initOptions() : void {
         var _loc6_:SystemPopupUI = null;
         OptionManager.reset();
         var _loc1_:AtouinOptions = new AtouinOptions(Dofus.getInstance().getWorldContainer(),Kernel.getWorker());
         _loc1_.frustum = new Frustum(LangManager.getInstance().getIntEntry("config.atouin.frustum.marginLeft"),LangManager.getInstance().getIntEntry("config.atouin.frustum.marginTop"),LangManager.getInstance().getIntEntry("config.atouin.frustum.marginRight"),LangManager.getInstance().getIntEntry("config.atouin.frustum.marginBottom"));
         _loc1_.mapsPath = LangManager.getInstance().getEntry("config.atouin.path.maps");
         _loc1_.elementsIndexPath = LangManager.getInstance().getEntry("config.atouin.path.elements");
         _loc1_.elementsPath = LangManager.getInstance().getEntry("config.gfx.path.cellElement");
         _loc1_.jpgSubPath = LangManager.getInstance().getEntry("config.gfx.subpath.world.jpg");
         _loc1_.pngSubPath = LangManager.getInstance().getEntry("config.gfx.subpath.world.png");
         _loc1_.particlesScriptsPath = LangManager.getInstance().getEntry("config.atouin.path.emitters");
         _loc1_.mapPictoExtension = LangManager.getInstance().getEntry("config.gfx.subpath.world.extension");
         if(_loc1_.jpgSubPath.charAt(0) == "!")
         {
            _loc1_.jpgSubPath = "jpg";
         }
         if(_loc1_.pngSubPath.charAt(0) == "!")
         {
            _loc1_.pngSubPath = "png";
         }
         if(_loc1_.mapPictoExtension.charAt(0) == "!")
         {
            _loc1_.mapPictoExtension = "png";
         }
         Atouin.getInstance().setDisplayOptions(_loc1_);
         var _loc2_:DofusOptions = new DofusOptions();
         Dofus.getInstance().setDisplayOptions(_loc2_);
         var _loc3_:BeriliaOptions = new BeriliaOptions();
         Berilia.getInstance().setDisplayOptions(_loc3_);
         var _loc4_:TiphonOptions = new TiphonOptions();
         Tiphon.getInstance().setDisplayOptions(_loc4_);
         var _loc5_:TubulOptions = new TubulOptions();
         SoundManager.getInstance().setDisplayOptions(_loc5_);
         PerformanceManager.init(Dofus.getInstance().options["optimize"]);
         if(_loc2_.allowLog)
         {
            _worker.addFrame(LogFrame.getInstance(Constants.LOG_UPLOAD_MODE));
            _loc2_.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onDofusOptionChange);
         }
         else
         {
            if(Constants.LOG_UPLOAD_MODE)
            {
               _loc6_ = new SystemPopupUI("logWarning");
               _loc6_.title = "Attention";
               _loc6_.content = "Vous participez au programme d\'analyse des performances de Dofus 2.0 mais le système de log est désactivé dans les options (Options -> Support)";
               _loc6_.show();
            }
         }
      }
      
      private function onDofusOptionChange(param1:PropertyChangeEvent) : void {
         if(param1.propertyName == "allowLog" && !param1.propertyValue && (_worker.contains(LogFrame)))
         {
            _worker.removeFrame(_worker.getFrame(LogFrame));
         }
      }
      
      private function addInitialFrames(param1:Boolean=false) : void {
         if(param1)
         {
            _worker.addFrame(new InitializationFrame());
         }
         else
         {
            _worker.addFrame(new LoadingModuleFrame(true));
            UiModuleManager.getInstance().reset();
            UiModuleManager.getInstance().init(Constants.COMMON_GAME_MODULE.concat(Constants.PRE_GAME_MODULE),true);
         }
         if(!_worker.contains(LatencyFrame))
         {
            _worker.addFrame(new LatencyFrame());
         }
         if(!_worker.contains(ServerControlFrame))
         {
            _worker.addFrame(new ServerControlFrame());
         }
         if(!_worker.contains(AuthorizedFrame))
         {
            _worker.addFrame(new AuthorizedFrame());
         }
         if(!_worker.contains(DebugFrame))
         {
            _worker.addFrame(new DebugFrame());
         }
         _worker.addFrame(new UIInteractionFrame());
         _worker.addFrame(new ShortcutsFrame());
         _worker.addFrame(new DisconnectionHandlerFrame());
         if(!_worker.contains(CleanupCrewFrame))
         {
            _worker.addFrame(new CleanupCrewFrame());
         }
      }
      
      private function initCaches() : void {
         UriCacheFactory.init(".swf",new DisplayObjectCache(100));
         UriCacheFactory.init(".png",new Cache(200,new LruGarbageCollector()));
      }
   }
}
