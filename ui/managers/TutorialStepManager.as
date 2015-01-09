package managers
{
    import d2hooks.EquipmentObjectMove;
    import d2hooks.GameFightStarting;
    import d2hooks.GameFightStart;
    import d2hooks.GameEntityDisposition;
    import d2hooks.PlayerFightMove;
    import d2hooks.FightSpellCast;
    import d2hooks.GameFightTurnEnd;
    import d2hooks.PlayerMove;
    import d2hooks.UiLoaded;
    import d2hooks.UiUnloaded;
    import d2hooks.StorageFilterUpdated;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.DropStart;
    import d2hooks.DropEnd;
    import d2hooks.CastSpellMode;
    import d2hooks.CancelCastSpell;
    import d2hooks.GameFightEnd;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2data.ItemWrapper;
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import d2actions.QuestObjectiveValidation;
    import d2data.Bind;
    import d2data.ItemType;
    import d2data.ShortcutWrapper;
    import d2hooks.*;
    import d2actions.*;

    public class TutorialStepManager 
    {

        private static var _self:TutorialStepManager;
        private static var _watchedComponents:Object = null;
        private static var _fightWatchedComponents:Object = null;
        private static var _disabledShortcuts:Object = {
            "cac":false,
            "s1":false,
            "s2":false,
            "s3":false,
            "s4":false,
            "s5":false,
            "s6":false,
            "s7":false,
            "s8":false,
            "s9":false,
            "s10":false,
            "s11":false,
            "s12":false,
            "s13":false,
            "s14":false,
            "s15":false,
            "s16":false,
            "s17":false,
            "s18":false,
            "s19":false,
            "s20":false,
            "skipTurn":false,
            "bannerSpellsTab":false,
            "bannerItemsTab":false,
            "bannerEmotesTab":false,
            "bannerPreviousTab":false,
            "bannerNextTab":false,
            "flagCurrentMap":false,
            "openInventory":false,
            "openBookSpell":false,
            "openBookQuest":false,
            "openBookAlignment":false,
            "openBookJob":false,
            "openWorldMap":false,
            "openSocialFriends":false,
            "openSocialGuild":false,
            "openSocialAlliance":false,
            "openSocialSpouse":false,
            "openCharacterSheet":false,
            "openMount":false,
            "openWebBrowser":false,
            "openTeamSearch":false,
            "openPvpArena":false,
            "openSell":false,
            "openAlmanax":false,
            "openAchievement":false,
            "openTitle":false,
            "openBestiary":false,
            "openSocialAlliance":false,
            "showAllNames":false,
            "showMonstersInfo":false,
            "toggleRide":false,
            "pageItem1":false,
            "pageItem2":false,
            "pageItem3":false,
            "pageItem4":false,
            "pageItem5":false,
            "pageItemDown":false,
            "pageItemUp":false
        };
        private static var _dropItem:Object;
        private static const ID_BTN_CARAC:int = 1;
        private static const ID_BTN_SPELL:int = 2;
        private static const ID_BTN_BAG:int = 3;
        private static const ID_BTN_BOOK:int = 4;
        private static const ID_BTN_MAP:int = 5;
        private static const ID_BTN_FRIEND:int = 6;
        private static const ID_BTN_GUILD:int = 7;
        private static const ID_BTN_TEAMSEARCH:int = 8;
        private static const ID_BTN_CONQUEST:int = 9;
        private static const ID_BTN_OGRINE:int = 10;
        private static const ID_BTN_JOB:int = 11;
        private static const ID_BTN_ALLIANCE:int = 12;
        private static const ID_BTN_MOUNT:int = 13;
        private static const ID_BTN_SHOP:int = 14;
        private static const ID_BTN_SPOUSE:int = 15;
        private static const ID_BTN_KROZ:int = 16;
        private static const ID_BTN_DIRECTORY:int = 22;

        private var _bannerUiClass:Object;
        private var _currentStepNumber:int = -1;
        private var _quest:Object;
        private var _disabled:Boolean = false;

        public function TutorialStepManager()
        {
            Api.system.addHook(EquipmentObjectMove, this.onEquipmentObjectMove);
            Api.system.addHook(GameFightStarting, this.onGameFightStarting);
            Api.system.addHook(GameFightStart, this.onGameFightStart);
            Api.system.addHook(GameEntityDisposition, this.onGameEntityDisposition);
            Api.system.addHook(PlayerFightMove, this.onPlayerFightMove);
            Api.system.addHook(FightSpellCast, this.onFightSpellCast);
            Api.system.addHook(GameFightTurnEnd, this.onGameFightTurnEnd);
            Api.system.addHook(PlayerMove, this.onPlayerMove);
            Api.system.addHook(UiLoaded, this.onUiLoaded);
            Api.system.addHook(UiUnloaded, this.onUiUnloaded);
            Api.system.addHook(StorageFilterUpdated, this.onStorageFilterUpdated);
            Api.system.addHook(MapComplementaryInformationsData, this.onMapComplementaryInformationsData);
            Api.system.addHook(DropStart, this.onDropStart);
            Api.system.addHook(DropEnd, this.onDropEnd);
            Api.system.addHook(CastSpellMode, this.onCastSpellMode);
            Api.system.addHook(CancelCastSpell, this.onCancelCastSpell);
            Api.system.addHook(GameFightEnd, this.onGameFightEnd);
            this._quest = Api.data.getQuest(TutorialConstants.QUEST_TUTORIAL_ID);
            this._disabled = true;
        }

        public static function initStepManager():void
        {
            _self = new (TutorialStepManager)();
        }

        public static function getInstance():TutorialStepManager
        {
            if (_self == null)
            {
                initStepManager();
            };
            return (_self);
        }


        public function get preloaded():Boolean
        {
            return (((!((_watchedComponents == null))) && (!((_fightWatchedComponents == null)))));
        }

        public function set disabled(b:Boolean):void
        {
            this._disabled = b;
            if (b)
            {
                this.unsetAllDisabled();
            }
            else
            {
                this.redoSteps();
            };
        }

        public function get disabled():Boolean
        {
            return (this._disabled);
        }

        private function onPlayerMove():void
        {
            if (!(this.disabled))
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE)
                {
                    this.validateCurrentStep();
                };
            };
        }

        private function onGameFightEnd(params:Object):void
        {
            if (!(this.disabled))
            {
                Api.highlight.stop();
            };
        }

        private function onEquipmentObjectMove(item:Object, oldPosition:uint):void
        {
            var _local_3:int;
            var _local_4:Boolean;
            var i:Object;
            if (!(this.disabled))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        if (item)
                        {
                            this.validateCurrentStep();
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        _local_3 = 0;
                        _local_4 = false;
                        for each (i in Api.storage.getViewContent("equipment"))
                        {
                            if (!(i))
                            {
                            }
                            else
                            {
                                if (TutorialConstants.TUTORIAL_RINGS_POSITIONS.indexOf(i.position) != -1)
                                {
                                    _local_4 = true;
                                }
                                else
                                {
                                    if (TutorialConstants.TUTORIAL_ITEMS_POSITIONS.indexOf(i.position) != -1)
                                    {
                                        _local_3++;
                                    };
                                };
                            };
                        };
                        if ((((_local_3 == TutorialConstants.TUTORIAL_ITEMS_POSITIONS.length)) && (_local_4)))
                        {
                            this.validateCurrentStep();
                        };
                        break;
                };
            };
        }

        private function onGameFightStarting(fightType:uint):void
        {
            if (!(this.disabled))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                        this.validateCurrentStep();
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        this.validateCurrentStep();
                        break;
                };
            };
        }

        private function onGameEntityDisposition(dispositionInformation:Object, cellId:uint, direction:uint):void
        {
            if (!(this.disabled))
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION)
                {
                    this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__START_FIGHT);
                };
            };
        }

        private function onGameFightStart():void
        {
            if (!(this.disabled))
            {
                if (this._currentStepNumber < TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL)
                {
                    _watchedComponents["SpellsBanner"].disabled = true;
                };
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION)
                {
                    this.validateCurrentStep();
                };
            };
        }

        private function onPlayerFightMove():void
        {
            if (!(this.disabled))
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_MOVE)
                {
                    this.validateCurrentStep();
                };
            };
        }

        private function onFightSpellCast():void
        {
            if (!(this.disabled))
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL)
                {
                    this.validateCurrentStep();
                };
            };
        }

        private function onGameFightTurnEnd(entityId:uint):void
        {
            if (!(this.disabled))
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_SKIP_TURN)
                {
                    if (entityId == Api.player.id())
                    {
                        this.validateCurrentStep();
                    };
                };
            };
        }

        private function onUiLoaded(name:String):void
        {
            var ui:Object;
            if (!(this.disabled))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_TALK:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_RESPONSE);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_RESPONSE);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_RESPONSE);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            ui = Api.ui.getUi(name);
                            if (((ui) && (!((ui.uiClass.categoryFilter == 0)))))
                            {
                                this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB);
                            }
                            else
                            {
                                this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
                            };
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION);
                        };
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            ui = Api.ui.getUi(name);
                            if (ui)
                            {
                                ui.uiClass.categoryFilter = 0;
                            };
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
                        };
                        break;
                };
            };
        }

        private function onUiUnloaded(name:String):void
        {
            if (!(this.disabled))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_TALK:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__OPEN_CHARACTER_SHEET);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_CHARACTER_SHEET);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION);
                        };
                        break;
                };
            };
        }

        public function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean):void
        {
            if (!(this.disabled))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_TALK:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__SHOW_MONSTER);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        if (map.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC);
                        break;
                };
            };
        }

        public function onDropStart(src:Object):void
        {
            if (((!(this.disabled)) && (src.data)))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        if ((src.data is ItemWrapper))
                        {
                            _dropItem = src.data;
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TARGET);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        if ((src.data is ItemWrapper))
                        {
                            _dropItem = src.data;
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT_TARGET);
                        };
                        break;
                };
            };
        }

        public function onDropEnd(src:Object):void
        {
            if (!(this.disabled))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
                        break;
                };
            };
        }

        public function onCastSpellMode(spell:Object):void
        {
            if (!(this.disabled))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_TARGET);
                        break;
                };
            };
        }

        public function onCancelCastSpell(spell:Object):void
        {
            if (!(this.disabled))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_SPELL);
                        break;
                };
            };
        }

        public function onStorageFilterUpdated(items:Object, category:int):void
        {
            switch (this._currentStepNumber)
            {
                case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                    if (category == 0)
                    {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
                    }
                    else
                    {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB);
                    };
                    break;
                case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                    if (category == 0)
                    {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
                    }
                    else
                    {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_TAB);
                    };
                    break;
            };
        }

        public function preload():void
        {
            this.loadWatchedComponents();
            this.loadFightWatchedComponents();
        }

        public function loadWatchedComponents():void
        {
            this._bannerUiClass = Api.ui.getUi(UIEnum.BANNER).uiClass;
            _watchedComponents = new Dictionary();
            _watchedComponents["SpellsBanner"] = this._bannerUiClass.gd_spellitemotes;
            _watchedComponents["InventoryButton"] = ID_BTN_BAG;
            _watchedComponents["GrimoireButton"] = ID_BTN_SPELL;
            _watchedComponents["QuestButton"] = ID_BTN_BOOK;
            _watchedComponents["MoreBtnButton"] = this._bannerUiClass.btn_moreBtn;
            _watchedComponents["MoreBtnCtr"] = this._bannerUiClass.ctr_moreBtn;
            _watchedComponents["SpellTab"] = this._bannerUiClass.btn_tabSpells;
            _watchedComponents["InventoryTab"] = this._bannerUiClass.btn_tabItems;
            this.checkComponents(_watchedComponents);
        }

        public function loadFightWatchedComponents():void
        {
            var bannerUiClass:Object = Api.ui.getUi(UIEnum.BANNER).uiClass;
            _fightWatchedComponents = new Dictionary();
            _fightWatchedComponents["SkipTurnButton"] = bannerUiClass.btn_skipTurn;
            _fightWatchedComponents["ReadyButton"] = bannerUiClass.btn_ready;
            _fightWatchedComponents["LeaveButton"] = bannerUiClass.btn_leave;
            _fightWatchedComponents["HelpButton"] = bannerUiClass.btn_help;
            _fightWatchedComponents["AllowJoinFightButton"] = bannerUiClass.btn_lock;
            _fightWatchedComponents["AllowJoinFightPartyButton"] = bannerUiClass.btn_lockparty;
            _fightWatchedComponents["InvisibleModeButton"] = bannerUiClass.btn_invimode;
            _fightWatchedComponents["AllowSpectatorButton"] = bannerUiClass.btn_witness;
            _fightWatchedComponents["ShowCellButton"] = bannerUiClass.btn_pointCell;
            this.checkComponents(_fightWatchedComponents);
        }

        public function unsetAllDisabled():void
        {
            this.setWatchedElementsDisabled(false);
            this.setFightWatchedElementsDisabled(false);
            this._bannerUiClass.checkJob(false);
            this._bannerUiClass.checkMount(false);
            this._bannerUiClass.checkSpouse(false);
            this._bannerUiClass.checkGuild(false);
            this._bannerUiClass.checkAlliance(false);
            this._bannerUiClass.checkConquest(false);
            this._bannerUiClass.checkWeb(false);
        }

        public function prepareStep(stepNumber:uint, subStep:uint=0, displayArrow:Boolean=false):void
        {
            var _local_4:Object;
            var _local_5:Object;
            var cellId:int;
            var fighter:Object;
            var _local_8:Object;
            var superTypeId:uint;
            var positions:Object;
            this._currentStepNumber = stepNumber;
            this.moveTutorialUiDefault();
            Api.highlight.stop();
            if (!(this.disabled))
            {
                switch (stepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE:
                        this.setWatchedElementsDisabled(true);
                        if (displayArrow)
                        {
                            Api.highlight.highlightAbsolute(new Rectangle(TutorialConstants.ROLEPLAY_MOVE_DESTINATION_X, TutorialConstants.ROLEPLAY_MOVE_DESTINATION_Y), 0, 0, 0, true);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_TALK:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_TALK__LOADING_MAP:
                                Api.modMenu.getMenuMaker("npc").maker.disabled = false;
                            case TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_RESPONSE:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightAbsolute(new Rectangle(TutorialConstants.RESPONSE_UI_ABSOLUTE_X, TutorialConstants.RESPONSE_UI_ABSOLUTE_Y), TutorialConstants.RESPONSE_UI_ABSOLUTE_POS, TutorialConstants.RESPONSE_UI_ABSOLUTE_REVERSE, 5, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__OPEN_CHARACTER_SHEET:
                                this._bannerUiClass.setDisabledBtn(_watchedComponents["InventoryButton"], false);
                                this.setShortcutDisabled("openInventory", false);
                                _local_5 = this._bannerUiClass.getSlotByBtnId(_watchedComponents["InventoryButton"]).getStageRect();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightAbsolute(new Rectangle(_local_5.x, _local_5.y, _local_5.width, _local_5.height), 1, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btnEquipable", 0, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "grid", 0, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TARGET:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "slot_2", 5, 0, 5, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                        if (!(Api.ui.getUi(UIEnum.STORAGE_UI)))
                        {
                            subStep = TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION;
                        };
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__CLOSE_CHARACTER_SHEET:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btnClose", 7, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightMapTransition(TutorialConstants.TUTORIAL_MAP_ID_FIRST, TutorialConstants.CHANGE_MAP_TRANSITION_ORIENTATION, TutorialConstants.CHANGE_MAP_TRANSITION_POSITION, false, 0, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                        this.setFightWatchedElementsDisabled(true);
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__LOADING_MAP:
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__SHOW_MONSTER:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_POUTCH, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__SHOW_CELL:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightCell(TutorialConstants.FIGHT_LOCATION_TARGET_CELLS, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__START_FIGHT:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.BANNER, "btn_ready", 0, 0, 5, true);
                                };
                                this.setShortcutDisabled("skipTurn", false);
                                _fightWatchedComponents["ReadyButton"].disabled = false;
                                Api.modMenu.getMenuMaker("player").maker.disabled = false;
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_MOVE:
                        _fightWatchedComponents["ReadyButton"].disabled = false;
                        if (((Api.player.isInFight()) && (displayArrow)))
                        {
                            cellId = -1;
                            fighter = Api.fight.getFighterInformations(Api.player.id());
                            if (fighter)
                            {
                                cellId = TutorialConstants.FIGHT_MOVE_TARGET_CELLS[fighter.currentCell];
                                Api.highlight.highlightCell([cellId], true);
                            };
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_SPELL:
                                if (((Api.player.isInFight()) && (displayArrow)))
                                {
                                    Api.highlight.highlightUi(UIEnum.BANNER, "gd_spellitemotes", 0, 0, 5, true);
                                };
                                _fightWatchedComponents["SkipTurnButton"].disabled = false;
                                this.setShortcutDisabled("skipTurn", false);
                                _watchedComponents["SpellsBanner"].disabled = false;
                                this.setShortcutDisabled("cac", false);
                                this.setShortcutDisabled("s1", false);
                                this.setShortcutDisabled("s2", false);
                                this.setShortcutDisabled("s3", false);
                                this.setShortcutDisabled("s4", false);
                                this.setShortcutDisabled("s5", false);
                                this.setShortcutDisabled("s6", false);
                                this.setShortcutDisabled("s7", false);
                                this.setShortcutDisabled("s8", false);
                                this.setShortcutDisabled("s9", false);
                                this.setShortcutDisabled("s10", false);
                                this.setShortcutDisabled("s11", false);
                                this.setShortcutDisabled("s12", false);
                                this.setShortcutDisabled("s13", false);
                                this.setShortcutDisabled("s14", false);
                                this.setShortcutDisabled("s15", false);
                                this.setShortcutDisabled("s16", false);
                                this.setShortcutDisabled("s17", false);
                                this.setShortcutDisabled("s18", false);
                                this.setShortcutDisabled("s19", false);
                                this.setShortcutDisabled("s20", false);
                                this.setShortcutDisabled("pageItem1", false);
                                this.setShortcutDisabled("pageItem2", false);
                                this.setShortcutDisabled("pageItem3", false);
                                this.setShortcutDisabled("pageItem4", false);
                                this.setShortcutDisabled("pageItem5", false);
                                this.setShortcutDisabled("pageItemDown", false);
                                this.setShortcutDisabled("pageItemUp", false);
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_TARGET:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_POUTCH, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_SKIP_TURN:
                        if (((Api.player.isInFight()) && (displayArrow)))
                        {
                            Api.highlight.highlightUi(UIEnum.BANNER, "btn_skipTurn", 0, 0, 5, true);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_WIN:
                        break;
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__LOADING_MAP:
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_RESPONSE:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightAbsolute(new Rectangle(TutorialConstants.RESPONSE_UI_ABSOLUTE_X, TutorialConstants.RESPONSE_UI_ABSOLUTE_Y), TutorialConstants.RESPONSE_UI_ABSOLUTE_POS, TutorialConstants.RESPONSE_UI_ABSOLUTE_REVERSE, 5, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_CHARACTER_SHEET:
                                this._bannerUiClass.setDisabledBtn(_watchedComponents["GrimoireButton"], false);
                                this._bannerUiClass.setDisabledBtn(_watchedComponents["QuestButton"], false);
                                this.setShortcutDisabled("openBook", false);
                                this.setShortcutDisabled("openBookSpell", false);
                                this.setShortcutDisabled("openBookQuest", false);
                                _local_8 = this._bannerUiClass.getSlotByBtnId(_watchedComponents["InventoryButton"]).getStageRect();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightAbsolute(new Rectangle(_local_8.x, _local_8.y, _local_8.width, _local_8.height), 1, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_TAB:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btnEquipable", 0, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "grid", 0, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT_TARGET:
                                this.moveTutorialUiLeft();
                                if (((displayArrow) && (_dropItem)))
                                {
                                    superTypeId = this.getItemSuperType(_dropItem);
                                    positions = Api.storage.itemSuperTypeToServerPosition(superTypeId);
                                    if (positions[0] != null)
                                    {
                                        Api.highlight.highlightUi(UIEnum.STORAGE_UI, ("slot_" + positions[0]), 5, 0, 5, true);
                                    };
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        _local_4 = Api.player.currentMap();
                        if ((((subStep == TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__CLOSE_CHARACTER_SHEET)) && (!(Api.ui.getUi(UIEnum.STORAGE_UI)))))
                        {
                            subStep = TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION;
                        };
                        if ((((subStep == TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION)) && ((_local_4.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT))))
                        {
                            subStep = TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS;
                        };
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__CLOSE_CHARACTER_SHEET:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btnClose", 7, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION:
                                if (_local_4.mapId == TutorialConstants.TUTORIAL_MAP_ID_SECOND_AFTER_FIGHT)
                                {
                                    if (displayArrow)
                                    {
                                        Api.highlight.highlightMapTransition(TutorialConstants.TUTORIAL_MAP_ID_SECOND_AFTER_FIGHT, TutorialConstants.FIND_BOSS_TRANSITION_ORIENTATION, TutorialConstants.FIND_BOSS_TRANSITION_POSITION, false, 0, true);
                                    };
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__LOADING_MAP:
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS:
                                if (_local_4.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT)
                                {
                                    if (displayArrow)
                                    {
                                        Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_BOSS, true);
                                    };
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_KILL_BOSS:
                        Api.highlight.forceArrowPosition("banner", "tx_timeFrame", new Point(640, 880));
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__LOADING_MAP:
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_RESPONSE:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightAbsolute(new Rectangle(TutorialConstants.RESPONSE_UI_ABSOLUTE_X, TutorialConstants.RESPONSE_UI_ABSOLUTE_Y), TutorialConstants.RESPONSE_UI_ABSOLUTE_POS, TutorialConstants.RESPONSE_UI_ABSOLUTE_REVERSE, 5, true);
                                };
                                break;
                        };
                        break;
                };
            };
        }

        public function redoSteps():void
        {
            var max:uint;
            if (this._currentStepNumber != -1)
            {
                max = this._currentStepNumber;
                this._currentStepNumber = 0;
                this.jumpToStep(max);
            };
        }

        public function jumpToStep(stepNumber:uint):void
        {
            if (this._currentStepNumber == -1)
            {
                this._currentStepNumber = 0;
            };
            var i:uint = this._currentStepNumber;
            while (i <= stepNumber)
            {
                this.prepareStep(i, 0, (i == stepNumber));
                i++;
            };
        }

        private function moveTutorialUiDefault():void
        {
            var tutorialUi:Object = Api.ui.getUi(UIEnum.TUTORIAL_UI);
            if (tutorialUi)
            {
                tutorialUi.uiClass.moveDefault();
            };
        }

        private function moveTutorialUiLeft():void
        {
            var tutorialUi:Object = Api.ui.getUi(UIEnum.TUTORIAL_UI);
            if (tutorialUi)
            {
                tutorialUi.uiClass.moveLeft();
            };
        }

        private function validateCurrentStep():void
        {
            var obj:uint;
            if (this._currentStepNumber != -1)
            {
                for each (obj in this._quest.steps[this._currentStepNumber].objectiveIds)
                {
                    Api.system.sendAction(new QuestObjectiveValidation(this._quest.id, obj));
                };
            };
        }

        private function refreshStep(subStep:uint):void
        {
            if (this._currentStepNumber != -1)
            {
                this.prepareStep(this._currentStepNumber, subStep, true);
            };
        }

        private function setComponentsDisabled(components:Object, disabled:Boolean):void
        {
            var component:Object;
            for each (component in components)
            {
                if (((component) && (component.hasOwnProperty("disabled"))))
                {
                    component.disabled = disabled;
                };
            };
            if (components === _watchedComponents)
            {
                this._bannerUiClass.setDisabledBtns(disabled);
            };
        }

        private function checkComponents(components:Object):void
        {
            var component:Object;
            for (component in components)
            {
                if (components[component] == null)
                {
                    throw (new Error(("Unable to find component : " + component)));
                };
            };
        }

        private function setWatchedElementsDisabled(disabled:Boolean):void
        {
            Api.modMenu.getMenuMaker("world").maker.disabled = disabled;
            Api.modMenu.getMenuMaker("player").maker.disabled = disabled;
            Api.modMenu.getMenuMaker("npc").maker.disabled = disabled;
            Api.modMenu.getMenuMaker("item").maker.disabled = disabled;
            this.setComponentsDisabled(_watchedComponents, disabled);
            this.setShortcutsDisabled(disabled);
        }

        private function setFightWatchedElementsDisabled(disabled:Boolean):void
        {
            this.setComponentsDisabled(_fightWatchedComponents, disabled);
        }

        private function setShortcutsDisabled(disabled:Boolean):void
        {
            var s:String;
            for (s in _disabledShortcuts)
            {
                this.setShortcutDisabled(s, disabled);
            };
        }

        private function setShortcutDisabled(s:String, disabled:Boolean):void
        {
            var bind:Bind = Api.binds.getShortcutBind(s, true);
            if (bind)
            {
                Api.binds.setBindDisabled(bind, disabled);
                _disabledShortcuts[s] = disabled;
            };
        }

        private function getItemSuperType(item:Object):uint
        {
            var cat:int;
            var type:ItemType;
            if (((item.isLivingObject) || (item.isWrapperObject)))
            {
                cat = 0;
                if (item.isLivingObject)
                {
                    cat = item.livingObjectCategory;
                }
                else
                {
                    cat = item.wrapperObjectCategory;
                };
                type = Api.data.getItemType(cat);
                if (type)
                {
                    return (type.superTypeId);
                };
                return (0);
            };
            if ((item is ItemWrapper))
            {
                return ((item as ItemWrapper).type.superTypeId);
            };
            if ((item is ShortcutWrapper))
            {
                if ((item as ShortcutWrapper).type == 0)
                {
                    return ((item as ShortcutWrapper).realItem.type.superTypeId);
                };
            };
            return (0);
        }


    }
}//package managers

