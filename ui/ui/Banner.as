package ui
{
    import d2api.BindsApi;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.TimeApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import d2api.StorageApi;
    import d2api.InventoryApi;
    import d2api.SocialApi;
    import d2api.FightApi;
    import d2api.JobsApi;
    import d2api.ContextMenuApi;
    import d2api.SecurityApi;
    import d2api.PartyApi;
    import d2api.RoleplayApi;
    import d2api.UtilApi;
    import d2api.SoundApi;
    import d2api.MapApi;
    import d2api.TooltipApi;
    import d2api.ConfigApi;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import d2components.Grid;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2components.StateContainer;
    import d2components.Texture;
    import d2components.GraphicContainer;
    import d2components.MapViewer;
    import d2components.EntityDisplayer;
    import d2data.HintCategory;
    import d2data.GuildWrapper;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.CharacterStatsList;
    import d2hooks.SlaveStatsList;
    import d2hooks.PlayedCharacterLookChange;
    import d2hooks.FighterLookChange;
    import d2hooks.GameFightEnd;
    import d2hooks.SpectatorWantLeave;
    import d2hooks.ShowMonsterArtwork;
    import d2hooks.ShowTacticMode;
    import d2hooks.FightEvent;
    import d2hooks.GameFightTurnEnd;
    import d2hooks.GameFightTurnStart;
    import d2hooks.GameFightJoin;
    import d2hooks.GameFightStart;
    import d2hooks.ReadyToFight;
    import d2hooks.MapFightCount;
    import d2hooks.CancelCastSpell;
    import d2hooks.CastSpellMode;
    import d2hooks.OpenInventory;
    import d2hooks.OpenMainMenu;
    import d2hooks.SwitchBannerTab;
    import d2hooks.PhoenixUpdate;
    import d2hooks.GameRolePlayPlayerLifeStatus;
    import d2hooks.SecureModeChange;
    import d2hooks.ShortcutBarViewContent;
    import d2hooks.DropStart;
    import d2hooks.DropEnd;
    import d2hooks.InventoryWeight;
    import d2hooks.EquipmentObjectMove;
    import d2hooks.ObjectModified;
    import d2hooks.ShowCell;
    import d2hooks.OptionLockFight;
    import d2hooks.OptionLockParty;
    import d2hooks.OptionHelpWanted;
    import d2hooks.OptionWitnessForbidden;
    import d2hooks.RemindTurn;
    import d2hooks.MountSet;
    import d2hooks.MountUnSet;
    import d2hooks.MountRiding;
    import d2hooks.SpouseUpdated;
    import d2hooks.DungeonPartyFinderRegister;
    import d2hooks.ArenaRegistrationStatusUpdate;
    import d2hooks.ArenaUpdateRank;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.MapDisplay;
    import d2hooks.MapHintsFilter;
    import d2hooks.WeaponUpdate;
    import d2hooks.GuildMembershipUpdated;
    import d2hooks.AllianceMembershipUpdated;
    import d2hooks.JobsListUpdated;
    import d2hooks.JobsExpUpdated;
    import d2hooks.HouseInformations;
    import d2hooks.GuildInformationsGeneral;
    import d2hooks.GuildInformationsFarms;
    import d2hooks.GuildHousesUpdate;
    import d2hooks.TaxCollectorListUpdate;
    import d2hooks.GuildPaddockAdd;
    import d2hooks.GuildPaddockRemoved;
    import d2hooks.GuildTaxCollectorAdd;
    import d2hooks.GuildTaxCollectorRemoved;
    import d2hooks.GuildHouseAdd;
    import d2hooks.GuildHouseRemoved;
    import d2hooks.SpellMovementAllowed;
    import d2hooks.ShortcutsMovementAllowed;
    import d2hooks.PresetsUpdate;
    import d2hooks.MouseClick;
    import d2hooks.AddBannerButton;
    import d2hooks.PartyLeave;
    import d2hooks.PartyJoin;
    import d2hooks.ConfigPropertyChange;
    import d2hooks.ShowPlayersNames;
    import d2hooks.ShowMonstersInfo;
    import d2hooks.PrismsList;
    import d2hooks.PrismsListUpdate;
    import d2hooks.CurrentMap;
    import d2enums.ShortcutHookListEnum;
    import d2hooks.FlagAdded;
    import d2hooks.FlagRemoved;
    import flash.display.Sprite;
    import d2data.OptionalFeature;
    import flash.events.TimerEvent;
    import d2actions.QuestListRequest;
    import d2enums.ProtocolConstantsEnum;
    import d2actions.ShowTacticMode;
    import d2actions.PrismsListRegister;
    import d2enums.PrismListenEnum;
    import d2enums.PlayerLifeStatusEnum;
    import d2data.ItemWrapper;
    import d2actions.ShortcutBarSwapRequest;
    import d2actions.ShortcutBarAddRequest;
    import d2components.Slot;
    import d2actions.ObjectSetPosition;
    import d2network.AccountHouseInformations;
    import d2network.PaddockContentInformations;
    import d2data.GuildHouseWrapper;
    import d2data.TaxCollectorWrapper;
    import d2data.PrismSubAreaWrapper;
    import d2data.SubArea;
    import d2data.FighterInformations;
    import d2data.EffectInstanceDate;
    import d2data.EffectInstance;
    import d2data.IncarnationLevel;
    import d2enums.CharacterInventoryPositionEnum;
    import flash.utils.getTimer;
    import d2enums.FightEventEnum;
    import d2utils.SpellTooltipSettings;
    import d2utils.ItemTooltipSettings;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2actions.ShowMonstersInfo;
    import d2data.ButtonWrapper;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2hooks.OpenSpellInterface;
    import d2actions.GameFightSpellCast;
    import d2actions.BannerEmptySlotClick;
    import d2hooks.ObjectSelected;
    import d2enums.SelectMethodEnum;
    import d2data.MapPosition;
    import d2hooks.AddMapFlag;
    import d2hooks.RemoveAllFlags;
    import d2actions.GuildGetInformations;
    import d2enums.GuildInformationsTypeEnum;
    import d2actions.GameFightTurnFinish;
    import d2actions.GameFightReady;
    import d2enums.FightTypeEnum;
    import d2actions.GameContextQuit;
    import d2actions.OpenCurrentFight;
    import d2actions.TogglePointCell;
    import d2actions.ToggleDematerialization;
    import d2actions.ToggleHelpWanted;
    import d2actions.ToggleLockFight;
    import d2actions.ToggleLockParty;
    import d2actions.ShowAllNames;
    import d2data.SpellWrapper;
    import d2enums.LocationEnum;
    import d2hooks.OpenFeed;
    import d2actions.ObjectUse;
    import d2actions.InventoryPresetUse;
    import d2actions.ChatSmileyRequest;
    import d2actions.EmotePlayRequest;
    import d2actions.OpenStats;
    import d2actions.OpenBook;
    import d2actions.OpenMap;
    import d2actions.OpenSocial;
    import d2hooks.TextInformation;
    import d2actions.OpenTeamSearch;
    import d2actions.OpenArena;
    import d2actions.ExchangeRequestOnShopStock;
    import d2actions.OpenMount;
    import d2actions.CloseInventory;
    import d2actions.ExchangeRequestOnMountStock;
    import d2hooks.ChatFocus;
    import d2actions.MountToggleRidingRequest;
    import d2actions.ShowMountsInFight;
    import d2hooks.OpenKrosmaster;
    import d2actions.ToggleWitnessForbidden;
    import d2actions.ShortcutBarRemoveRequest;
    import d2actions.OpenInventory;
    import d2enums.PvpArenaStepEnum;
    import d2actions.OpenWebService;
    import d2hooks.*;
    import d2actions.*;

    public class Banner 
    {

        private static const NUM_PAGES:uint = 5;
        private static const NUM_ITEMS_PER_PAGE:uint = 20;
        private static const NUM_BTNS_VISIBLE:uint = 13;
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
        private static const ID_BTN_ALMANAX:int = 17;
        private static const ID_BTN_ACHIEVEMENT:int = 18;
        private static const ID_BTN_TITLE:int = 19;
        private static const ID_BTN_BESTIARY:int = 20;
        private static const ID_BTN_ALIGNMENT:int = 21;
        private static const ID_BTN_DIRECTORY:int = 22;
        private static const ID_BTN_COMPANION:int = 23;
        private static var _shortcutColor:String;
        private static var FIGHT_CONTEXT:String = "fight";
        private static var PREFIGHT_CONTEXT:String = "prefight";
        private static var ROLEPLAY_CONTEXT:String = "roleplay";
        private static var SPECTATOR_CONTEXT:String = "spectator";
        private static var ITEMS_TAB:String = "items";
        private static var SPELLS_TAB:String = "spells";
        private static var LOCKET_ARTWORK:uint = 0;
        private static var LOCKET_SPRITE:uint = 1;
        private static var LOCKET_MINIMAP:uint = 2;
        private static var LOCKET_CLOCK:uint = 3;
        private static var XP_GAUGE:uint = 0;
        private static var GUILD_GAUGE:uint = 1;
        private static var MOUNT_GAUGE:uint = 2;
        private static var INCARNATION_GAUGE:uint = 3;
        private static var HONOUR_GAUGE:uint = 4;
        private static var POD_GAUGE:uint = 5;
        private static var JOB_GAUGE:uint = 6;
        private static const NB_GAUGE:uint = 6;
        private static var templeDisplayed:Boolean = true;
        private static var bidHouseDisplayed:Boolean = true;
        private static var craftHouseDisplayed:Boolean = true;
        private static var miscDisplayed:Boolean = true;
        private static var conquestDisplayed:Boolean = true;
        private static var dungeonDisplayed:Boolean = true;
        private static var privateDisplayed:Boolean = true;
        private static const SHORTCUT_DISABLE_DURATION:Number = 500;
        private static const WORLD_OF_AMAKNA:uint = 1;
        private static const WORLD_OF_INCARNAM:uint = 2;
        private static const FRIGOST_III:uint = 12;

        public var output:Object;
        public var bindsApi:BindsApi;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var timeApi:TimeApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        public var storageApi:StorageApi;
        public var inventoryApi:InventoryApi;
        public var socialApi:SocialApi;
        public var fightApi:FightApi;
        public var jobsApi:JobsApi;
        public var menuApi:ContextMenuApi;
        public var securityApi:SecurityApi;
        public var partyApi:PartyApi;
        public var rpApi:RoleplayApi;
        public var utilApi:UtilApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var soundApi:SoundApi;
        public var mapApi:MapApi;
        public var tooltipApi:TooltipApi;
        public var configApi:ConfigApi;
        [Module(name="Ankama_Cartography")]
        public var modCartography:Object;
        private var _turnDuration:uint;
        private var _turnElapsedTime:uint;
        private var _sContext:String;
        private var _sTabGrid:String;
        private var _clockStart:uint;
        private var _ticker:Object;
        private var _lifepointMode:uint = 0;
        private var _currentPdv:uint;
        private var _totalPdv:uint;
        private var _percentPdv:uint;
        private var _roundPercent:uint;
        private var _roundLevel:uint;
        private var _roundRemainingValue:Number;
        private var _roundGaugeType:uint = 0;
        private var _locketMode:uint = 0;
        private var _locketInitialized:Boolean = false;
        private var _artworkLookStr:String;
        private var _isDragging:Boolean = false;
        private var _itemToUseId:uint;
        private var _bIsReady:Boolean = false;
        private var _bIsSpectator:Boolean = false;
        private var _bCellPointed:Boolean = false;
        private var _nPageItems:uint = 0;
        private var _nPageSpells:uint = 0;
        private var _nPa:int;
        private var _nPm:int;
        private var _currentShieldPoints:int;
        private var _aSpells;
        private var _aItems;
        private var _nFightCount:uint;
        private var _bArenaRegistered:Boolean;
        private var _flags:Dictionary;
        private var _hintsList:Object;
        private var _hintLegends:Dictionary;
        private var _interactionWasEnabled:Boolean;
        private var _hintTypesList:Array;
        private var _mapIconScale:int = 2;
        private var _waitingForSocialUpdate:int;
        private var _lookingForMyGuildPlz:Boolean = false;
        private var _spectatorCloseLastRequest:uint = 0;
        private var _spectatorCloseLastRequestTime:uint = 1500;
        private var _secureMode:Boolean = false;
        private var _spellMovementAllowed:Boolean = false;
        private var _shortcutsMovementAllowed:Boolean = false;
        private var _delayUseObject:Boolean = false;
        private var _delayUseObjectTimer:Timer;
        private var _bOverMoreButtons:Boolean = false;
        private var _dataProviderButtons:Array;
        private var _aBtnOrderForCache:Array;
        private var _uiBtnHeight:int;
        private var _uiBtnOffset:int;
        private var _shortcutTimerDuration:Number = 0;
        private var _currentSuperAreaId:int;
        private var _currentWorldId:int;
        private var _playersNamesVisible:Boolean;
        private var _monstersInfoVisible:Boolean;
        private var _prismsToAdd:Array;
        private var _btn_help_originalX:Number;
        private var _btn_help_originalY:Number;
        private var _currentTurnEntityId:int;
        public var gd_spellitemotes:Grid;
        public var gd_btnUis:Grid;
        public var lbl_itemsNumber:Label;
        public var lbl_time:Label;
        public var lbl_pa:Label;
        public var lbl_pm:Label;
        public var lbl_pdv:Label;
        public var lbl_pdvTop:Label;
        public var lbl_pdvBottom:Label;
        public var lbl_ready:Label;
        public var btn_leave:ButtonContainer;
        public var btn_viewFights:ButtonContainer;
        public var btn_lock:ButtonContainer;
        public var btn_invimode:ButtonContainer;
        public var btn_lockparty:ButtonContainer;
        public var btn_pointCell:ButtonContainer;
        public var btn_help:ButtonContainer;
        public var btn_witness:ButtonContainer;
        public var btn_skipTurn:ButtonContainer;
        public var btn_ready:ButtonContainer;
        public var btn_tabSpells:ButtonContainer;
        public var btn_tabItems:ButtonContainer;
        public var btn_emptyMap:ButtonContainer;
        public var btn_moreBtn:ButtonContainer;
        public var btn_upArrow:ButtonContainer;
        public var btn_downArrow:ButtonContainer;
        public var btn_showPlayersNames:ButtonContainer;
        public var btn_showMonstersInfo:ButtonContainer;
        public var btn_showMapInfo:ButtonContainer;
        public var fightGroup:StateContainer;
        public var papmBackground:StateContainer;
        public var tx_paBackground:Texture;
        public var tx_pmBackground:Texture;
        public var tx_pdvFrame:Texture;
        public var tx_timeFrame:Texture;
        public var tx_xpFrame:Texture;
        public var tx_centerLight:Texture;
        public var tx_artwork:Texture;
        public var tx_show:Texture;
        public var tx_hourHand:Texture;
        public var tx_minuteHand:Texture;
        public var tx_gridBg:Texture;
        public var ctr_locket:GraphicContainer;
        public var ctr_artwork:GraphicContainer;
        public var ctr_clock:GraphicContainer;
        public var ctr_changeNumber:GraphicContainer;
        public var miniMap:MapViewer;
        public var ed_coloredArtwork:EntityDisplayer;
        public var ctr_moreBtn:GraphicContainer;
        public var gd_additionalBtns:Grid;
        private var _tacticModeActivated:Boolean = false;
        private var _pokemonModeActivated:Boolean = false;
        private var _waitingObjectUID:uint;
        private var _waitingObjectPosition:uint;
        private var _lastWorldMapInfo:Object;

        public function Banner()
        {
            this._sContext = ROLEPLAY_CONTEXT;
            this._flags = new Dictionary();
            this._hintLegends = new Dictionary();
            this._hintTypesList = new Array();
            super();
        }

        public function main(spellList:Array):void
        {
            var hint:Object;
            var hintCategoryFilters:int;
            var hintCat:HintCategory;
            var slot:Object;
            var guild:GuildWrapper;
            var value:Number;
            var floor:Number;
            var nextFloor:Number;
            var id:*;
            this.btn_skipTurn.soundId = SoundEnum.END_TURN;
            this.btn_ready.soundId = SoundEnum.READY_TO_FIGHT;
            this.btn_upArrow.soundId = SoundEnum.SCROLL_DOWN;
            this.btn_downArrow.soundId = SoundEnum.SCROLL_UP;
            this.btn_tabSpells.soundId = SoundEnum.BANNER_SPELL_TAB;
            this.btn_tabItems.soundId = SoundEnum.BANNER_OBJECT_TAB;
            this.sysApi.addHook(CharacterStatsList, this.onCharacterStatsList);
            this.sysApi.addHook(SlaveStatsList, this.onSlaveStatsList);
            this.sysApi.addHook(PlayedCharacterLookChange, this.onPlayedCharacterLookChange);
            this.sysApi.addHook(FighterLookChange, this.onFighterLookChange);
            this.sysApi.addHook(GameFightEnd, this.onGameFightEnd);
            this.sysApi.addHook(SpectatorWantLeave, this.onSpectatorWantLeave);
            this.sysApi.addHook(ShowMonsterArtwork, this.showMonsterArtwork);
            this.sysApi.addHook(ShowTacticMode, this.onShowTacticMode);
            this.sysApi.addHook(FightEvent, this.onFightEvent);
            this.sysApi.addHook(GameFightTurnEnd, this.onGameFightTurnEnd);
            this.sysApi.addHook(GameFightTurnStart, this.onGameFightTurnStart);
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.sysApi.addHook(GameFightStart, this.onGameFightStart);
            this.sysApi.addHook(ReadyToFight, this.onReadyToFight);
            this.sysApi.addHook(MapFightCount, this.onMapFightCount);
            this.sysApi.addHook(CancelCastSpell, this.onCancelCastSpell);
            this.sysApi.addHook(CastSpellMode, this.onCastSpellMode);
            this.sysApi.addHook(OpenInventory, this.onOpenInventory);
            this.sysApi.addHook(OpenMainMenu, this.onOpenMainMenu);
            this.sysApi.addHook(SwitchBannerTab, this.onSwitchBannerTab);
            this.sysApi.addHook(PhoenixUpdate, this.onPhoenixUpdate);
            this.sysApi.addHook(GameRolePlayPlayerLifeStatus, this.onGameRolePlayPlayerLifeStatus);
            this.sysApi.addHook(SecureModeChange, this.onSecureModeChange);
            this.sysApi.addHook(ShortcutBarViewContent, this.onShortcutBarViewContent);
            this.sysApi.addHook(DropStart, this.onDropStart);
            this.sysApi.addHook(DropEnd, this.onDropEnd);
            this.sysApi.addHook(InventoryWeight, this.onInventoryWeight);
            this.sysApi.addHook(EquipmentObjectMove, this.onEquipmentObjectMove);
            this.sysApi.addHook(ObjectModified, this.onObjectModified);
            this.sysApi.addHook(ShowCell, this.onShowCell);
            this.sysApi.addHook(OptionLockFight, this.onOptionLockFight);
            this.sysApi.addHook(OptionLockParty, this.onOptionLockParty);
            this.sysApi.addHook(OptionHelpWanted, this.onOptionHelpWanted);
            this.sysApi.addHook(OptionWitnessForbidden, this.onOptionWitnessForbidden);
            this.sysApi.addHook(RemindTurn, this.onRemindTurn);
            this.sysApi.addHook(MountSet, this.onMountSet);
            this.sysApi.addHook(MountUnSet, this.onMountUnSet);
            this.sysApi.addHook(MountRiding, this.onMountRiding);
            this.sysApi.addHook(SpouseUpdated, this.onSpouseUpdated);
            this.sysApi.addHook(DungeonPartyFinderRegister, this.onDungeonPartyFinderRegister);
            this.sysApi.addHook(ArenaRegistrationStatusUpdate, this.onArenaRegistrationStatusUpdate);
            this.sysApi.addHook(ArenaUpdateRank, this.onArenaUpdateRank);
            this.sysApi.addHook(MapComplementaryInformationsData, this.onMapComplementaryInformationsData);
            this.sysApi.addHook(MapDisplay, this.onOpenMap);
            this.sysApi.addHook(MapHintsFilter, this.onMapHintsFilter);
            this.sysApi.addHook(WeaponUpdate, this.onWeaponUpdate);
            this.sysApi.addHook(GuildMembershipUpdated, this.onGuildMembershipUpdated);
            this.sysApi.addHook(AllianceMembershipUpdated, this.onAllianceMembershipUpdated);
            this.sysApi.addHook(JobsListUpdated, this.onJobsListUpdated);
            this.sysApi.addHook(JobsExpUpdated, this.onJobsExpUpdated);
            this.sysApi.addHook(HouseInformations, this.onHouseInformations);
            this.sysApi.addHook(GuildInformationsGeneral, this.onGuildInformationsGeneral);
            this.sysApi.addHook(GuildInformationsFarms, this.onGuildInformationsFarms);
            this.sysApi.addHook(GuildHousesUpdate, this.onGuildHousesUpdate);
            this.sysApi.addHook(TaxCollectorListUpdate, this.onTaxCollectorListUpdate);
            this.sysApi.addHook(GuildPaddockAdd, this.onGuildPaddockAdd);
            this.sysApi.addHook(GuildPaddockRemoved, this.onGuildPaddockRemoved);
            this.sysApi.addHook(GuildTaxCollectorAdd, this.onGuildTaxCollectorAdd);
            this.sysApi.addHook(GuildTaxCollectorRemoved, this.onGuildTaxCollectorRemoved);
            this.sysApi.addHook(GuildHouseAdd, this.onGuildHouseAdd);
            this.sysApi.addHook(GuildHouseRemoved, this.onGuildHouseRemoved);
            this.sysApi.addHook(SpellMovementAllowed, this.onSpellMovementAllowed);
            this.sysApi.addHook(ShortcutsMovementAllowed, this.onShortcutsMovementAllowed);
            this.sysApi.addHook(PresetsUpdate, this.onPresetsUpdate);
            this.sysApi.addHook(MouseClick, this.onGenericMouseClick);
            this.sysApi.addHook(AddBannerButton, this.onAddBannerButton);
            this.sysApi.addHook(PartyLeave, this.onPartyLeave);
            this.sysApi.addHook(PartyJoin, this.onPartyJoin);
            this.sysApi.addHook(ConfigPropertyChange, this.onConfigPropertyChange);
            this.sysApi.addHook(ShowPlayersNames, this.onShowPlayersNames);
            this.sysApi.addHook(ShowMonstersInfo, this.onShowMonstersInfo);
            this._prismsToAdd = new Array();
            this.sysApi.addHook(PrismsList, this.onPrismsListInformation);
            this.sysApi.addHook(PrismsListUpdate, this.onPrismsInfoUpdate);
            this.sysApi.addHook(CurrentMap, this.onCurrentMap);
            this.uiApi.addShortcutHook("cac", this.onShortcut);
            this.uiApi.addShortcutHook("s1", this.onShortcut);
            this.uiApi.addShortcutHook("s2", this.onShortcut);
            this.uiApi.addShortcutHook("s3", this.onShortcut);
            this.uiApi.addShortcutHook("s4", this.onShortcut);
            this.uiApi.addShortcutHook("s5", this.onShortcut);
            this.uiApi.addShortcutHook("s6", this.onShortcut);
            this.uiApi.addShortcutHook("s7", this.onShortcut);
            this.uiApi.addShortcutHook("s8", this.onShortcut);
            this.uiApi.addShortcutHook("s9", this.onShortcut);
            this.uiApi.addShortcutHook("s10", this.onShortcut);
            this.uiApi.addShortcutHook("s11", this.onShortcut);
            this.uiApi.addShortcutHook("s12", this.onShortcut);
            this.uiApi.addShortcutHook("s13", this.onShortcut);
            this.uiApi.addShortcutHook("s14", this.onShortcut);
            this.uiApi.addShortcutHook("s15", this.onShortcut);
            this.uiApi.addShortcutHook("s16", this.onShortcut);
            this.uiApi.addShortcutHook("s17", this.onShortcut);
            this.uiApi.addShortcutHook("s18", this.onShortcut);
            this.uiApi.addShortcutHook("s19", this.onShortcut);
            this.uiApi.addShortcutHook("s20", this.onShortcut);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("skipTurn", this.onShortcut);
            this.uiApi.addShortcutHook("bannerSpellsTab", this.onShortcut);
            this.uiApi.addShortcutHook("bannerItemsTab", this.onShortcut);
            this.uiApi.addShortcutHook("bannerPreviousTab", this.onShortcut);
            this.uiApi.addShortcutHook("bannerNextTab", this.onShortcut);
            this.uiApi.addShortcutHook("flagCurrentMap", this.onShortcut);
            this.uiApi.addShortcutHook("openCharacterSheet", this.onShortcut);
            this.uiApi.addShortcutHook("openInventory", this.onShortcut);
            this.uiApi.addShortcutHook("openBookSpell", this.onShortcut);
            this.uiApi.addShortcutHook("openBookQuest", this.onShortcut);
            this.uiApi.addShortcutHook("openBookAlignment", this.onShortcut);
            this.uiApi.addShortcutHook("openBookJob", this.onShortcut);
            this.uiApi.addShortcutHook("openWorldMap", this.onShortcut);
            this.uiApi.addShortcutHook("openSocialFriends", this.onShortcut);
            this.uiApi.addShortcutHook("openSocialGuild", this.onShortcut);
            this.uiApi.addShortcutHook("openSocialAlliance", this.onShortcut);
            this.uiApi.addShortcutHook("openSocialSpouse", this.onShortcut);
            this.uiApi.addShortcutHook("openTeamSearch", this.onShortcut);
            this.uiApi.addShortcutHook("openPvpArena", this.onShortcut);
            this.uiApi.addShortcutHook("openSell", this.onShortcut);
            this.uiApi.addShortcutHook("openMount", this.onShortcut);
            this.uiApi.addShortcutHook("openAlmanax", this.onShortcut);
            this.uiApi.addShortcutHook("openAchievement", this.onShortcut);
            this.uiApi.addShortcutHook("openTitle", this.onShortcut);
            this.uiApi.addShortcutHook("openBestiary", this.onShortcut);
            this.uiApi.addShortcutHook("openMountStorage", this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.OPEN_WEB_BROWSER, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_ALL_NAMES, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_MONSTERS_INFO, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_MOUNTS_IN_FIGHT, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_RIDE, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_1, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_2, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_3, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_4, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_5, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_DOWN, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_UP, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_CELL, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_DEMATERIALIZATION, this.onShortcut);
            this.sysApi.addHook(FlagAdded, this.onFlagAdded);
            this.sysApi.addHook(FlagRemoved, this.onFlagRemoved);
            this.uiApi.addComponentHook(this.miniMap, "onMapElementRollOver");
            this.uiApi.addComponentHook(this.miniMap, "onMapElementRollOut");
            this.uiApi.addComponentHook(this.miniMap, "onMapElementRightClick");
            this.uiApi.addComponentHook(this.miniMap, "onRelease");
            this.uiApi.addComponentHook(this.miniMap, "onDoubleClick");
            this.uiApi.addComponentHook(this.ctr_artwork, "onRelease");
            this.uiApi.addComponentHook(this.ctr_artwork, "onDoubleClick");
            this.uiApi.addComponentHook(this.ctr_artwork, "onRightClick");
            this.uiApi.addComponentHook(this.gd_spellitemotes, "onPress");
            this.uiApi.addComponentHook(this.btn_showMonstersInfo, "onPress");
            this.uiApi.addComponentHook(this.btn_showMonstersInfo, "onMouseUp");
            this.uiApi.addComponentHook(this.tx_pdvFrame, "onRelease");
            this.uiApi.addComponentHook(this.btn_moreBtn, "onRollOver");
            this.uiApi.addComponentHook(this.btn_moreBtn, "onRollOut");
            this.uiApi.addComponentHook(this.btn_downArrow, "onRollOver");
            this.uiApi.addComponentHook(this.btn_downArrow, "onRollOut");
            this.uiApi.addComponentHook(this.btn_upArrow, "onRollOver");
            this.uiApi.addComponentHook(this.btn_upArrow, "onRollOut");
            this.uiApi.addComponentHook(this.btn_tabItems, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabItems, "onRollOut");
            this.uiApi.addComponentHook(this.btn_tabSpells, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabSpells, "onRollOut");
            this.uiApi.addComponentHook(this.tx_pdvFrame, "onRollOver");
            this.uiApi.addComponentHook(this.tx_pdvFrame, "onRollOut");
            this.uiApi.addComponentHook(this.tx_xpFrame, "onRollOver");
            this.uiApi.addComponentHook(this.tx_xpFrame, "onRollOut");
            this.uiApi.addComponentHook(this.tx_xpFrame, "onRightClick");
            this.uiApi.addComponentHook(this.tx_artwork, "onTextureLoadFail");
            this.uiApi.addComponentHook(this.ctr_changeNumber, "onWheel");
            this.uiApi.addComponentHook(this.gd_spellitemotes, "onWheel");
            this.uiApi.addComponentHook(this.gd_additionalBtns, "onSelectItem");
            this.uiApi.addComponentHook(this.gd_additionalBtns, "onItemRollOver");
            this.uiApi.addComponentHook(this.gd_additionalBtns, "onItemRollOut");
            this.uiApi.addComponentHook(this.gd_btnUis, "onSelectItem");
            this.uiApi.addComponentHook(this.gd_btnUis, "onItemRollOver");
            this.uiApi.addComponentHook(this.gd_btnUis, "onItemRollOut");
            this.ctr_artwork.mouseEnabled = true;
            this.ctr_artwork.mouseChildren = true;
            this.tx_artwork.showLoadingError = false;
            this.ctr_clock.mouseEnabled = true;
            this.ctr_clock.mouseChildren = true;
            this._ticker = new Timer(60000);
            this.lbl_pdvBottom.visible = false;
            this.lbl_pdvTop.visible = false;
            this._uiBtnHeight = this.uiApi.me().getConstant("ui_btn_height");
            this._uiBtnOffset = this.uiApi.me().getConstant("ui_btn_offset");
            this._aSpells = new Array();
            this._aItems = new Array();
            this.tx_show.visible = false;
            this.btn_upArrow.disabled = true;
            var lpModeObject:Object = this.sysApi.getData("lifepointMode");
            if (lpModeObject)
            {
                this._lifepointMode = lpModeObject.mode;
                this.changeLifepointDisplay(this._lifepointMode);
            };
            var roundGaugeMode:int = this.sysApi.getData(("roundGaugeMode_" + this.playerApi.id()));
            this._roundGaugeType = roundGaugeMode;
            var charMask:Sprite = new Sprite();
            charMask.graphics.beginFill(0xFF5500);
            var radius:Number = (this.ed_coloredArtwork.width / 2);
            charMask.graphics.drawCircle((this.ed_coloredArtwork.x + radius), (this.ed_coloredArtwork.y + radius), radius);
            charMask.graphics.endFill();
            this.ed_coloredArtwork.addChild(charMask);
            this.ed_coloredArtwork.mask = charMask;
            this.ed_coloredArtwork.withoutMount = true;
            this._nPageItems = this.sysApi.getData("bannerItemsPageIndex");
            if (this.getPlayerId() >= 0)
            {
                this._nPageSpells = this.sysApi.getData(("bannerSpellsPageIndex" + this.getPlayerId()));
            }
            else
            {
                this._nPageSpells = 0;
            };
            if (this._roundGaugeType == GUILD_GAUGE)
            {
                guild = this.socialApi.getGuild();
                if (guild)
                {
                    value = guild.experience;
                    floor = guild.expLevelFloor;
                    nextFloor = guild.expNextLevelFloor;
                    this.setXp(value, floor, nextFloor, guild.level);
                }
                else
                {
                    this._lookingForMyGuildPlz = true;
                    this._roundGaugeType = XP_GAUGE;
                };
            }
            else
            {
                this.onChangeXpGauge(this._roundGaugeType);
            };
            this._dataProviderButtons = new Array();
            this._aBtnOrderForCache = this.sysApi.getData("uiBtnOrder");
            if (this._aBtnOrderForCache == null)
            {
                this._aBtnOrderForCache = new Array();
            };
            var feature:OptionalFeature = this.dataApi.getOptionalFeatureByKeyword("game.krosmaster");
            var krosmasterActive:Boolean;
            if (((feature) && (this.configApi.isOptionalFeatureActive(feature.id))))
            {
                krosmasterActive = true;
            }
            else
            {
                if (this._aBtnOrderForCache[ID_BTN_KROZ])
                {
                    for (id in this._aBtnOrderForCache)
                    {
                        if (this._aBtnOrderForCache[id] > this._aBtnOrderForCache[ID_BTN_KROZ])
                        {
                            this._aBtnOrderForCache[id] = (this._aBtnOrderForCache[id] - 1);
                        };
                    };
                };
                this._aBtnOrderForCache[ID_BTN_KROZ] = 0;
            };
            this.gd_btnUis.autoSelectMode = 0;
            this.gd_additionalBtns.autoSelectMode = 0;
            this.onAddBannerButton(ID_BTN_CARAC, "btn_carac", this.onCharacterAction, this.uiApi.getText("ui.banner.character"), this.bindsApi.getShortcutBindStr("openCharacterSheet"));
            this.onAddBannerButton(ID_BTN_SPELL, "btn_spell", this.onSpellsAction, this.uiApi.getText("ui.grimoire.mySpell"), this.bindsApi.getShortcutBindStr("openBookSpell"));
            this.onAddBannerButton(ID_BTN_BAG, "btn_bag", this.onItemsAction, this.uiApi.getText("ui.banner.inventory"), this.bindsApi.getShortcutBindStr("openInventory"));
            this.onAddBannerButton(ID_BTN_BOOK, "btn_book", this.onQuestsAction, this.uiApi.getText("ui.common.quests"), this.bindsApi.getShortcutBindStr("openBookQuest"));
            this.onAddBannerButton(ID_BTN_MAP, "btn_map", this.onMapAction, this.uiApi.getText("ui.banner.map"), this.bindsApi.getShortcutBindStr("openWorldMap"));
            this.onAddBannerButton(ID_BTN_FRIEND, "btn_friend", this.onFriendsAction, this.uiApi.getText("ui.banner.friends"), this.bindsApi.getShortcutBindStr("openSocialFriends"));
            this.onAddBannerButton(ID_BTN_GUILD, "btn_guild", this.onGuildAction, this.uiApi.getText("ui.common.guild"), this.bindsApi.getShortcutBindStr("openSocialGuild"));
            this.onAddBannerButton(ID_BTN_TEAMSEARCH, "btn_teamSearch", this.onTeamSearchAction, this.uiApi.getText("ui.common.teamSearch"), this.bindsApi.getShortcutBindStr("openTeamSearch"));
            this.onAddBannerButton(ID_BTN_CONQUEST, "btn_conquest", this.onConquestAction, this.uiApi.getText("ui.common.koliseum"), this.bindsApi.getShortcutBindStr("openPvpArena"));
            this.onAddBannerButton(ID_BTN_OGRINE, "btn_veteran", this.onWebAction, this.uiApi.getText("ui.banner.shopGifts"), this.bindsApi.getShortcutBindStr("openWebBrowser"));
            this.onAddBannerButton(ID_BTN_JOB, "btn_job", this.onJobAction, this.uiApi.getText("ui.common.myJobs"), this.bindsApi.getShortcutBindStr("openBookJob"));
            this.onAddBannerButton(ID_BTN_ALLIANCE, "btn_alliance", this.onAllianceAction, this.uiApi.getText("ui.common.alliance"), this.bindsApi.getShortcutBindStr("openSocialAlliance"));
            this.onAddBannerButton(ID_BTN_MOUNT, "btn_mount", this.onMountAction, this.uiApi.getText("ui.banner.mount"), this.bindsApi.getShortcutBindStr("openMount"));
            this.onAddBannerButton(ID_BTN_SHOP, "btn_shop", this.onShopAction, this.uiApi.getText("ui.common.shop"), this.bindsApi.getShortcutBindStr("openSell"));
            this.onAddBannerButton(ID_BTN_SPOUSE, "btn_spouse", this.onSpouseAction, this.uiApi.processText(this.uiApi.getText("ui.common.spouse"), "m", true), this.bindsApi.getShortcutBindStr("openSocialSpouse"));
            this.onAddBannerButton(ID_BTN_ALMANAX, "btn_almanax", this.onAlmanaxAction, this.uiApi.getText("ui.almanax.almanax"), this.bindsApi.getShortcutBindStr("openAlmanax"));
            this.onAddBannerButton(ID_BTN_ACHIEVEMENT, "btn_achievement", this.onAchievementAction, this.uiApi.getText("ui.achievement.achievement"), this.bindsApi.getShortcutBindStr("openAchievement"));
            this.onAddBannerButton(ID_BTN_TITLE, "btn_title", this.onTitleAction, this.uiApi.getText("ui.common.titles"), this.bindsApi.getShortcutBindStr("openTitle"));
            this.onAddBannerButton(ID_BTN_BESTIARY, "btn_bestiary", this.onBestiaryAction, this.uiApi.getText("ui.common.bestiary"), this.bindsApi.getShortcutBindStr("openBestiary"));
            this.onAddBannerButton(ID_BTN_ALIGNMENT, "btn_alignment", this.onAlignmentAction, this.uiApi.getText("ui.common.alignment"), this.bindsApi.getShortcutBindStr("openBookAlignment"));
            this.onAddBannerButton(ID_BTN_DIRECTORY, "btn_directory", this.onDirectoryAction, this.uiApi.getText("ui.common.directory"), this.bindsApi.getShortcutBindStr("openSocialDirectory"));
            this.onAddBannerButton(ID_BTN_COMPANION, "btn_companions", this.onCompanionAction, this.uiApi.getText("ui.companion.companions"), "");
            if (krosmasterActive)
            {
                this.onAddBannerButton(ID_BTN_KROZ, "btn_krosmaster", this.onKrozAction, this.uiApi.getText("ui.krosmaster.krosmaster"));
            };
            this.checkJob(true);
            this.checkMount(true);
            this.checkSpouse(true);
            this.checkGuild(true);
            this.checkAlliance(true);
            this.checkConquest(true);
            this.checkWeb(true);
            this.updateButtonGrids();
            this.gd_spellitemotes.autoSelectMode = 0;
            this.gd_spellitemotes.renderer.dropValidatorFunction = this.dropValidator;
            this.gd_spellitemotes.renderer.processDropFunction = this.processDrop;
            this.gd_spellitemotes.renderer.removeDropSourceFunction = this.emptyFct;
            var objAccept:Object = this.uiApi.createUri(this.uiApi.me().getConstant("acceptDrop_uri"));
            var objRefuse:Object = this.uiApi.createUri(this.uiApi.me().getConstant("refuseDrop_uri"));
            this.gd_spellitemotes.renderer.acceptDragTexture = objAccept;
            this.gd_spellitemotes.renderer.refuseDragTexture = objRefuse;
            this.gd_btnUis.renderer.dropValidatorFunction = this.dropValidatorBtn;
            this.gd_btnUis.renderer.processDropFunction = this.processDropBtn;
            this.gd_btnUis.renderer.removeDropSourceFunction = this.emptyFct;
            this.gd_btnUis.renderer.acceptDragTexture = objAccept;
            this.gd_btnUis.renderer.refuseDragTexture = objRefuse;
            this.gd_additionalBtns.renderer.dropValidatorFunction = this.dropValidatorBtn;
            this.gd_additionalBtns.renderer.processDropFunction = this.processDropBtn;
            this.gd_additionalBtns.renderer.removeDropSourceFunction = this.emptyFct;
            this.gd_additionalBtns.renderer.acceptDragTexture = objAccept;
            this.gd_additionalBtns.renderer.refuseDragTexture = objRefuse;
            this.changeContext(ROLEPLAY_CONTEXT);
            this.onShortcutBarViewContent(0);
            this.onShortcutBarViewContent(1);
            this._hintsList = this.mapApi.getHintIds();
            for each (hint in this._hintsList)
            {
                this._hintLegends[("miniMap_hint_" + hint.id)] = (((((hint.x + ",") + hint.y) + " (") + hint.name) + ")");
            };
            this._delayUseObjectTimer = new Timer(500, 1);
            this._delayUseObjectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayUseObjectTimer);
            this.sysApi.sendAction(new QuestListRequest());
            hintCategoryFilters = this.sysApi.getOption("mapFilters", "dofus");
            for each (hintCat in this.dataApi.getHintCategories())
            {
                this._hintTypesList[hintCat.id] = ((hintCategoryFilters & Math.pow(2, hintCat.id)) > 0);
            };
            for each (slot in this.gd_btnUis.slots)
            {
                slot.allowDrag = false;
            };
            this.configApi.setConfigProperty("dofus", "creaturesFightMode", false);
            this._locketMode = this.sysApi.getData("locketMode");
            if (this._locketMode != LOCKET_SPRITE)
            {
                this.switchLocketContent(this._locketMode, true);
            };
            this._btn_help_originalX = this.btn_help.x;
            this._btn_help_originalY = this.btn_help.y;
        }

        public function setPdv(currentPdv:uint, maxPdv:uint):void
        {
            var currentHeartPos:uint;
            if (currentPdv != this._currentPdv)
            {
                currentHeartPos = int(((currentPdv / maxPdv) * 100));
                if (currentHeartPos > 100)
                {
                    currentHeartPos = 100;
                };
                if (this._currentShieldPoints)
                {
                    currentHeartPos = (currentHeartPos + 100);
                };
                this.tx_pdvFrame.gotoAndStop = currentHeartPos.toString();
            };
            this._currentPdv = currentPdv;
            this._totalPdv = maxPdv;
            this._percentPdv = int(((currentPdv / maxPdv) * 100));
            switch (this._lifepointMode)
            {
                case 0:
                    if (this._currentShieldPoints)
                    {
                        this.lbl_pdv.visible = false;
                        this.lbl_pdvBottom.visible = true;
                        this.lbl_pdvTop.visible = true;
                        this.lbl_pdvTop.text = this._currentPdv.toString();
                        this.lbl_pdvBottom.text = this._currentShieldPoints.toString();
                    }
                    else
                    {
                        this.lbl_pdv.visible = true;
                        this.lbl_pdvBottom.visible = false;
                        this.lbl_pdvTop.visible = false;
                        this.lbl_pdv.text = this._currentPdv.toString();
                    };
                    break;
                case 1:
                    this.lbl_pdvTop.text = this._currentPdv.toString();
                    this.lbl_pdvBottom.text = this._totalPdv.toString();
                    break;
                case 2:
                    this.lbl_pdvTop.text = this._percentPdv.toString();
                    this.lbl_pdvBottom.text = "%";
                    break;
            };
        }

        public function setShield(currentShield:uint):void
        {
            this._currentShieldPoints = currentShield;
            if (this._currentShieldPoints > 0)
            {
                if (this._lifepointMode == 0)
                {
                    if (this.lbl_pdv.visible)
                    {
                        this.lbl_pdv.visible = false;
                        this.lbl_pdvBottom.visible = true;
                        this.lbl_pdvTop.visible = true;
                        this.lbl_pdvTop.text = this._currentPdv.toString();
                    };
                    this.lbl_pdvBottom.text = this._currentShieldPoints.toString();
                };
                if (this.tx_pdvFrame.currentFrame <= 100)
                {
                    this.tx_pdvFrame.gotoAndStop = (this.tx_pdvFrame.currentFrame + 100);
                };
            }
            else
            {
                if ((((this._lifepointMode == 0)) && (!(this.lbl_pdv.visible))))
                {
                    this.lbl_pdv.visible = true;
                    this.lbl_pdvBottom.visible = false;
                    this.lbl_pdvTop.visible = false;
                    this.lbl_pdv.text = this._currentPdv.toString();
                };
                if (this.tx_pdvFrame.currentFrame > 100)
                {
                    this.tx_pdvFrame.gotoAndStop = (this.tx_pdvFrame.currentFrame - 100);
                };
            };
        }

        public function setPA(currentPA:int):void
        {
            this._nPa = currentPA;
            this.lbl_pa.text = String(this._nPa);
        }

        public function setPM(currentPM:int):void
        {
            this._nPm = currentPM;
            this.lbl_pm.text = String(this._nPm);
        }

        public function setTimeFromPercent(currentPercentTime:Number):void
        {
            var currentTimePos:uint = Math.ceil(currentPercentTime);
            if (currentTimePos < 1)
            {
                currentTimePos = 1;
            };
            if (currentTimePos > 100)
            {
                currentTimePos = 100;
            };
            currentTimePos = ((currentTimePos / 100) * this.tx_timeFrame.totalFrames);
            this.tx_timeFrame.gotoAndStop = currentTimePos.toString();
        }

        public function setXp(currentXp:Number, seuilInfXp:Number, seuilSupXp:Number, level:int=0):void
        {
            var percentLvl:Number = (((currentXp - seuilInfXp) / (seuilSupXp - seuilInfXp)) * 100);
            if ((((this._roundGaugeType == XP_GAUGE)) && ((level == ProtocolConstantsEnum.MAX_LEVEL))))
            {
                percentLvl = 100;
            };
            var currentXpPos:uint = Math.floor(percentLvl);
            if (currentXpPos < 1)
            {
                currentXpPos = 1;
            };
            if (currentXpPos >= 100)
            {
                currentXpPos = 100;
            };
            var gauge:uint = this._roundGaugeType;
            if (gauge > NB_GAUGE)
            {
                gauge = NB_GAUGE;
            };
            this.tx_xpFrame.gotoAndStop = (currentXpPos + (100 * gauge)).toString();
            this._roundPercent = Math.floor(percentLvl);
            this._roundLevel = level;
            if ((((((((((((((this._roundGaugeType == XP_GAUGE)) && ((level == ProtocolConstantsEnum.MAX_LEVEL)))) || ((((this._roundGaugeType == GUILD_GAUGE)) && ((level == ProtocolConstantsEnum.MAX_GUILD_LEVEL)))))) || ((((this._roundGaugeType == MOUNT_GAUGE)) && ((level == ProtocolConstantsEnum.MAX_MOUNT_LEVEL)))))) || ((((this._roundGaugeType == INCARNATION_GAUGE)) && ((this._roundRemainingValue == 0)))))) || ((((this._roundGaugeType == HONOUR_GAUGE)) && ((level == ProtocolConstantsEnum.MAX_HONOR)))))) || ((((this._roundGaugeType == JOB_GAUGE)) && ((level == ProtocolConstantsEnum.MAX_JOB_LEVEL))))))
            {
                this._roundRemainingValue = 0;
            }
            else
            {
                this._roundRemainingValue = (seuilSupXp - currentXp);
            };
        }

        private function isDungeonMap():Boolean
        {
            return (((((!((this._currentWorldId == WORLD_OF_INCARNAM))) && (!((this._currentWorldId == WORLD_OF_AMAKNA))))) && (!((this._currentWorldId == FRIGOST_III)))));
        }

        private function changeContext(context:String):void
        {
            var pa:String;
            var pm:String;
            var contextChanged:Boolean = !((this._sContext == context));
            var previousContext:String = this._sContext;
            this._sContext = context;
            if (previousContext == SPECTATOR_CONTEXT)
            {
                this._bIsSpectator = false;
                if ((((this._locketMode == LOCKET_MINIMAP)) || ((this._locketMode == LOCKET_CLOCK))))
                {
                    this.switchLocketContent(this._locketMode);
                }
                else
                {
                    this.headDisplay(this.playerApi.getCurrentEntityLook());
                };
                this.onCharacterStatsList();
            };
            this.setTimeFromPercent(0);
            this._turnElapsedTime = 0;
            switch (this._sContext)
            {
                case SPECTATOR_CONTEXT:
                    this.checkTitle(false, false);
                    this.papmBackground.softDisabled = false;
                    this.btn_skipTurn.visible = false;
                    this.btn_ready.visible = false;
                    this.btn_lockparty.visible = false;
                    this.btn_lock.visible = false;
                    this.btn_help.visible = false;
                    this.btn_invimode.visible = true;
                    this.btn_witness.visible = false;
                    this.btn_pointCell.visible = true;
                    this.btn_leave.visible = true;
                    this.btn_emptyMap.visible = true;
                    this.btn_showMapInfo.visible = false;
                    this.btn_showPlayersNames.visible = false;
                    this.btn_showMonstersInfo.visible = false;
                    this.btn_leave.disabled = false;
                    this.btn_viewFights.visible = false;
                    if (this._tacticModeActivated)
                    {
                        this.sysApi.sendAction(new ShowTacticMode());
                    };
                    this.btn_invimode.selected = this._pokemonModeActivated;
                    this.tx_timeFrame.visible = true;
                    this.tx_xpFrame.visible = false;
                    this.gd_spellitemotes.disabled = true;
                    this.ed_coloredArtwork.visible = false;
                    this.tx_centerLight.visible = true;
                    this.ctr_artwork.visible = true;
                    this.miniMap.visible = false;
                    this.ctr_clock.visible = false;
                    this.sysApi.sendAction(new PrismsListRegister("Banner", PrismListenEnum.PRISM_LISTEN_NONE));
                    this._ticker.removeEventListener(TimerEvent.TIMER, this.updateClock);
                    this._ticker.stop();
                    break;
                case PREFIGHT_CONTEXT:
                    this.checkTitle(false, false);
                    this.gridDisplay(ITEMS_TAB, true);
                    if (this.papmBackground.softDisabled)
                    {
                        this.papmBackground.softDisabled = false;
                    };
                    this.lbl_ready.text = this.uiApi.me().getConstant("ready");
                    this.btn_skipTurn.visible = false;
                    this.btn_ready.visible = true;
                    if ((((this.partyApi.getPartyMembers().length > 0)) && (!(this.partyApi.isArenaRegistered()))))
                    {
                        this.btn_lockparty.visible = true;
                        this.btn_help.x = this._btn_help_originalX;
                        this.btn_help.y = this._btn_help_originalY;
                    }
                    else
                    {
                        this.btn_help.x = this.btn_lockparty.x;
                        this.btn_help.y = this.btn_lockparty.y;
                    };
                    this.btn_lock.visible = true;
                    this.btn_help.visible = true;
                    this.btn_invimode.visible = true;
                    this.btn_witness.visible = true;
                    this.btn_pointCell.visible = true;
                    this.btn_leave.visible = true;
                    this.btn_emptyMap.visible = true;
                    this.btn_showMapInfo.visible = false;
                    this.btn_showPlayersNames.visible = false;
                    this.btn_showMonstersInfo.visible = false;
                    this.btn_leave.disabled = false;
                    if (this.fightApi.isWaitingBeforeFight())
                    {
                        this.btn_ready.disabled = true;
                    };
                    this.btn_ready.selected = false;
                    this.btn_lockparty.selected = false;
                    this.btn_lock.selected = false;
                    this.btn_help.selected = false;
                    this.btn_invimode.selected = this._pokemonModeActivated;
                    this.btn_witness.selected = false;
                    this.btn_pointCell.selected = false;
                    this._bIsReady = false;
                    this.btn_viewFights.visible = false;
                    this.tx_timeFrame.visible = true;
                    this.tx_xpFrame.visible = false;
                    if (((contextChanged) && (this._tacticModeActivated)))
                    {
                        this.sysApi.sendAction(new ShowTacticMode());
                    };
                    break;
                case FIGHT_CONTEXT:
                    this.checkTitle(false, false);
                    this.gridDisplay(SPELLS_TAB, true);
                    if (this.papmBackground.softDisabled)
                    {
                        this.papmBackground.softDisabled = false;
                    };
                    this.lbl_time.text = "";
                    this.ctr_locket.visible = true;
                    this.btn_showMapInfo.visible = false;
                    this.btn_showPlayersNames.visible = false;
                    this.btn_showMonstersInfo.visible = false;
                    this.btn_skipTurn.visible = true;
                    this.btn_ready.visible = false;
                    this.btn_lockparty.visible = false;
                    this.btn_lock.visible = false;
                    this.btn_help.visible = false;
                    this.btn_invimode.visible = true;
                    this.btn_witness.visible = true;
                    this.btn_pointCell.visible = true;
                    this.btn_leave.visible = true;
                    this.btn_emptyMap.visible = true;
                    this.btn_leave.disabled = false;
                    this.btn_ready.disabled = false;
                    this.btn_viewFights.visible = false;
                    this.tx_timeFrame.visible = true;
                    this.tx_xpFrame.visible = false;
                    break;
                case ROLEPLAY_CONTEXT:
                    this.checkTitle(false, true);
                    this.gridDisplay(ITEMS_TAB, true);
                    this.papmBackground.softDisabled = true;
                    this.setShield(0);
                    this.lbl_time.text = "";
                    this.ctr_locket.visible = true;
                    this.lbl_ready.text = "";
                    this.btn_showMapInfo.selected = Api.system.getOption("mapCoordinates", "dofus");
                    this.btn_showMapInfo.visible = true;
                    this.btn_showPlayersNames.selected = this._playersNamesVisible;
                    this.btn_showPlayersNames.visible = true;
                    this.btn_showMonstersInfo.selected = this._monstersInfoVisible;
                    this.btn_showMonstersInfo.visible = true;
                    this.btn_skipTurn.visible = false;
                    this.btn_ready.visible = false;
                    this.btn_lockparty.visible = false;
                    this.btn_lock.visible = false;
                    this.btn_help.visible = false;
                    this.btn_invimode.visible = false;
                    this.btn_witness.visible = false;
                    this.btn_pointCell.visible = false;
                    this.btn_leave.visible = false;
                    this.btn_emptyMap.visible = false;
                    this.btn_viewFights.visible = true;
                    this.tx_timeFrame.visible = false;
                    this.tx_xpFrame.visible = true;
                    this.gd_spellitemotes.disabled = false;
                    break;
            };
        }

        public function gridDisplay(tabStyle:String, forceRefresh:Boolean=false):void
        {
            var index:int;
            var dropAllEnabled:Boolean;
            if (this._sContext == ROLEPLAY_CONTEXT)
            {
                dropAllEnabled = true;
            };
            if ((((tabStyle == this._sTabGrid)) && (!(forceRefresh))))
            {
                return;
            };
            var autoselect:Boolean = (tabStyle == this._sTabGrid);
            this._sTabGrid = tabStyle;
            switch (tabStyle)
            {
                case SPELLS_TAB:
                    if (this.uiApi.getRadioGroupSelectedItem("tabGroup", this.uiApi.me()) != this.btn_tabSpells)
                    {
                        this.uiApi.setRadioGroupSelectedItem("tabGroup", this.btn_tabSpells, this.uiApi.me());
                    };
                    this.tx_gridBg.gotoAndStop = 1;
                    this.gd_spellitemotes.renderer.allowDrop = ((dropAllEnabled) ? dropAllEnabled : this._spellMovementAllowed);
                    this.updateGrid(this._aSpells, this._nPageSpells, autoselect);
                    this.lbl_itemsNumber.text = (this._nPageSpells + 1).toString();
                    index = this._nPageSpells;
                    break;
                case ITEMS_TAB:
                    if (this.uiApi.getRadioGroupSelectedItem("tabGroup", this.uiApi.me()) != this.btn_tabItems)
                    {
                        this.uiApi.setRadioGroupSelectedItem("tabGroup", this.btn_tabItems, this.uiApi.me());
                    };
                    this.tx_gridBg.gotoAndStop = 2;
                    this.gd_spellitemotes.renderer.allowDrop = ((dropAllEnabled) ? dropAllEnabled : this._shortcutsMovementAllowed);
                    this.updateGrid(this._aItems, this._nPageItems, autoselect);
                    this.lbl_itemsNumber.text = (this._nPageItems + 1).toString();
                    index = this._nPageItems;
                    break;
            };
            this.btn_upArrow.disabled = (index == 0);
            this.btn_downArrow.disabled = (index == (NUM_PAGES - 1));
        }

        public function onOpenMap(enabled:Boolean):void
        {
            this.gridDisplay(this._sTabGrid, true);
        }

        public function updateBtnLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                componentsRef.lbl_btnName.text = data.name;
                componentsRef.tx_btnSkin.uri = this.uiApi.createUri((this.uiApi.me().getConstant("assets") + data.skin));
                componentsRef.tx_btnSkin.gotoAndStop = "disabled";
                componentsRef.btn_btn.visible = true;
            }
            else
            {
                componentsRef.lbl_btnName.text = "";
                componentsRef.tx_btnSkin.uri = null;
                componentsRef.btn_btn.visible = false;
            };
            componentsRef.btn_btn.selected = false;
        }

        private function updateButtonGrids():void
        {
            this._dataProviderButtons.sortOn("position", Array.NUMERIC);
            this.gd_btnUis.dataProvider = this._dataProviderButtons.slice(0, NUM_BTNS_VISIBLE);
            var remainingButtons:Array = this._dataProviderButtons.slice(NUM_BTNS_VISIBLE);
            var remainingButtonsLength:int = remainingButtons.length;
            if (remainingButtonsLength > 16)
            {
                remainingButtonsLength = 16;
            };
            this.ctr_moreBtn.height = (remainingButtonsLength * (this._uiBtnHeight + this._uiBtnOffset));
            this.gd_additionalBtns.height = this.ctr_moreBtn.height;
            this.gd_additionalBtns.dataProvider = remainingButtons;
        }

        private function formatShortcut(text:String, shortcutKey:String):String
        {
            if (shortcutKey)
            {
                if (!(_shortcutColor))
                {
                    _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                    _shortcutColor = _shortcutColor.replace("0x", "#");
                };
                return ((((((text + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
            };
            return (text);
        }

        private function headDisplay(pLook:Object=null):void
        {
            var url:String;
            var breed:uint;
            var gender:uint;
            var colors:Object;
            var subEntityColors:Object;
            var colorStr:String;
            var color:*;
            var artworkLookStr:String;
            var look:Object;
            var playerId:int;
            var look2:Object;
            var isCreature:Boolean;
            var isIncarnation:Boolean;
            var boneId:uint = ((pLook) ? pLook.getBone() : this.playerApi.getBone());
            var isOnMount:Boolean = ((((this.playerApi.isRidding()) || (this.playerApi.isPetsMounting()))) || (this.playerApi.getCurrentEntityLook().getSubEntity(2, 0)));
            if ((((this._locketMode == LOCKET_ARTWORK)) && (((((this.playerApi.isIncarnation()) || (this.playerApi.isMutated()))) || (((((((((!(isOnMount)) && (!((boneId == 1))))) && (!((boneId == 44))))) && (!((boneId == 453))))) && (!((boneId == 113)))))))))
            {
                if (boneId != 0)
                {
                    this.showMonsterArtwork(boneId);
                };
                return;
            };
            if (this._locketMode == LOCKET_ARTWORK)
            {
                breed = this.playerApi.getPlayedCharacterInfo().breed;
                gender = this.playerApi.getPlayedCharacterInfo().sex;
                subEntityColors = this.playerApi.getSubentityColors();
                if (((isOnMount) && (subEntityColors)))
                {
                    colors = this.playerApi.getSubentityColors();
                }
                else
                {
                    if (!(isOnMount))
                    {
                        colors = this.playerApi.getColors();
                    };
                };
                if (!(colors))
                {
                    look = this.utilApi.getRealTiphonEntityLook(this.playerApi.id(), true);
                    colors = look.getColors();
                };
                colorStr = "";
                for (color in colors)
                {
                    if (colors[color] != -1)
                    {
                        colorStr = (colorStr + (((color + "=#") + colors[color].toString(16)) + ","));
                    };
                };
                colorStr = colorStr.substring(0, (colorStr.length - 1));
                artworkLookStr = "";
                if (!(gender))
                {
                    artworkLookStr = (("{" + this.dataApi.getBreed(breed).maleArtwork) + "}");
                }
                else
                {
                    artworkLookStr = (("{" + this.dataApi.getBreed(breed).femaleArtwork) + "}");
                };
                artworkLookStr = artworkLookStr.replace("}", (("||" + colorStr) + "}"));
                if (((!((artworkLookStr == this._artworkLookStr))) || ((this.ed_coloredArtwork.look == null))))
                {
                    this.ed_coloredArtwork.entityScale = 1;
                    this.ed_coloredArtwork.yOffset = 0;
                    this.ed_coloredArtwork.setAnimationAndDirection("AnimArtwork", 1);
                    this.ed_coloredArtwork.view = "banner";
                    this.ed_coloredArtwork.look = this.sysApi.getEntityLookFromString(artworkLookStr);
                    this._artworkLookStr = artworkLookStr;
                };
                this.ed_coloredArtwork.visible = true;
                this.tx_artwork.visible = false;
            }
            else
            {
                if (this._locketMode == LOCKET_SPRITE)
                {
                    playerId = this.getPlayerId();
                    look2 = this.utilApi.getLookFromContext(playerId);
                    isCreature = this.utilApi.isCreature(playerId);
                    isIncarnation = this.utilApi.isIncarnation(playerId);
                    if (((!(look2)) && (pLook)))
                    {
                        look2 = pLook;
                        isCreature = this.utilApi.isCreatureFromLook(look2);
                        isIncarnation = this.utilApi.isIncarnationFromLook(look2);
                    };
                    if (look2)
                    {
                        this.showSpritePortrait(look2, isCreature, isIncarnation);
                    };
                };
            };
        }

        private function showSpritePortrait(pLook:Object, pIsCreature:Boolean, pIsIncarnation:Boolean):void
        {
            var sameLook:Boolean;
            var tmpLook:Object;
            var boneId:uint;
            var isCharacterFighter:Boolean;
            var fighterId:int;
            this.tx_artwork.visible = false;
            var look:Object = pLook;
            if (pLook.getSubEntity(2, 0))
            {
                if (!(pIsCreature))
                {
                    look = pLook.getSubEntity(2, 0).clone();
                    look.setBone(1);
                }
                else
                {
                    look.removeSubEntity(2, 0);
                };
            };
            if (this.ed_coloredArtwork.look)
            {
                tmpLook = this.ed_coloredArtwork.look.clone();
                if (look.getSubEntity(6, 0))
                {
                    tmpLook.addSubEntity(6, 0, look.getSubEntity(6, 0).clone());
                };
                if (look.getSubEntity(1, 0))
                {
                    tmpLook.addSubEntity(1, 0, look.getSubEntity(1, 0).clone());
                };
                sameLook = tmpLook.equals(look);
            };
            if (((!(this.ed_coloredArtwork.look)) || (!(sameLook))))
            {
                boneId = ((pLook.getSubEntity(2, 0)) ? pLook.getSubEntity(2, 0).getBone() : pLook.getBone());
                if (((((!((boneId == 1))) && (!(pLook.getSubEntity(2, 0))))) && (((((!(this.playerApi.isInFight())) && (pIsCreature))) || (((this.playerApi.isInFight()) && (((this._pokemonModeActivated) || ((boneId == 1519))))))))))
                {
                    this.ed_coloredArtwork.entityScale = 0.9;
                    this.ed_coloredArtwork.yOffset = 0;
                }
                else
                {
                    if (((((!(this.playerApi.isInFight())) || ((this.fightApi.getCurrentPlayedFighterId() == this.playerApi.id())))) && (pIsIncarnation)))
                    {
                        this.ed_coloredArtwork.entityScale = 1;
                        this.ed_coloredArtwork.yOffset = 0;
                    }
                    else
                    {
                        isCharacterFighter = false;
                        if (((!(this.playerApi.isInFight())) || ((boneId == 1))))
                        {
                            isCharacterFighter = true;
                        }
                        else
                        {
                            fighterId = ((this._bIsSpectator) ? this.fightApi.getPlayingFighterId() : this.fightApi.getCurrentPlayedFighterId());
                            if ((((fighterId > 0)) && (!(this.fightApi.isCompanion(fighterId)))))
                            {
                                isCharacterFighter = true;
                            };
                        };
                        if (isCharacterFighter)
                        {
                            this.ed_coloredArtwork.entityScale = 2;
                            this.ed_coloredArtwork.yOffset = 50;
                        }
                        else
                        {
                            this.ed_coloredArtwork.entityScale = 1;
                            this.ed_coloredArtwork.yOffset = 0;
                        };
                    };
                };
                this.ed_coloredArtwork.view = null;
                this.ed_coloredArtwork.look = pLook;
                this.ed_coloredArtwork.setAnimationAndDirection("AnimStatique", 1);
            };
            this.ed_coloredArtwork.visible = true;
            this._artworkLookStr = "";
        }

        private function showMonsterArtwork(boneId:int):void
        {
            var url:String;
            var playerId:int;
            var look:Object;
            if (boneId == 0)
            {
                this.headDisplay();
            }
            else
            {
                if (this._locketMode == LOCKET_ARTWORK)
                {
                    this.ed_coloredArtwork.visible = false;
                    this.tx_artwork.visible = true;
                    url = this.sysApi.getConfigKey("ui.gfx.artworks");
                    if ((((this.playerApi.state() == PlayerLifeStatusEnum.STATUS_TOMBSTONE)) || ((((boneId > 2371)) && ((boneId < 2387))))))
                    {
                        url = (url + "23.png");
                    }
                    else
                    {
                        url = (url + (boneId.toString() + ".png"));
                    };
                    this.tx_artwork.uri = this.uiApi.createUri(url);
                    if (!(this.tx_artwork.finalized))
                    {
                        this.tx_artwork.finalize();
                    };
                }
                else
                {
                    playerId = this.getPlayerId();
                    look = this.utilApi.getLookFromContext(playerId);
                    if (look)
                    {
                        this.showSpritePortrait(look, this.utilApi.isCreature(playerId), this.utilApi.isIncarnation(playerId));
                    };
                };
            };
        }

        public function onTextureLoadFail(pTexture:Texture):void
        {
            var realLook:Object = this.utilApi.getRealTiphonEntityLook(this.getPlayerId(), true);
            var fileName:String = (realLook.getBone().toString() + ".png");
            if (fileName != pTexture.uri.fileName)
            {
                if (this.getPlayerId() == this.playerApi.id())
                {
                    this.headDisplay(realLook);
                }
                else
                {
                    this.showMonsterArtwork(realLook.getBone());
                };
            };
        }

        private function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            if (!(data))
            {
                return (false);
            };
            switch (this._sTabGrid)
            {
                case SPELLS_TAB:
                    return ((((data.simplyfiedQualifiedClassName == "SpellWrapper")) || ((data.simplyfiedQualifiedClassName == "ShortcutWrapper"))));
                case ITEMS_TAB:
                    return ((((((((((data is ItemWrapper)) || ((data.simplyfiedQualifiedClassName == "PresetWrapper")))) || ((data.simplyfiedQualifiedClassName == "EmoteWrapper")))) || ((data.simplyfiedQualifiedClassName == "SmileyWrapper")))) || ((data.simplyfiedQualifiedClassName == "ShortcutWrapper"))));
            };
            return (false);
        }

        private function processDrop(target:Object, data:Object, source:Object):void
        {
            if (this.dropValidator(target, data, source))
            {
                switch (this._sTabGrid)
                {
                    case SPELLS_TAB:
                        if (data.simplyfiedQualifiedClassName == "ShortcutWrapper")
                        {
                            this.sysApi.sendAction(new ShortcutBarSwapRequest(1, data.slot, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageSpells * NUM_ITEMS_PER_PAGE))));
                        }
                        else
                        {
                            this.sysApi.sendAction(new ShortcutBarAddRequest(2, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageSpells * NUM_ITEMS_PER_PAGE))));
                        };
                        break;
                    case ITEMS_TAB:
                        if (data.simplyfiedQualifiedClassName == "ShortcutWrapper")
                        {
                            this.sysApi.sendAction(new ShortcutBarSwapRequest(0, data.slot, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                        }
                        else
                        {
                            if (data.simplyfiedQualifiedClassName == "PresetWrapper")
                            {
                                this.sysApi.sendAction(new ShortcutBarAddRequest(1, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                            }
                            else
                            {
                                if (data.simplyfiedQualifiedClassName == "EmoteWrapper")
                                {
                                    this.sysApi.sendAction(new ShortcutBarAddRequest(4, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                                }
                                else
                                {
                                    if (data.simplyfiedQualifiedClassName == "SmileyWrapper")
                                    {
                                        this.sysApi.sendAction(new ShortcutBarAddRequest(3, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                                    }
                                    else
                                    {
                                        this.sysApi.sendAction(new ShortcutBarAddRequest(0, data.objectUID, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                                    };
                                };
                            };
                        };
                        break;
                };
            };
        }

        private function dropValidatorBtn(target:Object, data:Object, source:Object):Boolean
        {
            if (((!(data)) || (!(this.ctr_moreBtn.visible))))
            {
                return (false);
            };
            return ((data.simplyfiedQualifiedClassName == "ButtonWrapper"));
        }

        private function processDropBtn(target:Object, data:Object, source:Object):void
        {
            var idTarget:int;
            var idData:int;
            var slot:Slot;
            var fromSelected:Boolean;
            var fromDisabled:Boolean;
            var toSelected:Boolean;
            var toDisabled:Boolean;
            if (this.dropValidatorBtn(target, data, source))
            {
                idTarget = target.data.id;
                idData = data.id;
                slot = this.getSlotByBtnId(idData);
                fromSelected = slot.selected;
                fromDisabled = slot.disabled;
                slot = this.getSlotByBtnId(idTarget);
                toSelected = slot.selected;
                toDisabled = slot.disabled;
                this._aBtnOrderForCache[idData] = target.data.position;
                this._aBtnOrderForCache[idTarget] = data.position;
                this.sysApi.setData("uiBtnOrder", this._aBtnOrderForCache);
                this.rpApi.switchButtonWrappers(data, target.data);
                this.updateButtonGrids();
                this.uiApi.hideTooltip();
                slot = this.getSlotByBtnId(idData);
                slot.selected = fromSelected;
                slot.disabled = fromDisabled;
                slot = this.getSlotByBtnId(idTarget);
                slot.selected = toSelected;
                slot.disabled = toDisabled;
                this.refreshButtonAtIndex(this.getBtnById(idData).position);
                this.refreshButtonAtIndex(this.getBtnById(idTarget).position);
            };
        }

        private function onValidQty(qty:Number):void
        {
            if (qty <= 0)
            {
                return;
            };
            this.sysApi.sendAction(new ObjectSetPosition(this._waitingObjectUID, this._waitingObjectPosition, qty));
        }

        private function updateGrid(items:*, page:uint, autoSelect:Boolean=true):void
        {
            var item:Object;
            var i:uint;
            var dp:Array = new Array();
            for each (item in items)
            {
                if (item)
                {
                    dp[(item.slot - (page * NUM_ITEMS_PER_PAGE))] = item;
                };
            };
            i = 0;
            while (i < (NUM_PAGES * NUM_ITEMS_PER_PAGE))
            {
                if (!(dp[i]))
                {
                    dp[i] = null;
                };
                i++;
            };
            this.gd_spellitemotes.dataProvider = dp;
            if (!(autoSelect))
            {
                this.gd_spellitemotes.selectedIndex = -1;
                this.unselectSpell();
            };
        }

        private function emptyFct(... args):void
        {
        }

        private function changeLifepointDisplay(mode:int):void
        {
            if (mode != this._lifepointMode)
            {
                this.sysApi.setData("lifepointMode", {"mode":mode});
                this._lifepointMode = mode;
            };
            switch (this._lifepointMode)
            {
                case 0:
                case 3:
                    this._lifepointMode = 0;
                    this.lbl_pdv.visible = true;
                    this.lbl_pdvBottom.visible = false;
                    this.lbl_pdvTop.visible = false;
                    break;
                case 1:
                case 2:
                    this.lbl_pdv.visible = false;
                    this.lbl_pdvBottom.visible = true;
                    this.lbl_pdvTop.visible = true;
                    break;
            };
            this.setPdv(this._currentPdv, this._totalPdv);
        }

        private function onMountSet():void
        {
            this.checkMount();
            var mount:Object = this.playerApi.getMount();
            if ((((this._roundGaugeType == MOUNT_GAUGE)) && (mount)))
            {
                this.setXp(mount.experience, mount.experienceForLevel, mount.experienceForNextLevel, mount.level);
            };
        }

        private function onMountUnSet():void
        {
            this.checkMount();
            if ((((this._roundGaugeType == MOUNT_GAUGE)) && (!(this.playerApi.getMount()))))
            {
                this.onChangeXpGauge(0);
            };
        }

        private function onMountRiding(isRiding:Boolean):void
        {
            if (this._sContext == SPECTATOR_CONTEXT)
            {
                this.headDisplay();
            };
        }

        private function onSpouseUpdated():void
        {
            this.checkSpouse();
        }

        private function onArenaUpdateRank(ranks:Object, fights:int, wonFights:int):void
        {
            if (((!(this.getBtnById(ID_BTN_CONQUEST).active)) && ((this.playerApi.getPlayedCharacterInfo().level >= 50))))
            {
                this.checkConquest();
            };
        }

        private function onJobsListUpdated():void
        {
            this.checkJob();
        }

        private function onJobsExpUpdated(jobId:uint):void
        {
            var jobs:Array;
            var j:Object;
            var jobInfo:Object;
            var value:int;
            var floor:int;
            var nextFloor:int;
            if (this._roundGaugeType >= JOB_GAUGE)
            {
                jobs = new Array();
                for each (j in this.jobsApi.getKnownJobs())
                {
                    jobs.push(j);
                };
                jobInfo = this.jobsApi.getJobExperience(jobs[(this._roundGaugeType - JOB_GAUGE)]);
                if (jobInfo.currentLevel == 100)
                {
                    value = 1;
                    floor = 0;
                    nextFloor = 1;
                }
                else
                {
                    value = jobInfo.currentExperience;
                    floor = jobInfo.levelExperienceFloor;
                    nextFloor = jobInfo.levelExperienceCeil;
                };
                this.setXp(value, floor, nextFloor, jobInfo.currentLevel);
            };
        }

        private function onGuildInformationsGeneral(enabled:Boolean, expLevelFloor:Number, experience:Number, expNextLevelFloor:Number, level:uint, creationDate:uint, warning:Boolean, nbConnectedMembers:int, nbMembers:int):void
        {
            var value:Number;
            var floor:Number;
            var nextFloor:Number;
            if (this._lookingForMyGuildPlz)
            {
                this._roundGaugeType = GUILD_GAUGE;
                this._lookingForMyGuildPlz = false;
            };
            if (this._roundGaugeType == GUILD_GAUGE)
            {
                value = experience;
                floor = expLevelFloor;
                nextFloor = expNextLevelFloor;
                this.setXp(value, floor, nextFloor, level);
            };
        }

        private function onHouseInformations(houses:Object):void
        {
            var daHouse:AccountHouseInformations;
            var hintsList:Object = this.miniMap.getMapElementsByLayer("layer_7");
            var nHints:int = hintsList.length;
            var p:int;
            while (p < nHints)
            {
                if (((((hintsList[p]) && (hintsList[p].id))) && (!((hintsList[p].id.indexOf("myHouse") == -1)))))
                {
                    this.miniMap.removeMapElement(hintsList[p]);
                };
                p++;
            };
            var indexHouse:int;
            for each (daHouse in houses)
            {
                if (this.dataApi.getSubArea(daHouse.subAreaId).area.superAreaId == this._currentSuperAreaId)
                {
                    this._hintLegends[("miniMap_myHouse_" + indexHouse)] = (((((daHouse.worldX + ",") + daHouse.worldY) + " (") + this.uiApi.getText("ui.common.myHouse")) + ")");
                    this.miniMap.addIcon("layer_7", ("myHouse_" + indexHouse), (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1000"), daHouse.worldX, daHouse.worldY, this._mapIconScale);
                    indexHouse++;
                };
            };
            if (this._waitingForSocialUpdate == 0)
            {
                this.miniMap.updateMapElements();
            };
        }

        private function onGuildInformationsFarms():void
        {
            var paddock:PaddockContentInformations;
            var hintsList:Object = this.miniMap.getMapElementsByLayer("layer_7");
            var nHints:int = hintsList.length;
            var p:int;
            while (p < nHints)
            {
                if (((((hintsList[p]) && (hintsList[p].id))) && (!((hintsList[p].id.indexOf("guildPaddock") == -1)))))
                {
                    this.miniMap.removeMapElement(hintsList[p]);
                };
                p++;
            };
            var farmsList:Object = this.socialApi.getGuildPaddocks();
            for each (paddock in farmsList)
            {
                if (this.dataApi.getSubArea(paddock.subAreaId).area.superAreaId == this._currentSuperAreaId)
                {
                    this._hintLegends[("miniMap_guildPaddock_" + paddock.paddockId)] = (((((paddock.worldX + ",") + paddock.worldY) + " (") + this.uiApi.processText(this.uiApi.getText("ui.guild.paddock", paddock.maxOutdoorMount), "", (paddock.maxOutdoorMount == 1))) + ")");
                    this.miniMap.addIcon("layer_7", ("guildPaddock_" + paddock.paddockId), (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1002"), paddock.worldX, paddock.worldY, this._mapIconScale);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.miniMap.updateMapElements();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildPaddockAdd(paddockInfo:PaddockContentInformations):void
        {
            if (this.dataApi.getSubArea(paddockInfo.subAreaId).area.superAreaId == this._currentSuperAreaId)
            {
                this._hintLegends[("miniMap_guildPaddock_" + paddockInfo.paddockId)] = (((((paddockInfo.worldX + ",") + paddockInfo.worldY) + " (") + this.uiApi.processText(this.uiApi.getText("ui.guild.paddock", paddockInfo.maxOutdoorMount), "", (paddockInfo.maxOutdoorMount == 1))) + ")");
                this.miniMap.addIcon("layer_7", ("guildPaddock_" + paddockInfo.paddockId), (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1002"), paddockInfo.worldX, paddockInfo.worldY, this._mapIconScale);
                this.miniMap.updateMapElements();
            };
        }

        private function onGuildPaddockRemoved(paddockId:uint):void
        {
            var mapElemList:Object = this.miniMap.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildPaddock_" + paddockId)) == 0)
                {
                    this.miniMap.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.miniMap.updateMapElements();
        }

        private function onGuildHousesUpdate():void
        {
            var house:GuildHouseWrapper;
            var hintsList:Object = this.miniMap.getMapElementsByLayer("layer_7");
            var nHints:int = hintsList.length;
            var p:int;
            while (p < nHints)
            {
                if (((((hintsList[p]) && (hintsList[p].id))) && (!((hintsList[p].id.indexOf("guildHouse") == -1)))))
                {
                    this.miniMap.removeMapElement(hintsList[p]);
                };
                p++;
            };
            var housesList:Object = this.socialApi.getGuildHouses();
            for each (house in housesList)
            {
                if (this.dataApi.getSubArea(house.subareaId).area.superAreaId == this._currentSuperAreaId)
                {
                    this._hintLegends[("miniMap_guildHouse_" + house.houseId)] = (((((((house.worldX + ",") + house.worldY) + " (") + this.uiApi.getText("ui.common.guildHouse")) + this.uiApi.getText("ui.common.colon")) + house.houseName) + ")");
                    this.miniMap.addIcon("layer_7", ("guildHouse_" + house.houseId), (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1001"), house.worldX, house.worldY, this._mapIconScale);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.miniMap.updateMapElements();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildHouseAdd(house:GuildHouseWrapper):void
        {
            if (this.dataApi.getSubArea(house.subareaId).area.superAreaId == this._currentSuperAreaId)
            {
                this._hintLegends[("miniMap_guildHouse_" + house.houseId)] = (((((((house.worldX + ",") + house.worldY) + " (") + this.uiApi.getText("ui.common.guildHouse")) + this.uiApi.getText("ui.common.colon")) + house.houseName) + ")");
                this.miniMap.addIcon("layer_7", ("guildHouse_" + house.houseId), (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1001"), house.worldX, house.worldY, this._mapIconScale);
                this.miniMap.updateMapElements();
            };
        }

        private function onGuildHouseRemoved(houseId:uint):void
        {
            var housesList:Object = this.socialApi.getGuildHouses();
            var mapElemList:Object = this.miniMap.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildHouse_" + houseId)) == 0)
                {
                    this.miniMap.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.miniMap.updateMapElements();
        }

        private function onTaxCollectorListUpdate():void
        {
            var taxCollector:TaxCollectorWrapper;
            var hintsList:Object = this.miniMap.getMapElementsByLayer("layer_7");
            var nHints:int = hintsList.length;
            var p:int;
            while (p < nHints)
            {
                if (((((hintsList[p]) && (hintsList[p].id))) && (!((hintsList[p].id.indexOf("guildPony") == -1)))))
                {
                    this.miniMap.removeMapElement(hintsList[p]);
                };
                p++;
            };
            var taxCollectorsList:Object = this.socialApi.getTaxCollectors();
            for each (taxCollector in taxCollectorsList)
            {
                if (this.dataApi.getSubArea(taxCollector.subareaId).area.superAreaId == this._currentSuperAreaId)
                {
                    this._hintLegends[("miniMap_guildPony_" + taxCollector.uniqueId)] = (((((taxCollector.mapWorldX + ",") + taxCollector.mapWorldY) + " (") + this.uiApi.getText("ui.guild.taxCollectorFullInformations", taxCollector.firstName, taxCollector.lastName, taxCollector.additionalInformation.collectorCallerName, taxCollector.kamas, taxCollector.pods, taxCollector.itemsValue, taxCollector.experience)) + ")");
                    this.miniMap.addIcon("layer_7", ("guildPony_" + taxCollector.uniqueId), (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1003"), taxCollector.mapWorldX, taxCollector.mapWorldY, this._mapIconScale);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.miniMap.updateMapElements();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildTaxCollectorAdd(taxCollector:TaxCollectorWrapper):void
        {
            var firstName:String;
            var lastName:String;
            if (this.dataApi.getSubArea(taxCollector.subareaId).area.superAreaId == this._currentSuperAreaId)
            {
                firstName = taxCollector.firstName;
                lastName = taxCollector.lastName;
                this._hintLegends[("miniMap_guildPony_" + taxCollector.uniqueId)] = (((((taxCollector.mapWorldX + ",") + taxCollector.mapWorldY) + " (") + this.uiApi.getText("ui.guild.taxCollectorFullInformations", firstName, lastName, taxCollector.additionalInformation.collectorCallerName, taxCollector.kamas, taxCollector.pods, taxCollector.itemsValue, taxCollector.experience)) + ")");
                this.miniMap.addIcon("layer_7", ("guildPony_" + taxCollector.uniqueId), (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_1003"), taxCollector.mapWorldX, taxCollector.mapWorldY, this._mapIconScale);
                this.miniMap.updateMapElements();
            };
        }

        private function onGuildTaxCollectorRemoved(taxCollectorId:uint):void
        {
            var mapElemList:Object = this.miniMap.getMapElementsByLayer("layer_7");
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildPony_" + taxCollectorId)) == 0)
                {
                    this.miniMap.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.miniMap.updateMapElements();
        }

        private function onPrismsListInformation(pPrismsInfo:Object):void
        {
            var i:int;
            var prismSubAreaInfo:PrismSubAreaWrapper;
            var prismList:Object = this.miniMap.getMapElementsByLayer("layer_5");
            var nPrism:int = prismList.length;
            var p:int;
            while (p < nPrism)
            {
                this.miniMap.removeMapElement(prismList[p]);
                p++;
            };
            for each (prismSubAreaInfo in pPrismsInfo)
            {
                this.updatePrismIcon(prismSubAreaInfo);
            };
            this.miniMap.updateMapElements();
        }

        private function onPrismsInfoUpdate(pPrismSubAreaIds:Object):void
        {
            var prismSubAreaInfo:PrismSubAreaWrapper;
            var subAreaId:int;
            for each (subAreaId in pPrismSubAreaIds)
            {
                prismSubAreaInfo = this.socialApi.getPrismSubAreaById(subAreaId);
                this.updatePrismIcon(prismSubAreaInfo);
            };
            this.miniMap.updateMapElements();
        }

        private function updatePrismIcon(pPrismSubAreaInformation:PrismSubAreaWrapper):void
        {
            var allianceName:String;
            var prismStateInfo:Object;
            var subArea:SubArea = this.dataApi.getSubArea(pPrismSubAreaInformation.subAreaId);
            var prismId:String = ("prism_" + pPrismSubAreaInformation.subAreaId);
            if (((((((!((pPrismSubAreaInformation.mapId == -1))) && (subArea.worldmap))) && ((subArea.worldmap.id == this._currentWorldId)))) && (((pPrismSubAreaInformation.alliance) || (this.socialApi.getAlliance())))))
            {
                allianceName = ((pPrismSubAreaInformation.alliance) ? pPrismSubAreaInformation.alliance.allianceName : this.socialApi.getAlliance().allianceName);
                prismStateInfo = this.modCartography.getPrismStateInfo(pPrismSubAreaInformation.state);
                this._hintLegends[("miniMap_prism_" + pPrismSubAreaInformation.subAreaId)] = (((((((pPrismSubAreaInformation.worldX + ",") + pPrismSubAreaInformation.worldY) + " (") + prismStateInfo.text) + " - ") + allianceName) + ")");
                if (this.miniMap.getMapElement(prismId))
                {
                    this.miniMap.removeMapElement(this.miniMap.getMapElement(prismId));
                };
                if (((this._lastWorldMapInfo) && ((this._lastWorldMapInfo.id == this._currentWorldId))))
                {
                    this.miniMap.addIcon("layer_5", prismId, ((this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_") + prismStateInfo.icon), pPrismSubAreaInformation.worldX, pPrismSubAreaInformation.worldY, this._mapIconScale);
                }
                else
                {
                    this._prismsToAdd.push({
                        "prismId":prismId,
                        "icon":((this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|icon_") + prismStateInfo.icon),
                        "prismX":pPrismSubAreaInformation.worldX,
                        "prismY":pPrismSubAreaInformation.worldY
                    });
                };
            }
            else
            {
                if (pPrismSubAreaInformation.mapId == -1)
                {
                    this.miniMap.removeMapElement(this.miniMap.getMapElement(prismId));
                };
            };
        }

        private function onShortcutBarViewContent(barType:int):void
        {
            if (barType == 0)
            {
                this._aItems = this.storageApi.getShortcutBarContent(barType);
                if (this._sTabGrid == ITEMS_TAB)
                {
                    this.updateGrid(this._aItems, this._nPageItems);
                };
            }
            else
            {
                if (barType == 1)
                {
                    this.updateSpellShortcuts();
                };
            };
        }

        private function updateSpellShortcuts():void
        {
            this._aSpells = this.storageApi.getShortcutBarContent(1);
            var olNPage:int = this._nPageSpells;
            if (this.getPlayerId() < 0)
            {
                this._nPageSpells = 0;
            }
            else
            {
                this._nPageSpells = this.sysApi.getData(("bannerSpellsPageIndex" + this.getPlayerId()));
            };
            if (olNPage != this._nPageSpells)
            {
                this.displayPage();
            };
            if (this._sTabGrid == SPELLS_TAB)
            {
                this.updateGrid(this._aSpells, this._nPageSpells);
            };
        }

        public function onGameFightEnd(params:Object):void
        {
            this.sysApi.removeEventListener(this.onEnterFrame);
            this.changeContext(ROLEPLAY_CONTEXT);
        }

        public function onSpectatorWantLeave():void
        {
            this.onGameFightEnd(null);
        }

        public function onSlaveStatsList(charac:Object):void
        {
            this.onCharacterStatsList(false, charac);
            this.updateSpellShortcuts();
        }

        public function onCharacterStatsList(oneLifePointRegenOnly:Boolean=false, charac:Object=null):void
        {
            var pdv:int;
            var pdvMax:int;
            var pa:int;
            var pm:int;
            var currentPlayerId:int;
            var fighterInfos:FighterInformations;
            var _local_9:Object;
            if (this._bIsSpectator)
            {
                return;
            };
            if (!(charac))
            {
                charac = this.playerApi.characteristics();
            };
            if (((!(this.fightApi.preFightIsActive())) && (this.playerApi.isInFight())))
            {
                currentPlayerId = this.fightApi.getCurrentPlayedFighterId();
                fighterInfos = this.fightApi.getFighterInformations(currentPlayerId);
                if (fighterInfos)
                {
                    if (fighterInfos.shieldPoints != this._currentShieldPoints)
                    {
                        this.setShield(fighterInfos.shieldPoints);
                    };
                    pdv = fighterInfos.lifePoints;
                    pdvMax = fighterInfos.maxLifePoints;
                    pa = fighterInfos.actionPoints;
                    pm = fighterInfos.movementPoints;
                };
            };
            if (pdvMax == 0)
            {
                pdv = charac.lifePoints;
                pdvMax = charac.maxLifePoints;
                pa = charac.actionPointsCurrent;
                pm = charac.movementPointsCurrent;
            };
            this.setPdv(pdv, pdvMax);
            this.setPA(pa);
            this.setPM(pm);
            if (this.tx_xpFrame.numChildren > 0)
            {
                switch (this._roundGaugeType)
                {
                    case XP_GAUGE:
                        this.setXp(charac.experience, charac.experienceLevelFloor, charac.experienceNextLevelFloor, this.playerApi.getPlayedCharacterInfo().level);
                        break;
                    case HONOUR_GAUGE:
                        if (((charac.alignmentInfos) && ((charac.alignmentInfos.alignmentSide > 0))))
                        {
                            this.setXp(charac.alignmentInfos.honor, charac.alignmentInfos.honorGradeFloor, charac.alignmentInfos.honorNextGradeFloor, charac.alignmentInfos.alignmentGrade);
                        }
                        else
                        {
                            this.onChangeXpGauge(0);
                        };
                        break;
                    case POD_GAUGE:
                        this.setXp(this.playerApi.inventoryWeight(), 0, this.playerApi.inventoryWeightMax());
                        break;
                    case MOUNT_GAUGE:
                        _local_9 = this.playerApi.getMount();
                        if (_local_9)
                        {
                            this.setXp(_local_9.experience, _local_9.experienceForLevel, _local_9.experienceForNextLevel, _local_9.level);
                        };
                        break;
                };
            };
        }

        public function onInventoryWeight(currentWeight:uint, maxWeight:uint):void
        {
            if (this._roundGaugeType == POD_GAUGE)
            {
                this.setXp(currentWeight, 0, maxWeight);
            };
        }

        public function onObjectModified(item:Object):void
        {
            var effectIncarnation:EffectInstanceDate;
            var level:int;
            var floor:int;
            var nextFloor:int;
            var effect:EffectInstance;
            var value:int;
            var incLevel:IncarnationLevel;
            var incLevelPlusOne:IncarnationLevel;
            if ((((item.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)) && ((this._roundGaugeType == INCARNATION_GAUGE))))
            {
                level = 1;
                floor = 0;
                nextFloor = 0;
                for each (effect in this.playerApi.getWeapon().effects)
                {
                    if (effect.effectId == 669)
                    {
                        effectIncarnation = (effect as EffectInstanceDate);
                    };
                };
                value = int(effectIncarnation.parameter3);
                do 
                {
                    incLevel = this.dataApi.getIncarnationLevel(int(effectIncarnation.parameter0), level);
                    if (incLevel)
                    {
                        floor = incLevel.requiredXp;
                    };
                    level++;
                    incLevelPlusOne = this.dataApi.getIncarnationLevel(int(effectIncarnation.parameter0), level);
                    if (incLevelPlusOne)
                    {
                        nextFloor = incLevelPlusOne.requiredXp;
                    };
                } while ((((nextFloor < value)) && (incLevelPlusOne)));
                this._roundRemainingValue = 1;
                if (!(incLevelPlusOne))
                {
                    if (value >= nextFloor)
                    {
                        this._roundRemainingValue = 0;
                    };
                    nextFloor = value;
                };
                this.setXp(value, floor, nextFloor, (level - 1));
            };
        }

        public function onEquipmentObjectMove(pItemWrapper:Object, oldPosition:int):void
        {
            if (((((!(pItemWrapper)) && ((oldPosition == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)))) && ((this._roundGaugeType == INCARNATION_GAUGE))))
            {
                this.onChangeXpGauge(0);
            };
        }

        public function onGameFightTurnStart(id:int, waitTime:int, remainingTime:uint, picture:Boolean):void
        {
            var fighterInfo:Object;
            this._currentTurnEntityId = id;
            var isPlayer:Boolean = (id == this.fightApi.getCurrentPlayedFighterId());
            if (((isPlayer) || (this._bIsSpectator)))
            {
                this._clockStart = getTimer();
                this._turnDuration = waitTime;
                this._turnElapsedTime = (waitTime - remainingTime);
                this.sysApi.addEventListener(this.onEnterFrame, "FightBannerA");
            };
            if (this._bIsSpectator)
            {
                fighterInfo = this.fightApi.getFighterInformations(id);
                this.setShield(fighterInfo.shieldPoints);
                this.setPdv(fighterInfo.lifePoints, fighterInfo.maxLifePoints);
                this.setPA(fighterInfo.actionPoints);
                this.setPM(fighterInfo.movementPoints);
                this.showSpritePortrait(this.utilApi.getTiphonEntityLook(id), false, false);
            }
            else
            {
                if (!(isPlayer))
                {
                    this.sysApi.removeEventListener(this.onEnterFrame);
                    this.setTimeFromPercent(0);
                };
            };
        }

        public function onGameFightTurnEnd(id:int):void
        {
            if (id == this._currentTurnEntityId)
            {
                this.sysApi.removeEventListener(this.onEnterFrame);
                this.setTimeFromPercent(0);
                this.lbl_time.text = "";
                this.ctr_locket.visible = true;
            };
        }

        public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int):void
        {
            this._bIsSpectator = isSpectator;
            if (this._bIsSpectator)
            {
                this.changeContext(SPECTATOR_CONTEXT);
            }
            else
            {
                if (!(timeMaxBeforeFightStart))
                {
                    this.onGameFightStart();
                }
                else
                {
                    this.changeContext(PREFIGHT_CONTEXT);
                    this._turnDuration = (((timeMaxBeforeFightStart == -1)) ? 0 : timeMaxBeforeFightStart);
                    if (this.tx_timeFrame.numChildren == 0)
                    {
                        this.sysApi.addEventListener(this.onWaitingSwfLoaded, "FightBannerWaiting");
                    }
                    else
                    {
                        this._clockStart = getTimer();
                        this.sysApi.addEventListener(this.onEnterFrame, "FightBannerB");
                    };
                };
            };
        }

        public function onGameFightStart():void
        {
            if (!(this._bIsSpectator))
            {
                this.changeContext(FIGHT_CONTEXT);
            };
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        private function onReadyToFight():void
        {
            this.onRelease(this.btn_ready);
        }

        public function onFightEvent(eventName:String, params:Object, targetList:Object=null):void
        {
            var spectatorModeCurrentPlayer:Boolean;
            var targetId:int;
            var characteristics:Object;
            var life:int;
            var maxLife:int;
            var shield:int;
            if ((((((targetList == null)) || ((targetList == new Array())))) || ((targetList.length == 0))))
            {
                targetList = new Array();
                if (params.length)
                {
                    targetList[0] = params[0];
                };
            };
            var num:int = targetList.length;
            var i:int;
            while (i < num)
            {
                targetId = targetList[i];
                characteristics = this.fightApi.getFighterInformations(targetId);
                spectatorModeCurrentPlayer = ((this._bIsSpectator) && ((targetId == this.fightApi.getPlayingFighterId())));
                if (((characteristics) || (!((this._sContext == FIGHT_CONTEXT)))))
                {
                    switch (eventName)
                    {
                        case FightEventEnum.FIGHTER_LIFE_GAIN:
                        case FightEventEnum.FIGHTER_LIFE_LOSS:
                        case FightEventEnum.FIGHTER_SUMMONED:
                            if ((((targetId == this.fightApi.getCurrentPlayedFighterId())) || (spectatorModeCurrentPlayer)))
                            {
                                if ((((this._sContext == FIGHT_CONTEXT)) || (spectatorModeCurrentPlayer)))
                                {
                                    maxLife = characteristics.maxLifePoints;
                                    life = characteristics.lifePoints;
                                }
                                else
                                {
                                    maxLife = this.fightApi.getCurrentPlayedCharacteristicsInformations().maxLifePoints;
                                    life = this.fightApi.getCurrentPlayedCharacteristicsInformations().lifePoints;
                                };
                                this.setPdv(life, maxLife);
                            };
                            break;
                        case FightEventEnum.FIGHTER_DEATH:
                        case FightEventEnum.FIGHTER_LEAVE:
                            if ((((targetId == this.fightApi.getCurrentPlayedFighterId())) || (spectatorModeCurrentPlayer)))
                            {
                                this.setPdv(0, characteristics.maxLifePoints);
                            };
                            break;
                        case FightEventEnum.FIGHTER_SHIELD_LOSS:
                            if ((((targetId == this.fightApi.getCurrentPlayedFighterId())) || (spectatorModeCurrentPlayer)))
                            {
                                shield = characteristics.shieldPoints;
                                this.setShield(shield);
                            };
                            break;
                        case FightEventEnum.FIGHTER_AP_USED:
                        case FightEventEnum.FIGHTER_AP_LOST:
                        case FightEventEnum.FIGHTER_AP_GAINED:
                            if ((((targetId == this.fightApi.getCurrentPlayedFighterId())) || (spectatorModeCurrentPlayer)))
                            {
                                this.setPA(characteristics.actionPoints);
                            };
                            break;
                        case FightEventEnum.FIGHTER_MP_USED:
                        case FightEventEnum.FIGHTER_MP_LOST:
                        case FightEventEnum.FIGHTER_MP_GAINED:
                            if ((((targetId == this.fightApi.getCurrentPlayedFighterId())) || (spectatorModeCurrentPlayer)))
                            {
                                this.setPM(characteristics.movementPoints);
                            };
                            break;
                        case FightEventEnum.FIGHTER_GOT_DISPELLED:
                        case FightEventEnum.FIGHTER_TEMPORARY_BOOSTED:
                            if ((((targetId == this.fightApi.getCurrentPlayedFighterId())) || (spectatorModeCurrentPlayer)))
                            {
                                this.setPA(characteristics.actionPoints);
                                this.setPM(characteristics.movementPoints);
                                this.setPdv(characteristics.lifePoints, characteristics.maxLifePoints);
                                this.setShield(characteristics.shieldPoints);
                            };
                            break;
                        case FightEventEnum.FIGHTER_CASTED_SPELL:
                            break;
                    };
                }
                else
                {
                    this.sysApi.log(2, (("Le combattant " + targetId) + " n'existe pas."));
                };
                i++;
            };
        }

        public function onMapFightCount(fightCount:uint):void
        {
            this._nFightCount = fightCount;
            this.btn_viewFights.softDisabled = (this._nFightCount == 0);
        }

        public function onCancelCastSpell(spellWrapper:Object):void
        {
            this.uiApi.setFollowCursorUri(null);
        }

        public function onCastSpellMode(spellWrapper:Object):void
        {
            this.uiApi.setFollowCursorUri(spellWrapper.iconUri, false, false, 15, 15, 0.75);
        }

        public function onMapElementRollOver(map:Object, target:Object):void
        {
            var legend:String = this._hintLegends[("miniMap_" + target.id)];
            if (((!(legend)) && (target.legend)))
            {
                legend = target.legend;
            };
            if (!(legend))
            {
                return;
            };
            var txt:Object = this.uiApi.textTooltipInfo(legend);
            this.uiApi.showTooltip(txt, this.miniMap, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
        }

        public function onMapElementRollOut(map:Object, target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onMapElementRightClick(map:Object, target:Object):void
        {
            var contextMenu:Object;
            contextMenu = this.menuApi.create(target, "mapFlag", [this._currentWorldId]);
            if (contextMenu.content.length > 0)
            {
                this.modContextMenu.createContextMenu(contextMenu);
            };
        }

        public function unload():void
        {
            this._delayUseObjectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayUseObjectTimer);
            this._delayUseObjectTimer.stop();
            this._ticker.removeEventListener(TimerEvent.TIMER, this.updateClock);
            this._ticker.stop();
            this.uiApi.setFollowCursorUri(null);
            this.sysApi.removeEventListener(this.onEnterFrame);
            this.sysApi.removeEventListener(this.onWaitingSwfLoaded);
        }

        public function onEnterFrame():void
        {
            if (this._turnDuration == 0)
            {
                this.sysApi.removeEventListener(this.onEnterFrame);
                return;
            };
            var clock:uint = getTimer();
            var percentTime:Number = ((((clock - this._clockStart) + this._turnElapsedTime) / this._turnDuration) * 100);
            var remainedTime:Number = ((this._turnDuration - ((clock - this._clockStart) + this._turnElapsedTime)) / 1000);
            this.setTimeFromPercent(percentTime);
            if (remainedTime < 5)
            {
                if (this.ctr_locket.visible)
                {
                    this.ctr_locket.visible = false;
                };
                this.lbl_time.text = (Math.floor(remainedTime) + 1).toString();
            }
            else
            {
                if (this.lbl_time.text != "")
                {
                    this.ctr_locket.visible = true;
                    this.lbl_time.text = "";
                };
            };
            if (percentTime >= 100)
            {
                this.sysApi.removeEventListener(this.onEnterFrame);
            };
        }

        public function onWaitingSwfLoaded():void
        {
            if ((((this.tx_timeFrame.totalFrames > 1)) && ((this.tx_pdvFrame.totalFrames > 1))))
            {
                this._clockStart = getTimer();
                this.sysApi.removeEventListener(this.onWaitingSwfLoaded);
                this.setPdv(this.playerApi.characteristics().lifePoints, this.playerApi.characteristics().maxLifePoints);
                this.setPA(this.playerApi.characteristics().actionPointsCurrent);
                this.setPM(this.playerApi.characteristics().movementPointsCurrent);
                this.headDisplay();
            };
        }

        private function onShowCell():void
        {
            this.btn_pointCell.selected = false;
            this._bCellPointed = false;
        }

        private function onOptionLockFight(state:Boolean):void
        {
            this.btn_lock.selected = state;
        }

        private function onOptionLockParty(state:Boolean):void
        {
            this.btn_lockparty.selected = state;
        }

        private function onOptionHelpWanted(state:Boolean):void
        {
            this.btn_help.selected = state;
        }

        private function onOptionWitnessForbidden(state:Boolean):void
        {
            this.btn_witness.selected = state;
        }

        private function onSpellTooltipDisplayOption(field:String):void
        {
            var spellTS:SpellTooltipSettings = this.getSpellTooltipSettings();
            spellTS[field] = !(spellTS[field]);
            this.setSpellTooltipSettings(spellTS);
            this.tooltipApi.resetSpellTooltipCache();
        }

        private function onItemTooltipDisplayOption(field:String):void
        {
            var itemTooltipSettings:ItemTooltipSettings = this.getItemTooltipSettings();
            itemTooltipSettings[field] = !(itemTooltipSettings[field]);
            var val:Boolean = this.setItemTooltipSettings(itemTooltipSettings);
        }

        private function onPhoenixUpdate():void
        {
            var flagId:*;
            var phoenixesMaps:Object;
            var mapId:int;
            var gfxPath:String;
            for (flagId in this._flags)
            {
                if (flagId.indexOf("Phoenix") != -1)
                {
                    this.miniMap.removeMapElement(this._flags[flagId]);
                    delete this._flags[flagId];
                };
            };
            if (((!(this.playerApi.isAlive())) && (this.playerApi.currentMap())))
            {
                phoenixesMaps = this.mapApi.getPhoenixsMaps();
                gfxPath = this.sysApi.getConfigEntry("config.gfx.path");
                for each (mapId in phoenixesMaps)
                {
                    flagId = ("Phoenix_" + mapId);
                    this._flags[("flag_" + flagId)] = this.miniMap.addIcon("layer_8", flagId, (gfxPath + "icons/assets.swf|point0"), this.mapApi.getMapPositionById(mapId).posX, this.mapApi.getMapPositionById(mapId).posY, this._mapIconScale, this.uiApi.getText("ui.common.phoenix"), true, 14759203);
                };
            };
            this.miniMap.updateMapElements();
        }

        private function onDropStart(src:Object):void
        {
            this._isDragging = true;
            this._interactionWasEnabled = this.sysApi.hasWorldInteraction();
            if (src.getUi() == this.uiApi.me())
            {
                this.sysApi.disableWorldInteraction();
            };
        }

        private function onDropEnd(src:Object):void
        {
            this._isDragging = false;
            if ((((((src.getUi() == this.uiApi.me())) && (!(this.uiApi.getUi(UIEnum.GRIMOIRE))))) && (this._interactionWasEnabled)))
            {
                this.sysApi.enableWorldInteraction();
            };
        }

        public function onPress(target:Object):void
        {
            switch (target)
            {
                case this.gd_spellitemotes:
                    this.uiApi.hideTooltip();
                    break;
                case this.btn_showMonstersInfo:
                    if (!(this._monstersInfoVisible))
                    {
                        this.sysApi.sendAction(new ShowMonstersInfo(false));
                    };
                    break;
            };
        }

        public function onMouseUp(target:Object):void
        {
            switch (target)
            {
                case this.btn_showMonstersInfo:
                    if (this._monstersInfoVisible)
                    {
                        this.sysApi.sendAction(new ShowMonstersInfo(false));
                    };
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:Object;
            var item:Object;
            var selectedBtn:ButtonWrapper;
            switch (target)
            {
                case this.gd_spellitemotes:
                    switch (this._sTabGrid)
                    {
                        case SPELLS_TAB:
                            _local_4 = target.selectedItem;
                            if (_local_4)
                            {
                                if (selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
                                {
                                    this.sysApi.dispatchHook(OpenSpellInterface, _local_4.id);
                                }
                                else
                                {
                                    if (target.selectedItem.active)
                                    {
                                        this.sysApi.sendAction(new GameFightSpellCast(_local_4.id));
                                    };
                                };
                            }
                            else
                            {
                                if (this.sysApi.isFightContext())
                                {
                                    this.sysApi.sendAction(new BannerEmptySlotClick());
                                };
                            };
                            break;
                        case ITEMS_TAB:
                            if (((!(target.selectedItem)) || (!(target.selectedItem.active)))) break;
                            if ((((((target.selectedItem.type == 1)) || ((target.selectedItem.type == 3)))) || ((target.selectedItem.type == 4))))
                            {
                                if ((((selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)) || ((selectMethod == GridItemSelectMethodEnum.MANUAL))))
                                {
                                    this.useItem(target.selectedItem.id, target.selectedItem.type);
                                };
                            }
                            else
                            {
                                item = this.inventoryApi.getItem(target.selectedItem.id);
                                if (!(item)) break;
                                if ((((selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)) && (item.usable)))
                                {
                                    this.useItem(target.selectedItem.id);
                                }
                                else
                                {
                                    if (selectMethod == GridItemSelectMethodEnum.CLICK)
                                    {
                                        if (((item.targetable) && (!(this.uiApi.keyIsDown(16)))))
                                        {
                                            this.onItemUseOnCell(target.selectedItem.id);
                                        };
                                        this.sysApi.dispatchHook(ObjectSelected, {"data":item});
                                    }
                                    else
                                    {
                                        if (selectMethod == GridItemSelectMethodEnum.MANUAL)
                                        {
                                            if (item.targetable)
                                            {
                                                this.onItemUseOnCell(target.selectedItem.id);
                                            }
                                            else
                                            {
                                                if (item.usable)
                                                {
                                                    this.useItem(target.selectedItem.id);
                                                };
                                            };
                                        };
                                    };
                                };
                                if ((((item.category == 0)) && ((((selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)) || ((selectMethod == GridItemSelectMethodEnum.MANUAL))))))
                                {
                                    this.equipItem(item);
                                };
                            };
                            break;
                    };
                    break;
                case this.gd_additionalBtns:
                case this.gd_btnUis:
                    if (selectMethod != SelectMethodEnum.AUTO)
                    {
                        selectedBtn = (target.selectedItem as ButtonWrapper);
                        if (selectedBtn)
                        {
                            selectedBtn.callback.call();
                        };
                    };
                    break;
            };
        }

        private function addContextMenu():void
        {
            var job:Object;
            var gaugeMenu:Array;
            var current:Boolean;
            var disabled:Boolean;
            var typeSelected:Boolean;
            var hintCat:HintCategory;
            var gaugeNames:Array = new Array(this.uiApi.getText("ui.banner.xpCharacter"), this.uiApi.getText("ui.banner.xpGuild"), this.uiApi.getText("ui.banner.xpMount"), this.uiApi.getText("ui.banner.xpIncarnation"), this.uiApi.getText("ui.pvp.honourPoints"), this.uiApi.getText("ui.common.weight"));
            var jobs:Object = this.jobsApi.getKnownJobs();
            for each (job in jobs)
            {
                gaugeNames.push(((this.uiApi.getText("ui.common.xp") + " ") + job.name));
            };
            gaugeMenu = new Array();
            if (this._roundGaugeType > (gaugeNames.length - 1))
            {
                this._roundGaugeType = 0;
            };
            var i:int;
            while (i < gaugeNames.length)
            {
                if (this._roundGaugeType == i)
                {
                    current = true;
                }
                else
                {
                    current = false;
                };
                if ((((((((((i == GUILD_GAUGE)) && (!(this.socialApi.hasGuild())))) || ((((i == MOUNT_GAUGE)) && ((this.playerApi.getMount() == null)))))) || ((((i == INCARNATION_GAUGE)) && (!(this.playerApi.isIncarnation())))))) || ((((i == HONOUR_GAUGE)) && ((this.playerApi.characteristics().alignmentInfos.alignmentSide == 0))))))
                {
                    disabled = true;
                }
                else
                {
                    disabled = false;
                };
                gaugeMenu.push(this.modContextMenu.createContextMenuItemObject(gaugeNames[i], this.onChangeXpGauge, [i], disabled, null, current, true));
                i++;
            };
            var portraitMenu:Array = new Array();
            portraitMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.illustration"), this.switchLocketContent, [LOCKET_ARTWORK], false, null, (this._locketMode == LOCKET_ARTWORK), true));
            portraitMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.character"), this.switchLocketContent, [LOCKET_SPRITE], false, null, (this._locketMode == LOCKET_SPRITE), true));
            var mapMenu:Array = new Array();
            mapMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.map.mapFilters")));
            var h:int = 1;
            while (h < this._hintTypesList.length)
            {
                hintCat = this.dataApi.getHintCategory(h);
                typeSelected = this._hintTypesList[h];
                if (hintCat)
                {
                    mapMenu.push(this.modContextMenu.createContextMenuItemObject(hintCat.name, this.onSwitchAndSaveMapHintFilter, [h], false, null, typeSelected, false));
                };
                h++;
            };
            mapMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.cartography.flags")));
            var shortcutKey:String = this.bindsApi.getShortcutBindStr("flagCurrentMap");
            if (!(_shortcutColor))
            {
                _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                _shortcutColor = _shortcutColor.replace("0x", "#");
            };
            var flagMyMapText:String = (((((this.uiApi.getText("ui.map.flagMyMap") + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>");
            mapMenu.push(this.modContextMenu.createContextMenuItemObject(flagMyMapText, this.flagCurrentMap, []));
            mapMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.map.removeAllFlags"), this.removeAllFlags, []));
            var menu:Object = this.menuApi.create(this.playerApi.getPlayedCharacterInfo().name);
            menu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.banner.customGauge"), null, null, false, gaugeMenu));
            menu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.map.options"), null, null, false, mapMenu));
            menu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.gameuicore.minimap"), this.switchLocketContent, [LOCKET_MINIMAP]));
            menu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.gameuicore.clock"), this.switchLocketContent, [LOCKET_CLOCK]));
            menu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.gameuicore.portrait"), null, null, false, portraitMenu));
            this.modContextMenu.createContextMenu(menu);
        }

        private function onChangeXpGauge(param:uint):void
        {
            var _local_7:Object;
            var _local_8:Object;
            var _local_9:EffectInstanceDate;
            var _local_10:int;
            var _local_11:IncarnationLevel;
            var _local_12:IncarnationLevel;
            var _local_13:Array;
            var _local_14:Object;
            var effect:EffectInstance;
            var j:Object;
            var value:Number = 0;
            var floor:Number = 0;
            var nextFloor:Number = 0;
            var level:int;
            var charac:Object = this.playerApi.characteristics();
            switch (param)
            {
                case XP_GAUGE:
                    if (!(charac))
                    {
                        return;
                    };
                    value = charac.experience;
                    floor = charac.experienceLevelFloor;
                    nextFloor = charac.experienceNextLevelFloor;
                    level = this.playerApi.getPlayedCharacterInfo().level;
                    break;
                case GUILD_GAUGE:
                    _local_7 = this.socialApi.getGuild();
                    if (!(_local_7))
                    {
                        return;
                    };
                    value = _local_7.experience;
                    floor = _local_7.expLevelFloor;
                    nextFloor = _local_7.expNextLevelFloor;
                    level = _local_7.level;
                    break;
                case MOUNT_GAUGE:
                    _local_8 = this.playerApi.getMount();
                    if (!(_local_8))
                    {
                        return;
                    };
                    value = _local_8.experience;
                    floor = _local_8.experienceForLevel;
                    nextFloor = _local_8.experienceForNextLevel;
                    level = _local_8.level;
                    break;
                case INCARNATION_GAUGE:
                    _local_10 = 1;
                    if (!(this.playerApi.getWeapon()))
                    {
                        return;
                    };
                    for each (effect in this.playerApi.getWeapon().effects)
                    {
                        if (effect.effectId == 669)
                        {
                            _local_9 = (effect as EffectInstanceDate);
                        };
                    };
                    value = int(_local_9.parameter3);
                    do 
                    {
                        _local_11 = this.dataApi.getIncarnationLevel(int(_local_9.parameter0), _local_10);
                        if (_local_11)
                        {
                            floor = _local_11.requiredXp;
                        };
                        _local_10++;
                        _local_12 = this.dataApi.getIncarnationLevel(int(_local_9.parameter0), _local_10);
                        if (_local_12)
                        {
                            nextFloor = _local_12.requiredXp;
                        };
                    } while ((((nextFloor < value)) && (_local_12)));
                    this._roundRemainingValue = 1;
                    if (!(_local_12))
                    {
                        if (value >= nextFloor)
                        {
                            this._roundRemainingValue = 0;
                        };
                        nextFloor = value;
                    };
                    level = (_local_10 - 1);
                    break;
                case HONOUR_GAUGE:
                    if (!(charac))
                    {
                        return;
                    };
                    value = charac.alignmentInfos.honor;
                    floor = charac.alignmentInfos.honorGradeFloor;
                    nextFloor = charac.alignmentInfos.honorNextGradeFloor;
                    level = charac.alignmentInfos.alignmentGrade;
                    break;
                case POD_GAUGE:
                    value = this.playerApi.inventoryWeight();
                    floor = 0;
                    nextFloor = this.playerApi.inventoryWeightMax();
                    break;
                case JOB_GAUGE:
                default:
                    _local_13 = new Array();
                    for each (j in this.jobsApi.getKnownJobs())
                    {
                        _local_13.push(j);
                    };
                    if (_local_13.length == 0)
                    {
                        return;
                    };
                    _local_14 = this.jobsApi.getJobExperience(_local_13[(param - JOB_GAUGE)]);
                    if (!(_local_14))
                    {
                        return;
                    };
                    if (_local_14.currentLevel == 100)
                    {
                        value = 1;
                        floor = 0;
                        nextFloor = 1;
                    }
                    else
                    {
                        value = _local_14.currentExperience;
                        floor = _local_14.levelExperienceFloor;
                        nextFloor = _local_14.levelExperienceCeil;
                    };
                    level = _local_14.currentLevel;
            };
            this._roundGaugeType = param;
            if (this._roundGaugeType != GUILD_GAUGE)
            {
                this._lookingForMyGuildPlz = false;
            };
            this.sysApi.setData(("roundGaugeMode_" + this.playerApi.id()), this._roundGaugeType);
            this.setXp(value, floor, nextFloor, level);
        }

        private function flagCurrentMap():void
        {
            var p:MapPosition = this.dataApi.getMapInfo(this.playerApi.currentMap().mapId);
            var flagId:String = ((("flag_custom_" + p.posX) + "_") + p.posY);
            this.sysApi.dispatchHook(AddMapFlag, flagId, (((((this.uiApi.getText("ui.cartography.customFlag") + " (") + p.posX) + ",") + p.posY) + ")"), p.worldMap, p.posX, p.posY, 0xFFDD00, true);
        }

        private function removeAllFlags():void
        {
            this.sysApi.dispatchHook(RemoveAllFlags);
        }

        private function switchLocketContent(type:int, force:Boolean=false):void
        {
            var playerId:int;
            var look:Object;
            var oldLocketMode:int = this._locketMode;
            this._locketMode = type;
            this._locketInitialized = true;
            this.sysApi.setData("locketMode", type);
            if ((((type == LOCKET_ARTWORK)) || ((type == LOCKET_SPRITE))))
            {
                this.sysApi.sendAction(new PrismsListRegister("Banner", PrismListenEnum.PRISM_LISTEN_NONE));
                if (((!((oldLocketMode == this._locketMode))) || (force)))
                {
                    if (this.getPlayerId() != this.playerApi.id())
                    {
                        playerId = this.getPlayerId();
                        look = this.utilApi.getLookFromContext(playerId);
                        if (this._locketMode == LOCKET_ARTWORK)
                        {
                            this.showMonsterArtwork(look.getBone());
                        }
                        else
                        {
                            if (this._locketMode == LOCKET_SPRITE)
                            {
                                this.showSpritePortrait(look, this.utilApi.isCreature(playerId), this.utilApi.isIncarnation(playerId));
                            };
                        };
                    }
                    else
                    {
                        this.headDisplay();
                    };
                };
                this.tx_centerLight.visible = true;
                this.ctr_artwork.visible = true;
                this.miniMap.visible = false;
                this.ctr_clock.visible = false;
                this._ticker.removeEventListener(TimerEvent.TIMER, this.updateClock);
                this._ticker.stop();
            }
            else
            {
                if (type == LOCKET_MINIMAP)
                {
                    this.tx_centerLight.visible = false;
                    this.ctr_artwork.visible = false;
                    this.miniMap.visible = true;
                    this.ctr_clock.visible = false;
                    this._lastWorldMapInfo = null;
                    this.updateMinimap(this.playerApi.currentMap());
                    this.sysApi.sendAction(new PrismsListRegister("Banner", PrismListenEnum.PRISM_LISTEN_ALL));
                    this._ticker.removeEventListener(TimerEvent.TIMER, this.updateClock);
                    this._ticker.stop();
                }
                else
                {
                    if (type == LOCKET_CLOCK)
                    {
                        this.sysApi.sendAction(new PrismsListRegister("Banner", PrismListenEnum.PRISM_LISTEN_NONE));
                        this.tx_centerLight.visible = false;
                        this.ctr_artwork.visible = false;
                        this.miniMap.visible = false;
                        this.ctr_clock.visible = true;
                        this.updateClock(null);
                        this._ticker = new Timer(60000);
                        this._ticker.addEventListener(TimerEvent.TIMER, this.updateClock);
                        this._ticker.start();
                    };
                };
            };
        }

        private function onCurrentMap(pMapId:uint):void
        {
            var subArea:SubArea = this.mapApi.getMapPositionById(pMapId).subArea;
            var worldmapId:int = ((subArea.worldmap) ? subArea.worldmap.id : 1);
            if (worldmapId == this._currentWorldId)
            {
                this.onPhoenixUpdate();
            };
            this._currentWorldId = worldmapId;
        }

        private function updateMinimap(map:Object):void
        {
            var worldmap:Object;
            var hintCatId:Object;
            var folder:String;
            var zoom:String;
            var layers:Array;
            var l:String;
            var gfxPath:String;
            var hint:Object;
            var nbHintCategories:int;
            var h:int;
            var flagList:*;
            var flag:Object;
            var ts:Number;
            var ts2:Number;
            var prismIconInfo:Object;
            var cat:int;
            var catVisible:Boolean;
            var subArea:Object = this.playerApi.currentSubArea();
            if (subArea)
            {
                worldmap = subArea.worldmap;
            };
            if (!(worldmap))
            {
                return;
            };
            this._currentSuperAreaId = subArea.area.superAreaId;
            this._currentWorldId = worldmap.id;
            if (this._lastWorldMapInfo != worldmap)
            {
                this.miniMap.origineX = worldmap.origineX;
                this.miniMap.origineY = worldmap.origineY;
                this.miniMap.mapWidth = worldmap.mapWidth;
                this.miniMap.mapHeight = worldmap.mapHeight;
                this.miniMap.minScale = worldmap.minScale;
                this.miniMap.maxScale = worldmap.maxScale;
                this.miniMap.startScale = worldmap.startScale;
                this.miniMap.autoSizeIcon = (((this._currentWorldId == WORLD_OF_INCARNAM)) ? true : false);
                folder = ((this.uiApi.me().getConstant("maps_uri") + worldmap.id) + "/");
                this.miniMap.removeAllMap();
                for each (zoom in worldmap.zoom)
                {
                    this.miniMap.addMap(parseFloat(zoom), ((folder + zoom) + "/"), worldmap.totalWidth, worldmap.totalHeight, 250, 250);
                };
                this.miniMap.finalize();
                layers = new Array();
                gfxPath = this.sysApi.getConfigEntry("config.gfx.path");
                this.miniMap.addLayer("myPosition");
                for each (hint in this._hintsList)
                {
                    ts = getTimer();
                    if (hint.worldMapId == subArea.worldmap.id)
                    {
                        l = ("layer_" + hint.category);
                        if (!(layers[l]))
                        {
                            layers[l] = true;
                            this.miniMap.addLayer(l);
                        };
                        ts2 = getTimer();
                        this.miniMap.addIcon(l, ("hint_" + hint.id), ((gfxPath + "icons/assets.swf|icon_") + hint.gfx), hint.x, hint.y, this._mapIconScale);
                    };
                };
                nbHintCategories = this.dataApi.getHintCategories().length;
                h = 1;
                while (h <= nbHintCategories)
                {
                    if (!(layers[h]))
                    {
                        layers[h] = true;
                        this.miniMap.addLayer(("layer_" + h));
                    };
                    h++;
                };
                flagList = this.modCartography.getFlags(this._currentWorldId);
                for each (flag in flagList)
                {
                    this._flags[((this._currentWorldId + "_") + flag.id)] = this.miniMap.addIcon("layer_8", flag.id, (gfxPath + "icons/assets.swf|point0"), flag.position.x, flag.position.y, this._mapIconScale, flag.legend, true, flag.color, true, flag.canBeManuallyRemoved);
                };
                if (this._prismsToAdd.length > 0)
                {
                    while (this._prismsToAdd.length > 0)
                    {
                        prismIconInfo = this._prismsToAdd.shift();
                        if (!(this.miniMap.getMapElement(prismIconInfo.prismId)))
                        {
                            this.miniMap.addIcon("layer_5", prismIconInfo.prismId, prismIconInfo.icon, prismIconInfo.prismX, prismIconInfo.prismY, this._mapIconScale);
                        };
                    };
                };
            };
            this.miniMap.moveTo(map.outdoorX, map.outdoorY);
            this._hintLegends["center"] = (((((map.outdoorX + ",") + map.outdoorY) + " (") + this.uiApi.getText("ui.cartography.yourposition")) + ")");
            if (this._flags["center"])
            {
                this.miniMap.removeMapElement(this._flags["center"]);
            };
            var centerIcon:Object = this.miniMap.addIcon("myPosition", "center", (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|myPosition2"), map.outdoorX, map.outdoorY, 1, this._hintLegends["center"], true, -1, false);
            if (centerIcon)
            {
                this._flags["center"] = centerIcon;
                if (this.miniMap.autoSizeIcon)
                {
                    centerIcon.texture.scaleX = (centerIcon.texture.scaleY = 1);
                    this.miniMap.getMapElement("center").canBeAutoSize = false;
                };
                centerIcon.texture.width = ((worldmap) ? worldmap.mapWidth : 69);
                centerIcon.texture.height = ((worldmap) ? worldmap.mapHeight : 50);
            };
            for (hintCatId in this._hintTypesList)
            {
                cat = int(hintCatId);
                catVisible = this._hintTypesList[cat];
                if (cat == 7)
                {
                    catVisible = ((this.isDungeonMap()) ? false : true);
                };
                this.miniMap.showLayer(("layer_" + hintCatId), catVisible);
            };
            this.miniMap.updateMapElements();
            if (((!(this._lastWorldMapInfo)) || (!((this._lastWorldMapInfo.id == worldmap.id)))))
            {
                this._lastWorldMapInfo = worldmap;
                this.miniMap.finalized = true;
            };
            this.onHouseInformations(this.playerApi.getPlayerHouses());
            this.getMapGuildInformations();
        }

        private function getMapGuildInformations():void
        {
            if (this.socialApi.hasGuild())
            {
                this._waitingForSocialUpdate++;
                this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_GUILD_ONLY));
                if (((this.socialApi.guildHousesUpdateNeeded()) && (((!(this.socialApi.getGuildHouses())) || ((this.socialApi.getGuildHouses().length == 0))))))
                {
                    this._waitingForSocialUpdate++;
                    this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_HOUSES));
                }
                else
                {
                    this.onGuildHousesUpdate();
                };
                if (((!(this.socialApi.getGuildPaddocks())) || ((this.socialApi.getGuildPaddocks().length == 0))))
                {
                    this._waitingForSocialUpdate++;
                    this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_PADDOCKS));
                }
                else
                {
                    this.onGuildInformationsFarms();
                };
            };
        }

        private function updateClock(te:TimerEvent):void
        {
            var currentTime:Object = this.timeApi.getClockNumbers();
            this.tx_minuteHand.rotation = (currentTime[0] * 6);
            this.tx_hourHand.rotation = ((currentTime[1] * 30) + (currentTime[0] * 0.5));
        }

        public function onDoubleClick(target:Object):void
        {
            if (target == this.miniMap)
            {
                if (this.sysApi.hasRight())
                {
                    this.mapApi.movePlayer(this.miniMap.currentMouseMapX, this.miniMap.currentMouseMapY);
                };
            };
        }

        public function onRelease(target:Object):void
        {
            var _local_2:int;
            var slot:Object;
            var slot2:Object;
            var server:Object;
            var giveUp:String;
            switch (target)
            {
                case this.btn_emptyMap:
                    this.sysApi.sendAction(new ShowTacticMode());
                    break;
                case this.btn_moreBtn:
                    if (this.ctr_moreBtn.visible)
                    {
                        this.ctr_moreBtn.visible = false;
                        for each (slot in this.gd_btnUis.slots)
                        {
                            slot.allowDrag = false;
                        };
                    }
                    else
                    {
                        this.ctr_moreBtn.visible = true;
                        for each (slot2 in this.gd_btnUis.slots)
                        {
                            slot2.allowDrag = true;
                        };
                    };
                    break;
                case this.btn_tabItems:
                    this.gridDisplay(ITEMS_TAB);
                    break;
                case this.btn_tabSpells:
                    this.gridDisplay(SPELLS_TAB);
                    break;
                case this.tx_pdvFrame:
                    _local_2 = (this._lifepointMode + 1);
                    this.changeLifepointDisplay(_local_2);
                    break;
                case this.btn_skipTurn:
                    this.sysApi.sendAction(new GameFightTurnFinish());
                    break;
                case this.btn_ready:
                    if (this._bIsReady)
                    {
                        this._bIsReady = false;
                        this.sysApi.sendAction(new GameFightReady(false));
                        this.btn_ready.selected = false;
                    }
                    else
                    {
                        this._bIsReady = true;
                        this.sysApi.sendAction(new GameFightReady(true));
                        this.btn_ready.selected = true;
                    };
                    break;
                case this.btn_leave:
                    if (!(this._bIsSpectator))
                    {
                        server = this.sysApi.getCurrentServer();
                        if ((((((server.gameTypeId == 1)) && (!((this.fightApi.getFightType() == FightTypeEnum.FIGHT_TYPE_CHALLENGE))))) || ((((server.gameTypeId == 4)) && ((((this.fightApi.getFightType() == FightTypeEnum.FIGHT_TYPE_MXvM)) || ((this.fightApi.getFightType() == FightTypeEnum.FIGHT_TYPE_PvM))))))))
                        {
                            giveUp = this.uiApi.getText("ui.popup.hardcoreGiveup");
                        }
                        else
                        {
                            giveUp = this.uiApi.getText("ui.popup.giveup");
                        };
                        if (this.fightApi.getFightType() == FightTypeEnum.FIGHT_TYPE_PVP_ARENA)
                        {
                            giveUp = (giveUp + ("\n" + this.uiApi.getText("ui.party.arenaLeaveWarning")));
                        };
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), giveUp, [this.uiApi.getText("ui.common.ok"), this.uiApi.getText("ui.common.cancel")], [this.onPopupLeaveFight, this.onPopupClose], this.onPopupLeaveFight, this.onPopupClose);
                    }
                    else
                    {
                        this.sysApi.sendAction(new GameContextQuit());
                    };
                    break;
                case this.btn_viewFights:
                    if (!(this.uiApi.getUi(UIEnum.SPECTATOR_UI)))
                    {
                        if (this._nFightCount > 0)
                        {
                            this.sysApi.sendAction(new OpenCurrentFight());
                        };
                    }
                    else
                    {
                        this.uiApi.unloadUi(UIEnum.SPECTATOR_UI);
                    };
                    break;
                case this.btn_pointCell:
                    if (!(this._bCellPointed))
                    {
                        this.btn_pointCell.selected = true;
                        this._bCellPointed = true;
                    };
                    this.sysApi.sendAction(new TogglePointCell());
                    break;
                case this.btn_witness:
                    this.toggleWitnessForbiden();
                    break;
                case this.btn_invimode:
                    this._pokemonModeActivated = !(this._pokemonModeActivated);
                    this.configApi.setConfigProperty("dofus", "creaturesFightMode", this._pokemonModeActivated);
                    this.sysApi.sendAction(new ToggleDematerialization());
                    break;
                case this.btn_help:
                    this.sysApi.sendAction(new ToggleHelpWanted());
                    break;
                case this.btn_lock:
                    this.sysApi.sendAction(new ToggleLockFight());
                    break;
                case this.btn_lockparty:
                    this.sysApi.sendAction(new ToggleLockParty());
                    break;
                case this.btn_upArrow:
                    this.pageItemUp();
                    break;
                case this.btn_downArrow:
                    this.pageItemDown();
                    break;
                case this.btn_showMapInfo:
                    this.configApi.setConfigProperty("dofus", "mapCoordinates", !(Api.system.getOption("mapCoordinates", "dofus")));
                    break;
                case this.btn_showPlayersNames:
                    this.sysApi.sendAction(new ShowAllNames());
                    break;
                default:
                    switch (this._sTabGrid)
                    {
                        case ITEMS_TAB:
                            break;
                        case SPELLS_TAB:
                            break;
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var textKey:String;
            var data:Object;
            var point:uint = 7;
            var relPoint:uint = 1;
            var shortcutKey:String;
            switch (target)
            {
                case this.tx_paBackground:
                    tooltipText = this.uiApi.getText("ui.stats.actionPoints");
                    break;
                case this.tx_pmBackground:
                    tooltipText = this.uiApi.getText("ui.stats.movementPoints");
                    break;
                case this.btn_viewFights:
                    tooltipText = this.uiApi.getText("ui.fightsOnMap", this._nFightCount);
                    tooltipText = this.uiApi.processText(tooltipText, "m", (this._nFightCount < 2));
                    break;
                case this.btn_ready:
                    tooltipText = this.uiApi.getText("ui.fight.ready");
                    shortcutKey = this.bindsApi.getShortcutBindStr("skipTurn");
                    break;
                case this.btn_skipTurn:
                    tooltipText = this.uiApi.getText("ui.fight.option.nextTurn");
                    shortcutKey = this.bindsApi.getShortcutBindStr("skipTurn");
                    break;
                case this.btn_leave:
                    if (!(this._bIsSpectator))
                    {
                        tooltipText = this.uiApi.getText("ui.fight.option.giveUp");
                    }
                    else
                    {
                        tooltipText = this.uiApi.getText("ui.fight.option.giveupSpectator");
                    };
                    break;
                case this.btn_pointCell:
                    tooltipText = this.uiApi.getText("ui.fight.option.flagHelp");
                    shortcutKey = this.bindsApi.getShortcutBindStr("showCell");
                    break;
                case this.btn_lockparty:
                    tooltipText = this.uiApi.getText("ui.fight.option.blockJoinerExceptParty");
                    break;
                case this.btn_witness:
                    tooltipText = this.uiApi.getText("ui.fight.option.spectator");
                    break;
                case this.btn_invimode:
                    tooltipText = this.uiApi.getText("ui.fight.option.invisible");
                    shortcutKey = this.bindsApi.getShortcutBindStr(ShortcutHookListEnum.TOGGLE_DEMATERIALIZATION);
                    break;
                case this.btn_help:
                    tooltipText = this.uiApi.getText("ui.fight.option.help");
                    break;
                case this.btn_emptyMap:
                    tooltipText = this.uiApi.getText("ui.fight.option.tacticMod");
                    break;
                case this.btn_lock:
                    tooltipText = this.uiApi.getText("ui.fight.option.blockJoiner");
                    break;
                case this.btn_tabSpells:
                    tooltipText = this.uiApi.getText("ui.charcrea.spells");
                    shortcutKey = this.bindsApi.getShortcutBindStr("bannerSpellsTab");
                    break;
                case this.btn_tabItems:
                    tooltipText = this.uiApi.getText("ui.common.objects");
                    shortcutKey = this.bindsApi.getShortcutBindStr("bannerItemsTab");
                    break;
                case this.btn_upArrow:
                    tooltipText = this.uiApi.getText("ui.common.prevPage");
                    shortcutKey = this.bindsApi.getShortcutBindStr("pageItemUp");
                    break;
                case this.btn_downArrow:
                    point = 1;
                    relPoint = 7;
                    tooltipText = this.uiApi.getText("ui.common.nextPage");
                    shortcutKey = this.bindsApi.getShortcutBindStr("pageItemDown");
                    break;
                case this.btn_moreBtn:
                    this._bOverMoreButtons = true;
                    tooltipText = this.uiApi.getText("ui.common.moreButtons");
                    break;
                case this.tx_pdvFrame:
                    tooltipText = this.uiApi.getText("ui.common.lifePoints");
                    break;
                case this.tx_xpFrame:
                    if (this._roundPercent < 0)
                    {
                        this._roundPercent = 0;
                    };
                    if (this._roundPercent > 100)
                    {
                        this._roundPercent = 100;
                    };
                    tooltipText = "";
                    if (((!((this._roundGaugeType == POD_GAUGE))) && ((this._roundLevel > 0))))
                    {
                        if (this._roundGaugeType == HONOUR_GAUGE)
                        {
                            tooltipText = (tooltipText + ((this.uiApi.getText("ui.pvp.rank") + this.uiApi.getText("ui.common.colon")) + this._roundLevel));
                        }
                        else
                        {
                            tooltipText = (tooltipText + ((this.uiApi.getText("ui.common.level") + this.uiApi.getText("ui.common.colon")) + this._roundLevel));
                        };
                    };
                    if (this._roundRemainingValue > 0)
                    {
                        if (this._roundGaugeType != POD_GAUGE)
                        {
                            if (this._roundGaugeType == HONOUR_GAUGE)
                            {
                                tooltipText = (tooltipText + (("\n" + this.uiApi.getText("ui.pvp.nextRank")) + this.uiApi.getText("ui.common.colon")));
                            }
                            else
                            {
                                tooltipText = (tooltipText + (("\n" + this.uiApi.getText("ui.common.nextLevel")) + this.uiApi.getText("ui.common.colon")));
                            };
                        };
                        tooltipText = (tooltipText + (this._roundPercent + " %"));
                        if (this._roundGaugeType != POD_GAUGE)
                        {
                            tooltipText = (tooltipText + ((("\n" + this.uiApi.getText("ui.common.required")) + this.uiApi.getText("ui.common.colon")) + this.utilApi.formateIntToString(this._roundRemainingValue)));
                        }
                        else
                        {
                            tooltipText = (tooltipText + ((("\n" + this.uiApi.getText("ui.common.remaining")) + this.uiApi.getText("ui.common.colon")) + this.utilApi.formateIntToString(this._roundRemainingValue)));
                        };
                    }
                    else
                    {
                        if (this._roundGaugeType == POD_GAUGE)
                        {
                            tooltipText = (tooltipText + (this._roundPercent + " %"));
                        };
                    };
                    break;
                case this.ctr_clock:
                    tooltipText = ((this.timeApi.getClock() + "\r") + this.timeApi.getDofusDate());
                    break;
                case this.btn_showMapInfo:
                    tooltipText = this.uiApi.getText("ui.option.mapInfo");
                    shortcutKey = this.bindsApi.getShortcutBindStr("showCoord");
                    break;
                case this.btn_showPlayersNames:
                    tooltipText = this.uiApi.getText("ui.shortcuts.displayNames");
                    shortcutKey = this.bindsApi.getShortcutBindStr("showAllNames");
                    break;
                case this.btn_showMonstersInfo:
                    textKey = "ui.option.monstersInfo.hold";
                    shortcutKey = this.bindsApi.getShortcutBindStr("showMonstersInfo");
                    break;
            };
            if (shortcutKey)
            {
                if (!(_shortcutColor))
                {
                    _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                    _shortcutColor = _shortcutColor.replace("0x", "#");
                };
                if (tooltipText)
                {
                    data = this.uiApi.textTooltipInfo((((((tooltipText + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                }
                else
                {
                    if (textKey)
                    {
                        data = this.uiApi.textTooltipInfo(this.uiApi.getText(textKey, (((("<font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>")));
                    };
                };
            }
            else
            {
                data = this.uiApi.textTooltipInfo(tooltipText);
            };
            this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this._bOverMoreButtons = false;
            this.uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var data:Object;
            var tooltipMaker:String;
            var settings:Object;
            var cacheName:String;
            var _local_11:ItemWrapper;
            var _local_12:String;
            var _local_13:ItemTooltipSettings;
            var spellWrapper:SpellWrapper;
            var text:String;
            var ref:Object = this.uiApi.getUi(UIEnum.BANNER).getElement(((this.sysApi.isFightContext()) ? "tooltipFightPlacer" : "tooltipRoleplayPlacer"));
            var cte:String = "banner::gd_spellitemotes::item";
            var nSlot:int = (int(item.container.name.substr(cte.length)) + 1);
            var shortcutKey:String = this.bindsApi.getShortcutBindStr(("s" + nSlot));
            if (!(item.data))
            {
                return;
            };
            if (!(_shortcutColor))
            {
                _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                _shortcutColor = _shortcutColor.replace("0x", "#");
            };
            if (target == this.gd_spellitemotes)
            {
                if (this._sTabGrid == ITEMS_TAB)
                {
                    cacheName = "TextInfo";
                    switch (item.data.type)
                    {
                        case 0:
                            _local_11 = this.inventoryApi.getItem(item.data.id);
                            if (!(_local_11))
                            {
                                _local_11 = this.dataApi.getItemWrapper(item.data.gid);
                            };
                            data = this.tooltipApi.getItemTooltipInfo(_local_11, shortcutKey);
                            tooltipMaker = "itemName";
                            settings = new Object();
                            _local_13 = this.getItemTooltipSettings();
                            for each (_local_12 in this.sysApi.getObjectVariables(_local_13))
                            {
                                settings[_local_12] = _local_13[_local_12];
                            };
                            settings.ref = ref;
                            cacheName = "ItemInfo";
                            break;
                        case 1:
                            data = this.uiApi.textTooltipInfo((((((this.uiApi.getText("ui.banner.preset.tooltip", (item.data.id + 1)) + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                            break;
                        case 3:
                            data = this.uiApi.textTooltipInfo((((((this.uiApi.getText("ui.banner.emote.tooltip") + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                            break;
                        case 4:
                            data = this.uiApi.textTooltipInfo((((((item.data.name + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                            tooltipMaker = "emoteName";
                            break;
                        default:
                            data = this.uiApi.textTooltipInfo((((("<font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                    };
                    this.uiApi.showTooltip(data, item.container, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 0, tooltipMaker, null, settings, cacheName);
                }
                else
                {
                    if (this._sTabGrid == SPELLS_TAB)
                    {
                        spellWrapper = this.playerApi.getSpell(item.data.id);
                        if (spellWrapper == null)
                        {
                            return;
                        };
                        data = this.tooltipApi.getSpellTooltipInfo(spellWrapper, shortcutKey);
                        this.uiApi.showTooltip(data, item.container, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 3, null, null, null, "SpellBanner");
                    };
                };
            }
            else
            {
                if ((((target == this.gd_btnUis)) || ((target == this.gd_additionalBtns))))
                {
                    text = item.data.name;
                    if (item.data.shortcut)
                    {
                        if (!(_shortcutColor))
                        {
                            _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                            _shortcutColor = _shortcutColor.replace("0x", "#");
                        };
                        text = (text + ((((" <font color='" + _shortcutColor) + "'>(") + item.data.shortcut) + ")</font>"));
                    };
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), item.container, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 0, null, null, null, "TextInfo");
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
            this.uiApi.hideTooltip("spellBanner");
        }

        public function onWheel(target:Object, delta:int):void
        {
            if (delta > 0)
            {
                this.pageItemUp();
            }
            else
            {
                this.pageItemDown();
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            var _local_5:Object;
            var _local_6:Boolean;
            var _local_7:Object;
            var _local_8:Array;
            var _local_9:String;
            var _local_10:String;
            var _local_11:String;
            var _local_12:String;
            var itemTooltipSettings:Object;
            switch (this._sTabGrid)
            {
                case ITEMS_TAB:
                    data = item.data;
                    if (data == null)
                    {
                        return;
                    };
                    _local_5 = data.realItem;
                    contextMenu = this.menuApi.create(_local_5, "item");
                    _local_6 = false;
                    if (((((contextMenu) && (contextMenu.content))) && (contextMenu.content[0])))
                    {
                        _local_6 = contextMenu.content[0].disabled;
                    };
                    if ((((((data.type == 0)) && (data.targetable))) && (!(data.nonUsableOnAnother))))
                    {
                        contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.target"), this.onItemUseOnCell, [data.id], _local_6));
                    };
                    if (((((((data.usable) || ((data.type == 1)))) || ((data.type == 3)))) || ((data.type == 4))))
                    {
                        if ((((data.category == 1)) && ((data.realItem.type.id == 157))))
                        {
                            contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.krosmaster.collection"), this.goToKrosmasterUi, null, _local_6));
                        };
                        if ((((data.quantity > 1)) && (data.isOkForMultiUse)))
                        {
                            contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.multipleUse"), this.useItemQuantity, [data.id, data.quantity], _local_6));
                        };
                        contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.use"), this.useItem, [data.id, data.type, data.slot], ((!(_local_6)) ? !(data.active) : _local_6)));
                    };
                    if ((((data.type == 0)) && ((data.category == 0))))
                    {
                        contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.equip"), this.equipItem, [_local_5], ((!(_local_6)) ? !(data.active) : _local_6)));
                    };
                    contextMenu.content.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.remove"), this.onRemoveItem, [data.slot], false));
                    if (contextMenu.content.length)
                    {
                        contextMenu.content.push(this.modContextMenu.createContextMenuSeparatorObject());
                    };
                    if (Api.system.getOption("displayTooltips", "dofus"))
                    {
                        itemTooltipSettings = this.getItemTooltipSettings();
                        contextMenu.content.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.tooltip"), null, null, false, [this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.name"), this.onItemTooltipDisplayOption, ["header"], _local_6, null, itemTooltipSettings.header, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.processText(this.uiApi.getText("ui.common.effects"), "", false), this.onItemTooltipDisplayOption, ["effects"], _local_6, null, itemTooltipSettings.effects, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.conditions"), this.onItemTooltipDisplayOption, ["conditions"], _local_6, null, itemTooltipSettings.conditions, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.description"), this.onItemTooltipDisplayOption, ["description"], _local_6, null, itemTooltipSettings.description, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.item.averageprice"), this.onItemTooltipDisplayOption, ["averagePrice"], _local_6, null, itemTooltipSettings.averagePrice, false)], _local_6));
                    };
                    if (contextMenu.content.length > 0)
                    {
                        this.modContextMenu.createContextMenu(contextMenu);
                    };
                    break;
                case SPELLS_TAB:
                    data = item.data;
                    if (data == null)
                    {
                        return;
                    };
                    _local_7 = this.getSpellTooltipSettings();
                    _local_8 = new Array();
                    _local_9 = this.uiApi.getText("ui.common.name");
                    _local_10 = this.uiApi.processText(this.uiApi.getText("ui.common.effects"), "", false);
                    _local_11 = this.uiApi.getText("ui.common.description");
                    _local_12 = this.uiApi.getText("ui.common.CC_EC");
                    _local_8.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.tooltip"), null, null, false, [this.modContextMenu.createContextMenuItemObject(_local_9, this.onSpellTooltipDisplayOption, ["header"], false, null, _local_7.header, false), this.modContextMenu.createContextMenuItemObject(_local_10, this.onSpellTooltipDisplayOption, ["effects"], false, null, _local_7.effects, false), this.modContextMenu.createContextMenuItemObject(_local_12, this.onSpellTooltipDisplayOption, ["CC_EC"], false, null, _local_7.CC_EC, false), this.modContextMenu.createContextMenuItemObject(_local_11, this.onSpellTooltipDisplayOption, ["description"], false, null, _local_7.description, false)], false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.remove"), this.onRemoveSpell, [data.slot], false));
                    this.modContextMenu.createContextMenu(_local_8);
                    break;
            };
        }

        public function onItemFeed(item:Object):void
        {
            this.sysApi.dispatchHook(OpenFeed, item);
        }

        public function onItemUseOnCell(id:uint):void
        {
            if (((!(this._delayUseObject)) && (id)))
            {
                this.sysApi.sendAction(new ObjectUse(id, 1, true));
            };
        }

        public function useItem(id:uint, type:uint=0, position:int=-1):void
        {
            if (!(this._delayUseObject))
            {
                if (type == 1)
                {
                    this.sysApi.sendAction(new InventoryPresetUse(id));
                }
                else
                {
                    if (type == 3)
                    {
                        this.sysApi.sendAction(new ChatSmileyRequest(id));
                    }
                    else
                    {
                        if (type == 4)
                        {
                            this.sysApi.sendAction(new EmotePlayRequest(id));
                        }
                        else
                        {
                            this._delayUseObjectTimer.start();
                            this.sysApi.sendAction(new ObjectUse(id, 1, false));
                        };
                    };
                };
            };
        }

        public function equipItem(item:Object):void
        {
            var freeSlot:int;
            var equipment:Object;
            var companionUID:int;
            var itemEquiped:Object;
            var uid:int = item.objectUID;
            if ((((item.position <= CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD)) || ((item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION))))
            {
                freeSlot = CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED;
            }
            else
            {
                freeSlot = this.storageApi.getBestEquipablePosition(item);
                if (item.quantity > 1)
                {
                    equipment = this.storageApi.getViewContent("equipment");
                    for each (itemEquiped in equipment)
                    {
                        if (((((itemEquiped) && ((itemEquiped.position == freeSlot)))) && ((itemEquiped.objectGID == item.objectGID))))
                        {
                            freeSlot = CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED;
                            uid = itemEquiped.objectUID;
                        };
                    };
                };
            };
            if (freeSlot > -1)
            {
                this.sysApi.sendAction(new ObjectSetPosition(uid, freeSlot, 1));
            };
        }

        public function useItemQuantity(id:uint, qtyMax:uint=1):void
        {
            if (!(this._delayUseObject))
            {
                this._itemToUseId = id;
                this.modCommon.openQuantityPopup(1, qtyMax, 1, this.onValidItemQuantityUse);
            };
        }

        public function onValidItemQuantityUse(qty:Number):void
        {
            this._delayUseObjectTimer.start();
            this.sysApi.sendAction(new ObjectUse(this._itemToUseId, qty, false));
            this._itemToUseId = 0;
        }

        public function onDelayUseObjectTimer(e:TimerEvent):void
        {
            this._delayUseObjectTimer.reset();
            this._delayUseObject = false;
        }

        public function onAddBannerButton(id:int, assetName:String, callbackFct:Function=null, tooltipText:String="", shortcutBind:String=""):void
        {
            var maxPos:int;
            var pos:int;
            if (!(this._aBtnOrderForCache[id]))
            {
                maxPos = 0;
                for each (pos in this._aBtnOrderForCache)
                {
                    if (pos > maxPos)
                    {
                        maxPos = pos;
                    };
                };
                this._aBtnOrderForCache[id] = (maxPos + 1);
            };
            this._dataProviderButtons.push(this.dataApi.getButtonWrapper(id, this._aBtnOrderForCache[id], assetName, callbackFct, tooltipText, shortcutBind));
        }

        private function onGenericMouseClick(target:Object):void
        {
            var slot:Object;
            if (((((((!((target == this.ctr_moreBtn))) && (!(this._bOverMoreButtons)))) && (!(this._isDragging)))) && (this.ctr_moreBtn.visible)))
            {
                this.ctr_moreBtn.visible = false;
                for each (slot in this.gd_btnUis.slots)
                {
                    slot.allowDrag = false;
                };
            };
        }

        public function onRightClick(target:Object):void
        {
            switch (target)
            {
                case this.ctr_artwork:
                case this.miniMap:
                case this.tx_artwork:
                case this.tx_centerLight:
                case this.ed_coloredArtwork:
                case this.ctr_clock:
                case this.tx_xpFrame:
                    if (!(this._bIsSpectator))
                    {
                        this.addContextMenu();
                    };
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            var _local_2:Boolean;
            var spellIndex:uint;
            var storageUi:Object;
            switch (s)
            {
                case "cac":
                    if (((this.sysApi.isFightContext()) && (this.playerApi.canCastThisSpell(0, 1))))
                    {
                        this.sysApi.sendAction(new GameFightSpellCast(0));
                    };
                    return (true);
                case "s1":
                case "s2":
                case "s3":
                case "s4":
                case "s5":
                case "s6":
                case "s7":
                case "s8":
                case "s9":
                case "s10":
                case "s11":
                case "s12":
                case "s13":
                case "s14":
                case "s15":
                case "s16":
                case "s17":
                case "s18":
                case "s19":
                case "s20":
                    if (!(this.inventoryApi.removeSelectedItem()))
                    {
                        spellIndex = (parseInt(s.substr(1)) - 1);
                        this.gd_spellitemotes.selectedIndex = spellIndex;
                    };
                    return (true);
                case "skipTurn":
                case this.btn_skipTurn:
                    if (this.btn_skipTurn.visible)
                    {
                        this.sysApi.sendAction(new GameFightTurnFinish());
                        return (true);
                    };
                    if (this.btn_ready.visible)
                    {
                        if (this._bIsReady)
                        {
                            this._bIsReady = false;
                            this.sysApi.sendAction(new GameFightReady(false));
                            this.btn_ready.selected = false;
                            return (true);
                        };
                        this._bIsReady = true;
                        this.sysApi.sendAction(new GameFightReady(true));
                        this.btn_ready.selected = true;
                        return (true);
                    };
                    return (false);
                case "bannerSpellsTab":
                    this.gridDisplay(SPELLS_TAB);
                    return (true);
                case "bannerItemsTab":
                    this.gridDisplay(ITEMS_TAB);
                    return (true);
                case "bannerNextTab":
                    switch (this._sTabGrid)
                    {
                        case SPELLS_TAB:
                            this.gridDisplay(ITEMS_TAB);
                            break;
                        case ITEMS_TAB:
                            this.gridDisplay(SPELLS_TAB);
                            break;
                    };
                    return (true);
                case "bannerPreviousTab":
                    switch (this._sTabGrid)
                    {
                        case SPELLS_TAB:
                            this.gridDisplay(ITEMS_TAB);
                            break;
                        case ITEMS_TAB:
                            this.gridDisplay(SPELLS_TAB);
                            break;
                    };
                    return (true);
                case "flagCurrentMap":
                    this.flagCurrentMap();
                    return (true);
                case "openCharacterSheet":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenStats());
                    };
                    return (true);
                case "openInventory":
                    if (this.shortcutTimerReady())
                    {
                        this.openInventory();
                    };
                    return (true);
                case "openBookSpell":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenBook("spellTab"));
                    };
                    return (true);
                case "openBookQuest":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenBook("questTab"));
                    };
                    return (true);
                case "openBookAlignment":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenBook("alignmentTab"));
                    };
                    return (true);
                case "openBookJob":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenBook("jobTab"));
                    };
                    return (true);
                case "openWorldMap":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenMap());
                    };
                    return (true);
                case "openSocialFriends":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenSocial("0"));
                    };
                    return (true);
                case "openSocialAlliance":
                    if (this.shortcutTimerReady())
                    {
                        if (!(this.socialApi.hasAlliance()))
                        {
                            this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.error.onlyForAlliance"), 666, this.timeApi.getTimestamp());
                        }
                        else
                        {
                            this.sysApi.sendAction(new OpenSocial("2"));
                        };
                    };
                    return (true);
                case "openAlmanax":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenBook("calendarTab"));
                    };
                    return (true);
                case "openAchievement":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenBook("achievementTab"));
                    };
                    return (true);
                case "openTitle":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenBook("titleTab"));
                    };
                    return (true);
                case "openBestiary":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenBook("bestiaryTab"));
                    };
                    return (true);
                case "openSocialGuild":
                    if (this.shortcutTimerReady())
                    {
                        if (!(this.socialApi.hasGuild()))
                        {
                            this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.error.onlyForGuild"), 666, this.timeApi.getTimestamp());
                        }
                        else
                        {
                            this.sysApi.sendAction(new OpenSocial("1"));
                        };
                    };
                    return (true);
                case "openSocialSpouse":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenSocial("3"));
                    };
                    return (true);
                case "openTeamSearch":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenTeamSearch());
                    };
                    return (true);
                case "openPvpArena":
                    if (this.shortcutTimerReady())
                    {
                        this.sysApi.sendAction(new OpenArena());
                    };
                    return (true);
                case "openSell":
                    if (this.shortcutTimerReady())
                    {
                        if (!(this.uiApi.getUi("stockMyselfVendor")))
                        {
                            Api.system.sendAction(new ExchangeRequestOnShopStock());
                        }
                        else
                        {
                            this.uiApi.unloadUi("stockMyselfVendor");
                        };
                    };
                    return (true);
                case "openMount":
                    if (this.shortcutTimerReady())
                    {
                        if (!(this.playerApi.getMount()))
                        {
                            this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.error.onlyForMount"), 666, this.timeApi.getTimestamp());
                        }
                        else
                        {
                            this.sysApi.sendAction(new OpenMount());
                        };
                    };
                    return (true);
                case "openMountStorage":
                    if (((this.shortcutTimerReady()) && (this.playerApi.getMount())))
                    {
                        if (this.playerApi.isInFight())
                        {
                            this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.error.cantDoInFight"), 666, this.timeApi.getTimestamp());
                        }
                        else
                        {
                            storageUi = this.uiApi.getUi(UIEnum.STORAGE_UI);
                            if (storageUi)
                            {
                                if (storageUi.uiClass.currentStorageBehavior.getName() == "mount")
                                {
                                    this.sysApi.sendAction(new CloseInventory());
                                }
                                else
                                {
                                    this.sysApi.sendAction(new ExchangeRequestOnMountStock());
                                };
                            }
                            else
                            {
                                this.sysApi.sendAction(new ExchangeRequestOnMountStock());
                            };
                        };
                    };
                    return (true);
                case "validUi":
                    this.sysApi.dispatchHook(ChatFocus);
                    return (true);
                case "closeUi":
                    if (!(this.inventoryApi.removeSelectedItem()))
                    {
                        if (!(this.fightApi.isCastingSpell()))
                        {
                            return (false);
                        };
                        this.unselectSpell();
                    };
                    return (true);
                case ShortcutHookListEnum.TOGGLE_RIDE:
                    if (this.playerApi.getMount())
                    {
                        this.sysApi.sendAction(new MountToggleRidingRequest());
                    };
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_1:
                    this.pageItem(0);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_2:
                    this.pageItem(1);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_3:
                    this.pageItem(2);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_4:
                    this.pageItem(3);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_5:
                    this.pageItem(4);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_DOWN:
                    this.pageItemDown();
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_UP:
                    this.pageItemUp();
                    return (true);
                case ShortcutHookListEnum.SHOW_CELL:
                    if (!(this._bCellPointed))
                    {
                        this.btn_pointCell.selected = true;
                        this._bCellPointed = true;
                    };
                    this.sysApi.sendAction(new TogglePointCell());
                    return (true);
                case ShortcutHookListEnum.TOGGLE_DEMATERIALIZATION:
                    this.sysApi.sendAction(new ToggleDematerialization());
                    return (true);
                case ShortcutHookListEnum.OPEN_WEB_BROWSER:
                    this.onWebAction();
                    return (true);
                case ShortcutHookListEnum.SHOW_ALL_NAMES:
                    this.sysApi.sendAction(new ShowAllNames());
                    return (true);
                case ShortcutHookListEnum.SHOW_MONSTERS_INFO:
                    this.sysApi.sendAction(new ShowMonstersInfo());
                    return (true);
                case ShortcutHookListEnum.SHOW_MOUNTS_IN_FIGHT:
                    _local_2 = this.sysApi.getOption("showMountsInFight", "dofus");
                    this.sysApi.sendAction(new ShowMountsInFight(!(_local_2)));
                    return (true);
            };
            return (false);
        }

        public function onOpenInventory(... args):void
        {
            if (!(this.playerApi.isInFight()))
            {
                this.gridDisplay(ITEMS_TAB);
            };
        }

        public function onShowTacticMode(state:Boolean):void
        {
            this.btn_emptyMap.selected = state;
            this._tacticModeActivated = state;
        }

        public function onOpenMainMenu():void
        {
            if (!(this.uiApi.getUi("mainMenu")))
            {
                this.uiApi.loadUi("mainMenu", null, null, 2);
            };
        }

        public function onRemindTurn():void
        {
            if (!(this.tx_show))
            {
                return;
            };
            this.tx_show.visible = true;
            this.tx_show.gotoAndPlay = 1;
            var endArrowTimer:Timer = new Timer(2000, 1);
            endArrowTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.endRemindArrow);
            endArrowTimer.start();
        }

        private function endRemindArrow(event:TimerEvent):void
        {
            if (this.tx_show)
            {
                this.tx_show.visible = false;
            };
            event.currentTarget.removeEventListener(TimerEvent.TIMER_COMPLETE, this.endRemindArrow);
        }

        public function onOpenSpellBook():void
        {
            this.gridDisplay(SPELLS_TAB);
        }

        public function onPlayedCharacterLookChange(pLook:Object):void
        {
            var playerId:int;
            var look:Object;
            if ((((this._locketMode == LOCKET_ARTWORK)) || ((this._locketMode == LOCKET_SPRITE))))
            {
                if (((!(this.playerApi.isInFight())) || ((this.fightApi.getCurrentPlayedFighterId() == this.playerApi.id()))))
                {
                    this.headDisplay(pLook);
                }
                else
                {
                    if (this.playerApi.isInFight())
                    {
                        playerId = this.getPlayerId();
                        look = this.utilApi.getLookFromContext(playerId);
                        if (!(look))
                        {
                            look = pLook;
                        };
                        if (this._locketMode == LOCKET_ARTWORK)
                        {
                            this.showMonsterArtwork(look.getBone());
                        }
                        else
                        {
                            if (this._locketMode == LOCKET_SPRITE)
                            {
                                this.showSpritePortrait(look, this.utilApi.isCreature(playerId), this.utilApi.isIncarnation(playerId));
                            };
                        };
                    };
                };
            };
        }

        private function onFighterLookChange(pEntityId:int, pLook:Object):void
        {
            if (((this._bIsSpectator) && ((pEntityId == this._currentTurnEntityId))))
            {
                this.showSpritePortrait(pLook, false, false);
            };
        }

        public function onPopupClose():void
        {
        }

        public function onPopupLeaveFight():void
        {
            this.sysApi.sendAction(new GameContextQuit());
        }

        public function onGoKrosmaster():void
        {
            this.sysApi.dispatchHook(OpenKrosmaster);
        }

        private function onSwitchBannerTab(tabName:String):void
        {
            switch (tabName)
            {
                case ITEMS_TAB:
                case SPELLS_TAB:
                    this.gridDisplay(tabName);
            };
        }

        private function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean):void
        {
            if (this._locketMode == LOCKET_MINIMAP)
            {
                this.updateMinimap(map);
            }
            else
            {
                if ((((this._locketMode == LOCKET_SPRITE)) && (!(this._locketInitialized))))
                {
                    this.switchLocketContent(this._locketMode, true);
                };
            };
        }

        private function onGameRolePlayPlayerLifeStatus(status:uint, hardcore:uint):void
        {
            var playerId:int;
            var look:Object;
            if (hardcore != 0)
            {
                return;
            };
            if ((((status == PlayerLifeStatusEnum.STATUS_PHANTOM)) || ((status == PlayerLifeStatusEnum.STATUS_TOMBSTONE))))
            {
                playerId = this.getPlayerId();
                look = this.utilApi.getLookFromContext(playerId);
                if (look)
                {
                    if ((((((this._locketMode == LOCKET_ARTWORK)) && (this.tx_artwork.uri))) && (!((this.tx_artwork.uri.fileName == (look.getBone() + ".png"))))))
                    {
                        this.showMonsterArtwork(look.getBone());
                    }
                    else
                    {
                        if ((((((this._locketMode == LOCKET_SPRITE)) && (this.ed_coloredArtwork.look))) && (!(this.ed_coloredArtwork.look.equals(look)))))
                        {
                            this.showSpritePortrait(look, this.utilApi.isCreature(playerId), this.utilApi.isIncarnation(playerId));
                        };
                    };
                };
            };
        }

        private function onFlagAdded(flagId:String, worldMapId:int, x:int, y:int, color:int, flagLegend:String, canBeManuallyRemoved:Boolean=true):void
        {
            var flagKey:String = ((worldMapId + "_") + flagId);
            if (((!((this._locketMode == LOCKET_MINIMAP))) && (!(this.playerApi.isInFight()))))
            {
                this.switchLocketContent(LOCKET_MINIMAP);
            };
            if ((((((this._locketMode == LOCKET_MINIMAP)) && (this.mapApi.getCurrentWorldMap()))) && ((this.mapApi.getCurrentWorldMap().id == worldMapId))))
            {
                if (((!(this._flags[flagKey])) || ((this._flags[flagKey] == undefined))))
                {
                    this._flags[flagKey] = this.miniMap.addIcon("layer_8", flagId, (this.sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|point0"), x, y, this._mapIconScale, flagLegend, true, color, true, canBeManuallyRemoved);
                }
                else
                {
                    this._flags[flagKey].x = x;
                    this._flags[flagKey].y = y;
                    this._flags[flagKey].legend = flagLegend;
                };
                this.miniMap.updateMapElements();
            };
            if (!(this._hintTypesList[8]))
            {
                this.onSwitchAndSaveMapHintFilter(8);
            };
        }

        private function onFlagRemoved(flagId:String, worldMapId:int):void
        {
            var flagKey:String;
            if ((((this._locketMode == LOCKET_MINIMAP)) && ((this.mapApi.getCurrentWorldMap().id == worldMapId))))
            {
                flagKey = ((worldMapId + "_") + flagId);
                this.miniMap.removeMapElement(this._flags[flagKey]);
                this.miniMap.updateMapElements();
                delete this._flags[flagKey];
            };
        }

        private function onWeaponUpdate():void
        {
            if (this._sTabGrid == SPELLS_TAB)
            {
                this.gridDisplay(this._sTabGrid, true);
            };
        }

        private function toggleWitnessForbiden():void
        {
            if ((getTimer() - this._spectatorCloseLastRequest) < this._spectatorCloseLastRequestTime)
            {
                return;
            };
            this._spectatorCloseLastRequest = getTimer();
            this.sysApi.sendAction(new ToggleWitnessForbidden());
        }

        private function onGuildMembershipUpdated(hasGuild:Boolean):void
        {
            this.checkGuild();
        }

        private function onAllianceMembershipUpdated(hasAlliance:Boolean):void
        {
            this.checkAlliance();
        }

        private function onMapHintsFilter(layerId:int, displayed:Boolean, fromCartography:Boolean):void
        {
            if (!(fromCartography))
            {
                return;
            };
            this._hintTypesList[layerId] = displayed;
            this.miniMap.showLayer(("layer_" + layerId), displayed);
            this.miniMap.updateMapElements();
        }

        private function onSwitchAndSaveMapHintFilter(layerId:int):void
        {
            var hintCategoryFilters:int;
            var hintCatId:Object;
            this._hintTypesList[layerId] = !(this._hintTypesList[layerId]);
            this.miniMap.showLayer(("layer_" + layerId), this._hintTypesList[layerId]);
            this.miniMap.updateMapElements();
            this.sysApi.dispatchHook(MapHintsFilter, layerId, this._hintTypesList[layerId], false);
            for (hintCatId in this._hintTypesList)
            {
                if (this._hintTypesList[hintCatId])
                {
                    hintCategoryFilters = (hintCategoryFilters + Math.pow(2, int(hintCatId)));
                };
            };
            this.configApi.setConfigProperty("dofus", "mapFilters", hintCategoryFilters);
            if (layerId == 5)
            {
                if (!(this._hintTypesList[layerId]))
                {
                    this.sysApi.sendAction(new PrismsListRegister("Banner", PrismListenEnum.PRISM_LISTEN_NONE));
                }
                else
                {
                    this.sysApi.sendAction(new PrismsListRegister("Banner", PrismListenEnum.PRISM_LISTEN_ALL));
                };
            }
            else
            {
                if (layerId == 7)
                {
                    if (this._hintTypesList[layerId])
                    {
                        this.getMapGuildInformations();
                    };
                };
            };
        }

        private function displayPage():void
        {
            var index:int;
            if (this._sTabGrid == ITEMS_TAB)
            {
                index = this._nPageItems;
                this.sysApi.setData("bannerItemsPageIndex", this._nPageItems);
            }
            else
            {
                if (this._sTabGrid == SPELLS_TAB)
                {
                    index = this._nPageSpells;
                    if (this.getPlayerId() >= 0)
                    {
                        this.sysApi.setData(("bannerSpellsPageIndex" + this.getPlayerId()), this._nPageSpells);
                    };
                };
            };
            this.lbl_itemsNumber.text = (index + 1).toString();
            this.btn_upArrow.disabled = (index == 0);
            this.btn_downArrow.disabled = (index == (NUM_PAGES - 1));
        }

        private function pageItem(page:int):void
        {
            if ((((page < NUM_PAGES)) && ((page >= 0))))
            {
                switch (this._sTabGrid)
                {
                    case ITEMS_TAB:
                        this._nPageItems = page;
                        this.updateGrid(this._aItems, this._nPageItems, false);
                        break;
                    case SPELLS_TAB:
                        this._nPageSpells = page;
                        this.updateGrid(this._aSpells, this._nPageSpells, false);
                        break;
                };
                this.displayPage();
            };
        }

        private function pageItemDown():void
        {
            switch (this._sTabGrid)
            {
                case ITEMS_TAB:
                    if (this._nPageItems < (NUM_PAGES - 1))
                    {
                        this._nPageItems++;
                        this.updateGrid(this._aItems, this._nPageItems, false);
                        this.displayPage();
                    };
                    break;
                case SPELLS_TAB:
                    if (this._nPageSpells < (NUM_PAGES - 1))
                    {
                        this._nPageSpells++;
                        this.updateGrid(this._aSpells, this._nPageSpells, false);
                        this.gd_spellitemotes.selectedIndex = -1;
                        this.displayPage();
                    };
                    break;
            };
        }

        private function pageItemUp():void
        {
            switch (this._sTabGrid)
            {
                case ITEMS_TAB:
                    if (this._nPageItems > 0)
                    {
                        this._nPageItems--;
                        this.updateGrid(this._aItems, this._nPageItems, false);
                        this.displayPage();
                    };
                    break;
                case SPELLS_TAB:
                    if (this._nPageSpells > 0)
                    {
                        this._nPageSpells--;
                        this.updateGrid(this._aSpells, this._nPageSpells, false);
                        this.displayPage();
                    };
                    break;
            };
        }

        private function onRemoveSpell(index:int):void
        {
            this.sysApi.sendAction(new ShortcutBarRemoveRequest(1, index));
        }

        private function onRemoveItem(index:int):void
        {
            this.sysApi.sendAction(new ShortcutBarRemoveRequest(0, index));
        }

        private function onSpellMovementAllowed(state:Boolean):void
        {
            this._spellMovementAllowed = state;
            if (this._sTabGrid == SPELLS_TAB)
            {
                this.gd_spellitemotes.renderer.allowDrop = state;
                this.updateGrid(this._aSpells, this._nPageSpells);
            };
        }

        private function onShortcutsMovementAllowed(state:Boolean):void
        {
            this._shortcutsMovementAllowed = state;
            if (this._sTabGrid == ITEMS_TAB)
            {
                this.gd_spellitemotes.renderer.allowDrop = state;
                this.updateGrid(this._aItems, this._nPageItems);
            };
        }

        private function onPresetsUpdate():void
        {
            if (this._sTabGrid == ITEMS_TAB)
            {
                this._aItems = this.storageApi.getShortcutBarContent(0);
                this.updateGrid(this._aItems, this._nPageItems);
            };
        }

        private function openInventory():void
        {
            var storageUi:Object;
            if (this.uiApi.getUi(UIEnum.STORAGE_UI))
            {
                storageUi = this.uiApi.getUi(UIEnum.STORAGE_UI);
                if (((!(storageUi.isNull)) || ((storageUi.uiClass.currentStorageBehavior.getName() == "bag"))))
                {
                    this.sysApi.sendAction(new CloseInventory());
                };
            }
            else
            {
                this.sysApi.sendAction(new OpenInventory());
            };
        }

        private function onDungeonPartyFinderRegister(result:Boolean):void
        {
            if (result)
            {
                this.getSlotByBtnId(ID_BTN_TEAMSEARCH).selected = true;
            }
            else
            {
                this.getSlotByBtnId(ID_BTN_TEAMSEARCH).selected = false;
            };
        }

        private function onArenaRegistrationStatusUpdate(isRegistered:Boolean, currentStatus:int):void
        {
            var txt:Object;
            if (isRegistered != this._bArenaRegistered)
            {
                if (isRegistered)
                {
                    this.getSlotByBtnId(ID_BTN_CONQUEST).selected = true;
                }
                else
                {
                    this.getSlotByBtnId(ID_BTN_CONQUEST).selected = false;
                    if (currentStatus != PvpArenaStepEnum.ARENA_STEP_STARTING_FIGHT)
                    {
                        txt = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arenaNotAnymoreIn"));
                        this.uiApi.showTooltip(txt, this.getSlotByBtnId(ID_BTN_CONQUEST), true, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    };
                };
                this._bArenaRegistered = isRegistered;
            };
        }

        private function onPartyJoin(id:int, pMembers:Object, restrict:Boolean, isArenaParty:Boolean, name:String=""):void
        {
            if (((((!(this.btn_lockparty.visible)) && ((id == this.partyApi.getPartyId())))) && (this.playerApi.isInPreFight())))
            {
                this.btn_lockparty.visible = true;
            };
        }

        private function onPartyLeave(id:int, isArena:Boolean):void
        {
            if (((((this.btn_lockparty.visible) && ((id == this.partyApi.getPartyId())))) && (this.playerApi.isInPreFight())))
            {
                this.btn_lockparty.visible = false;
            };
        }

        private function unselectSpell():void
        {
            if (this.fightApi.isCastingSpell())
            {
                this.fightApi.cancelSpell();
                this.gd_spellitemotes.selectedIndex = -1;
            };
        }

        public function getBtnById(id:int):ButtonWrapper
        {
            var btn:ButtonWrapper;
            for each (btn in this._dataProviderButtons)
            {
                if (btn.id == id)
                {
                    return (btn);
                };
            };
            return (null);
        }

        public function setDisabledBtn(id:int, disabled:Boolean):void
        {
            var btn:ButtonWrapper = this.getBtnById(id);
            this.rpApi.setButtonWrapperActivation(btn, !(disabled));
            this.refreshButtonAtIndex(btn.position);
        }

        public function setDisabledBtns(disabled:Boolean):void
        {
            var btn:ButtonWrapper;
            for each (btn in this._dataProviderButtons)
            {
                this.rpApi.setButtonWrapperActivation(btn, !(disabled));
                this.refreshButtonAtIndex(btn.position);
            };
        }

        public function getSlotByBtnId(id:int):Slot
        {
            var pos:int = this.getBtnById(id).position;
            if (pos <= NUM_BTNS_VISIBLE)
            {
                return (this.gd_btnUis.slots[(pos - 1)]);
            };
            return (this.gd_additionalBtns.slots[(pos - (NUM_BTNS_VISIBLE + 1))]);
        }

        public function refreshButtonAtIndex(index:uint):void
        {
            if (index <= NUM_BTNS_VISIBLE)
            {
                this.gd_btnUis.updateItem((index - 1));
            }
            else
            {
                this.gd_additionalBtns.updateItem((index - (NUM_BTNS_VISIBLE + 1)));
            };
        }

        private function onSecureModeChange(isActive:Boolean):void
        {
            this._secureMode = isActive;
        }

        private function onConfigPropertyChange(pOptionManager:String, pPropertyName:String, pNewValue:*, pOldValue:*):void
        {
            if ((((pOptionManager == "dofus")) && ((pPropertyName == "mapCoordinates"))))
            {
                this.btn_showMapInfo.selected = (pNewValue as Boolean);
            };
        }

        private function onShowPlayersNames(pVisible:Boolean):void
        {
            this._playersNamesVisible = (this.btn_showPlayersNames.selected = pVisible);
        }

        private function onShowMonstersInfo(pVisible:Boolean):void
        {
            this._monstersInfoVisible = (this.btn_showMonstersInfo.selected = pVisible);
        }

        private function onCharacterAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_CARAC).active)))
            {
                this.sysApi.sendAction(new OpenStats());
            };
        }

        private function onSpellsAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_SPELL).active)))
            {
                this.sysApi.sendAction(new OpenBook("spellTab"));
            };
        }

        private function onItemsAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_BAG).active)))
            {
                this.openInventory();
            };
        }

        private function onQuestsAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_BOOK).active)))
            {
                this.sysApi.sendAction(new OpenBook("questTab"));
            };
        }

        private function onMapAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_MAP).active)))
            {
                this.sysApi.sendAction(new OpenMap());
            };
        }

        private function onFriendsAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_FRIEND).active)))
            {
                this.sysApi.sendAction(new OpenSocial("0"));
            };
        }

        private function onGuildAction():void
        {
            if (this.shortcutTimerReady())
            {
                if (!(this.socialApi.hasGuild()))
                {
                    this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.error.onlyForGuild"), 666, this.timeApi.getTimestamp());
                }
                else
                {
                    this.sysApi.sendAction(new OpenSocial("1"));
                };
            };
        }

        private function onTeamSearchAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_TEAMSEARCH).active)))
            {
                this.sysApi.sendAction(new OpenTeamSearch());
            };
        }

        private function onConquestAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_CONQUEST).active)))
            {
                this.getSlotByBtnId(ID_BTN_CONQUEST).selected = this._bArenaRegistered;
                this.sysApi.sendAction(new OpenArena());
            };
        }

        private function onWebAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_OGRINE).active)))
            {
                this.sysApi.sendAction(new OpenWebService());
            };
        }

        private function onAlignmentAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_ALIGNMENT).active)))
            {
                this.sysApi.sendAction(new OpenBook("alignmentTab"));
            };
        }

        private function onAllianceAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_ALLIANCE).active)))
            {
                this.sysApi.sendAction(new OpenSocial("2"));
            };
        }

        private function onJobAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_JOB).active)))
            {
                this.sysApi.sendAction(new OpenBook("jobTab"));
            };
        }

        private function onMountAction():void
        {
            if (this.shortcutTimerReady())
            {
                if (!(this.getBtnById(ID_BTN_MOUNT).active))
                {
                    this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.error.onlyForMount"), 666, this.timeApi.getTimestamp());
                }
                else
                {
                    this.sysApi.sendAction(new OpenMount());
                };
            };
        }

        private function onSpouseAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_SPOUSE).active)))
            {
                this.sysApi.sendAction(new OpenSocial("3"));
            };
        }

        private function onAlmanaxAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_ALMANAX).active)))
            {
                this.sysApi.sendAction(new OpenBook("calendarTab"));
            };
        }

        private function onAchievementAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_ACHIEVEMENT).active)))
            {
                this.sysApi.sendAction(new OpenBook("achievementTab"));
            };
        }

        private function onTitleAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_TITLE).active)))
            {
                this.sysApi.sendAction(new OpenBook("titleTab"));
            };
        }

        private function onBestiaryAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_BESTIARY).active)))
            {
                this.sysApi.sendAction(new OpenBook("bestiaryTab"));
            };
        }

        private function onKrozAction():void
        {
            var feature:OptionalFeature;
            var playDisabled:Boolean;
            var contextMenu:Array;
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_KROZ).active)))
            {
                feature = this.dataApi.getOptionalFeatureByKeyword("game.krosmasterGameInClient");
                playDisabled = true;
                if (((feature) && (this.configApi.isOptionalFeatureActive(feature.id))))
                {
                    playDisabled = false;
                };
                contextMenu = new Array();
                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.play"), this.onGoKrosmaster, null, playDisabled, null, false, true));
                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.krosmaster.collection"), this.goToKrosmasterUi, null, false, null, false, true));
                this.modContextMenu.createContextMenu(contextMenu);
            };
        }

        private function onShopAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_SHOP).active)))
            {
                if (!(this.uiApi.getUi("stockMyselfVendor")))
                {
                    Api.system.sendAction(new ExchangeRequestOnShopStock());
                }
                else
                {
                    this.uiApi.unloadUi("stockMyselfVendor");
                };
            };
        }

        private function onDirectoryAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_DIRECTORY).active)))
            {
                this.sysApi.sendAction(new OpenSocial("4"));
            };
        }

        private function onCompanionAction():void
        {
            if (((this.shortcutTimerReady()) && (this.getBtnById(ID_BTN_COMPANION).active)))
            {
                this.sysApi.sendAction(new OpenBook("companionTab"));
            };
        }

        public function checkJob(waitForRefresh:Boolean=false):void
        {
            var btn:ButtonWrapper = this.getBtnById(ID_BTN_JOB);
            var jobs:Object = this.jobsApi.getKnownJobs();
            if (((jobs) && ((jobs.length > 0))))
            {
                this.rpApi.setButtonWrapperActivation(btn, true);
            }
            else
            {
                this.rpApi.setButtonWrapperActivation(btn, false);
            };
            if (!(waitForRefresh))
            {
                this.refreshButtonAtIndex(btn.position);
            };
        }

        public function checkMount(waitForRefresh:Boolean=false):void
        {
            var btn:ButtonWrapper = this.getBtnById(ID_BTN_MOUNT);
            if (this.playerApi.getMount() != null)
            {
                this.rpApi.setButtonWrapperActivation(btn, true);
            }
            else
            {
                this.rpApi.setButtonWrapperActivation(btn, false);
            };
            if (!(waitForRefresh))
            {
                this.refreshButtonAtIndex(btn.position);
            };
        }

        public function checkSpouse(waitForRefresh:Boolean=false):void
        {
            var btn:ButtonWrapper = this.getBtnById(ID_BTN_SPOUSE);
            if (this.socialApi.hasSpouse())
            {
                this.rpApi.setButtonWrapperActivation(btn, true);
            }
            else
            {
                this.rpApi.setButtonWrapperActivation(btn, false);
            };
            if (!(waitForRefresh))
            {
                this.refreshButtonAtIndex(btn.position);
            };
        }

        public function checkAlliance(waitForRefresh:Boolean=false):void
        {
            var btn:ButtonWrapper = this.getBtnById(ID_BTN_ALLIANCE);
            if (this.socialApi.hasAlliance())
            {
                this.rpApi.setButtonWrapperActivation(btn, true);
            }
            else
            {
                this.rpApi.setButtonWrapperActivation(btn, false);
            };
            if (!(waitForRefresh))
            {
                this.refreshButtonAtIndex(btn.position);
            };
        }

        public function checkGuild(waitForRefresh:Boolean=false):void
        {
            var btn:ButtonWrapper = this.getBtnById(ID_BTN_GUILD);
            if (this.socialApi.hasGuild())
            {
                this.rpApi.setButtonWrapperActivation(btn, true);
            }
            else
            {
                this.rpApi.setButtonWrapperActivation(btn, false);
            };
            if (!(waitForRefresh))
            {
                this.refreshButtonAtIndex(btn.position);
            };
        }

        public function checkConquest(waitForRefresh:Boolean=false):void
        {
            var btn:ButtonWrapper = this.getBtnById(ID_BTN_CONQUEST);
            var feature:OptionalFeature = this.dataApi.getOptionalFeatureByKeyword("pvp.arena");
            if ((((((this.playerApi.getPlayedCharacterInfo().level >= 50)) && (feature))) && (this.configApi.isOptionalFeatureActive(feature.id))))
            {
                this.rpApi.setButtonWrapperActivation(btn, true);
            }
            else
            {
                this.rpApi.setButtonWrapperActivation(btn, false);
            };
            if (!(waitForRefresh))
            {
                this.refreshButtonAtIndex(btn.position);
            };
        }

        public function checkWeb(waitForRefresh:Boolean=false):void
        {
            var btn:ButtonWrapper = this.getBtnById(ID_BTN_OGRINE);
            if (!(this._secureMode))
            {
                this.rpApi.setButtonWrapperActivation(btn, true);
            }
            else
            {
                this.rpApi.setButtonWrapperActivation(btn, false);
            };
            if (!(waitForRefresh))
            {
                this.refreshButtonAtIndex(btn.position);
            };
        }

        public function checkTitle(waitForRefresh:Boolean=false, activation:Boolean=true):void
        {
            var btn:ButtonWrapper = this.getBtnById(ID_BTN_TITLE);
            this.rpApi.setButtonWrapperActivation(btn, activation);
            if (!(waitForRefresh))
            {
                this.refreshButtonAtIndex(btn.position);
            };
        }

        private function goToKrosmasterUi():void
        {
            this.sysApi.sendAction(new OpenBook("krosmasterTab"));
        }

        private function getItemTooltipSettings():ItemTooltipSettings
        {
            var val:Boolean;
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", true) as ItemTooltipSettings);
            if (itemTooltipSettings == null)
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                val = this.setItemTooltipSettings(itemTooltipSettings);
            };
            return (itemTooltipSettings);
        }

        private function setItemTooltipSettings(val:ItemTooltipSettings):Boolean
        {
            return (this.sysApi.setData("itemTooltipSettings", val, true));
        }

        private function getSpellTooltipSettings():SpellTooltipSettings
        {
            var spellTS:SpellTooltipSettings = (this.sysApi.getData("spellTooltipSettings", true) as SpellTooltipSettings);
            if (spellTS == null)
            {
                spellTS = this.tooltipApi.createSpellSettings();
                this.setSpellTooltipSettings(spellTS);
            };
            return (spellTS);
        }

        private function setSpellTooltipSettings(val:SpellTooltipSettings):Boolean
        {
            return (this.sysApi.setData("spellTooltipSettings", val, true));
        }

        private function shortcutTimerReady():Boolean
        {
            var currentTime:int = getTimer();
            var ret:Boolean = ((currentTime - this._shortcutTimerDuration) > SHORTCUT_DISABLE_DURATION);
            this._shortcutTimerDuration = currentTime;
            if (!(ret))
            {
                trace("shortcut timer bloqué !");
            };
            return (ret);
        }

        private function getPlayerId():int
        {
            if (this.playerApi.isInFight())
            {
                return (this.fightApi.getCurrentPlayedFighterId());
            };
            return (this.playerApi.id());
        }


    }
}//package ui

