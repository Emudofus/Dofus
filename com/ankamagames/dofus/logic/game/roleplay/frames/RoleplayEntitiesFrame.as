package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import flash.display.Sprite;
   import flash.utils.Timer;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapInformationsRequestMessage;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.enum.OptionEnum;
   import flash.events.TimerEvent;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.dofus.kernel.Kernel;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveMapUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.StatedMapUpdateMessage;
   import com.ankamagames.dofus.network.types.game.house.HouseInformations;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowActorMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationsMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.GameRolePlaySetAnimationMessage;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayShowChallengeMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionStateUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightRemoveTeamMemberMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayRemoveChallengeMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapFightCountMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.UpdateMapPlayersAgressableStatusMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.messages.game.pvp.UpdateSelfAgressableStatusMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundAddedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundRemovedMultipleMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundListAddedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockRemoveItemRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockRemoveItemRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockMoveItemRequestAction;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectListAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.GameDataPlayFarmObjectAnimationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.MapNpcsQuestStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellMessage;
   import com.ankamagames.dofus.logic.game.common.actions.StartZoomAction;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsWithCoordsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataInHouseMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.logic.game.roleplay.messages.DelayedActionMessage;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HousePropertiesMessage;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayRequestMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import flash.geom.Rectangle;
   import com.ankamagames.dofus.logic.game.roleplay.types.FightTeam;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionEmote;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionObjectUse;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.logic.game.roleplay.managers.AnimFunManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.atouin.messages.MapZoomMessage;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.logic.game.roleplay.types.Fight;
   import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformations;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AlternativeMonstersInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformationsWithAlternatives;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.look.IndexedEntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcWithQuestInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionFollowers;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.factories.RolePlayEntitiesFactory;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.types.entities.RoleplayObjectEntity;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.dofus.logic.game.roleplay.types.GroundObject;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.tiphon.engine.TiphonMultiBonesManager;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
   import com.ankamagames.tiphon.display.TiphonAnimation;
   import com.ankamagames.dofus.datacenter.sounds.SoundBones;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.engine.TiphonEventsManager;
   import flash.display.MovieClip;
   import flash.utils.clearTimeout;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockMoveItemRequestMessage;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.types.enums.EntityIconEnum;
   import flash.events.Event;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.dofus.logic.game.roleplay.types.EntityIcon;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   
   public class RoleplayEntitiesFrame extends AbstractEntitiesFrame implements Frame
   {
      
      public function RoleplayEntitiesFrame() {
         this._paddockItem = new Dictionary();
         this._groundObjectCache = new Cache(20,new LruGarbageCollector());
         this._usableEmotes = new Array();
         this._npcList = new Dictionary(true);
         this._lastStaticAnimations = new Dictionary();
         this._entitiesIconsNames = new Dictionary();
         this._entitiesIcons = new Dictionary();
         this._entitiesIconsContainer = new Sprite();
         this._waitingEmotesAnims = new Dictionary();
         super();
      }
      
      private static const ICONS_FILEPATH:String = XmlConfig.getInstance().getEntry("config.content.path") + "gfx/icons/conquestIcon.swf";
      
      private var _fights:Dictionary;
      
      private var _objects:Dictionary;
      
      private var _objectsByCellId:Dictionary;
      
      private var _paddockItem:Dictionary;
      
      private var _fightNumber:uint = 0;
      
      private var _timeout:Number;
      
      private var _loader:IResourceLoader;
      
      private var _groundObjectCache:ICache;
      
      private var _currentPaddockItemCellId:uint;
      
      private var _usableEmotes:Array;
      
      private var _currentEmoticon:uint = 0;
      
      private var _playersId:Array;
      
      private var _npcList:Dictionary;
      
      private var _housesList:Dictionary;
      
      private var _emoteTimesBySprite:Dictionary;
      
      private var _waitForMap:Boolean;
      
      private var _monstersIds:Vector.<int>;
      
      private var _allianceFrame:AllianceFrame;
      
      private var _lastStaticAnimations:Dictionary;
      
      private var _entitiesIconsNames:Dictionary;
      
      private var _entitiesIcons:Dictionary;
      
      private var _entitiesIconsContainer:Sprite;
      
      private var _updateAllIcons:Boolean;
      
      private var _waitingEmotesAnims:Dictionary;
      
      private var _auraCycleTimer:Timer;
      
      private var _auraCycleIndex:int;
      
      private var _lastEntityWithAura:AnimatedCharacter;
      
      private var _dispatchPlayerNewLook:Boolean;
      
      public function get currentEmoticon() : uint {
         return this._currentEmoticon;
      }
      
      public function set currentEmoticon(emoteId:uint) : void {
         this._currentEmoticon = emoteId;
      }
      
      public function get dispatchPlayerNewLook() : Boolean {
         return this._dispatchPlayerNewLook;
      }
      
      public function set dispatchPlayerNewLook(pValue:Boolean) : void {
         this._dispatchPlayerNewLook = pValue;
      }
      
      public function get fightNumber() : uint {
         return this._fightNumber;
      }
      
      public function get currentSubAreaId() : uint {
         return _currentSubAreaId;
      }
      
      public function get playersId() : Array {
         return this._playersId;
      }
      
      public function get housesInformations() : Dictionary {
         return this._housesList;
      }
      
      public function get fights() : Dictionary {
         return this._fights;
      }
      
      public function get isCreatureMode() : Boolean {
         return _creaturesMode;
      }
      
      public function get monstersIds() : Vector.<int> {
         return this._monstersIds;
      }
      
      public function get lastStaticAnimations() : Dictionary {
         return this._lastStaticAnimations;
      }
      
      override public function pushed() : Boolean {
         var mirmsg:MapInformationsRequestMessage = null;
         this.initNewMap();
         this._playersId = new Array();
         this._monstersIds = new Vector.<int>();
         this._emoteTimesBySprite = new Dictionary();
         _humanNumber = 0;
         this._auraCycleIndex = 0;
         this._auraCycleTimer = new Timer(1800);
         if(OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_CYCLE)
         {
            this._auraCycleTimer.addEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
            this._auraCycleTimer.start();
         }
         if(MapDisplayManager.getInstance().currentMapRendered)
         {
            mirmsg = new MapInformationsRequestMessage();
            mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
            ConnectionsHandler.getConnection().send(mirmsg);
         }
         else
         {
            this._waitForMap = true;
         }
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onGroundObjectLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onGroundObjectLoadFailed);
         _interactiveElements = new Vector.<InteractiveElement>();
         Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,onPropertyChanged);
         Tiphon.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onTiphonPropertyChanged);
         this._allianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         this._entitiesIconsContainer.mouseEnabled = this._entitiesIconsContainer.mouseChildren = false;
         DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(StrataEnum.STRATA_WORLD + 1)).addChild(this._entitiesIconsContainer);
         EnterFrameDispatcher.addEventListener(this.showIcons,"showIcons",25);
         return super.pushed();
      }
      
      override public function process(msg:Message) : Boolean {
         var char:AnimatedCharacter = null;
         var mcidmsg:MapComplementaryInformationsDataMessage = null;
         var newSubArea:SubArea = null;
         var newCreatureMode:* = false;
         var mapWithNoMonsters:* = false;
         var emoteId:* = 0;
         var emoteStartTime:* = NaN;
         var imumsg:InteractiveMapUpdateMessage = null;
         var smumsg:StatedMapUpdateMessage = null;
         var houseInformations:HouseInformations = null;
         var grpsamsg:GameRolePlayShowActorMessage = null;
         var gcrelmsg:GameContextRefreshEntityLookMessage = null;
         var gmcomsg:GameMapChangeOrientationMessage = null;
         var gmcomsg2:GameMapChangeOrientationsMessage = null;
         var num:* = 0;
         var grsamsg:GameRolePlaySetAnimationMessage = null;
         var characterEntity:AnimatedCharacter = null;
         var emcm:EntityMovementCompleteMessage = null;
         var entityMovementComplete:AnimatedCharacter = null;
         var emsm:EntityMovementStoppedMessage = null;
         var cmsmsg:CharacterMovementStoppedMessage = null;
         var characterEntityStopped:AnimatedCharacter = null;
         var grpsclmsg:GameRolePlayShowChallengeMessage = null;
         var gfosumsg:GameFightOptionStateUpdateMessage = null;
         var gfutmsg:GameFightUpdateTeamMessage = null;
         var gfrtmmsg:GameFightRemoveTeamMemberMessage = null;
         var grprcmsg:GameRolePlayRemoveChallengeMessage = null;
         var gcremsg:GameContextRemoveElementMessage = null;
         var playerCompt:uint = 0;
         var monsterId:* = 0;
         var mfcmsg:MapFightCountMessage = null;
         var umpasm:UpdateMapPlayersAgressableStatusMessage = null;
         var idx:* = 0;
         var nbPlayersUpdated:* = 0;
         var playerInfo:GameRolePlayHumanoidInformations = null;
         var playerOption:* = undefined;
         var usasm:UpdateSelfAgressableStatusMessage = null;
         var myPlayerInfo:GameRolePlayHumanoidInformations = null;
         var myPlayerOption:* = undefined;
         var ogamsg:ObjectGroundAddedMessage = null;
         var ogrmsg:ObjectGroundRemovedMessage = null;
         var ogrmmsg:ObjectGroundRemovedMultipleMessage = null;
         var oglamsg:ObjectGroundListAddedMessage = null;
         var comptObjects:uint = 0;
         var prira:PaddockRemoveItemRequestAction = null;
         var prirmsg:PaddockRemoveItemRequestMessage = null;
         var pmira:PaddockMoveItemRequestAction = null;
         var cursorIcon:Texture = null;
         var iw:ItemWrapper = null;
         var gdpormsg:GameDataPaddockObjectRemoveMessage = null;
         var roleplayContextFrame:RoleplayContextFrame = null;
         var gdpoamsg:GameDataPaddockObjectAddMessage = null;
         var gdpolamsg:GameDataPaddockObjectListAddMessage = null;
         var gdpfoamsg:GameDataPlayFarmObjectAnimationMessage = null;
         var mnqsumsg:MapNpcsQuestStatusUpdateMessage = null;
         var scmsg:ShowCellMessage = null;
         var roleplayContextFrame2:RoleplayContextFrame = null;
         var name:String = null;
         var text:String = null;
         var sza:StartZoomAction = null;
         var player:DisplayObject = null;
         var scmamsg:SwitchCreatureModeAction = null;
         var mirmsg:MapInformationsRequestMessage = null;
         var mciwcmsg:MapComplementaryInformationsWithCoordsMessage = null;
         var mcidihmsg:MapComplementaryInformationsDataInHouseMessage = null;
         var playerHouse:* = false;
         var actor:GameRolePlayActorInformations = null;
         var actor1:GameRolePlayActorInformations = null;
         var ac:AnimatedCharacter = null;
         var hi:GameRolePlayCharacterInformations = null;
         var option:* = undefined;
         var dam:DelayedActionMessage = null;
         var emote:Emoticon = null;
         var staticOnly:* = false;
         var time:Date = null;
         var animNameLook:TiphonEntityLook = null;
         var emoteAnimMsg:GameRolePlaySetAnimationMessage = null;
         var fight:FightCommonInformations = null;
         var house:HouseInformations = null;
         var houseWrapper:HouseWrapper = null;
         var numDoors:* = 0;
         var i:* = 0;
         var hpmsg:HousePropertiesMessage = null;
         var mo:MapObstacle = null;
         var rpInfos:GameRolePlayCharacterInformations = null;
         var k:* = 0;
         var orientation:ActorOrientation = null;
         var rider:TiphonSprite = null;
         var myAura:Emoticon = null;
         var rpEmoticonFrame:EmoticonFrame = null;
         var emoteId2:uint = 0;
         var aura:Emoticon = null;
         var eprmsg:EmotePlayRequestMessage = null;
         var playerId:uint = 0;
         var cell:uint = 0;
         var objectId:uint = 0;
         var item:PaddockItem = null;
         var cellId:uint = 0;
         var npc:TiphonSprite = null;
         var questClip:Sprite = null;
         var iq:* = 0;
         var nbnpcqnr:* = 0;
         var q:Quest = null;
         var rect:Rectangle = null;
         var id:* = undefined;
         var entity:* = undefined;
         var fightTeam:FightTeam = null;
         switch(true)
         {
            case msg is MapLoadedMessage:
               if(this._waitForMap)
               {
                  mirmsg = new MapInformationsRequestMessage();
                  mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                  ConnectionsHandler.getConnection().send(mirmsg);
                  this._waitForMap = false;
               }
               return false;
            case msg is MapComplementaryInformationsDataMessage:
               mcidmsg = msg as MapComplementaryInformationsDataMessage;
               this.initNewMap();
               _interactiveElements = mcidmsg.interactiveElements;
               this._fightNumber = mcidmsg.fights.length;
               if(msg is MapComplementaryInformationsWithCoordsMessage)
               {
                  mciwcmsg = msg as MapComplementaryInformationsWithCoordsMessage;
                  if(PlayedCharacterManager.getInstance().isInHouse)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                  }
                  PlayedCharacterManager.getInstance().isInHouse = false;
                  PlayedCharacterManager.getInstance().isInHisHouse = false;
                  PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mciwcmsg.worldX,mciwcmsg.worldY);
                  _worldPoint = new WorldPointWrapper(mciwcmsg.mapId,true,mciwcmsg.worldX,mciwcmsg.worldY);
               }
               else
               {
                  if(msg is MapComplementaryInformationsDataInHouseMessage)
                  {
                     mcidihmsg = msg as MapComplementaryInformationsDataInHouseMessage;
                     playerHouse = PlayerManager.getInstance().nickname == mcidihmsg.currentHouse.ownerName;
                     PlayedCharacterManager.getInstance().isInHouse = true;
                     if(playerHouse)
                     {
                        PlayedCharacterManager.getInstance().isInHisHouse = true;
                     }
                     PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
                     KernelEventsManager.getInstance().processCallback(HookList.HouseEntered,playerHouse,mcidihmsg.currentHouse.ownerId,mcidihmsg.currentHouse.ownerName,mcidihmsg.currentHouse.price,mcidihmsg.currentHouse.isLocked,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY,HouseWrapper.manualCreate(mcidihmsg.currentHouse.modelId,-1,mcidihmsg.currentHouse.ownerName,!(mcidihmsg.currentHouse.price == 0)));
                     _worldPoint = new WorldPointWrapper(mcidihmsg.mapId,true,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
                  }
                  else
                  {
                     _worldPoint = new WorldPointWrapper(mcidmsg.mapId);
                     if(PlayedCharacterManager.getInstance().isInHouse)
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                     }
                     PlayedCharacterManager.getInstance().isInHouse = false;
                     PlayedCharacterManager.getInstance().isInHisHouse = false;
                  }
               }
               _currentSubAreaId = mcidmsg.subAreaId;
               newSubArea = SubArea.getSubAreaById(_currentSubAreaId);
               PlayedCharacterManager.getInstance().currentMap = _worldPoint;
               PlayedCharacterManager.getInstance().currentSubArea = newSubArea;
               TooltipManager.hide();
               updateCreaturesLimit();
               newCreatureMode = false;
               for each (actor in mcidmsg.actors)
               {
                  _humanNumber++;
                  if((_creaturesLimit == 0) || (_creaturesLimit < 50) && (_humanNumber >= _creaturesLimit))
                  {
                     _creaturesMode = true;
                  }
                  if((actor.contextualId > 0) && (this._playersId) && (this._playersId.indexOf(actor.contextualId) == -1))
                  {
                     this._playersId.push(actor.contextualId);
                  }
                  if((actor is GameRolePlayGroupMonsterInformations) && (this._monstersIds.indexOf(actor.contextualId) == -1))
                  {
                     this._monstersIds.push(actor.contextualId);
                  }
               }
               mapWithNoMonsters = true;
               emoteId = 0;
               emoteStartTime = 0;
               for each (actor1 in mcidmsg.actors)
               {
                  ac = this.addOrUpdateActor(actor1) as AnimatedCharacter;
                  if(ac)
                  {
                     if(ac.id == PlayedCharacterManager.getInstance().id)
                     {
                        if(ac.libraryIsAvaible)
                        {
                           this.updateUsableEmotesListInit(ac.look);
                        }
                        else
                        {
                           ac.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                        }
                        if(this.dispatchPlayerNewLook)
                        {
                           KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,ac.look);
                           this.dispatchPlayerNewLook = false;
                        }
                     }
                     hi = actor1 as GameRolePlayCharacterInformations;
                     if(hi)
                     {
                        emoteId = 0;
                        emoteStartTime = 0;
                        for each (option in hi.humanoidInfo.options)
                        {
                           if(option is HumanOptionEmote)
                           {
                              emoteId = option.emoteId;
                              emoteStartTime = option.emoteStartTime;
                           }
                           else
                           {
                              if(option is HumanOptionObjectUse)
                              {
                                 dam = new DelayedActionMessage(hi.contextualId,option.objectGID,option.delayEndTime);
                                 Kernel.getWorker().process(dam);
                              }
                           }
                        }
                        if(emoteId > 0)
                        {
                           emote = Emoticon.getEmoticonById(emoteId);
                           if((emote) && (emote.persistancy))
                           {
                              this._currentEmoticon = emote.id;
                              if(!emote.aura)
                              {
                                 staticOnly = false;
                                 time = new Date();
                                 if(time.getTime() - emoteStartTime >= emote.duration)
                                 {
                                    staticOnly = true;
                                 }
                                 animNameLook = EntityLookAdapter.fromNetwork(hi.look);
                                 emoteAnimMsg = new GameRolePlaySetAnimationMessage(actor1,emote.getAnimName(animNameLook),emoteStartTime,!emote.persistancy,emote.eight_directions,staticOnly);
                                 if(ac.rendered)
                                 {
                                    this.process(emoteAnimMsg);
                                 }
                                 else
                                 {
                                    if(emoteAnimMsg.playStaticOnly)
                                    {
                                       ac.visible = false;
                                    }
                                    this._waitingEmotesAnims[ac.id] = emoteAnimMsg;
                                    ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
                                    ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
                                 }
                              }
                           }
                        }
                     }
                  }
                  if(mapWithNoMonsters)
                  {
                     if(actor1 is GameRolePlayGroupMonsterInformations)
                     {
                        mapWithNoMonsters = false;
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.MapWithMonsters);
                     }
                  }
                  if(actor1 is GameRolePlayCharacterInformations)
                  {
                     ChatAutocompleteNameManager.getInstance().addEntry((actor1 as GameRolePlayCharacterInformations).name,0);
                  }
               }
               for each (fight in mcidmsg.fights)
               {
                  this.addFight(fight);
               }
               this._housesList = new Dictionary();
               for each (house in mcidmsg.houses)
               {
                  houseWrapper = HouseWrapper.create(house);
                  numDoors = house.doorsOnMap.length;
                  i = 0;
                  while(i < numDoors)
                  {
                     this._housesList[house.doorsOnMap[i]] = houseWrapper;
                     i++;
                  }
                  hpmsg = new HousePropertiesMessage();
                  hpmsg.initHousePropertiesMessage(house);
                  Kernel.getWorker().process(hpmsg);
               }
               for each (mo in mcidmsg.obstacles)
               {
                  InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId,mo.state == MapObstacleStateEnum.OBSTACLE_OPENED);
               }
               imumsg = new InteractiveMapUpdateMessage();
               imumsg.initInteractiveMapUpdateMessage(mcidmsg.interactiveElements);
               Kernel.getWorker().process(imumsg);
               smumsg = new StatedMapUpdateMessage();
               smumsg.initStatedMapUpdateMessage(mcidmsg.statedElements);
               Kernel.getWorker().process(smumsg);
               KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,PlayedCharacterManager.getInstance().currentMap,_currentSubAreaId,Dofus.getInstance().options.mapCoordinates);
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,0);
               AnimFunManager.getInstance().initializeByMap(mcidmsg.mapId);
               this.switchPokemonMode();
               if(Kernel.getWorker().contains(MonstersInfoFrame))
               {
                  (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).update();
               }
               if(Kernel.getWorker().contains(InfoEntitiesFrame))
               {
                  (Kernel.getWorker().getFrame(InfoEntitiesFrame) as InfoEntitiesFrame).update();
               }
               return false;
            case msg is HousePropertiesMessage:
               houseInformations = (msg as HousePropertiesMessage).properties;
               houseWrapper = HouseWrapper.create(houseInformations);
               numDoors = houseInformations.doorsOnMap.length;
               i = 0;
               while(i < numDoors)
               {
                  this._housesList[houseInformations.doorsOnMap[i]] = houseWrapper;
                  i++;
               }
               KernelEventsManager.getInstance().processCallback(HookList.HouseProperties,houseInformations.houseId,houseInformations.doorsOnMap,houseInformations.ownerName,houseInformations.isOnSale,houseInformations.modelId);
               return true;
            case msg is GameRolePlayShowActorMessage:
               grpsamsg = msg as GameRolePlayShowActorMessage;
               char = DofusEntities.getEntity(grpsamsg.informations.contextualId) as AnimatedCharacter;
               if((char) && (char.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == -1))
               {
                  char.visibleAura = false;
               }
               if(!char)
               {
                  updateCreaturesLimit();
                  _humanNumber++;
               }
               char = this.addOrUpdateActor(grpsamsg.informations);
               if((char) && (grpsamsg.informations.contextualId == PlayedCharacterManager.getInstance().id))
               {
                  if(char.libraryIsAvaible)
                  {
                     this.updateUsableEmotesListInit(char.look);
                  }
                  else
                  {
                     char.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                  }
               }
               if(this.switchPokemonMode())
               {
                  return true;
               }
               if(grpsamsg.informations is GameRolePlayCharacterInformations)
               {
                  ChatAutocompleteNameManager.getInstance().addEntry((grpsamsg.informations as GameRolePlayCharacterInformations).name,0);
               }
               if((grpsamsg.informations is GameRolePlayCharacterInformations) && (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE))
               {
                  rpInfos = grpsamsg.informations as GameRolePlayCharacterInformations;
                  switch(PlayedCharacterManager.getInstance().levelDiff(rpInfos.alignmentInfos.characterPower - grpsamsg.informations.contextualId))
                  {
                     case -1:
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
                        break;
                     case 1:
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
                        break;
                  }
               }
               AnimFunManager.getInstance().restart();
               return true;
            case msg is GameContextRefreshEntityLookMessage:
               gcrelmsg = msg as GameContextRefreshEntityLookMessage;
               char = this.updateActorLook(gcrelmsg.id,gcrelmsg.look,true);
               if((char) && (gcrelmsg.id == PlayedCharacterManager.getInstance().id))
               {
                  if(char.libraryIsAvaible)
                  {
                     this.updateUsableEmotesListInit(char.look);
                  }
                  else
                  {
                     char.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                  }
               }
               return true;
            case msg is GameMapChangeOrientationMessage:
               gmcomsg = msg as GameMapChangeOrientationMessage;
               updateActorOrientation(gmcomsg.orientation.id,gmcomsg.orientation.direction);
               return true;
            case msg is GameMapChangeOrientationsMessage:
               gmcomsg2 = msg as GameMapChangeOrientationsMessage;
               num = gmcomsg2.orientations.length;
               k = 0;
               while(k < num)
               {
                  orientation = gmcomsg2.orientations[k];
                  updateActorOrientation(orientation.id,orientation.direction);
                  k++;
               }
               return true;
            case msg is GameRolePlaySetAnimationMessage:
               grsamsg = msg as GameRolePlaySetAnimationMessage;
               characterEntity = DofusEntities.getEntity(grsamsg.informations.contextualId) as AnimatedCharacter;
               if(!characterEntity)
               {
                  _log.error("GameRolePlaySetAnimationMessage : l\'entitée " + grsamsg.informations.contextualId + " n\'a pas ete trouvee");
                  return true;
               }
               if(grsamsg.animation == AnimationEnum.ANIM_STATIQUE)
               {
                  this._currentEmoticon = 0;
                  characterEntity.setAnimation(grsamsg.animation);
                  this._emoteTimesBySprite[characterEntity.name] = 0;
               }
               else
               {
                  if(!grsamsg.directions8)
                  {
                     if(characterEntity.getDirection() % 2 == 0)
                     {
                        characterEntity.setDirection(characterEntity.getDirection() + 1);
                     }
                  }
                  if(!characterEntity.hasAnimation(grsamsg.animation,characterEntity.getDirection()))
                  {
                     _log.error("GameRolePlaySetAnimationMessage : l\'animation " + grsamsg.animation + "_" + characterEntity.getDirection() + " n\'a pas ete trouvee");
                  }
                  else
                  {
                     if(!_creaturesMode)
                     {
                        this._emoteTimesBySprite[characterEntity.name] = grsamsg.duration;
                        characterEntity.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
                        characterEntity.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
                        rider = characterEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
                        if(rider)
                        {
                           rider.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
                           rider.addEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
                        }
                        characterEntity.setAnimation(grsamsg.animation);
                        if(grsamsg.playStaticOnly)
                        {
                           if((characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET)) && (characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length))
                           {
                              characterEntity.setSubEntityBehaviour(1,new AnimStatiqueSubEntityBehavior());
                           }
                           characterEntity.stopAnimationAtLastFrame();
                           if(rider)
                           {
                              rider.stopAnimationAtLastFrame();
                           }
                        }
                     }
                  }
               }
               return true;
            case msg is EntityMovementCompleteMessage:
               emcm = msg as EntityMovementCompleteMessage;
               entityMovementComplete = emcm.entity as AnimatedCharacter;
               if(_entities[entityMovementComplete.getRootEntity().id])
               {
                  (_entities[entityMovementComplete.getRootEntity().id] as GameContextActorInformations).disposition.cellId = entityMovementComplete.position.cellId;
               }
               if(this._entitiesIcons[emcm.entity.id])
               {
                  this._entitiesIcons[emcm.entity.id].needUpdate = true;
               }
               return false;
            case msg is EntityMovementStoppedMessage:
               emsm = msg as EntityMovementStoppedMessage;
               if(this._entitiesIcons[emsm.entity.id])
               {
                  this._entitiesIcons[emsm.entity.id].needUpdate = true;
               }
               return false;
            case msg is CharacterMovementStoppedMessage:
               cmsmsg = msg as CharacterMovementStoppedMessage;
               characterEntityStopped = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
               if((((OptionManager.getOptionManager("tiphon").auraMode > OptionEnum.AURA_NONE) && (OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront)) && (characterEntityStopped.getDirection() == DirectionsEnum.DOWN)) && (!(characterEntityStopped.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == -1)) && (PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING))
               {
                  rpEmoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
                  for each (emoteId2 in rpEmoticonFrame.emotes)
                  {
                     aura = Emoticon.getEmoticonById(emoteId2);
                     if((aura) && (aura.aura))
                     {
                        if((!myAura) || (aura.weight > myAura.weight))
                        {
                           myAura = aura;
                        }
                     }
                  }
                  if(myAura)
                  {
                     eprmsg = new EmotePlayRequestMessage();
                     eprmsg.initEmotePlayRequestMessage(myAura.id);
                     ConnectionsHandler.getConnection().send(eprmsg);
                  }
               }
               return true;
            case msg is GameRolePlayShowChallengeMessage:
               grpsclmsg = msg as GameRolePlayShowChallengeMessage;
               this.addFight(grpsclmsg.commonsInfos);
               return true;
            case msg is GameFightOptionStateUpdateMessage:
               gfosumsg = msg as GameFightOptionStateUpdateMessage;
               this.updateSwordOptions(gfosumsg.fightId,gfosumsg.teamId,gfosumsg.option,gfosumsg.state);
               KernelEventsManager.getInstance().processCallback(HookList.GameFightOptionStateUpdate,gfosumsg.fightId,gfosumsg.teamId,gfosumsg.option,gfosumsg.state);
               return true;
            case msg is GameFightUpdateTeamMessage:
               gfutmsg = msg as GameFightUpdateTeamMessage;
               this.updateFight(gfutmsg.fightId,gfutmsg.team);
               return true;
            case msg is GameFightRemoveTeamMemberMessage:
               gfrtmmsg = msg as GameFightRemoveTeamMemberMessage;
               this.removeFighter(gfrtmmsg.fightId,gfrtmmsg.teamId,gfrtmmsg.charId);
               return true;
            case msg is GameRolePlayRemoveChallengeMessage:
               grprcmsg = msg as GameRolePlayRemoveChallengeMessage;
               KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayRemoveFight,grprcmsg.fightId);
               this.removeFight(grprcmsg.fightId);
               return true;
            case msg is GameContextRemoveElementMessage:
               gcremsg = msg as GameContextRemoveElementMessage;
               delete this._lastStaticAnimations[[gcremsg.id]];
               playerCompt = 0;
               for each (playerId in this._playersId)
               {
                  if(playerId == gcremsg.id)
                  {
                     this._playersId.splice(playerCompt,1);
                  }
                  else
                  {
                     playerCompt++;
                  }
               }
               monsterId = this._monstersIds.indexOf(gcremsg.id);
               if(monsterId != -1)
               {
                  this._monstersIds.splice(monsterId,1);
               }
               if(this._entitiesIconsNames[gcremsg.id])
               {
                  delete this._entitiesIconsNames[[gcremsg.id]];
               }
               if(this._entitiesIcons[gcremsg.id])
               {
                  this.removeIcon(gcremsg.id);
               }
               delete this._waitingEmotesAnims[[gcremsg.id]];
               this.removeEntityListeners(gcremsg.id);
               removeActor(gcremsg.id);
               return true;
            case msg is MapFightCountMessage:
               mfcmsg = msg as MapFightCountMessage;
               trace("Nombre de combat(s) sur la carte : " + mfcmsg.fightCount);
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,mfcmsg.fightCount);
               return true;
            case msg is UpdateMapPlayersAgressableStatusMessage:
               umpasm = msg as UpdateMapPlayersAgressableStatusMessage;
               nbPlayersUpdated = umpasm.playerIds.length;
               idx = 0;
               while(idx < nbPlayersUpdated)
               {
                  playerInfo = getEntityInfos(umpasm.playerIds[idx]) as GameRolePlayHumanoidInformations;
                  if(playerInfo)
                  {
                     for each (playerOption in playerInfo.humanoidInfo.options)
                     {
                        if(playerOption is HumanOptionAlliance)
                        {
                           (playerOption as HumanOptionAlliance).aggressable = umpasm.enable[idx];
                           break;
                        }
                     }
                  }
                  if(umpasm.playerIds[idx] == PlayedCharacterManager.getInstance().id)
                  {
                     PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = umpasm.enable[idx];
                     KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange,umpasm.enable[idx],0);
                  }
                  idx++;
               }
               this.updateConquestIcons(umpasm.playerIds);
               return true;
            case msg is UpdateSelfAgressableStatusMessage:
               usasm = msg as UpdateSelfAgressableStatusMessage;
               myPlayerInfo = getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayHumanoidInformations;
               if(myPlayerInfo)
               {
                  for each (myPlayerOption in myPlayerInfo.humanoidInfo.options)
                  {
                     if(myPlayerOption is HumanOptionAlliance)
                     {
                        (myPlayerOption as HumanOptionAlliance).aggressable = usasm.status;
                        break;
                     }
                  }
               }
               if(PlayedCharacterManager.getInstance().characteristics)
               {
                  PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = usasm.status;
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange,usasm.status,usasm.probationTime);
               this.updateConquestIcons(PlayedCharacterManager.getInstance().id);
               return true;
            case msg is ObjectGroundAddedMessage:
               ogamsg = msg as ObjectGroundAddedMessage;
               this.addObject(ogamsg.objectGID,ogamsg.cellId);
               return true;
            case msg is ObjectGroundRemovedMessage:
               ogrmsg = msg as ObjectGroundRemovedMessage;
               this.removeObject(ogrmsg.cell);
               return true;
            case msg is ObjectGroundRemovedMultipleMessage:
               ogrmmsg = msg as ObjectGroundRemovedMultipleMessage;
               for each (cell in ogrmmsg.cells)
               {
                  this.removeObject(cell);
               }
               return true;
            case msg is ObjectGroundListAddedMessage:
               oglamsg = msg as ObjectGroundListAddedMessage;
               comptObjects = 0;
               for each (objectId in oglamsg.referenceIds)
               {
                  this.addObject(objectId,oglamsg.cells[comptObjects]);
                  comptObjects++;
               }
               return true;
            case msg is PaddockRemoveItemRequestAction:
               prira = msg as PaddockRemoveItemRequestAction;
               prirmsg = new PaddockRemoveItemRequestMessage();
               prirmsg.initPaddockRemoveItemRequestMessage(prira.cellId);
               ConnectionsHandler.getConnection().send(prirmsg);
               return true;
            case msg is PaddockMoveItemRequestAction:
               pmira = msg as PaddockMoveItemRequestAction;
               this._currentPaddockItemCellId = pmira.object.disposition.cellId;
               cursorIcon = new Texture();
               iw = ItemWrapper.create(0,0,pmira.object.item.id,0,null,false);
               cursorIcon.uri = iw.iconUri;
               cursorIcon.finalize();
               Kernel.getWorker().addFrame(new RoleplayPointCellFrame(this.onCellPointed,cursorIcon,true,this.paddockCellValidator,true));
               return true;
            case msg is GameDataPaddockObjectRemoveMessage:
               gdpormsg = msg as GameDataPaddockObjectRemoveMessage;
               roleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
               this.removePaddockItem(gdpormsg.cellId);
               return true;
            case msg is GameDataPaddockObjectAddMessage:
               gdpoamsg = msg as GameDataPaddockObjectAddMessage;
               this.addPaddockItem(gdpoamsg.paddockItemDescription);
               return true;
            case msg is GameDataPaddockObjectListAddMessage:
               gdpolamsg = msg as GameDataPaddockObjectListAddMessage;
               for each (item in gdpolamsg.paddockItemDescription)
               {
                  this.addPaddockItem(item);
               }
               return true;
            case msg is GameDataPlayFarmObjectAnimationMessage:
               gdpfoamsg = msg as GameDataPlayFarmObjectAnimationMessage;
               for each (cellId in gdpfoamsg.cellId)
               {
                  this.activatePaddockItem(cellId);
               }
               return true;
            case msg is MapNpcsQuestStatusUpdateMessage:
               mnqsumsg = msg as MapNpcsQuestStatusUpdateMessage;
               if(MapDisplayManager.getInstance().currentMapPoint.mapId == mnqsumsg.mapId)
               {
                  for each (npc in this._npcList)
                  {
                     this.removeBackground(npc);
                  }
                  nbnpcqnr = mnqsumsg.npcsIdsWithQuest.length;
                  iq = 0;
                  while(iq < nbnpcqnr)
                  {
                     npc = this._npcList[mnqsumsg.npcsIdsWithQuest[iq]];
                     if(npc)
                     {
                        q = Quest.getFirstValidQuest(mnqsumsg.questFlags[iq]);
                        if(q != null)
                        {
                           if(mnqsumsg.questFlags[iq].questsToStartId.indexOf(q.id) != -1)
                           {
                              if(q.repeatType == 0)
                              {
                                 questClip = EmbedAssets.getSprite("QUEST_CLIP");
                                 npc.addBackground("questClip",questClip,true);
                              }
                              else
                              {
                                 questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                                 npc.addBackground("questRepeatableClip",questClip,true);
                              }
                           }
                           else
                           {
                              if(q.repeatType == 0)
                              {
                                 questClip = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                                 npc.addBackground("questObjectiveClip",questClip,true);
                              }
                              else
                              {
                                 questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                                 npc.addBackground("questRepeatableObjectiveClip",questClip,true);
                              }
                           }
                        }
                     }
                     iq++;
                  }
               }
               return true;
            case msg is ShowCellMessage:
               scmsg = msg as ShowCellMessage;
               HyperlinkShowCellManager.showCell(scmsg.cellId);
               roleplayContextFrame2 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
               name = roleplayContextFrame2.getActorName(scmsg.sourceId);
               text = I18n.getUiText("ui.fight.showCell",[name,"{cell," + scmsg.cellId + "::" + scmsg.cellId + "}"]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is StartZoomAction:
               sza = msg as StartZoomAction;
               if(Atouin.getInstance().currentZoom != 1)
               {
                  Atouin.getInstance().cancelZoom();
                  KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
                  this.updateAllIcons();
                  return true;
               }
               player = DofusEntities.getEntity(sza.playerId) as DisplayObject;
               if((player) && (player.stage))
               {
                  rect = player.getRect(Atouin.getInstance().worldContainer);
                  Atouin.getInstance().zoom(sza.value,rect.x + rect.width / 2,rect.y + rect.height / 2);
                  KernelEventsManager.getInstance().processCallback(HookList.StartZoom,true);
                  this.updateAllIcons();
               }
               return true;
            case msg is SwitchCreatureModeAction:
               scmamsg = msg as SwitchCreatureModeAction;
               if(_creaturesMode != scmamsg.isActivated)
               {
                  _creaturesMode = scmamsg.isActivated;
                  for (id in _entities)
                  {
                     this.updateActorLook(id,(_entities[id] as GameContextActorInformations).look);
                  }
               }
               return true;
            case msg is MapZoomMessage:
               for each (entity in _entities)
               {
                  fightTeam = entity as FightTeam;
                  if((fightTeam) && (fightTeam.fight) && (fightTeam.teamInfos))
                  {
                     this.updateSwordOptions(fightTeam.fight.fightId,fightTeam.teamInfos.teamId);
                  }
               }
               return false;
         }
      }
      
      private function initNewMap() : void {
         var go:* = undefined;
         for each (go in this._objectsByCellId)
         {
            (go as IDisplayable).remove();
         }
         this._npcList = new Dictionary();
         this._fights = new Dictionary();
         this._objects = new Dictionary();
         this._objectsByCellId = new Dictionary();
         this._paddockItem = new Dictionary();
      }
      
      override protected function switchPokemonMode() : Boolean {
         if(super.switchPokemonMode())
         {
            KernelEventsManager.getInstance().processCallback(TriggerHookList.CreaturesMode);
            return true;
         }
         return false;
      }
      
      override public function pulled() : Boolean {
         var fight:Fight = null;
         var team:FightTeam = null;
         for each (fight in this._fights)
         {
            for each (team in fight.teams)
            {
               (team.teamEntity as TiphonSprite).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onFightEntityRendered);
               TooltipManager.hide("fightOptions_" + fight.fightId + "_" + team.teamInfos.teamId);
            }
         }
         if(this._loader)
         {
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onGroundObjectLoaded);
            this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onGroundObjectLoadFailed);
            this._loader = null;
         }
         AnimFunManager.getInstance().stopAllTimer();
         this._fights = null;
         this._objects = null;
         this._npcList = null;
         Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,onPropertyChanged);
         Tiphon.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onTiphonPropertyChanged);
         EnterFrameDispatcher.removeEventListener(this.showIcons);
         var doc:DisplayObjectContainer = Berilia.getInstance().docMain.getChildAt(StrataEnum.STRATA_WORLD + 1) as DisplayObjectContainer;
         if((doc) && (doc == this._entitiesIconsContainer.parent))
         {
            doc.removeChild(this._entitiesIconsContainer);
         }
         this.removeAllIcons();
         if(OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_CYCLE)
         {
            this._auraCycleTimer.removeEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
            this._auraCycleTimer.stop();
         }
         this._lastEntityWithAura = null;
         return super.pulled();
      }
      
      public function isFight(entityId:int) : Boolean {
         return _entities[entityId] is FightTeam;
      }
      
      public function isPaddockItem(entityId:int) : Boolean {
         return _entities[entityId] is GameContextPaddockItemInformations;
      }
      
      public function getFightTeam(entityId:int) : FightTeam {
         return _entities[entityId] as FightTeam;
      }
      
      public function getFightId(entityId:int) : uint {
         return (_entities[entityId] as FightTeam).fight.fightId;
      }
      
      public function getFightLeaderId(entityId:int) : uint {
         return (_entities[entityId] as FightTeam).teamInfos.leaderId;
      }
      
      public function getFightTeamType(entityId:int) : uint {
         return (_entities[entityId] as FightTeam).teamType;
      }
      
      private function getMonsterGroup(pStaticMonsterInfos:GroupMonsterStaticInformations) : Vector.<MonsterInGroupLightInformations> {
         var newGroup:Vector.<MonsterInGroupLightInformations> = null;
         var pmf:PartyManagementFrame = null;
         var partyMembers:Vector.<PartyMemberWrapper> = null;
         var nbMembers:* = 0;
         var monsterGroup:AlternativeMonstersInGroupLightInformations = null;
         var member:PartyMemberWrapper = null;
         var infos:GroupMonsterStaticInformationsWithAlternatives = pStaticMonsterInfos as GroupMonsterStaticInformationsWithAlternatives;
         if(infos)
         {
            pmf = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
            partyMembers = pmf.partyMembers;
            nbMembers = partyMembers.length;
            if((nbMembers == 0) && (PlayedCharacterManager.getInstance().hasCompanion))
            {
               nbMembers = 2;
            }
            else
            {
               for each (member in partyMembers)
               {
                  nbMembers = nbMembers + member.companions.length;
               }
            }
            for each (monsterGroup in infos.alternatives)
            {
               if((!newGroup) || (monsterGroup.playerCount <= nbMembers))
               {
                  newGroup = monsterGroup.monsters;
               }
            }
         }
         return newGroup?newGroup.concat():null;
      }
      
      override public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier=null) : AnimatedCharacter {
         var questClip:Sprite = null;
         var q:Quest = null;
         var monstersInfos:GameRolePlayGroupMonsterInformations = null;
         var groupHasMiniBoss:* = false;
         var i:uint = 0;
         var underling:MonsterInGroupLightInformations = null;
         var monster:Monster = null;
         var monsterGrade:* = 0;
         var monstersGroup:Vector.<MonsterInGroupLightInformations> = null;
         var monsterInfos:MonsterInGroupLightInformations = null;
         var followersLooks:Vector.<EntityLook> = null;
         var followersSpeeds:Vector.<Number> = null;
         var entityLooks:Vector.<EntityLook> = null;
         var option:* = undefined;
         var indexedLooks:Array = null;
         var indexedEL:IndexedEntityLook = null;
         var iEL:IndexedEntityLook = null;
         var ac:AnimatedCharacter = super.addOrUpdateActor(infos);
         switch(true)
         {
            case infos is GameRolePlayNpcWithQuestInformations:
               this._npcList[infos.contextualId] = ac;
               q = Quest.getFirstValidQuest((infos as GameRolePlayNpcWithQuestInformations).questFlag);
               this.removeBackground(ac);
               if(q != null)
               {
                  if((infos as GameRolePlayNpcWithQuestInformations).questFlag.questsToStartId.indexOf(q.id) != -1)
                  {
                     if(q.repeatType == 0)
                     {
                        questClip = EmbedAssets.getSprite("QUEST_CLIP");
                        ac.addBackground("questClip",questClip,true);
                     }
                     else
                     {
                        questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                        ac.addBackground("questRepeatableClip",questClip,true);
                     }
                  }
                  else
                  {
                     if(q.repeatType == 0)
                     {
                        questClip = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                        ac.addBackground("questObjectiveClip",questClip,true);
                     }
                     else
                     {
                        questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                        ac.addBackground("questRepeatableObjectiveClip",questClip,true);
                     }
                  }
               }
               if(ac.look.getBone() == 1)
               {
                  ac.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode) || (ac.getAnimation() == AnimationEnum.ANIM_STATIQUE))
               {
                  ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case infos is GameRolePlayGroupMonsterInformations:
               monstersInfos = infos as GameRolePlayGroupMonsterInformations;
               groupHasMiniBoss = Monster.getMonsterById(monstersInfos.staticInfos.mainCreatureLightInfos.creatureGenericId).isMiniBoss;
               i = 0;
               monstersGroup = this.getMonsterGroup(monstersInfos.staticInfos);
               if(monstersGroup)
               {
                  for each (monsterInfos in monstersGroup)
                  {
                     if(monsterInfos.creatureGenericId == monstersInfos.staticInfos.mainCreatureLightInfos.creatureGenericId)
                     {
                        monstersGroup.splice(monstersGroup.indexOf(monsterInfos),1);
                        break;
                     }
                  }
               }
               followersLooks = Dofus.getInstance().options.showEveryMonsters?new Vector.<EntityLook>(!monstersGroup?monstersInfos.staticInfos.underlings.length:monstersGroup.length,true):null;
               followersSpeeds = followersLooks?new Vector.<Number>(followersLooks.length,true):null;
               for each (underling in monstersInfos.staticInfos.underlings)
               {
                  if(followersLooks)
                  {
                     monster = Monster.getMonsterById(underling.creatureGenericId);
                     monsterGrade = -1;
                     if(!monstersGroup)
                     {
                        monsterGrade = 0;
                     }
                     else
                     {
                        for each (monsterInfos in monstersGroup)
                        {
                           if(monsterInfos.creatureGenericId == underling.creatureGenericId)
                           {
                              monstersGroup.splice(monstersGroup.indexOf(monsterInfos),1);
                              monsterGrade = monsterInfos.grade;
                              break;
                           }
                        }
                     }
                     if(monsterGrade >= 0)
                     {
                        followersSpeeds[i] = monster.speedAdjust;
                        followersLooks[i] = EntityLookAdapter.toNetwork(TiphonEntityLook.fromString(monster.look));
                        i++;
                     }
                  }
                  if((!groupHasMiniBoss) && (Monster.getMonsterById(underling.creatureGenericId).isMiniBoss))
                  {
                     groupHasMiniBoss = true;
                     if(!followersLooks)
                     {
                        break;
                     }
                  }
               }
               if(followersLooks)
               {
                  this.manageFollowers(ac,followersLooks,followersSpeeds);
               }
               if(this._monstersIds.indexOf(infos.contextualId) == -1)
               {
                  this._monstersIds.push(infos.contextualId);
               }
               if(Kernel.getWorker().contains(MonstersInfoFrame))
               {
                  (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).update();
               }
               if((!(PlayerManager.getInstance().serverGameType == 0)) && (monstersInfos.hasHardcoreDrop))
               {
                  this.addEntityIcon(monstersInfos.contextualId,"treasure");
               }
               if(groupHasMiniBoss)
               {
                  this.addEntityIcon(monstersInfos.contextualId,"archmonsters");
               }
               if(monstersInfos.hasAVARewardToken)
               {
                  this.addEntityIcon(monstersInfos.contextualId,"nugget");
               }
               break;
            case infos is GameRolePlayHumanoidInformations:
               if((infos.contextualId > 0) && (this._playersId) && (this._playersId.indexOf(infos.contextualId) == -1))
               {
                  this._playersId.push(infos.contextualId);
               }
               entityLooks = new Vector.<EntityLook>();
               for each (option in (infos as GameRolePlayHumanoidInformations).humanoidInfo.options)
               {
                  switch(true)
                  {
                     case option is HumanOptionFollowers:
                        indexedLooks = new Array();
                        for each (indexedEL in option.followingCharactersLook)
                        {
                           indexedLooks.push(indexedEL);
                        }
                        indexedLooks.sortOn("index");
                        for each (iEL in indexedLooks)
                        {
                           entityLooks.push(iEL.look);
                        }
                        continue;
                     case option is HumanOptionAlliance:
                        this.addConquestIcon(infos.contextualId,option as HumanOptionAlliance);
                        continue;
                  }
               }
               this.manageFollowers(ac,entityLooks);
               if(ac.look.getBone() == 1)
               {
                  ac.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode) || (ac.getAnimation() == AnimationEnum.ANIM_STATIQUE))
               {
                  ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case infos is GameRolePlayMerchantInformations:
               if(ac.look.getBone() == 1)
               {
                  ac.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode) || (ac.getAnimation() == AnimationEnum.ANIM_STATIQUE))
               {
                  ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               trace("Affichage d\'un personnage en mode marchand");
               break;
            case infos is GameRolePlayTaxCollectorInformations:
            case infos is GameRolePlayPrismInformations:
            case infos is GameRolePlayPortalInformations:
               ac.allowMovementThrough = true;
               break;
            case infos is GameRolePlayNpcInformations:
               this._npcList[infos.contextualId] = ac;
            case infos is GameContextPaddockItemInformations:
               break;
         }
         return ac;
      }
      
      override protected function updateActorLook(actorId:int, newLook:EntityLook, smoke:Boolean=false) : AnimatedCharacter {
         var anim:String = null;
         var ac:AnimatedCharacter = DofusEntities.getEntity(actorId) as AnimatedCharacter;
         if(ac)
         {
            anim = (TiphonUtility.getEntityWithoutMount(ac) as TiphonSprite).getAnimation();
            if((!(anim.indexOf("_Statique_") == -1)) && ((!this._lastStaticAnimations[actorId]) || (!(this._lastStaticAnimations[actorId] == anim))))
            {
               this._lastStaticAnimations[actorId] = {"anim":anim};
            }
            if((!(ac.look.getBone() == newLook.bonesId)) && (this._lastStaticAnimations[actorId]))
            {
               this._lastStaticAnimations[actorId].targetBone = newLook.bonesId;
               ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
               ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
               ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
         }
         return super.updateActorLook(actorId,newLook,smoke);
      }
      
      private function onEntityRendered(pEvent:TiphonEvent) : void {
         var ac:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         if((this._lastStaticAnimations[ac.id].targetBone == ac.look.getBone()) && (ac.rendered))
         {
            ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
            ac.setAnimation(this._lastStaticAnimations[ac.id].anim);
            delete this._lastStaticAnimations[[ac.id]];
         }
      }
      
      private function removeBackground(ac:TiphonSprite) : void {
         if(!ac)
         {
            return;
         }
         ac.removeBackground("questClip");
         ac.removeBackground("questObjectiveClip");
         ac.removeBackground("questRepeatableClip");
         ac.removeBackground("questRepeatableObjectiveClip");
      }
      
      private function manageFollowers(char:AnimatedCharacter, followers:Vector.<EntityLook>, speedAdjust:Vector.<Number>=null) : void {
         var num:* = 0;
         var i:* = 0;
         var followerBaseLook:EntityLook = null;
         var followerEntityLook:TiphonEntityLook = null;
         var followerEntity:AnimatedCharacter = null;
         if(!char.followersEqual(followers))
         {
            char.removeAllFollowers();
            num = followers.length;
            i = 0;
            while(i < num)
            {
               followerBaseLook = followers[i];
               followerEntityLook = EntityLookAdapter.fromNetwork(followerBaseLook);
               followerEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),followerEntityLook,char);
               if(speedAdjust)
               {
                  followerEntity.speedAdjust = speedAdjust[i];
               }
               char.addFollower(followerEntity);
               i++;
            }
         }
      }
      
      private function addFight(infos:FightCommonInformations) : void {
         var team:FightTeamInformations = null;
         var teamEntity:IEntity = null;
         var fightTeam:FightTeam = null;
         var teams:Vector.<FightTeam> = new Vector.<FightTeam>(0,false);
         var fight:Fight = new Fight(infos.fightId,teams);
         var teamCounter:uint = 0;
         for each (team in infos.fightTeams)
         {
            teamEntity = RolePlayEntitiesFactory.createFightEntity(infos,team,MapPoint.fromCellId(infos.fightTeamsPositions[teamCounter]));
            (teamEntity as IDisplayable).display();
            fightTeam = new FightTeam(fight,team.teamTypeId,teamEntity,team,infos.fightTeamsOptions[team.teamId]);
            _entities[teamEntity.id] = fightTeam;
            teams.push(fightTeam);
            teamCounter++;
            (teamEntity as TiphonSprite).addEventListener(TiphonEvent.RENDER_SUCCEED,this.onFightEntityRendered,false,0,true);
         }
         this._fights[infos.fightId] = fight;
      }
      
      private function addObject(pObjectUID:uint, pCellId:uint) : void {
         var objectUri:Uri = new Uri(LangManager.getInstance().getEntry("config.gfx.path.item.vector") + Item.getItemById(pObjectUID).iconId + ".swf");
         var objectEntity:IInteractive = new RoleplayObjectEntity(pObjectUID,MapPoint.fromCellId(pCellId));
         (objectEntity as IDisplayable).display();
         var groundObject:GameContextActorInformations = new GroundObject(Item.getItemById(pObjectUID));
         groundObject.contextualId = objectEntity.id;
         groundObject.disposition.cellId = pCellId;
         groundObject.disposition.direction = DirectionsEnum.DOWN_RIGHT;
         if(this._objects == null)
         {
            this._objects = new Dictionary();
         }
         this._objects[objectUri] = objectEntity;
         this._objectsByCellId[pCellId] = this._objects[objectUri];
         _entities[objectEntity.id] = groundObject;
         this._loader.load(objectUri,null,null,true);
      }
      
      private function removeObject(pCellId:uint) : void {
         if(this._objectsByCellId[pCellId] != null)
         {
            if(this._objects[this._objectsByCellId[pCellId]] != null)
            {
               delete this._objects[[this._objectsByCellId[pCellId]]];
            }
            if(_entities[this._objectsByCellId[pCellId].id] != null)
            {
               delete _entities[[this._objectsByCellId[pCellId].id]];
            }
            (this._objectsByCellId[pCellId] as IDisplayable).remove();
            delete this._objectsByCellId[[pCellId]];
         }
      }
      
      private function updateFight(fightId:uint, team:FightTeamInformations) : void {
         var newMember:FightTeamMemberInformations = null;
         var present:* = false;
         var teamMember:FightTeamMemberInformations = null;
         var fight:Fight = this._fights[fightId];
         if(fight == null)
         {
            return;
         }
         var fightTeam:FightTeam = fight.getTeamById(team.teamId);
         var tInfo:FightTeamInformations = (_entities[fightTeam.teamEntity.id] as FightTeam).teamInfos;
         if(tInfo.teamMembers == team.teamMembers)
         {
            return;
         }
         for each (newMember in team.teamMembers)
         {
            present = false;
            for each (teamMember in tInfo.teamMembers)
            {
               if(teamMember.id == newMember.id)
               {
                  present = true;
               }
            }
            if(!present)
            {
               tInfo.teamMembers.push(newMember);
            }
         }
      }
      
      private function removeFighter(fightId:uint, teamId:uint, charId:int) : void {
         var fightTeam:FightTeam = null;
         var teamInfos:FightTeamInformations = null;
         var newMembers:Vector.<FightTeamMemberInformations> = null;
         var member:FightTeamMemberInformations = null;
         var fight:Fight = this._fights[fightId];
         if(fight)
         {
            fightTeam = fight.teams[teamId];
            teamInfos = fightTeam.teamInfos;
            newMembers = new Vector.<FightTeamMemberInformations>(0,false);
            for each (member in teamInfos.teamMembers)
            {
               if(member.id != charId)
               {
                  newMembers.push(member);
               }
            }
            teamInfos.teamMembers = newMembers;
         }
      }
      
      private function removeFight(fightId:uint) : void {
         var team:FightTeam = null;
         var entity:Object = null;
         var fight:Fight = this._fights[fightId];
         if(fight == null)
         {
            return;
         }
         for each (team in fight.teams)
         {
            entity = _entities[team.teamEntity.id];
            Kernel.getWorker().process(new EntityMouseOutMessage(team.teamEntity as IInteractive));
            (team.teamEntity as IDisplayable).remove();
            TooltipManager.hide("fightOptions_" + fightId + "_" + team.teamInfos.teamId);
            delete _entities[[team.teamEntity.id]];
         }
         delete this._fights[[fightId]];
      }
      
      private function addPaddockItem(item:PaddockItem) : void {
         var contextualId:* = 0;
         var i:Item = Item.getItemById(item.objectGID);
         if(this._paddockItem[item.cellId])
         {
            contextualId = (this._paddockItem[item.cellId] as IEntity).id;
         }
         else
         {
            contextualId = EntitiesManager.getInstance().getFreeEntityId();
         }
         var gcpii:GameContextPaddockItemInformations = new GameContextPaddockItemInformations(contextualId,i.appearance,item.cellId,item.durability,i);
         var e:IEntity = this.addOrUpdateActor(gcpii);
         this._paddockItem[item.cellId] = e;
      }
      
      private function removePaddockItem(cellId:uint) : void {
         var e:IEntity = this._paddockItem[cellId];
         if(!e)
         {
            return;
         }
         (e as IDisplayable).remove();
         delete this._paddockItem[[cellId]];
      }
      
      private function activatePaddockItem(cellId:uint) : void {
         var seq:SerialSequencer = null;
         var item:TiphonSprite = this._paddockItem[cellId];
         if(item)
         {
            seq = new SerialSequencer();
            seq.addStep(new PlayAnimationStep(item,AnimationEnum.ANIM_HIT));
            seq.addStep(new PlayAnimationStep(item,AnimationEnum.ANIM_STATIQUE));
            seq.start();
         }
      }
      
      private function onFightEntityRendered(event:TiphonEvent) : void {
         if((!_entities) || (!event.target))
         {
            return;
         }
         var fightTeam:FightTeam = _entities[event.target.id];
         if((fightTeam) && (fightTeam.fight) && (fightTeam.teamInfos))
         {
            this.updateSwordOptions(fightTeam.fight.fightId,fightTeam.teamInfos.teamId);
         }
      }
      
      private function updateSwordOptions(fightId:uint, teamId:uint, option:int=-1, state:Boolean=false) : void {
         var opt:* = undefined;
         var fight:Fight = this._fights[fightId];
         if(fight == null)
         {
            return;
         }
         var fightTeam:FightTeam = fight.teams[teamId];
         if(fightTeam == null)
         {
            return;
         }
         if(option != -1)
         {
            fightTeam.teamOptions[option] = state;
         }
         var textures:Vector.<String> = new Vector.<String>();
         for (opt in fightTeam.teamOptions)
         {
            if(fightTeam.teamOptions[opt])
            {
               textures.push("fightOption" + opt);
            }
         }
         if(fightTeam.hasGroupMember())
         {
            textures.push("fightOption4");
         }
         TooltipManager.show(textures,(fightTeam.teamEntity as IDisplayable).absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"fightOptions_" + fightId + "_" + teamId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,"texturesList",null,null,null,false,0,Atouin.getInstance().currentZoom,false);
      }
      
      private function paddockCellValidator(cellId:int) : Boolean {
         var infos:GameContextActorInformations = null;
         var entity:IEntity = EntitiesManager.getInstance().getEntityOnCell(cellId);
         if(entity)
         {
            infos = getEntityInfos(entity.id);
            if(infos is GameContextPaddockItemInformations)
            {
               return false;
            }
         }
         return (DataMapProvider.getInstance().farmCell(MapPoint.fromCellId(cellId).x,MapPoint.fromCellId(cellId).y)) && (DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(cellId).x,MapPoint.fromCellId(cellId).y,true));
      }
      
      private function removeEntityListeners(pEntityId:int) : void {
         var rider:TiphonSprite = null;
         var ts:TiphonSprite = DofusEntities.getEntity(pEntityId) as TiphonSprite;
         if(ts)
         {
            ts.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            rider = ts.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
            if(rider)
            {
               rider.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
            }
            ts.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
         }
      }
      
      private function updateUsableEmotesListInit(pLook:TiphonEntityLook) : void {
         var realEntityLook:TiphonEntityLook = null;
         var bonesToLoad:Array = null;
         if((_entities) && (_entities[PlayedCharacterManager.getInstance().id]))
         {
            realEntityLook = EntityLookAdapter.fromNetwork((_entities[PlayedCharacterManager.getInstance().id] as GameContextActorInformations).look);
         }
         if(((_creaturesMode) || (_creaturesFightMode)) && (realEntityLook))
         {
            bonesToLoad = TiphonMultiBonesManager.getInstance().getAllBonesFromLook(realEntityLook);
            TiphonMultiBonesManager.getInstance().forceBonesLoading(bonesToLoad,new Callback(this.updateUsableEmotesList,realEntityLook));
         }
         else
         {
            this.updateUsableEmotesList(pLook);
         }
      }
      
      private function updateUsableEmotesList(pLook:TiphonEntityLook) : void {
         var emote:EmoteWrapper = null;
         var animName:String = null;
         var emoteAvailable:* = false;
         var subCat:String = null;
         var subIndex:String = null;
         var sw:ShortcutWrapper = null;
         var emoteIndex:* = 0;
         var isGhost:Boolean = PlayedCharacterManager.getInstance().isGhost;
         var rpEmoticonFrame:EmoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
         var emotes:Array = rpEmoticonFrame.emotesList;
         var subEntities:Array = pLook.getSubEntities();
         var updateShortcutsBar:Boolean = false;
         this._usableEmotes = new Array();
         var boneToTest:uint = pLook.getBone();
         for each (emote in emotes)
         {
            emoteAvailable = false;
            if((emote) && (emote.emote))
            {
               animName = emote.emote.getAnimName(pLook);
               if((emote.emote.aura) && (!isGhost) || (Tiphon.skullLibrary.hasAnim(pLook.getBone(),animName)))
               {
                  emoteAvailable = true;
               }
               else
               {
                  if(subEntities)
                  {
                     for (subCat in subEntities)
                     {
                        for (subIndex in subEntities[subCat])
                        {
                           if(Tiphon.skullLibrary.hasAnim(subEntities[subCat][subIndex].getBone(),animName))
                           {
                              emoteAvailable = true;
                              break;
                           }
                        }
                        if(emoteAvailable)
                        {
                           break;
                        }
                     }
                  }
               }
               emoteIndex = rpEmoticonFrame.emotes.indexOf(emote.id);
               for each (sw in InventoryManager.getInstance().shortcutBarItems)
               {
                  if(((sw) && (sw.type == 4)) && (sw.id == emote.id) && (!(sw.active == emoteAvailable)))
                  {
                     sw.active = emoteAvailable;
                     updateShortcutsBar = true;
                     break;
                  }
               }
               if(emoteAvailable)
               {
                  this._usableEmotes.push(emote.id);
                  if(emoteIndex == -1)
                  {
                     rpEmoticonFrame.emotes.push(emote.id);
                  }
               }
               else
               {
                  if(emoteIndex != -1)
                  {
                     rpEmoticonFrame.emotes.splice(emoteIndex,1);
                  }
               }
            }
         }
         KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteUnabledListUpdated,this._usableEmotes);
         if(updateShortcutsBar)
         {
            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
         }
      }
      
      private function onEntityReadyForEmote(pEvent:TiphonEvent) : void {
         var entity:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         entity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
         if(this._playersId.indexOf(entity.id) != -1)
         {
            this.process(this._waitingEmotesAnims[entity.id]);
         }
         delete this._waitingEmotesAnims[[entity.id]];
      }
      
      private function onAnimationAdded(e:TiphonEvent) : void {
         var name:String = null;
         var vsa:Vector.<SoundAnimation> = null;
         var sa:SoundAnimation = null;
         var dataSoundLabel:String = null;
         var entity:TiphonSprite = e.currentTarget as TiphonSprite;
         entity.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
         var animation:TiphonAnimation = entity.rawAnimation;
         var soundBones:SoundBones = SoundBones.getSoundBonesById(entity.look.getBone());
         if(soundBones)
         {
            name = getQualifiedClassName(animation);
            vsa = soundBones.getSoundAnimations(name);
            animation.spriteHandler.tiphonEventManager.removeEvents(TiphonEventsManager.BALISE_SOUND,name);
            for each (sa in vsa)
            {
               dataSoundLabel = TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN + ((!(sa.label == null)) && (!(sa.label == "null"))?sa.label:"") + TiphonEventsManager.BALISE_PARAM_END;
               animation.spriteHandler.tiphonEventManager.addEvent(dataSoundLabel,sa.startFrame,name);
            }
         }
      }
      
      private function onGroundObjectLoaded(e:ResourceLoadedEvent) : void {
         var objectMc:MovieClip = e.resource;
         objectMc.x = objectMc.x - objectMc.width / 2;
         objectMc.y = objectMc.y - objectMc.height / 2;
         if(this._objects[e.uri])
         {
            this._objects[e.uri].addChild(objectMc);
         }
      }
      
      private function onGroundObjectLoadFailed(e:ResourceErrorEvent) : void {
         trace("l\'objet au sol n\'a pas pu être chargé / uri : " + e.uri);
      }
      
      public function timeoutStop(character:AnimatedCharacter) : void {
         clearTimeout(this._timeout);
         character.setAnimation(AnimationEnum.ANIM_STATIQUE);
         this._currentEmoticon = 0;
      }
      
      override public function onPlayAnim(e:TiphonEvent) : void {
         var animsRandom:Array = new Array();
         var tempStr:String = e.params.substring(6,e.params.length - 1);
         animsRandom = tempStr.split(",");
         var whichAnim:int = this._emoteTimesBySprite[(e.currentTarget as TiphonSprite).name] % animsRandom.length;
         e.sprite.setAnimation(animsRandom[whichAnim]);
      }
      
      private function onAnimationEnd(e:TiphonEvent) : void {
         var statiqueAnim:String = null;
         var animNam:String = null;
         var tiphonSprite:TiphonSprite = e.currentTarget as TiphonSprite;
         tiphonSprite.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         var subEnt:Object = tiphonSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(subEnt != null)
         {
            animNam = subEnt.getAnimation();
            if(animNam.indexOf("_") == -1)
            {
               animNam = tiphonSprite.getAnimation();
            }
         }
         else
         {
            animNam = tiphonSprite.getAnimation();
         }
         if(animNam.indexOf("_Statique_") == -1)
         {
            statiqueAnim = animNam.replace("_","_Statique_");
         }
         else
         {
            statiqueAnim = animNam;
         }
         if((tiphonSprite.hasAnimation(statiqueAnim,tiphonSprite.getDirection())) || ((subEnt) && (subEnt is TiphonSprite)) && (TiphonSprite(subEnt).hasAnimation(statiqueAnim,TiphonSprite(subEnt).getDirection())))
         {
            tiphonSprite.setAnimation(statiqueAnim);
         }
         else
         {
            tiphonSprite.setAnimation(AnimationEnum.ANIM_STATIQUE);
            this._currentEmoticon = 0;
         }
      }
      
      private function onPlayerSpriteInit(pEvent:TiphonEvent) : void {
         var currentLook:TiphonEntityLook = (pEvent.sprite as TiphonSprite).look;
         if(pEvent.params == currentLook.getBone())
         {
            pEvent.sprite.removeEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
            this.updateUsableEmotesListInit(currentLook);
         }
      }
      
      private function onCellPointed(success:Boolean, cellId:uint, entityId:int) : void {
         var m:PaddockMoveItemRequestMessage = null;
         if(success)
         {
            m = new PaddockMoveItemRequestMessage();
            m.initPaddockMoveItemRequestMessage(this._currentPaddockItemCellId,cellId);
            ConnectionsHandler.getConnection().send(m);
         }
      }
      
      private function updateConquestIcons(pPlayersIds:*) : void {
         var playerId:* = 0;
         var infos:GameRolePlayHumanoidInformations = null;
         var option:* = undefined;
         if((pPlayersIds is Vector.<uint>) && ((pPlayersIds as Vector.<uint>).length > 0))
         {
            for each (playerId in pPlayersIds)
            {
               infos = getEntityInfos(playerId) as GameRolePlayHumanoidInformations;
               if(infos)
               {
                  for each (option in infos.humanoidInfo.options)
                  {
                     if(option is HumanOptionAlliance)
                     {
                        this.addConquestIcon(infos.contextualId,option as HumanOptionAlliance);
                        break;
                     }
                  }
               }
            }
         }
         else
         {
            if(pPlayersIds is int)
            {
               infos = getEntityInfos(pPlayersIds) as GameRolePlayHumanoidInformations;
               if(infos)
               {
                  for each (option in infos.humanoidInfo.options)
                  {
                     if(option is HumanOptionAlliance)
                     {
                        this.addConquestIcon(infos.contextualId,option as HumanOptionAlliance);
                        break;
                     }
                  }
               }
            }
         }
      }
      
      private function addConquestIcon(pEntityId:int, pHumanOptionAlliance:HumanOptionAlliance) : void {
         var prismInfo:PrismSubAreaWrapper = null;
         var playerConqueststatus:String = null;
         var iconsNames:Vector.<String> = null;
         var iconName:String = null;
         if(((((!(PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.NON_AGGRESSABLE)) && (this._allianceFrame)) && (this._allianceFrame.hasAlliance)) && (!(pHumanOptionAlliance.aggressable == AggressableStatusEnum.NON_AGGRESSABLE))) && (!(pHumanOptionAlliance.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE)) && (!(pHumanOptionAlliance.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE)))
         {
            prismInfo = this._allianceFrame.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id);
            if((prismInfo) && (prismInfo.state == PrismStateEnum.PRISM_STATE_VULNERABLE))
            {
               switch(pHumanOptionAlliance.aggressable)
               {
                  case AggressableStatusEnum.AvA_DISQUALIFIED:
                     if(pEntityId == PlayedCharacterManager.getInstance().id)
                     {
                        playerConqueststatus = "neutral";
                     }
                     break;
                  case AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE:
                     if(pEntityId == PlayedCharacterManager.getInstance().id)
                     {
                        playerConqueststatus = "clock";
                     }
                     else
                     {
                        playerConqueststatus = this.getPlayerConquestStatus(pEntityId,pHumanOptionAlliance.allianceInformations.allianceId,prismInfo.alliance.allianceId);
                     }
                     break;
                  case AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE:
                     playerConqueststatus = this.getPlayerConquestStatus(pEntityId,pHumanOptionAlliance.allianceInformations.allianceId,prismInfo.alliance.allianceId);
                     break;
               }
               if(playerConqueststatus)
               {
                  iconsNames = this.getIconNamesByCategory(pEntityId,EntityIconEnum.AVA_CATEGORY);
                  if((iconsNames) && (!(iconsNames[0] == playerConqueststatus)))
                  {
                     iconName = iconsNames[0];
                     iconsNames.length = 0;
                     this.removeIcon(pEntityId,iconName);
                  }
                  this.addEntityIcon(pEntityId,playerConqueststatus,EntityIconEnum.AVA_CATEGORY);
               }
            }
         }
         if((!playerConqueststatus) && (this._entitiesIconsNames[pEntityId]) && (this._entitiesIconsNames[pEntityId][EntityIconEnum.AVA_CATEGORY]))
         {
            this.removeIconsCategory(pEntityId,EntityIconEnum.AVA_CATEGORY);
         }
      }
      
      private function getPlayerConquestStatus(pPlayerId:int, pPlayerAllianceId:int, pPrismAllianceId:int) : String {
         var status:String = null;
         if((pPlayerId == PlayedCharacterManager.getInstance().id) || (this._allianceFrame.alliance.allianceId == pPlayerAllianceId))
         {
            status = "ownTeam";
         }
         else
         {
            if(pPlayerAllianceId == pPrismAllianceId)
            {
               status = "defender";
            }
            else
            {
               status = "forward";
            }
         }
         return status;
      }
      
      public function addEntityIcon(pEntityId:int, pIconName:String, pIconCategory:int=0) : void {
         if(!this._entitiesIconsNames[pEntityId])
         {
            this._entitiesIconsNames[pEntityId] = new Dictionary();
         }
         if(!this._entitiesIconsNames[pEntityId][pIconCategory])
         {
            this._entitiesIconsNames[pEntityId][pIconCategory] = new Vector.<String>(0);
         }
         if(this._entitiesIconsNames[pEntityId][pIconCategory].indexOf(pIconName) == -1)
         {
            this._entitiesIconsNames[pEntityId][pIconCategory].push(pIconName);
         }
         if(this._entitiesIcons[pEntityId])
         {
            this._entitiesIcons[pEntityId].needUpdate = true;
         }
      }
      
      public function updateAllIcons() : void {
         this._updateAllIcons = true;
         this.showIcons();
      }
      
      public function forceIconUpdate(pEntityId:int) : void {
         this._entitiesIcons[pEntityId].needUpdate = true;
      }
      
      private function removeAllIcons() : void {
         var id:* = undefined;
         for (id in this._entitiesIconsNames)
         {
            delete this._entitiesIconsNames[[id]];
            this.removeIcon(id);
         }
      }
      
      public function removeIcon(pEntityId:int, pIconName:String=null) : void {
         var entity:AnimatedCharacter = DofusEntities.getEntity(pEntityId) as AnimatedCharacter;
         if(entity)
         {
            entity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
         }
         if(this._entitiesIcons[pEntityId])
         {
            if(!pIconName)
            {
               this._entitiesIcons[pEntityId].remove();
               delete this._entitiesIcons[[pEntityId]];
            }
            else
            {
               this._entitiesIcons[pEntityId].removeIcon(pIconName);
            }
         }
      }
      
      public function getIconNamesByCategory(pEntityId:int, pIconCategory:int) : Vector.<String> {
         var iconNames:Vector.<String> = null;
         if((this._entitiesIconsNames[pEntityId]) && (this._entitiesIconsNames[pEntityId][pIconCategory]))
         {
            iconNames = this._entitiesIconsNames[pEntityId][pIconCategory];
         }
         return iconNames;
      }
      
      public function removeIconsCategory(pEntityId:int, pIconCategory:int) : void {
         var iconName:String = null;
         if((this._entitiesIconsNames[pEntityId]) && (this._entitiesIconsNames[pEntityId][pIconCategory]))
         {
            if(this._entitiesIcons[pEntityId])
            {
               for each (iconName in this._entitiesIconsNames[pEntityId][pIconCategory])
               {
                  this._entitiesIcons[pEntityId].removeIcon(iconName);
               }
            }
            delete this._entitiesIconsNames[pEntityId][[pIconCategory]];
            if((this._entitiesIcons[pEntityId]) && (this._entitiesIcons[pEntityId].length == 0))
            {
               delete this._entitiesIconsNames[[pEntityId]];
               this.removeIcon(pEntityId);
            }
         }
      }
      
      public function hasIcon(pEntityId:int, pIconName:String=null) : Boolean {
         return this._entitiesIcons[pEntityId]?pIconName?this._entitiesIcons[pEntityId].hasIcon(pIconName):true:false;
      }
      
      private function showIcons(pEvent:Event=null) : void {
         var entityId:* = undefined;
         var head:DisplayObject = null;
         var entity:AnimatedCharacter = null;
         var targetBounds:IRectangle = null;
         var r1:Rectangle = null;
         var r2:Rectangle2 = null;
         var ei:EntityIcon = null;
         var icon:Texture = null;
         var tiphonspr:TiphonSprite = null;
         var foot:DisplayObject = null;
         var iconCat:* = undefined;
         var iconName:String = null;
         var newIcons:* = false;
         for (entityId in this._entitiesIconsNames)
         {
            entity = DofusEntities.getEntity(entityId) as AnimatedCharacter;
            if(!entity)
            {
               delete this._entitiesIconsNames[[entityId]];
               if(this._entitiesIcons[entityId])
               {
                  this.removeIcon(entityId);
               }
            }
            else
            {
               targetBounds = null;
               if((this._updateAllIcons) || (entity.isMoving) || (!this._entitiesIcons[entityId]) || (this._entitiesIcons[entityId].needUpdate))
               {
                  if((this._entitiesIcons[entityId]) && (this._entitiesIcons[entityId].rendering))
                  {
                     continue;
                  }
                  tiphonspr = entity as TiphonSprite;
                  if((entity.getSubEntitySlot(2,0)) && (!this.isCreatureMode))
                  {
                     tiphonspr = entity.getSubEntitySlot(2,0) as TiphonSprite;
                  }
                  head = tiphonspr.getSlot("Tete");
                  if(head)
                  {
                     r1 = head.getBounds(StageShareManager.stage);
                     r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
                     targetBounds = r2;
                     if(targetBounds.y - 30 - 10 < 0)
                     {
                        foot = tiphonspr.getSlot("Pied");
                        if(foot)
                        {
                           r1 = foot.getBounds(StageShareManager.stage);
                           r2 = new Rectangle2(r1.x,r1.y + targetBounds.height + 30,r1.width,r1.height);
                           targetBounds = r2;
                        }
                     }
                  }
                  else
                  {
                     if(tiphonspr is IDisplayable)
                     {
                        targetBounds = (tiphonspr as IDisplayable).absoluteBounds;
                     }
                     else
                     {
                        r1 = tiphonspr.getBounds(StageShareManager.stage);
                        r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
                        targetBounds = r2;
                     }
                     if(targetBounds.y - 30 - 10 < 0)
                     {
                        targetBounds.y = targetBounds.y + (targetBounds.height + 30);
                     }
                  }
               }
               if(targetBounds)
               {
                  ei = this._entitiesIcons[entityId];
                  if(!ei)
                  {
                     this._entitiesIcons[entityId] = new EntityIcon();
                     ei = this._entitiesIcons[entityId];
                     this._entitiesIconsContainer.addChild(ei);
                  }
                  newIcons = false;
                  for (iconCat in this._entitiesIconsNames[entityId])
                  {
                     for each (iconName in this._entitiesIconsNames[entityId][iconCat])
                     {
                        if(!ei.hasIcon(iconName))
                        {
                           newIcons = true;
                           ei.addIcon(ICONS_FILEPATH + "|" + iconName,iconName);
                        }
                     }
                  }
                  if(!newIcons)
                  {
                     if((this._entitiesIcons[entityId].needUpdate) && (!entity.isMoving) && (entity.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == 0))
                     {
                        this._entitiesIcons[entityId].needUpdate = false;
                     }
                     if(ei.scaleX != Atouin.getInstance().rootContainer.scaleX)
                     {
                        ei.scaleX = Atouin.getInstance().rootContainer.scaleX;
                     }
                     if(ei.scaleY != Atouin.getInstance().rootContainer.scaleY)
                     {
                        ei.scaleY = Atouin.getInstance().rootContainer.scaleY;
                     }
                     if(entity.rendered)
                     {
                        ei.x = targetBounds.x + targetBounds.width / 2 - ei.width / 2;
                        ei.y = targetBounds.y - 10;
                     }
                     else
                     {
                        ei.rendering = true;
                        entity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
                        entity.addEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
                     }
                  }
               }
            }
         }
         this._updateAllIcons = false;
      }
      
      private function updateIconAfterRender(pEvent:TiphonEvent) : void {
         var entity:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         entity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
         if(this._entitiesIcons[entity.id])
         {
            this._entitiesIcons[entity.id].rendering = false;
            this._entitiesIcons[entity.id].needUpdate = true;
         }
      }
      
      private function onTiphonPropertyChanged(event:PropertyChangeEvent) : void {
         if((event.propertyName == "auraMode") && (!(event.propertyOldValue == event.propertyValue)))
         {
            if(this._auraCycleTimer.running)
            {
               this._auraCycleTimer.removeEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
               this._auraCycleTimer.stop();
            }
            switch(event.propertyValue)
            {
               case OptionEnum.AURA_CYCLE:
                  this._auraCycleTimer.addEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
                  this._auraCycleTimer.start();
                  this.setEntitiesAura(false);
                  break;
               case OptionEnum.AURA_ON_ROLLOVER:
               case OptionEnum.AURA_NONE:
                  this.setEntitiesAura(false);
                  break;
               case OptionEnum.AURA_ALWAYS:
                  this.setEntitiesAura(true);
                  break;
            }
         }
      }
      
      private function onAuraCycleTimer(event:TimerEvent) : void {
         var firstEntityWithAuraIndex:* = 0;
         var firstEntityWithAura:AnimatedCharacter = null;
         var nextEntityWithAura:AnimatedCharacter = null;
         var entity:AnimatedCharacter = null;
         var entitiesIdsList:Vector.<int> = getEntitiesIdsList();
         if(this._auraCycleIndex >= entitiesIdsList.length)
         {
            this._auraCycleIndex = 0;
         }
         var l:int = entitiesIdsList.length;
         var i:int = 0;
         while(i < l)
         {
            entity = DofusEntities.getEntity(entitiesIdsList[i]) as AnimatedCharacter;
            if(entity)
            {
               if((!firstEntityWithAura) && (entity.hasAura) && (entity.getDirection() == DirectionsEnum.DOWN))
               {
                  firstEntityWithAura = entity;
                  firstEntityWithAuraIndex = i;
               }
               if((i == this._auraCycleIndex) && (entity.hasAura) && (entity.getDirection() == DirectionsEnum.DOWN))
               {
                  nextEntityWithAura = entity;
                  break;
               }
               if(!entity.hasAura)
               {
                  this._auraCycleIndex++;
               }
            }
            i++;
         }
         if(this._lastEntityWithAura)
         {
            this._lastEntityWithAura.visibleAura = false;
         }
         if(nextEntityWithAura)
         {
            nextEntityWithAura.visibleAura = true;
            this._lastEntityWithAura = nextEntityWithAura;
         }
         else
         {
            if((!nextEntityWithAura) && (firstEntityWithAura))
            {
               firstEntityWithAura.visibleAura = true;
               this._lastEntityWithAura = firstEntityWithAura;
               this._auraCycleIndex = firstEntityWithAuraIndex;
            }
         }
         this._auraCycleIndex++;
      }
      
      private function setEntitiesAura(visible:Boolean) : void {
         var entity:AnimatedCharacter = null;
         var entitiesIdsList:Vector.<int> = getEntitiesIdsList();
         var i:int = 0;
         while(i < entitiesIdsList.length)
         {
            entity = DofusEntities.getEntity(entitiesIdsList[i]) as AnimatedCharacter;
            if(entity)
            {
               entity.visibleAura = visible;
            }
            i++;
         }
      }
   }
}
