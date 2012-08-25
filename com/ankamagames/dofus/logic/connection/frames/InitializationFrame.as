package com.ankamagames.dofus.logic.connection.frames
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.api.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.messages.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.datacenter.breeds.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.fight.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.internalDatacenter.house.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.manager.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.types.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.types.data.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.files.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.types.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class InitializationFrame extends Object implements Frame
    {
        private var _aFiles:Array;
        private var _aLoadedFiles:Array;
        private var _aModuleInit:Array;
        private var _loadingScreen:LoadingScreen;
        private var _percentPerModule:Number = 0;
        private var _modPercents:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InitializationFrame));

        public function InitializationFrame()
        {
            this._modPercents = new Array();
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            var _loc_1:Boolean = false;
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG)
            {
                KernelEventsManager.getInstance().disableAsyncError();
            }
            this.initPerformancesWatcher();
            this.initStaticConstants();
            this.initModulesBindings();
            this.displayLoadingScreen();
            this._aModuleInit = new Array();
            this._aModuleInit["config"] = false;
            this._aModuleInit["colors"] = false;
            this._aModuleInit["langFiles"] = false;
            this._aModuleInit["font"] = false;
            this._aModuleInit["i18n"] = false;
            this._aModuleInit["gameData"] = false;
            this._aModuleInit["modules"] = false;
            this._aModuleInit["uiXmlParsing"] = false;
            for each (_loc_1 in this._aModuleInit)
            {
                
                var _loc_4:String = this;
                var _loc_5:* = this._percentPerModule + 1;
                _loc_4._percentPerModule = _loc_5;
            }
            this._percentPerModule = 100 / this._percentPerModule;
            LangManager.getInstance().loadFile("config.xml");
            SubstituteAnimationManager.setDefaultAnimation("AnimStatique", "AnimStatique");
            SubstituteAnimationManager.setDefaultAnimation("AnimTacle", "AnimHit");
            SubstituteAnimationManager.setDefaultAnimation("AnimAttaque", "AnimAttaque0");
            SubstituteAnimationManager.setDefaultAnimation("AnimArme", "AnimArme0");
            SubstituteAnimationManager.setDefaultAnimation("AnimThrow", "AnimStatique");
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var langMsg:LangFileLoadedMessage;
            var langAllMsg:LangAllFilesLoadedMessage;
            var ankamaModule:Boolean;
            var mrlfm:ModuleRessourceLoadFailedMessage;
            var subConfigFile:String;
            var i:uint;
            var newValues:Array;
            var key:String;
            var keyInfo:Array;
            var oldKey:String;
            var lastLang:String;
            var resetLang:Boolean;
            var overrideFile:Uri;
            var currentCommunity:String;
            var msg:* = param1;
            switch(true)
            {
                case msg is LangFileLoadedMessage:
                {
                    langMsg = LangFileLoadedMessage(msg);
                    if (!langMsg.success)
                    {
                        if (langMsg.file.indexOf("i18n") > -1)
                        {
                            this._loadingScreen.log("Unabled to load i18n file " + langMsg.file, LoadingScreen.ERROR);
                            Kernel.panic(PanicMessages.I18N_LOADING_FAILED, [LangManager.getInstance().getEntry("config.lang.current")]);
                        }
                        else if (langMsg.file.indexOf("config.xml") > -1)
                        {
                            this._loadingScreen.log("Unabled to load main config file : " + langMsg.file, LoadingScreen.ERROR);
                            Kernel.panic(PanicMessages.CONFIG_LOADING_FAILED);
                        }
                        else if (langMsg.file.indexOf("config-") > -1)
                        {
                            this._loadingScreen.log("Unabled to load secondary config file : " + langMsg.file, LoadingScreen.INFO);
                            this._aModuleInit["config"] = true;
                            this.setModulePercent("config", 100);
                        }
                        else
                        {
                            this._loadingScreen.log("Unabled to load  " + langMsg.file, LoadingScreen.ERROR);
                        }
                    }
                    if (this._loadingScreen)
                    {
                        this._loadingScreen.log(langMsg.file + " loaded.", LoadingScreen.INFO);
                    }
                    return true;
                }
                case msg is LangAllFilesLoadedMessage:
                {
                    langAllMsg = LangAllFilesLoadedMessage(msg);
                    _log.debug("file : " + langAllMsg.file);
                    switch(langAllMsg.file)
                    {
                        case "file://config.xml":
                        {
                            if (!langAllMsg.success)
                            {
                                throw new BeriliaError("Impossible de charger " + langAllMsg.file);
                            }
                            Kernel.getInstance().postInit();
                            this._aFiles = new Array();
                            this._aLoadedFiles = new Array();
                            this._aFiles.push(LangManager.getInstance().getEntry("config.ui.asset.fontsList"));
                            i;
                            while (i < this._aFiles.length)
                            {
                                
                                FontManager.getInstance().loadFile(this._aFiles[i]);
                                i = (i + 1);
                            }
                            subConfigFile = "config-" + XmlConfig.getInstance().getEntry("config.lang.current") + ".xml";
                            if (File.applicationDirectory.resolvePath(subConfigFile).exists)
                            {
                                this._aFiles.push(subConfigFile);
                                LangManager.getInstance().loadFile(subConfigFile);
                                this.setModulePercent("config", 50);
                            }
                            else
                            {
                                this._aModuleInit["config"] = true;
                                this.setModulePercent("config", 100);
                            }
                            this._loadingScreen.value = this._loadingScreen.value + this._percentPerModule;
                            KernelEventsManager.getInstance().processCallback(HookList.ConfigStart);
                            this.initTubul();
                            if (!(SoundManager.getInstance().manager is ClassicSoundManager))
                            {
                                Berilia.getInstance().addUIListener(SoundManager.getInstance().manager);
                                TiphonEventsManager.addListener(SoundManager.getInstance().manager, "Sound");
                                TiphonEventsManager.addListener(SoundManager.getInstance().manager, "DataSound");
                            }
                            ThemeManager.getInstance().init();
                            ThemeManager.getInstance().applyTheme(OptionManager.getOptionManager("dofus").switchUiSkin);
                            CustomLoadingScreenManager.getInstance().loadCustomScreenList();
                            break;
                        }
                        default:
                        {
                            if (langAllMsg.file.indexOf("colors.xml") != -1)
                            {
                                if (!langAllMsg.success)
                                {
                                    throw new BeriliaError("Impossible de charger " + langAllMsg.file);
                                }
                                XmlConfig.getInstance().addCategory(LangManager.getInstance().getCategory("colors"));
                                this._aModuleInit["colors"] = true;
                                this.setModulePercent("colors", 100);
                                this._loadingScreen.value = this._loadingScreen.value + this._percentPerModule;
                                break;
                            }
                            else
                            {
                                if (langAllMsg.file.indexOf("config-") != -1)
                                {
                                    this._aLoadedFiles.push(langAllMsg.file);
                                    try
                                    {
                                        newValues = LangManager.getInstance().getCategory("config-" + XmlConfig.getInstance().getEntry("config.lang.current"));
                                        var _loc_3:int = 0;
                                        var _loc_4:* = newValues;
                                        while (_loc_4 in _loc_3)
                                        {
                                            
                                            key = _loc_4[_loc_3];
                                            keyInfo = key.split(".");
                                            keyInfo[0] = "config";
                                            oldKey = keyInfo.join(".");
                                            XmlConfig.getInstance().setEntry(oldKey, newValues[key]);
                                            LangManager.getInstance().setEntry(oldKey, newValues[key]);
                                        }
                                    }
                                    catch (e:Error)
                                    {
                                        throw e;
                                    }
                                    finally
                                    {
                                    }
                                }
                            }
                            return false;
        }// end function

        public function pulled() : Boolean
        {
            this._loadingScreen.parent.removeChild(this._loadingScreen);
            this._loadingScreen = null;
            StageShareManager.testQuality();
            EmbedFontManager.getInstance().removeEventListener(Event.COMPLETE, this.onFontsManagerInit);
            return true;
        }// end function

        private function initPerformancesWatcher() : void
        {
            DofusFpsManager.init();
            FpsControler.Init(ScriptedAnimation);
            return;
        }// end function

        private function initStaticConstants() : void
        {
            return;
        }// end function

        private function initModulesBindings() : void
        {
            ApiBinder.addApi("Ui", UiApi);
            ApiBinder.addApi("System", SystemApi);
            ApiBinder.addApi("Data", DataApi);
            ApiBinder.addApi("Time", TimeApi);
            ApiBinder.addApi("Tooltip", TooltipApi);
            ApiBinder.addApi("ContextMenu", ContextMenuApi);
            ApiBinder.addApi("Test", TestApi);
            ApiBinder.addApi("Jobs", JobsApi);
            ApiBinder.addApi("Storage", StorageApi);
            ApiBinder.addApi("Util", UtilApi);
            ApiBinder.addApi("Exchange", ExchangeApi);
            ApiBinder.addApi("Config", ConfigApi);
            ApiBinder.addApi("Binds", BindsApi);
            ApiBinder.addApi("Chat", ChatApi);
            ApiBinder.addApi("Sound", SoundApi);
            ApiBinder.addApi("Fight", FightApi);
            ApiBinder.addApi("PlayedCharacter", PlayedCharacterApi);
            ApiBinder.addApi("Connection", ConnectionApi);
            ApiBinder.addApi("Social", SocialApi);
            ApiBinder.addApi("Roleplay", RoleplayApi);
            ApiBinder.addApi("Map", MapApi);
            ApiBinder.addApi("Quest", QuestApi);
            ApiBinder.addApi("Alignment", AlignmentApi);
            ApiBinder.addApi("Inventory", InventoryApi);
            ApiBinder.addApi("Document", DocumentApi);
            ApiBinder.addApi("Mount", MountApi);
            ApiBinder.addApi("Party", PartyApi);
            ApiBinder.addApi("Highlight", HighlightApi);
            ApiBinder.addApi("File", FileApi);
            ApiBinder.addApi("Security", SecurityApi);
            ApiBinder.addApi("Capture", CaptureApi);
            TooltipsFactory.registerAssoc(String, "text");
            TooltipsFactory.registerAssoc(TextTooltipInfo, "textInfo");
            TooltipsFactory.registerAssoc(SpellWrapper, "spell");
            TooltipsFactory.registerAssoc(SpellTooltipInfo, "spellBanner");
            TooltipsFactory.registerAssoc(ItemWrapper, "item");
            TooltipsFactory.registerAssoc(WeaponWrapper, "item");
            TooltipsFactory.registerAssoc(SmileyWrapper, "smiley");
            TooltipsFactory.registerAssoc(ChatBubble, "chatBubble");
            TooltipsFactory.registerAssoc(ThinkBubble, "thinkBubble");
            TooltipsFactory.registerAssoc(GameRolePlayCharacterInformations, "player");
            TooltipsFactory.registerAssoc(GameRolePlayMutantInformations, "mutant");
            TooltipsFactory.registerAssoc(CharacterTooltipInformation, "player");
            TooltipsFactory.registerAssoc(MutantTooltipInformation, "mutant");
            TooltipsFactory.registerAssoc(GameRolePlayNpcInformations, "npc");
            TooltipsFactory.registerAssoc(GameRolePlayGroupMonsterInformations, "monsterGroup");
            TooltipsFactory.registerAssoc(GameRolePlayMerchantInformations, "merchant");
            TooltipsFactory.registerAssoc(GameRolePlayMerchantWithGuildInformations, "merchant");
            TooltipsFactory.registerAssoc(GroundObject, "groundObject");
            TooltipsFactory.registerAssoc(TaxCollectorTooltipInformation, "taxCollector");
            TooltipsFactory.registerAssoc(GameFightTaxCollectorInformations, "fightTaxCollector");
            TooltipsFactory.registerAssoc(EffectsWrapper, "effects");
            TooltipsFactory.registerAssoc(EffectsListWrapper, "effectsList");
            TooltipsFactory.registerAssoc(Vector.<String>, "texturesList");
            TooltipsFactory.registerAssoc(CraftSmileyItem, "craftSmiley");
            TooltipsFactory.registerAssoc(GameRolePlayPrismInformations, "prism");
            TooltipsFactory.registerAssoc(Object, "mount");
            TooltipsFactory.registerAssoc(MountWrapper, "mount");
            TooltipsFactory.registerAssoc(GameContextPaddockItemInformations, "paddockItem");
            TooltipsFactory.registerAssoc(GameRolePlayMountInformations, "paddockMount");
            TooltipsFactory.registerAssoc(ChallengeWrapper, "challenge");
            TooltipsFactory.registerAssoc(PaddockWrapper, "paddock");
            TooltipsFactory.registerAssoc(GameFightCharacterInformations, "playerFighter");
            TooltipsFactory.registerAssoc(GameFightMonsterInformations, "monsterFighter");
            TooltipsFactory.registerAssoc(HouseWrapper, "house");
            MenusFactory.registerAssoc(GameRolePlayMerchantInformations, "humanVendor");
            MenusFactory.registerAssoc(GameRolePlayMerchantWithGuildInformations, "humanVendor");
            MenusFactory.registerAssoc(ItemWrapper, "item");
            MenusFactory.registerAssoc(WeaponWrapper, "item");
            MenusFactory.registerAssoc(MountWrapper, "mount");
            MenusFactory.registerAssoc(GameRolePlayCharacterInformations, "player");
            MenusFactory.registerAssoc(GameRolePlayMutantInformations, "mutant");
            MenusFactory.registerAssoc(GameRolePlayNpcInformations, "npc");
            MenusFactory.registerAssoc(GameRolePlayNpcWithQuestInformations, "npc");
            MenusFactory.registerAssoc(GameRolePlayTaxCollectorInformations, "taxCollector");
            MenusFactory.registerAssoc(GameRolePlayPrismInformations, "prism");
            MenusFactory.registerAssoc(GameContextPaddockItemInformations, "paddockItem");
            MenusFactory.registerAssoc(GameRolePlayMountInformations, "mount");
            MenusFactory.registerAssoc(String, "player");
            HyperlinkFactory.registerProtocol("ui", HyperlinkDisplayArrowManager.showArrow);
            HyperlinkFactory.registerProtocol("spell", HyperlinkSpellManager.showSpell, HyperlinkSpellManager.getSpellName);
            HyperlinkFactory.registerProtocol("cell", HyperlinkShowCellManager.showCell);
            HyperlinkFactory.registerProtocol("entity", HyperlinkShowEntityManager.showEntity);
            HyperlinkFactory.registerProtocol("recipe", HyperlinkShowRecipeManager.showRecipe, HyperlinkShowRecipeManager.getRecipeName);
            HyperlinkFactory.registerProtocol("player", HyperlinkShowPlayerMenuManager.showPlayerMenu, HyperlinkShowPlayerMenuManager.getPlayerName, null, false);
            HyperlinkFactory.registerProtocol("account", HyperlinkShowAccountMenuManager.showAccountMenu);
            HyperlinkFactory.registerProtocol("item", HyperlinkItemManager.showItem, HyperlinkItemManager.getItemName);
            HyperlinkFactory.registerProtocol("map", HyperlinkMapPosition.showPosition, HyperlinkMapPosition.getText);
            HyperlinkFactory.registerProtocol("chatitem", HyperlinkItemManager.showChatItem, null, HyperlinkItemManager.duplicateChatHyperlink);
            HyperlinkFactory.registerProtocol("hook", HyperlinkSendHookManager.sendHook);
            HyperlinkFactory.registerProtocol("npc", HyperlinkShowNpcManager.showNpc);
            HyperlinkFactory.registerProtocol("monster", HyperlinkShowMonsterManager.showMonster, HyperlinkShowMonsterManager.getMonsterName);
            HyperlinkFactory.registerProtocol("monsterFight", HyperlinkShowMonsterFightManager.showEntity);
            HyperlinkFactory.registerProtocol("spellEffectArea", HyperlinkSpellManager.showSpellArea);
            HyperlinkFactory.registerProtocol("chatquest", HyperlinkShowQuestManager.showQuest, null, null);
            return;
        }// end function

        private function displayLoadingScreen() : void
        {
            this._loadingScreen = new LoadingScreen(false, true);
            Dofus.getInstance().addChild(this._loadingScreen);
            return;
        }// end function

        private function initTubul() : void
        {
            SoundManager.getInstance().checkSoundDirectory();
            return;
        }// end function

        private function checkInit() : void
        {
            var _loc_2:uint = 0;
            var _loc_3:String = null;
            var _loc_4:XML = null;
            var _loc_5:Array = null;
            var _loc_6:XML = null;
            var _loc_7:uint = 0;
            var _loc_8:Array = null;
            var _loc_9:Breed = null;
            var _loc_10:XML = null;
            var _loc_11:XML = null;
            var _loc_1:Boolean = true;
            for (_loc_3 in this._aModuleInit)
            {
                
                _loc_1 = _loc_1 && this._aModuleInit[_loc_3];
                if (!this._aModuleInit[_loc_3])
                {
                    _loc_2 = _loc_2 + 1;
                }
            }
            if (_loc_2 == 2)
            {
                UiModuleManager.getInstance().init(Constants.COMMON_GAME_MODULE.concat(Constants.PRE_GAME_MODULE), true);
            }
            if (_loc_1)
            {
                _loc_4 = describeType(GameDataList);
                _loc_5 = [];
                for each (_loc_6 in _loc_4..constant)
                {
                    
                    _loc_10 = describeType(getDefinitionByName(_loc_6.@type));
                    for each (_loc_11 in _loc_10..method)
                    {
                        
                        if (_loc_11.@returnType.toString() == _loc_6.@type.toString() && _loc_11.@name.toString().indexOf("get") == 0 && _loc_11.@name.toString().indexOf("ById") != -1)
                        {
                            _loc_5.push({fct:getDefinitionByName(_loc_6.@type)[_loc_11.@name.toString()], returnClass:getDefinitionByName(_loc_6.@type), testIndex:[0, 1, 2, 3, 4, 100, 1000, 2000, 10000, 100000]});
                        }
                    }
                }
                DofusApiAction.updateInfo();
                CensoredContentManager.getInstance().init(CensoredContent.getCensoredContents(), XmlConfig.getInstance().getEntry("config.lang.current"));
                _loc_8 = Breed.getBreeds();
                for each (_loc_9 in _loc_8)
                {
                    
                    _loc_7 = 1;
                    while (_loc_7 < _loc_9.alternativeFemaleSkin.length)
                    {
                        
                        Skin.addAlternativeSkin(_loc_9.alternativeFemaleSkin[0], _loc_9.alternativeFemaleSkin[_loc_7]);
                        _loc_7 = _loc_7 + 1;
                    }
                    _loc_7 = 1;
                    while (_loc_7 < _loc_9.alternativeMaleSkin.length)
                    {
                        
                        Skin.addAlternativeSkin(_loc_9.alternativeMaleSkin[0], _loc_9.alternativeMaleSkin[_loc_7]);
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _log.info("Initialization frame end");
                Constants.EVENT_MODE = LangManager.getInstance().getEntry("config.eventMode") == "true";
                Constants.EVENT_MODE_PARAM = LangManager.getInstance().getEntry("config.eventModeParams");
                Constants.CHARACTER_CREATION_ALLOWED = LangManager.getInstance().getEntry("config.characterCreationAllowed") == "true";
                Constants.FORCE_MAXIMIZED_WINDOW = LangManager.getInstance().getEntry("config.autoMaximize") == "true";
                if (Constants.FORCE_MAXIMIZED_WINDOW && AirScanner.hasAir())
                {
                    StageShareManager.stage["nativeWindow"].maximize();
                }
                Kernel.getWorker().removeFrame(this);
                Kernel.getWorker().addFrame(new AuthentificationFrame());
                Kernel.getWorker().addFrame(new QueueFrame());
                Kernel.getWorker().addFrame(new GameStartingFrame());
            }
            return;
        }// end function

        private function initFonts() : void
        {
            EmbedFontManager.getInstance().addEventListener(Event.COMPLETE, this.onFontsManagerInit);
            var _loc_1:* = FontManager.getInstance().getFontsList();
            EmbedFontManager.getInstance().initialize(_loc_1);
            return;
        }// end function

        private function setModulePercent(param1:String, param2:Number, param3:Boolean = false) : void
        {
            var _loc_5:Number = NaN;
            var _loc_6:uint = 0;
            if (!this._modPercents[param1])
            {
                this._modPercents[param1] = 0;
            }
            if (param3)
            {
                this._modPercents[param1] = this._modPercents[param1] + param2;
            }
            else
            {
                this._modPercents[param1] = param2;
            }
            var _loc_4:Number = 0;
            for each (_loc_5 in this._modPercents)
            {
                
                _loc_4 = _loc_4 + _loc_5 / 100 * this._percentPerModule;
            }
            _loc_6 = Dofus.getInstance().instanceId;
            if (this._modPercents[param1] == 100)
            {
                this._loadingScreen.log(param1 + " initialized", LoadingScreen.IMPORTANT);
            }
            this._loadingScreen.value = _loc_4;
            return;
        }// end function

        private function onFontsManagerInit(event:Event) : void
        {
            this._aModuleInit["font"] = true;
            this.setModulePercent("font", 100);
            this.checkInit();
            return;
        }// end function

        private function onI18nReady(event:Event) : void
        {
            this._aModuleInit["i18n"] = true;
            this.setModulePercent("i18n", 100);
            StoreDataManager.getInstance().setData(Constants.DATASTORE_LANG_VERSION, "lastLang", LangManager.getInstance().getEntry("config.lang.current"));
            this.checkInit();
            return;
        }// end function

        private function onGameDataReady(event:Event) : void
        {
            this._aModuleInit["gameData"] = true;
            this.setModulePercent("gameData", 100);
            this.checkInit();
            return;
        }// end function

        private function onGameDataPartialDataReady(event:LangFileEvent) : void
        {
            if (!this._loadingScreen)
            {
                this._loadingScreen = new LoadingScreen();
                Dofus.getInstance().addChild(this._loadingScreen);
            }
            this._loadingScreen.log("[GameData] " + FileUtils.getFileName(event.url) + " parsed", LoadingScreen.INFO);
            this.setModulePercent("gameData", this._percentPerModule * 1 / GameDataUpdater.getInstance().files.length, true);
            KernelEventsManager.getInstance().processCallback(HookList.LangFileLoaded, event.url, true);
            return;
        }// end function

        private function onI18nPartialDataReady(event:LangFileEvent) : void
        {
            this._loadingScreen.log("[i18n] " + FileUtils.getFileName(event.url) + " parsed", LoadingScreen.INFO);
            this.setModulePercent("i18n", this._percentPerModule * 1 / I18nUpdater.getInstance().files.length, true);
            KernelEventsManager.getInstance().processCallback(HookList.LangFileLoaded, event.url, true);
            return;
        }// end function

        private function onDataFileError(event:FileEvent) : void
        {
            this._loadingScreen.log("Unabled to load  " + event.file, LoadingScreen.ERROR);
            return;
        }// end function

    }
}
