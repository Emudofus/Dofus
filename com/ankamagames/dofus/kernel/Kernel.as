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
      
      protected static const _log:Logger;
      
      private static var _self:Kernel;
      
      private static var _worker:Worker;
      
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
      
      public static function panic(errorId:uint = 0, panicArgs:Array = null) : void {
         var blueScreen:Sprite = null;
         var errorTitle:TextField = null;
         var errorMsg:TextField = null;
         var ls:LoadingScreen = null;
         _worker.clear();
         ConnectionsHandler.closeConnection();
         if(Math.random() * 1000 > 999)
         {
            blueScreen = new Sprite();
            blueScreen.graphics.beginFill(6710886,0.9);
            blueScreen.graphics.drawRect(-2000,-2000,5000,5000);
            blueScreen.graphics.endFill();
            StageShareManager.stage.addChild(blueScreen);
            errorTitle = new TextField();
            errorTitle.selectable = false;
            errorTitle.defaultTextFormat = new TextFormat("Courier New",12,16777215,true,false,false,null,null,TextFormatAlign.CENTER);
            errorTitle.text = "FATAL ERROR 0x" + errorId.toString(16).toUpperCase();
            errorTitle.width = StageShareManager.stage.stageWidth;
            errorTitle.y = StageShareManager.stage.stageHeight / 2 - errorTitle.textHeight / 2;
            StageShareManager.stage.addChild(errorTitle);
            errorMsg = new TextField();
            errorMsg.selectable = false;
            errorMsg.defaultTextFormat = new TextFormat("Courier New",11,16777215,false,false,false,null,null,TextFormatAlign.CENTER);
            errorMsg.text = "A fatal error has occured.\n" + PanicMessages.getMessage(errorId,panicArgs);
            errorMsg.width = StageShareManager.stage.stageWidth;
            errorMsg.height = errorMsg.textHeight + 10;
            errorMsg.y = StageShareManager.stage.stageHeight / 2 + errorTitle.textHeight / 2 + 10;
            StageShareManager.stage.addChild(errorMsg);
         }
         else
         {
            ls = new LoadingScreen();
            ls.useEmbedFont = false;
            if(errorId == 4)
            {
               ls.tip = "FATAL ERROR 0x" + errorId.toString(16).toUpperCase() + " : " + I18n.getUiText("ui.error.clientServerDesync");
            }
            else
            {
               ls.tip = "FATAL ERROR 0x" + errorId.toString(16).toUpperCase() + "\n" + "A fatal error has occured.\n" + PanicMessages.getMessage(errorId,panicArgs);
            }
            ls.log(PanicMessages.getMessage(errorId,panicArgs),LoadingScreen.ERROR);
            ls.value = -1;
            ls.showLog(false);
            Dofus.getInstance().addChild(ls);
         }
      }
      
      protected var _gamedataClassList:GameDataList = null;
      
      protected var _enumList:EnumList = null;
      
      protected var _apiList:ApiList = null;
      
      protected var _apiActionList:ApiActionList = null;
      
      protected var _ApiRolePlayActionList:ApiRolePlayActionList = null;
      
      private var _include_DebugTarget:DebugTarget = null;
      
      public function init(stage:Stage, rootClip:DisplayObject) : void {
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
         var ui:SoundUi = null;
         var imeLang:Array = null;
         var buildType:* = 0;
         var configVersion:String = null;
         var uiElem:SoundUiElement = null;
         this.initCaches();
         XmlConfig.getInstance().init(LangManager.getInstance().getCategory("config"));
         if(XmlConfig.getInstance().getEntry("config.buildType"))
         {
            buildType = -1;
            configVersion = XmlConfig.getInstance().getEntry("config.buildType");
            switch(configVersion.toLowerCase())
            {
               case "debug":
                  buildType = BuildTypeEnum.DEBUG;
                  break;
               case "internal":
                  buildType = BuildTypeEnum.INTERNAL;
                  break;
               case "testing":
                  buildType = BuildTypeEnum.TESTING;
                  break;
               case "alpha":
                  buildType = BuildTypeEnum.ALPHA;
                  break;
               case "beta":
                  buildType = BuildTypeEnum.BETA;
                  break;
               case "release":
                  buildType = BuildTypeEnum.RELEASE;
                  break;
            }
            if((!(buildType == -1)) && (buildType < BuildInfos.BUILD_TYPE))
            {
               BuildInfos.BUILD_TYPE = buildType;
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
         var uiSound:Array = SoundUi.getSoundUis();
         for each(ui in uiSound)
         {
            UiSoundManager.getInstance().registerUi(ui.uiName,ui.openFile,ui.closeFile);
            for each(uiElem in ui.subElements)
            {
               UiSoundManager.getInstance().registerUiElement(ui.uiName,uiElem.name,uiElem.hook,uiElem.file);
            }
         }
         imeLang = LangManager.getInstance().getStringEntry("config.lang.usingIME").split(",");
         if(imeLang.indexOf(LangManager.getInstance().getStringEntry("config.lang.current")) != -1)
         {
            Berilia.getInstance().useIME = true;
         }
      }
      
      public function reset(messagesToDispatchAfter:Array = null, autoRetry:Boolean = false, reloadData:Boolean = false) : void {
         var msg:Message = null;
         if(Constants.EVENT_MODE)
         {
            _log.error("eventmode : quit");
            Dofus.getInstance().reboot();
         }
         if(!autoRetry)
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
         this.addInitialFrames(reloadData);
         Kernel.beingInReconection = false;
         if((!(messagesToDispatchAfter == null)) && (messagesToDispatchAfter.length > 0))
         {
            for each(msg in messagesToDispatchAfter)
            {
               _worker.process(msg);
            }
         }
         SoundManager.getInstance().manager.reset();
         if((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().initialized))
         {
            ExternalNotificationManager.getInstance().reset();
         }
      }
      
      public function initOptions() : void {
         var popup:SystemPopupUI = null;
         OptionManager.reset();
         var ao:AtouinOptions = new AtouinOptions(Dofus.getInstance().getWorldContainer(),Kernel.getWorker());
         ao.frustum = new Frustum(LangManager.getInstance().getIntEntry("config.atouin.frustum.marginLeft"),LangManager.getInstance().getIntEntry("config.atouin.frustum.marginTop"),LangManager.getInstance().getIntEntry("config.atouin.frustum.marginRight"),LangManager.getInstance().getIntEntry("config.atouin.frustum.marginBottom"));
         ao.mapsPath = LangManager.getInstance().getEntry("config.atouin.path.maps");
         ao.elementsIndexPath = LangManager.getInstance().getEntry("config.atouin.path.elements");
         ao.elementsPath = LangManager.getInstance().getEntry("config.gfx.path.cellElement");
         ao.jpgSubPath = LangManager.getInstance().getEntry("config.gfx.subpath.world.jpg");
         ao.pngSubPath = LangManager.getInstance().getEntry("config.gfx.subpath.world.png");
         ao.particlesScriptsPath = LangManager.getInstance().getEntry("config.atouin.path.emitters");
         ao.mapPictoExtension = LangManager.getInstance().getEntry("config.gfx.subpath.world.extension");
         if(ao.jpgSubPath.charAt(0) == "!")
         {
            ao.jpgSubPath = "jpg";
         }
         if(ao.pngSubPath.charAt(0) == "!")
         {
            ao.pngSubPath = "png";
         }
         if(ao.mapPictoExtension.charAt(0) == "!")
         {
            ao.mapPictoExtension = "png";
         }
         Atouin.getInstance().setDisplayOptions(ao);
         var dofusO:DofusOptions = new DofusOptions();
         Dofus.getInstance().setDisplayOptions(dofusO);
         var beriliaO:BeriliaOptions = new BeriliaOptions();
         Berilia.getInstance().setDisplayOptions(beriliaO);
         var tiphonO:TiphonOptions = new TiphonOptions();
         Tiphon.getInstance().setDisplayOptions(tiphonO);
         var tubulO:TubulOptions = new TubulOptions();
         SoundManager.getInstance().setDisplayOptions(tubulO);
         PerformanceManager.init(Dofus.getInstance().options["optimize"]);
         if(dofusO.allowLog)
         {
            _worker.addFrame(LogFrame.getInstance(Constants.LOG_UPLOAD_MODE));
            dofusO.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onDofusOptionChange);
         }
         else if(Constants.LOG_UPLOAD_MODE)
         {
            popup = new SystemPopupUI("logWarning");
            popup.title = "Attention";
            popup.content = "Vous participez au programme d\'analyse des performances de Dofus 2.0 mais le système de log est désactivé dans les options (Options -> Support)";
            popup.show();
         }
         
      }
      
      private function onDofusOptionChange(e:PropertyChangeEvent) : void {
         if((e.propertyName == "allowLog") && (!e.propertyValue) && (_worker.contains(LogFrame)))
         {
            _worker.removeFrame(_worker.getFrame(LogFrame));
         }
      }
      
      private function addInitialFrames(firstLaunch:Boolean = false) : void {
         if(firstLaunch)
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
