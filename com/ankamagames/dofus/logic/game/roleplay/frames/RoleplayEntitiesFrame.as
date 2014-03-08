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
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupInformations;
   import com.ankamagames.dofus.network.types.game.look.IndexedEntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcWithQuestInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionFollowers;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
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
   import __AS3__.vec.*;
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
      
      public function set currentEmoticon(param1:uint) : void {
         this._currentEmoticon = param1;
      }
      
      public function get dispatchPlayerNewLook() : Boolean {
         return this._dispatchPlayerNewLook;
      }
      
      public function set dispatchPlayerNewLook(param1:Boolean) : void {
         this._dispatchPlayerNewLook = param1;
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
         var _loc1_:MapInformationsRequestMessage = null;
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
            _loc1_ = new MapInformationsRequestMessage();
            _loc1_.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
            ConnectionsHandler.getConnection().send(_loc1_);
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
      
      override public function process(param1:Message) : Boolean {
         var _loc2_:AnimatedCharacter = null;
         var _loc3_:MapComplementaryInformationsDataMessage = null;
         var _loc4_:SubArea = null;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = 0;
         var _loc8_:* = NaN;
         var _loc9_:InteractiveMapUpdateMessage = null;
         var _loc10_:StatedMapUpdateMessage = null;
         var _loc11_:HouseInformations = null;
         var _loc12_:GameRolePlayShowActorMessage = null;
         var _loc13_:GameContextRefreshEntityLookMessage = null;
         var _loc14_:GameMapChangeOrientationMessage = null;
         var _loc15_:GameMapChangeOrientationsMessage = null;
         var _loc16_:* = 0;
         var _loc17_:GameRolePlaySetAnimationMessage = null;
         var _loc18_:AnimatedCharacter = null;
         var _loc19_:EntityMovementCompleteMessage = null;
         var _loc20_:AnimatedCharacter = null;
         var _loc21_:EntityMovementStoppedMessage = null;
         var _loc22_:CharacterMovementStoppedMessage = null;
         var _loc23_:AnimatedCharacter = null;
         var _loc24_:GameRolePlayShowChallengeMessage = null;
         var _loc25_:GameFightOptionStateUpdateMessage = null;
         var _loc26_:GameFightUpdateTeamMessage = null;
         var _loc27_:GameFightRemoveTeamMemberMessage = null;
         var _loc28_:GameRolePlayRemoveChallengeMessage = null;
         var _loc29_:GameContextRemoveElementMessage = null;
         var _loc30_:uint = 0;
         var _loc31_:* = 0;
         var _loc32_:MapFightCountMessage = null;
         var _loc33_:UpdateMapPlayersAgressableStatusMessage = null;
         var _loc34_:* = 0;
         var _loc35_:* = 0;
         var _loc36_:GameRolePlayHumanoidInformations = null;
         var _loc37_:* = undefined;
         var _loc38_:UpdateSelfAgressableStatusMessage = null;
         var _loc39_:GameRolePlayHumanoidInformations = null;
         var _loc40_:* = undefined;
         var _loc41_:ObjectGroundAddedMessage = null;
         var _loc42_:ObjectGroundRemovedMessage = null;
         var _loc43_:ObjectGroundRemovedMultipleMessage = null;
         var _loc44_:ObjectGroundListAddedMessage = null;
         var _loc45_:uint = 0;
         var _loc46_:PaddockRemoveItemRequestAction = null;
         var _loc47_:PaddockRemoveItemRequestMessage = null;
         var _loc48_:PaddockMoveItemRequestAction = null;
         var _loc49_:Texture = null;
         var _loc50_:ItemWrapper = null;
         var _loc51_:GameDataPaddockObjectRemoveMessage = null;
         var _loc52_:RoleplayContextFrame = null;
         var _loc53_:GameDataPaddockObjectAddMessage = null;
         var _loc54_:GameDataPaddockObjectListAddMessage = null;
         var _loc55_:GameDataPlayFarmObjectAnimationMessage = null;
         var _loc56_:MapNpcsQuestStatusUpdateMessage = null;
         var _loc57_:ShowCellMessage = null;
         var _loc58_:RoleplayContextFrame = null;
         var _loc59_:String = null;
         var _loc60_:String = null;
         var _loc61_:StartZoomAction = null;
         var _loc62_:DisplayObject = null;
         var _loc63_:SwitchCreatureModeAction = null;
         var _loc64_:MapInformationsRequestMessage = null;
         var _loc65_:MapComplementaryInformationsWithCoordsMessage = null;
         var _loc66_:MapComplementaryInformationsDataInHouseMessage = null;
         var _loc67_:* = false;
         var _loc68_:GameRolePlayActorInformations = null;
         var _loc69_:GameRolePlayActorInformations = null;
         var _loc70_:AnimatedCharacter = null;
         var _loc71_:GameRolePlayCharacterInformations = null;
         var _loc72_:* = undefined;
         var _loc73_:DelayedActionMessage = null;
         var _loc74_:Emoticon = null;
         var _loc75_:* = false;
         var _loc76_:Date = null;
         var _loc77_:TiphonEntityLook = null;
         var _loc78_:GameRolePlaySetAnimationMessage = null;
         var _loc79_:FightCommonInformations = null;
         var _loc80_:HouseInformations = null;
         var _loc81_:HouseWrapper = null;
         var _loc82_:* = 0;
         var _loc83_:* = 0;
         var _loc84_:HousePropertiesMessage = null;
         var _loc85_:MapObstacle = null;
         var _loc86_:GameRolePlayCharacterInformations = null;
         var _loc87_:* = 0;
         var _loc88_:ActorOrientation = null;
         var _loc89_:TiphonSprite = null;
         var _loc90_:Emoticon = null;
         var _loc91_:EmoticonFrame = null;
         var _loc92_:uint = 0;
         var _loc93_:Emoticon = null;
         var _loc94_:EmotePlayRequestMessage = null;
         var _loc95_:uint = 0;
         var _loc96_:uint = 0;
         var _loc97_:uint = 0;
         var _loc98_:PaddockItem = null;
         var _loc99_:uint = 0;
         var _loc100_:TiphonSprite = null;
         var _loc101_:Sprite = null;
         var _loc102_:* = 0;
         var _loc103_:* = 0;
         var _loc104_:Quest = null;
         var _loc105_:Rectangle = null;
         var _loc106_:* = undefined;
         var _loc107_:* = undefined;
         var _loc108_:FightTeam = null;
         switch(true)
         {
            case param1 is MapLoadedMessage:
               if(this._waitForMap)
               {
                  _loc64_ = new MapInformationsRequestMessage();
                  _loc64_.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                  ConnectionsHandler.getConnection().send(_loc64_);
                  this._waitForMap = false;
               }
               return false;
            case param1 is MapComplementaryInformationsDataMessage:
               _loc3_ = param1 as MapComplementaryInformationsDataMessage;
               this.initNewMap();
               _interactiveElements = _loc3_.interactiveElements;
               this._fightNumber = _loc3_.fights.length;
               if(param1 is MapComplementaryInformationsWithCoordsMessage)
               {
                  _loc65_ = param1 as MapComplementaryInformationsWithCoordsMessage;
                  if(PlayedCharacterManager.getInstance().isInHouse)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                  }
                  PlayedCharacterManager.getInstance().isInHouse = false;
                  PlayedCharacterManager.getInstance().isInHisHouse = false;
                  PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(_loc65_.worldX,_loc65_.worldY);
                  _worldPoint = new WorldPointWrapper(_loc65_.mapId,true,_loc65_.worldX,_loc65_.worldY);
               }
               else
               {
                  if(param1 is MapComplementaryInformationsDataInHouseMessage)
                  {
                     _loc66_ = param1 as MapComplementaryInformationsDataInHouseMessage;
                     _loc67_ = PlayerManager.getInstance().nickname == _loc66_.currentHouse.ownerName;
                     PlayedCharacterManager.getInstance().isInHouse = true;
                     if(_loc67_)
                     {
                        PlayedCharacterManager.getInstance().isInHisHouse = true;
                     }
                     PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(_loc66_.currentHouse.worldX,_loc66_.currentHouse.worldY);
                     KernelEventsManager.getInstance().processCallback(HookList.HouseEntered,_loc67_,_loc66_.currentHouse.ownerId,_loc66_.currentHouse.ownerName,_loc66_.currentHouse.price,_loc66_.currentHouse.isLocked,_loc66_.currentHouse.worldX,_loc66_.currentHouse.worldY,HouseWrapper.manualCreate(_loc66_.currentHouse.modelId,-1,_loc66_.currentHouse.ownerName,!(_loc66_.currentHouse.price == 0)));
                     _worldPoint = new WorldPointWrapper(_loc66_.mapId,true,_loc66_.currentHouse.worldX,_loc66_.currentHouse.worldY);
                  }
                  else
                  {
                     _worldPoint = new WorldPointWrapper(_loc3_.mapId);
                     if(PlayedCharacterManager.getInstance().isInHouse)
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                     }
                     PlayedCharacterManager.getInstance().isInHouse = false;
                     PlayedCharacterManager.getInstance().isInHisHouse = false;
                  }
               }
               _currentSubAreaId = _loc3_.subAreaId;
               _loc4_ = SubArea.getSubAreaById(_currentSubAreaId);
               PlayedCharacterManager.getInstance().currentMap = _worldPoint;
               PlayedCharacterManager.getInstance().currentSubArea = _loc4_;
               TooltipManager.hide();
               updateCreaturesLimit();
               _loc5_ = false;
               for each (_loc68_ in _loc3_.actors)
               {
                  _humanNumber++;
                  if(_creaturesLimit == 0 || _creaturesLimit < 50 && _humanNumber >= _creaturesLimit)
                  {
                     _creaturesMode = true;
                  }
                  if((_loc68_.contextualId > 0) && (this._playersId) && this._playersId.indexOf(_loc68_.contextualId) == -1)
                  {
                     this._playersId.push(_loc68_.contextualId);
                  }
                  if(_loc68_ is GameRolePlayGroupMonsterInformations && this._monstersIds.indexOf(_loc68_.contextualId) == -1)
                  {
                     this._monstersIds.push(_loc68_.contextualId);
                  }
               }
               _loc6_ = true;
               _loc7_ = 0;
               _loc8_ = 0;
               for each (_loc69_ in _loc3_.actors)
               {
                  _loc70_ = this.addOrUpdateActor(_loc69_) as AnimatedCharacter;
                  if(_loc70_)
                  {
                     if(_loc70_.id == PlayedCharacterManager.getInstance().id)
                     {
                        if(_loc70_.libraryIsAvaible)
                        {
                           this.updateUsableEmotesListInit(_loc70_.look);
                        }
                        else
                        {
                           _loc70_.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                        }
                        if(this.dispatchPlayerNewLook)
                        {
                           KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,_loc70_.look);
                           this.dispatchPlayerNewLook = false;
                        }
                     }
                     _loc71_ = _loc69_ as GameRolePlayCharacterInformations;
                     if(_loc71_)
                     {
                        _loc7_ = 0;
                        _loc8_ = 0;
                        for each (_loc72_ in _loc71_.humanoidInfo.options)
                        {
                           if(_loc72_ is HumanOptionEmote)
                           {
                              _loc7_ = _loc72_.emoteId;
                              _loc8_ = _loc72_.emoteStartTime;
                           }
                           else
                           {
                              if(_loc72_ is HumanOptionObjectUse)
                              {
                                 _loc73_ = new DelayedActionMessage(_loc71_.contextualId,_loc72_.objectGID,_loc72_.delayEndTime);
                                 Kernel.getWorker().process(_loc73_);
                              }
                           }
                        }
                        if(_loc7_ > 0)
                        {
                           _loc74_ = Emoticon.getEmoticonById(_loc7_);
                           if((_loc74_) && (_loc74_.persistancy))
                           {
                              this._currentEmoticon = _loc74_.id;
                              if(!_loc74_.aura)
                              {
                                 _loc75_ = false;
                                 _loc76_ = new Date();
                                 if(_loc76_.getTime() - _loc8_ >= _loc74_.duration)
                                 {
                                    _loc75_ = true;
                                 }
                                 _loc77_ = EntityLookAdapter.fromNetwork(_loc71_.look);
                                 _loc78_ = new GameRolePlaySetAnimationMessage(_loc69_,_loc74_.getAnimName(_loc77_),_loc8_,!_loc74_.persistancy,_loc74_.eight_directions,_loc75_);
                                 if(_loc70_.rendered)
                                 {
                                    this.process(_loc78_);
                                 }
                                 else
                                 {
                                    if(_loc78_.playStaticOnly)
                                    {
                                       _loc70_.visible = false;
                                    }
                                    this._waitingEmotesAnims[_loc70_.id] = _loc78_;
                                    _loc70_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
                                    _loc70_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
                                 }
                              }
                           }
                        }
                     }
                  }
                  if(_loc6_)
                  {
                     if(_loc69_ is GameRolePlayGroupMonsterInformations)
                     {
                        _loc6_ = false;
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.MapWithMonsters);
                     }
                  }
                  if(_loc69_ is GameRolePlayCharacterInformations)
                  {
                     ChatAutocompleteNameManager.getInstance().addEntry((_loc69_ as GameRolePlayCharacterInformations).name,0);
                  }
               }
               for each (_loc79_ in _loc3_.fights)
               {
                  this.addFight(_loc79_);
               }
               this._housesList = new Dictionary();
               for each (_loc80_ in _loc3_.houses)
               {
                  _loc81_ = HouseWrapper.create(_loc80_);
                  _loc82_ = _loc80_.doorsOnMap.length;
                  _loc83_ = 0;
                  while(_loc83_ < _loc82_)
                  {
                     this._housesList[_loc80_.doorsOnMap[_loc83_]] = _loc81_;
                     _loc83_++;
                  }
                  _loc84_ = new HousePropertiesMessage();
                  _loc84_.initHousePropertiesMessage(_loc80_);
                  Kernel.getWorker().process(_loc84_);
               }
               for each (_loc85_ in _loc3_.obstacles)
               {
                  InteractiveCellManager.getInstance().updateCell(_loc85_.obstacleCellId,_loc85_.state == MapObstacleStateEnum.OBSTACLE_OPENED);
               }
               _loc9_ = new InteractiveMapUpdateMessage();
               _loc9_.initInteractiveMapUpdateMessage(_loc3_.interactiveElements);
               Kernel.getWorker().process(_loc9_);
               _loc10_ = new StatedMapUpdateMessage();
               _loc10_.initStatedMapUpdateMessage(_loc3_.statedElements);
               Kernel.getWorker().process(_loc10_);
               KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,PlayedCharacterManager.getInstance().currentMap,_currentSubAreaId,Dofus.getInstance().options.mapCoordinates);
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,0);
               AnimFunManager.getInstance().initializeByMap(_loc3_.mapId);
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
            case param1 is HousePropertiesMessage:
               _loc11_ = (param1 as HousePropertiesMessage).properties;
               _loc81_ = HouseWrapper.create(_loc11_);
               _loc82_ = _loc11_.doorsOnMap.length;
               _loc83_ = 0;
               while(_loc83_ < _loc82_)
               {
                  this._housesList[_loc11_.doorsOnMap[_loc83_]] = _loc81_;
                  _loc83_++;
               }
               KernelEventsManager.getInstance().processCallback(HookList.HouseProperties,_loc11_.houseId,_loc11_.doorsOnMap,_loc11_.ownerName,_loc11_.isOnSale,_loc11_.modelId);
               return true;
            case param1 is GameRolePlayShowActorMessage:
               _loc12_ = param1 as GameRolePlayShowActorMessage;
               _loc2_ = DofusEntities.getEntity(_loc12_.informations.contextualId) as AnimatedCharacter;
               if((_loc2_) && _loc2_.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == -1)
               {
                  _loc2_.visibleAura = false;
               }
               if(!_loc2_)
               {
                  updateCreaturesLimit();
                  _humanNumber++;
               }
               _loc2_ = this.addOrUpdateActor(_loc12_.informations);
               if((_loc2_) && _loc12_.informations.contextualId == PlayedCharacterManager.getInstance().id)
               {
                  if(_loc2_.libraryIsAvaible)
                  {
                     this.updateUsableEmotesListInit(_loc2_.look);
                  }
                  else
                  {
                     _loc2_.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                  }
               }
               if(this.switchPokemonMode())
               {
                  return true;
               }
               if(_loc12_.informations is GameRolePlayCharacterInformations)
               {
                  ChatAutocompleteNameManager.getInstance().addEntry((_loc12_.informations as GameRolePlayCharacterInformations).name,0);
               }
               if(_loc12_.informations is GameRolePlayCharacterInformations && PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE)
               {
                  _loc86_ = _loc12_.informations as GameRolePlayCharacterInformations;
                  switch(PlayedCharacterManager.getInstance().levelDiff(_loc86_.alignmentInfos.characterPower - _loc12_.informations.contextualId))
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
            case param1 is GameContextRefreshEntityLookMessage:
               _loc13_ = param1 as GameContextRefreshEntityLookMessage;
               _loc2_ = this.updateActorLook(_loc13_.id,_loc13_.look,true);
               if((_loc2_) && _loc13_.id == PlayedCharacterManager.getInstance().id)
               {
                  if(_loc2_.libraryIsAvaible)
                  {
                     this.updateUsableEmotesListInit(_loc2_.look);
                  }
                  else
                  {
                     _loc2_.addEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
                  }
               }
               return true;
            case param1 is GameMapChangeOrientationMessage:
               _loc14_ = param1 as GameMapChangeOrientationMessage;
               updateActorOrientation(_loc14_.orientation.id,_loc14_.orientation.direction);
               return true;
            case param1 is GameMapChangeOrientationsMessage:
               _loc15_ = param1 as GameMapChangeOrientationsMessage;
               _loc16_ = _loc15_.orientations.length;
               _loc87_ = 0;
               while(_loc87_ < _loc16_)
               {
                  _loc88_ = _loc15_.orientations[_loc87_];
                  updateActorOrientation(_loc88_.id,_loc88_.direction);
                  _loc87_++;
               }
               return true;
            case param1 is GameRolePlaySetAnimationMessage:
               _loc17_ = param1 as GameRolePlaySetAnimationMessage;
               _loc18_ = DofusEntities.getEntity(_loc17_.informations.contextualId) as AnimatedCharacter;
               if(!_loc18_)
               {
                  _log.error("GameRolePlaySetAnimationMessage : l\'entitée " + _loc17_.informations.contextualId + " n\'a pas ete trouvee");
                  return true;
               }
               if(_loc17_.animation == AnimationEnum.ANIM_STATIQUE)
               {
                  this._currentEmoticon = 0;
                  _loc18_.setAnimation(_loc17_.animation);
                  this._emoteTimesBySprite[_loc18_.name] = 0;
               }
               else
               {
                  if(!_loc17_.directions8)
                  {
                     if(_loc18_.getDirection() % 2 == 0)
                     {
                        _loc18_.setDirection(_loc18_.getDirection() + 1);
                     }
                  }
                  if(!_loc18_.hasAnimation(_loc17_.animation,_loc18_.getDirection()))
                  {
                     _log.error("GameRolePlaySetAnimationMessage : l\'animation " + _loc17_.animation + "_" + _loc18_.getDirection() + " n\'a pas ete trouvee");
                  }
                  else
                  {
                     if(!_creaturesMode)
                     {
                        this._emoteTimesBySprite[_loc18_.name] = _loc17_.duration;
                        _loc18_.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
                        _loc18_.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
                        _loc89_ = _loc18_.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
                        if(_loc89_)
                        {
                           _loc89_.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
                           _loc89_.addEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
                        }
                        _loc18_.setAnimation(_loc17_.animation);
                        if(_loc17_.playStaticOnly)
                        {
                           if((_loc18_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET)) && (_loc18_.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length))
                           {
                              _loc18_.setSubEntityBehaviour(1,new AnimStatiqueSubEntityBehavior());
                           }
                           _loc18_.stopAnimationAtLastFrame();
                           if(_loc89_)
                           {
                              _loc89_.stopAnimationAtLastFrame();
                           }
                        }
                     }
                  }
               }
               return true;
            case param1 is EntityMovementCompleteMessage:
               _loc19_ = param1 as EntityMovementCompleteMessage;
               _loc20_ = _loc19_.entity as AnimatedCharacter;
               if(_entities[_loc20_.getRootEntity().id])
               {
                  (_entities[_loc20_.getRootEntity().id] as GameContextActorInformations).disposition.cellId = _loc20_.position.cellId;
               }
               if(this._entitiesIcons[_loc19_.entity.id])
               {
                  this._entitiesIcons[_loc19_.entity.id].needUpdate = true;
               }
               return false;
            case param1 is EntityMovementStoppedMessage:
               _loc21_ = param1 as EntityMovementStoppedMessage;
               if(this._entitiesIcons[_loc21_.entity.id])
               {
                  this._entitiesIcons[_loc21_.entity.id].needUpdate = true;
               }
               return false;
            case param1 is CharacterMovementStoppedMessage:
               _loc22_ = param1 as CharacterMovementStoppedMessage;
               _loc23_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
               if((((OptionManager.getOptionManager("tiphon").auraMode > OptionEnum.AURA_NONE) && (OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront)) && (_loc23_.getDirection() == DirectionsEnum.DOWN)) && (!(_loc23_.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == -1)) && PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
               {
                  _loc91_ = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
                  for each (_loc92_ in _loc91_.emotes)
                  {
                     _loc93_ = Emoticon.getEmoticonById(_loc92_);
                     if((_loc93_) && (_loc93_.aura))
                     {
                        if(!_loc90_ || _loc93_.weight > _loc90_.weight)
                        {
                           _loc90_ = _loc93_;
                        }
                     }
                  }
                  if(_loc90_)
                  {
                     _loc94_ = new EmotePlayRequestMessage();
                     _loc94_.initEmotePlayRequestMessage(_loc90_.id);
                     ConnectionsHandler.getConnection().send(_loc94_);
                  }
               }
               return true;
            case param1 is GameRolePlayShowChallengeMessage:
               _loc24_ = param1 as GameRolePlayShowChallengeMessage;
               this.addFight(_loc24_.commonsInfos);
               return true;
            case param1 is GameFightOptionStateUpdateMessage:
               _loc25_ = param1 as GameFightOptionStateUpdateMessage;
               this.updateSwordOptions(_loc25_.fightId,_loc25_.teamId,_loc25_.option,_loc25_.state);
               KernelEventsManager.getInstance().processCallback(HookList.GameFightOptionStateUpdate,_loc25_.fightId,_loc25_.teamId,_loc25_.option,_loc25_.state);
               return true;
            case param1 is GameFightUpdateTeamMessage:
               _loc26_ = param1 as GameFightUpdateTeamMessage;
               this.updateFight(_loc26_.fightId,_loc26_.team);
               return true;
            case param1 is GameFightRemoveTeamMemberMessage:
               _loc27_ = param1 as GameFightRemoveTeamMemberMessage;
               this.removeFighter(_loc27_.fightId,_loc27_.teamId,_loc27_.charId);
               return true;
            case param1 is GameRolePlayRemoveChallengeMessage:
               _loc28_ = param1 as GameRolePlayRemoveChallengeMessage;
               KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayRemoveFight,_loc28_.fightId);
               this.removeFight(_loc28_.fightId);
               return true;
            case param1 is GameContextRemoveElementMessage:
               _loc29_ = param1 as GameContextRemoveElementMessage;
               delete this._lastStaticAnimations[[_loc29_.id]];
               _loc30_ = 0;
               for each (_loc95_ in this._playersId)
               {
                  if(_loc95_ == _loc29_.id)
                  {
                     this._playersId.splice(_loc30_,1);
                  }
                  else
                  {
                     _loc30_++;
                  }
               }
               _loc31_ = this._monstersIds.indexOf(_loc29_.id);
               if(_loc31_ != -1)
               {
                  this._monstersIds.splice(_loc31_,1);
               }
               if(this._entitiesIconsNames[_loc29_.id])
               {
                  delete this._entitiesIconsNames[[_loc29_.id]];
               }
               if(this._entitiesIcons[_loc29_.id])
               {
                  this.removeIcon(_loc29_.id);
               }
               delete this._waitingEmotesAnims[[_loc29_.id]];
               this.removeEntityListeners(_loc29_.id);
               removeActor(_loc29_.id);
               return true;
            case param1 is MapFightCountMessage:
               _loc32_ = param1 as MapFightCountMessage;
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,_loc32_.fightCount);
               return true;
            case param1 is UpdateMapPlayersAgressableStatusMessage:
               _loc33_ = param1 as UpdateMapPlayersAgressableStatusMessage;
               _loc35_ = _loc33_.playerIds.length;
               _loc34_ = 0;
               while(_loc34_ < _loc35_)
               {
                  _loc36_ = getEntityInfos(_loc33_.playerIds[_loc34_]) as GameRolePlayHumanoidInformations;
                  if(_loc36_)
                  {
                     for each (_loc37_ in _loc36_.humanoidInfo.options)
                     {
                        if(_loc37_ is HumanOptionAlliance)
                        {
                           (_loc37_ as HumanOptionAlliance).aggressable = _loc33_.enable[_loc34_];
                           break;
                        }
                     }
                  }
                  if(_loc33_.playerIds[_loc34_] == PlayedCharacterManager.getInstance().id)
                  {
                     PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = _loc33_.enable[_loc34_];
                     KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange,_loc33_.enable[_loc34_],0);
                  }
                  _loc34_++;
               }
               this.updateConquestIcons(_loc33_.playerIds);
               return true;
            case param1 is UpdateSelfAgressableStatusMessage:
               _loc38_ = param1 as UpdateSelfAgressableStatusMessage;
               _loc39_ = getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayHumanoidInformations;
               if(_loc39_)
               {
                  for each (_loc40_ in _loc39_.humanoidInfo.options)
                  {
                     if(_loc40_ is HumanOptionAlliance)
                     {
                        (_loc40_ as HumanOptionAlliance).aggressable = _loc38_.status;
                        break;
                     }
                  }
               }
               if(PlayedCharacterManager.getInstance().characteristics)
               {
                  PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = _loc38_.status;
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange,_loc38_.status,_loc38_.probationTime);
               this.updateConquestIcons(PlayedCharacterManager.getInstance().id);
               return true;
            case param1 is ObjectGroundAddedMessage:
               _loc41_ = param1 as ObjectGroundAddedMessage;
               this.addObject(_loc41_.objectGID,_loc41_.cellId);
               return true;
            case param1 is ObjectGroundRemovedMessage:
               _loc42_ = param1 as ObjectGroundRemovedMessage;
               this.removeObject(_loc42_.cell);
               return true;
            case param1 is ObjectGroundRemovedMultipleMessage:
               _loc43_ = param1 as ObjectGroundRemovedMultipleMessage;
               for each (_loc96_ in _loc43_.cells)
               {
                  this.removeObject(_loc96_);
               }
               return true;
            case param1 is ObjectGroundListAddedMessage:
               _loc44_ = param1 as ObjectGroundListAddedMessage;
               _loc45_ = 0;
               for each (_loc97_ in _loc44_.referenceIds)
               {
                  this.addObject(_loc97_,_loc44_.cells[_loc45_]);
                  _loc45_++;
               }
               return true;
            case param1 is PaddockRemoveItemRequestAction:
               _loc46_ = param1 as PaddockRemoveItemRequestAction;
               _loc47_ = new PaddockRemoveItemRequestMessage();
               _loc47_.initPaddockRemoveItemRequestMessage(_loc46_.cellId);
               ConnectionsHandler.getConnection().send(_loc47_);
               return true;
            case param1 is PaddockMoveItemRequestAction:
               _loc48_ = param1 as PaddockMoveItemRequestAction;
               this._currentPaddockItemCellId = _loc48_.object.disposition.cellId;
               _loc49_ = new Texture();
               _loc50_ = ItemWrapper.create(0,0,_loc48_.object.item.id,0,null,false);
               _loc49_.uri = _loc50_.iconUri;
               _loc49_.finalize();
               Kernel.getWorker().addFrame(new RoleplayPointCellFrame(this.onCellPointed,_loc49_,true,this.paddockCellValidator,true));
               return true;
            case param1 is GameDataPaddockObjectRemoveMessage:
               _loc51_ = param1 as GameDataPaddockObjectRemoveMessage;
               _loc52_ = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
               this.removePaddockItem(_loc51_.cellId);
               return true;
            case param1 is GameDataPaddockObjectAddMessage:
               _loc53_ = param1 as GameDataPaddockObjectAddMessage;
               this.addPaddockItem(_loc53_.paddockItemDescription);
               return true;
            case param1 is GameDataPaddockObjectListAddMessage:
               _loc54_ = param1 as GameDataPaddockObjectListAddMessage;
               for each (_loc98_ in _loc54_.paddockItemDescription)
               {
                  this.addPaddockItem(_loc98_);
               }
               return true;
            case param1 is GameDataPlayFarmObjectAnimationMessage:
               _loc55_ = param1 as GameDataPlayFarmObjectAnimationMessage;
               for each (_loc99_ in _loc55_.cellId)
               {
                  this.activatePaddockItem(_loc99_);
               }
               return true;
            case param1 is MapNpcsQuestStatusUpdateMessage:
               _loc56_ = param1 as MapNpcsQuestStatusUpdateMessage;
               if(MapDisplayManager.getInstance().currentMapPoint.mapId == _loc56_.mapId)
               {
                  for each (_loc100_ in this._npcList)
                  {
                     this.removeBackground(_loc100_);
                  }
                  _loc103_ = _loc56_.npcsIdsWithQuest.length;
                  _loc102_ = 0;
                  while(_loc102_ < _loc103_)
                  {
                     _loc100_ = this._npcList[_loc56_.npcsIdsWithQuest[_loc102_]];
                     if(_loc100_)
                     {
                        _loc104_ = Quest.getFirstValidQuest(_loc56_.questFlags[_loc102_]);
                        if(_loc104_ != null)
                        {
                           if(_loc56_.questFlags[_loc102_].questsToStartId.indexOf(_loc104_.id) != -1)
                           {
                              if(_loc104_.repeatType == 0)
                              {
                                 _loc101_ = EmbedAssets.getSprite("QUEST_CLIP");
                                 _loc100_.addBackground("questClip",_loc101_,true);
                              }
                              else
                              {
                                 _loc101_ = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                                 _loc100_.addBackground("questRepeatableClip",_loc101_,true);
                              }
                           }
                           else
                           {
                              if(_loc104_.repeatType == 0)
                              {
                                 _loc101_ = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                                 _loc100_.addBackground("questObjectiveClip",_loc101_,true);
                              }
                              else
                              {
                                 _loc101_ = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                                 _loc100_.addBackground("questRepeatableObjectiveClip",_loc101_,true);
                              }
                           }
                        }
                     }
                     _loc102_++;
                  }
               }
               return true;
            case param1 is ShowCellMessage:
               _loc57_ = param1 as ShowCellMessage;
               HyperlinkShowCellManager.showCell(_loc57_.cellId);
               _loc58_ = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
               _loc59_ = _loc58_.getActorName(_loc57_.sourceId);
               _loc60_ = I18n.getUiText("ui.fight.showCell",[_loc59_,"{cell," + _loc57_.cellId + "::" + _loc57_.cellId + "}"]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc60_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is StartZoomAction:
               _loc61_ = param1 as StartZoomAction;
               if(Atouin.getInstance().currentZoom != 1)
               {
                  Atouin.getInstance().cancelZoom();
                  KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
                  this.updateAllIcons();
                  return true;
               }
               _loc62_ = DofusEntities.getEntity(_loc61_.playerId) as DisplayObject;
               if((_loc62_) && (_loc62_.stage))
               {
                  _loc105_ = _loc62_.getRect(Atouin.getInstance().worldContainer);
                  Atouin.getInstance().zoom(_loc61_.value,_loc105_.x + _loc105_.width / 2,_loc105_.y + _loc105_.height / 2);
                  KernelEventsManager.getInstance().processCallback(HookList.StartZoom,true);
                  this.updateAllIcons();
               }
               return true;
            case param1 is SwitchCreatureModeAction:
               _loc63_ = param1 as SwitchCreatureModeAction;
               if(_creaturesMode != _loc63_.isActivated)
               {
                  _creaturesMode = _loc63_.isActivated;
                  for (_loc106_ in _entities)
                  {
                     this.updateActorLook(_loc106_,(_entities[_loc106_] as GameContextActorInformations).look);
                  }
               }
               return true;
            case param1 is MapZoomMessage:
               for each (_loc107_ in _entities)
               {
                  _loc108_ = _loc107_ as FightTeam;
                  if((_loc108_) && (_loc108_.fight) && (_loc108_.teamInfos))
                  {
                     this.updateSwordOptions(_loc108_.fight.fightId,_loc108_.teamInfos.teamId);
                  }
               }
               return false;
            default:
               return false;
         }
      }
      
      private function initNewMap() : void {
         var _loc1_:* = undefined;
         for each (_loc1_ in this._objectsByCellId)
         {
            (_loc1_ as IDisplayable).remove();
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
         var _loc1_:Fight = null;
         var _loc3_:FightTeam = null;
         for each (_loc1_ in this._fights)
         {
            for each (_loc3_ in _loc1_.teams)
            {
               (_loc3_.teamEntity as TiphonSprite).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onFightEntityRendered);
               TooltipManager.hide("fightOptions_" + _loc1_.fightId + "_" + _loc3_.teamInfos.teamId);
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
         var _loc2_:DisplayObjectContainer = Berilia.getInstance().docMain.getChildAt(StrataEnum.STRATA_WORLD + 1) as DisplayObjectContainer;
         if((_loc2_) && _loc2_ == this._entitiesIconsContainer.parent)
         {
            _loc2_.removeChild(this._entitiesIconsContainer);
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
      
      public function isFight(param1:int) : Boolean {
         return _entities[param1] is FightTeam;
      }
      
      public function isPaddockItem(param1:int) : Boolean {
         return _entities[param1] is GameContextPaddockItemInformations;
      }
      
      public function getFightTeam(param1:int) : FightTeam {
         return _entities[param1] as FightTeam;
      }
      
      public function getFightId(param1:int) : uint {
         return (_entities[param1] as FightTeam).fight.fightId;
      }
      
      public function getFightLeaderId(param1:int) : uint {
         return (_entities[param1] as FightTeam).teamInfos.leaderId;
      }
      
      public function getFightTeamType(param1:int) : uint {
         return (_entities[param1] as FightTeam).teamType;
      }
      
      override public function addOrUpdateActor(param1:GameContextActorInformations, param2:IAnimationModifier=null) : AnimatedCharacter {
         var _loc4_:Sprite = null;
         var _loc5_:Quest = null;
         var _loc6_:GameRolePlayGroupMonsterInformations = null;
         var _loc7_:* = false;
         var _loc8_:Vector.<EntityLook> = null;
         var _loc9_:Vector.<Number> = null;
         var _loc10_:uint = 0;
         var _loc11_:Vector.<EntityLook> = null;
         var _loc12_:MonsterInGroupInformations = null;
         var _loc13_:* = undefined;
         var _loc14_:Array = null;
         var _loc15_:IndexedEntityLook = null;
         var _loc16_:IndexedEntityLook = null;
         var _loc3_:AnimatedCharacter = super.addOrUpdateActor(param1);
         switch(true)
         {
            case param1 is GameRolePlayNpcWithQuestInformations:
               this._npcList[param1.contextualId] = _loc3_;
               _loc5_ = Quest.getFirstValidQuest((param1 as GameRolePlayNpcWithQuestInformations).questFlag);
               this.removeBackground(_loc3_);
               if(_loc5_ != null)
               {
                  if((param1 as GameRolePlayNpcWithQuestInformations).questFlag.questsToStartId.indexOf(_loc5_.id) != -1)
                  {
                     if(_loc5_.repeatType == 0)
                     {
                        _loc4_ = EmbedAssets.getSprite("QUEST_CLIP");
                        _loc3_.addBackground("questClip",_loc4_,true);
                     }
                     else
                     {
                        _loc4_ = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                        _loc3_.addBackground("questRepeatableClip",_loc4_,true);
                     }
                  }
                  else
                  {
                     if(_loc5_.repeatType == 0)
                     {
                        _loc4_ = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                        _loc3_.addBackground("questObjectiveClip",_loc4_,true);
                     }
                     else
                     {
                        _loc4_ = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                        _loc3_.addBackground("questRepeatableObjectiveClip",_loc4_,true);
                     }
                  }
               }
               if(_loc3_.look.getBone() == 1)
               {
                  _loc3_.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode) || _loc3_.getAnimation() == AnimationEnum.ANIM_STATIQUE)
               {
                  _loc3_.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case param1 is GameRolePlayGroupMonsterInformations:
               _loc6_ = param1 as GameRolePlayGroupMonsterInformations;
               _loc7_ = Monster.getMonsterById(_loc6_.staticInfos.mainCreatureLightInfos.creatureGenericId).isMiniBoss;
               _loc8_ = Dofus.getInstance().options.showEveryMonsters?new Vector.<EntityLook>(_loc6_.staticInfos.underlings.length,true):null;
               _loc9_ = _loc8_?new Vector.<Number>(_loc8_.length,true):null;
               _loc10_ = 0;
               for each (_loc12_ in _loc6_.staticInfos.underlings)
               {
                  if(_loc8_)
                  {
                     _loc9_[_loc10_] = Monster.getMonsterById(_loc12_.creatureGenericId).speedAdjust;
                     _loc8_[_loc10_++] = _loc12_.look;
                  }
                  if(!_loc7_ && (Monster.getMonsterById(_loc12_.creatureGenericId).isMiniBoss))
                  {
                     _loc7_ = true;
                     if(!_loc8_)
                     {
                        break;
                     }
                  }
               }
               if(_loc8_)
               {
                  this.manageFollowers(_loc3_,_loc8_,_loc9_);
               }
               if(this._monstersIds.indexOf(param1.contextualId) == -1)
               {
                  this._monstersIds.push(param1.contextualId);
               }
               if(Kernel.getWorker().contains(MonstersInfoFrame))
               {
                  (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).update();
               }
               if(!(PlayerManager.getInstance().serverGameType == 0) && (_loc6_.hasHardcoreDrop))
               {
                  this.addEntityIcon(_loc6_.contextualId,"treasure");
               }
               if(_loc7_)
               {
                  this.addEntityIcon(_loc6_.contextualId,"archmonsters");
               }
               if(_loc6_.hasAVARewardToken)
               {
                  this.addEntityIcon(_loc6_.contextualId,"nugget");
               }
               break;
            case param1 is GameRolePlayHumanoidInformations:
               if((param1.contextualId > 0) && (this._playersId) && this._playersId.indexOf(param1.contextualId) == -1)
               {
                  this._playersId.push(param1.contextualId);
               }
               _loc11_ = new Vector.<EntityLook>();
               for each (_loc13_ in (param1 as GameRolePlayHumanoidInformations).humanoidInfo.options)
               {
                  switch(true)
                  {
                     case _loc13_ is HumanOptionFollowers:
                        _loc14_ = new Array();
                        for each (_loc15_ in _loc13_.followingCharactersLook)
                        {
                           _loc14_.push(_loc15_);
                        }
                        _loc14_.sortOn("index");
                        for each (_loc16_ in _loc14_)
                        {
                           _loc11_.push(_loc16_.look);
                        }
                        continue;
                     case _loc13_ is HumanOptionAlliance:
                        this.addConquestIcon(param1.contextualId,_loc13_ as HumanOptionAlliance);
                        continue;
                     default:
                        continue;
                  }
               }
               this.manageFollowers(_loc3_,_loc11_);
               if(_loc3_.look.getBone() == 1)
               {
                  _loc3_.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode) || _loc3_.getAnimation() == AnimationEnum.ANIM_STATIQUE)
               {
                  _loc3_.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case param1 is GameRolePlayMerchantInformations:
               if(_loc3_.look.getBone() == 1)
               {
                  _loc3_.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode) || _loc3_.getAnimation() == AnimationEnum.ANIM_STATIQUE)
               {
                  _loc3_.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case param1 is GameRolePlayTaxCollectorInformations:
            case param1 is GameRolePlayPrismInformations:
               _loc3_.allowMovementThrough = true;
               break;
            case param1 is GameRolePlayNpcInformations:
            case param1 is GameContextPaddockItemInformations:
               break;
            default:
               _log.warn("Unknown GameRolePlayActorInformations type : " + param1 + ".");
         }
         return _loc3_;
      }
      
      override protected function updateActorLook(param1:int, param2:EntityLook, param3:Boolean=false) : AnimatedCharacter {
         var _loc5_:String = null;
         var _loc4_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         if(_loc4_)
         {
            _loc5_ = (TiphonUtility.getEntityWithoutMount(_loc4_) as TiphonSprite).getAnimation();
            if(!(_loc5_.indexOf("_Statique_") == -1) && (!this._lastStaticAnimations[param1] || !(this._lastStaticAnimations[param1] == _loc5_)))
            {
               this._lastStaticAnimations[param1] = {"anim":_loc5_};
            }
            if(!(_loc4_.look.getBone() == param2.bonesId) && (this._lastStaticAnimations[param1]))
            {
               this._lastStaticAnimations[param1].targetBone = param2.bonesId;
               _loc4_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
               _loc4_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
               _loc4_.setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
         }
         return super.updateActorLook(param1,param2,param3);
      }
      
      private function onEntityRendered(param1:TiphonEvent) : void {
         var _loc2_:AnimatedCharacter = param1.currentTarget as AnimatedCharacter;
         if(this._lastStaticAnimations[_loc2_.id].targetBone == _loc2_.look.getBone() && (_loc2_.rendered))
         {
            _loc2_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
            _loc2_.setAnimation(this._lastStaticAnimations[_loc2_.id].anim);
            delete this._lastStaticAnimations[[_loc2_.id]];
         }
      }
      
      private function removeBackground(param1:TiphonSprite) : void {
         if(!param1)
         {
            return;
         }
         param1.removeBackground("questClip");
         param1.removeBackground("questObjectiveClip");
         param1.removeBackground("questRepeatableClip");
         param1.removeBackground("questRepeatableObjectiveClip");
      }
      
      private function manageFollowers(param1:AnimatedCharacter, param2:Vector.<EntityLook>, param3:Vector.<Number>=null) : void {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:EntityLook = null;
         var _loc7_:TiphonEntityLook = null;
         var _loc8_:AnimatedCharacter = null;
         if(!param1.followersEqual(param2))
         {
            param1.removeAllFollowers();
            _loc4_ = param2.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = param2[_loc5_];
               _loc7_ = EntityLookAdapter.fromNetwork(_loc6_);
               _loc8_ = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),_loc7_,param1);
               if(param3)
               {
                  _loc8_.speedAdjust = param3[_loc5_];
               }
               param1.addFollower(_loc8_);
               _loc5_++;
            }
         }
      }
      
      private function addFight(param1:FightCommonInformations) : void {
         var _loc5_:FightTeamInformations = null;
         var _loc6_:IEntity = null;
         var _loc7_:FightTeam = null;
         var _loc2_:Vector.<FightTeam> = new Vector.<FightTeam>(0,false);
         var _loc3_:Fight = new Fight(param1.fightId,_loc2_);
         var _loc4_:uint = 0;
         for each (_loc5_ in param1.fightTeams)
         {
            _loc6_ = RolePlayEntitiesFactory.createFightEntity(param1,_loc5_,MapPoint.fromCellId(param1.fightTeamsPositions[_loc4_]));
            (_loc6_ as IDisplayable).display();
            _loc7_ = new FightTeam(_loc3_,_loc5_.teamTypeId,_loc6_,_loc5_,param1.fightTeamsOptions[_loc5_.teamId]);
            _entities[_loc6_.id] = _loc7_;
            _loc2_.push(_loc7_);
            _loc4_++;
            (_loc6_ as TiphonSprite).addEventListener(TiphonEvent.RENDER_SUCCEED,this.onFightEntityRendered,false,0,true);
         }
         this._fights[param1.fightId] = _loc3_;
      }
      
      private function addObject(param1:uint, param2:uint) : void {
         var _loc3_:Uri = new Uri(LangManager.getInstance().getEntry("config.gfx.path.item.vector") + Item.getItemById(param1).iconId + ".swf");
         var _loc4_:IInteractive = new RoleplayObjectEntity(param1,MapPoint.fromCellId(param2));
         (_loc4_ as IDisplayable).display();
         var _loc5_:GameContextActorInformations = new GroundObject(Item.getItemById(param1));
         _loc5_.contextualId = _loc4_.id;
         _loc5_.disposition.cellId = param2;
         _loc5_.disposition.direction = DirectionsEnum.DOWN_RIGHT;
         if(this._objects == null)
         {
            this._objects = new Dictionary();
         }
         this._objects[_loc3_] = _loc4_;
         this._objectsByCellId[param2] = this._objects[_loc3_];
         _entities[_loc4_.id] = _loc5_;
         this._loader.load(_loc3_,null,null,true);
      }
      
      private function removeObject(param1:uint) : void {
         if(this._objectsByCellId[param1] != null)
         {
            if(this._objects[this._objectsByCellId[param1]] != null)
            {
               delete this._objects[[this._objectsByCellId[param1]]];
            }
            if(_entities[this._objectsByCellId[param1].id] != null)
            {
               delete _entities[[this._objectsByCellId[param1].id]];
            }
            (this._objectsByCellId[param1] as IDisplayable).remove();
            delete this._objectsByCellId[[param1]];
         }
      }
      
      private function updateFight(param1:uint, param2:FightTeamInformations) : void {
         var _loc6_:FightTeamMemberInformations = null;
         var _loc7_:* = false;
         var _loc8_:FightTeamMemberInformations = null;
         var _loc3_:Fight = this._fights[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:FightTeam = _loc3_.getTeamById(param2.teamId);
         var _loc5_:FightTeamInformations = (_entities[_loc4_.teamEntity.id] as FightTeam).teamInfos;
         if(_loc5_.teamMembers == param2.teamMembers)
         {
            return;
         }
         for each (_loc6_ in param2.teamMembers)
         {
            _loc7_ = false;
            for each (_loc8_ in _loc5_.teamMembers)
            {
               if(_loc8_.id == _loc6_.id)
               {
                  _loc7_ = true;
               }
            }
            if(!_loc7_)
            {
               _loc5_.teamMembers.push(_loc6_);
            }
         }
      }
      
      private function removeFighter(param1:uint, param2:uint, param3:int) : void {
         var _loc5_:FightTeam = null;
         var _loc6_:FightTeamInformations = null;
         var _loc7_:Vector.<FightTeamMemberInformations> = null;
         var _loc8_:FightTeamMemberInformations = null;
         var _loc4_:Fight = this._fights[param1];
         if(_loc4_)
         {
            _loc5_ = _loc4_.teams[param2];
            _loc6_ = _loc5_.teamInfos;
            _loc7_ = new Vector.<FightTeamMemberInformations>(0,false);
            for each (_loc8_ in _loc6_.teamMembers)
            {
               if(_loc8_.id != param3)
               {
                  _loc7_.push(_loc8_);
               }
            }
            _loc6_.teamMembers = _loc7_;
         }
      }
      
      private function removeFight(param1:uint) : void {
         var _loc3_:FightTeam = null;
         var _loc4_:Object = null;
         var _loc2_:Fight = this._fights[param1];
         if(_loc2_ == null)
         {
            return;
         }
         for each (_loc3_ in _loc2_.teams)
         {
            _loc4_ = _entities[_loc3_.teamEntity.id];
            Kernel.getWorker().process(new EntityMouseOutMessage(_loc3_.teamEntity as IInteractive));
            (_loc3_.teamEntity as IDisplayable).remove();
            TooltipManager.hide("fightOptions_" + param1 + "_" + _loc3_.teamInfos.teamId);
            delete _entities[[_loc3_.teamEntity.id]];
         }
         delete this._fights[[param1]];
      }
      
      private function addPaddockItem(param1:PaddockItem) : void {
         var _loc3_:* = 0;
         var _loc2_:Item = Item.getItemById(param1.objectGID);
         if(this._paddockItem[param1.cellId])
         {
            _loc3_ = (this._paddockItem[param1.cellId] as IEntity).id;
         }
         else
         {
            _loc3_ = EntitiesManager.getInstance().getFreeEntityId();
         }
         var _loc4_:GameContextPaddockItemInformations = new GameContextPaddockItemInformations(_loc3_,_loc2_.appearance,param1.cellId,param1.durability,_loc2_);
         var _loc5_:IEntity = this.addOrUpdateActor(_loc4_);
         this._paddockItem[param1.cellId] = _loc5_;
      }
      
      private function removePaddockItem(param1:uint) : void {
         var _loc2_:IEntity = this._paddockItem[param1];
         if(!_loc2_)
         {
            return;
         }
         (_loc2_ as IDisplayable).remove();
         delete this._paddockItem[[param1]];
      }
      
      private function activatePaddockItem(param1:uint) : void {
         var _loc3_:SerialSequencer = null;
         var _loc2_:TiphonSprite = this._paddockItem[param1];
         if(_loc2_)
         {
            _loc3_ = new SerialSequencer();
            _loc3_.addStep(new PlayAnimationStep(_loc2_,AnimationEnum.ANIM_HIT));
            _loc3_.addStep(new PlayAnimationStep(_loc2_,AnimationEnum.ANIM_STATIQUE));
            _loc3_.start();
         }
      }
      
      private function onFightEntityRendered(param1:TiphonEvent) : void {
         if(!_entities || !param1.target)
         {
            return;
         }
         var _loc2_:FightTeam = _entities[param1.target.id];
         if((_loc2_) && (_loc2_.fight) && (_loc2_.teamInfos))
         {
            this.updateSwordOptions(_loc2_.fight.fightId,_loc2_.teamInfos.teamId);
         }
      }
      
      private function updateSwordOptions(param1:uint, param2:uint, param3:int=-1, param4:Boolean=false) : void {
         var _loc8_:* = undefined;
         var _loc5_:Fight = this._fights[param1];
         if(_loc5_ == null)
         {
            return;
         }
         var _loc6_:FightTeam = _loc5_.teams[param2];
         if(_loc6_ == null)
         {
            return;
         }
         if(param3 != -1)
         {
            _loc6_.teamOptions[param3] = param4;
         }
         var _loc7_:Vector.<String> = new Vector.<String>();
         for (_loc8_ in _loc6_.teamOptions)
         {
            if(_loc6_.teamOptions[_loc8_])
            {
               _loc7_.push("fightOption" + _loc8_);
            }
         }
         if(_loc6_.hasGroupMember())
         {
            _loc7_.push("fightOption4");
         }
         TooltipManager.show(_loc7_,(_loc6_.teamEntity as IDisplayable).absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"fightOptions_" + param1 + "_" + param2,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,"texturesList",null,null,null,false,0,Atouin.getInstance().currentZoom,false);
      }
      
      private function paddockCellValidator(param1:int) : Boolean {
         var _loc3_:GameContextActorInformations = null;
         var _loc2_:IEntity = EntitiesManager.getInstance().getEntityOnCell(param1);
         if(_loc2_)
         {
            _loc3_ = getEntityInfos(_loc2_.id);
            if(_loc3_ is GameContextPaddockItemInformations)
            {
               return false;
            }
         }
         return (DataMapProvider.getInstance().farmCell(MapPoint.fromCellId(param1).x,MapPoint.fromCellId(param1).y)) && (DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(param1).x,MapPoint.fromCellId(param1).y,true));
      }
      
      private function removeEntityListeners(param1:int) : void {
         var _loc3_:TiphonSprite = null;
         var _loc2_:TiphonSprite = DofusEntities.getEntity(param1) as TiphonSprite;
         if(_loc2_)
         {
            _loc2_.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            _loc3_ = _loc2_.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
            if(_loc3_)
            {
               _loc3_.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
            }
            _loc2_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
         }
      }
      
      private function updateUsableEmotesListInit(param1:TiphonEntityLook) : void {
         var _loc2_:TiphonEntityLook = null;
         var _loc3_:Array = null;
         if((_entities) && (_entities[PlayedCharacterManager.getInstance().id]))
         {
            _loc2_ = EntityLookAdapter.fromNetwork((_entities[PlayedCharacterManager.getInstance().id] as GameContextActorInformations).look);
         }
         if(((_creaturesMode) || (_creaturesFightMode)) && (_loc2_))
         {
            _loc3_ = TiphonMultiBonesManager.getInstance().getAllBonesFromLook(_loc2_);
            TiphonMultiBonesManager.getInstance().forceBonesLoading(_loc3_,new Callback(this.updateUsableEmotesList,_loc2_));
         }
         else
         {
            this.updateUsableEmotesList(param1);
         }
      }
      
      private function updateUsableEmotesList(param1:TiphonEntityLook) : void {
         var _loc5_:EmoteWrapper = null;
         var _loc6_:String = null;
         var _loc8_:* = false;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc12_:ShortcutWrapper = null;
         var _loc14_:* = 0;
         var _loc2_:Boolean = PlayedCharacterManager.getInstance().isGhost;
         var _loc3_:EmoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
         var _loc4_:Array = _loc3_.emotesList;
         var _loc7_:Array = param1.getSubEntities();
         var _loc11_:* = false;
         this._usableEmotes = new Array();
         var _loc13_:uint = param1.getBone();
         for each (_loc5_ in _loc4_)
         {
            _loc8_ = false;
            if((_loc5_) && (_loc5_.emote))
            {
               _loc6_ = _loc5_.emote.getAnimName(param1);
               if((_loc5_.emote.aura) && !_loc2_ || (Tiphon.skullLibrary.hasAnim(param1.getBone(),_loc6_)))
               {
                  _loc8_ = true;
               }
               else
               {
                  if(_loc7_)
                  {
                     for (_loc9_ in _loc7_)
                     {
                        for (_loc10_ in _loc7_[_loc9_])
                        {
                           if(Tiphon.skullLibrary.hasAnim(_loc7_[_loc9_][_loc10_].getBone(),_loc6_))
                           {
                              _loc8_ = true;
                              break;
                           }
                        }
                        if(_loc8_)
                        {
                           break;
                        }
                     }
                  }
               }
               _loc14_ = _loc3_.emotes.indexOf(_loc5_.id);
               for each (_loc12_ in InventoryManager.getInstance().shortcutBarItems)
               {
                  if(((_loc12_) && (_loc12_.type == 4)) && (_loc12_.id == _loc5_.id) && !(_loc12_.active == _loc8_))
                  {
                     _loc12_.active = _loc8_;
                     _loc11_ = true;
                     break;
                  }
               }
               if(_loc8_)
               {
                  this._usableEmotes.push(_loc5_.id);
                  if(_loc14_ == -1)
                  {
                     _loc3_.emotes.push(_loc5_.id);
                  }
               }
               else
               {
                  if(_loc14_ != -1)
                  {
                     _loc3_.emotes.splice(_loc14_,1);
                  }
               }
            }
         }
         KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteUnabledListUpdated,this._usableEmotes);
         if(_loc11_)
         {
            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
         }
      }
      
      private function onEntityReadyForEmote(param1:TiphonEvent) : void {
         var _loc2_:AnimatedCharacter = param1.currentTarget as AnimatedCharacter;
         _loc2_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityReadyForEmote);
         if(this._playersId.indexOf(_loc2_.id) != -1)
         {
            this.process(this._waitingEmotesAnims[_loc2_.id]);
         }
         delete this._waitingEmotesAnims[[_loc2_.id]];
      }
      
      private function onAnimationAdded(param1:TiphonEvent) : void {
         var _loc5_:String = null;
         var _loc6_:Vector.<SoundAnimation> = null;
         var _loc7_:SoundAnimation = null;
         var _loc8_:String = null;
         var _loc2_:TiphonSprite = param1.currentTarget as TiphonSprite;
         _loc2_.removeEventListener(TiphonEvent.ANIMATION_ADDED,this.onAnimationAdded);
         var _loc3_:TiphonAnimation = _loc2_.rawAnimation;
         var _loc4_:SoundBones = SoundBones.getSoundBonesById(_loc2_.look.getBone());
         if(_loc4_)
         {
            _loc5_ = getQualifiedClassName(_loc3_);
            _loc6_ = _loc4_.getSoundAnimations(_loc5_);
            _loc3_.spriteHandler.tiphonEventManager.removeEvents(TiphonEventsManager.BALISE_SOUND,_loc5_);
            for each (_loc7_ in _loc6_)
            {
               _loc8_ = TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN + (!(_loc7_.label == null) && !(_loc7_.label == "null")?_loc7_.label:"") + TiphonEventsManager.BALISE_PARAM_END;
               _loc3_.spriteHandler.tiphonEventManager.addEvent(_loc8_,_loc7_.startFrame,_loc5_);
            }
         }
      }
      
      private function onGroundObjectLoaded(param1:ResourceLoadedEvent) : void {
         var _loc2_:MovieClip = param1.resource;
         _loc2_.x = _loc2_.x - _loc2_.width / 2;
         _loc2_.y = _loc2_.y - _loc2_.height / 2;
         if(this._objects[param1.uri])
         {
            this._objects[param1.uri].addChild(_loc2_);
         }
      }
      
      private function onGroundObjectLoadFailed(param1:ResourceErrorEvent) : void {
      }
      
      public function timeoutStop(param1:AnimatedCharacter) : void {
         clearTimeout(this._timeout);
         param1.setAnimation(AnimationEnum.ANIM_STATIQUE);
         this._currentEmoticon = 0;
      }
      
      override public function onPlayAnim(param1:TiphonEvent) : void {
         var _loc2_:Array = new Array();
         var _loc3_:String = param1.params.substring(6,param1.params.length-1);
         _loc2_ = _loc3_.split(",");
         var _loc4_:int = this._emoteTimesBySprite[(param1.currentTarget as TiphonSprite).name] % _loc2_.length;
         param1.sprite.setAnimation(_loc2_[_loc4_]);
      }
      
      private function onAnimationEnd(param1:TiphonEvent) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:TiphonSprite = param1.currentTarget as TiphonSprite;
         _loc2_.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         var _loc5_:Object = _loc2_.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.getAnimation();
            if(_loc4_.indexOf("_") == -1)
            {
               _loc4_ = _loc2_.getAnimation();
            }
         }
         else
         {
            _loc4_ = _loc2_.getAnimation();
         }
         if(_loc4_.indexOf("_Statique_") == -1)
         {
            _loc3_ = _loc4_.replace("_","_Statique_");
         }
         else
         {
            _loc3_ = _loc4_;
         }
         if((_loc2_.hasAnimation(_loc3_,_loc2_.getDirection())) || ((_loc5_) && (_loc5_ is TiphonSprite)) && (TiphonSprite(_loc5_).hasAnimation(_loc3_,TiphonSprite(_loc5_).getDirection())))
         {
            _loc2_.setAnimation(_loc3_);
         }
         else
         {
            _loc2_.setAnimation(AnimationEnum.ANIM_STATIQUE);
            this._currentEmoticon = 0;
         }
      }
      
      private function onPlayerSpriteInit(param1:TiphonEvent) : void {
         var _loc2_:TiphonEntityLook = (param1.sprite as TiphonSprite).look;
         if(param1.params == _loc2_.getBone())
         {
            param1.sprite.removeEventListener(TiphonEvent.SPRITE_INIT,this.onPlayerSpriteInit);
            this.updateUsableEmotesListInit(_loc2_);
         }
      }
      
      private function onCellPointed(param1:Boolean, param2:uint, param3:int) : void {
         var _loc4_:PaddockMoveItemRequestMessage = null;
         if(param1)
         {
            _loc4_ = new PaddockMoveItemRequestMessage();
            _loc4_.initPaddockMoveItemRequestMessage(this._currentPaddockItemCellId,param2);
            ConnectionsHandler.getConnection().send(_loc4_);
         }
      }
      
      private function updateConquestIcons(param1:*) : void {
         var _loc2_:* = 0;
         var _loc3_:GameRolePlayHumanoidInformations = null;
         var _loc4_:* = undefined;
         if(param1 is Vector.<uint> && (param1 as Vector.<uint>).length > 0)
         {
            for each (_loc2_ in param1)
            {
               _loc3_ = getEntityInfos(_loc2_) as GameRolePlayHumanoidInformations;
               if(_loc3_)
               {
                  for each (_loc4_ in _loc3_.humanoidInfo.options)
                  {
                     if(_loc4_ is HumanOptionAlliance)
                     {
                        this.addConquestIcon(_loc3_.contextualId,_loc4_ as HumanOptionAlliance);
                        break;
                     }
                  }
               }
            }
         }
         else
         {
            if(param1 is int)
            {
               _loc3_ = getEntityInfos(param1) as GameRolePlayHumanoidInformations;
               if(_loc3_)
               {
                  for each (_loc4_ in _loc3_.humanoidInfo.options)
                  {
                     if(_loc4_ is HumanOptionAlliance)
                     {
                        this.addConquestIcon(_loc3_.contextualId,_loc4_ as HumanOptionAlliance);
                        break;
                     }
                  }
               }
            }
         }
      }
      
      private function addConquestIcon(param1:int, param2:HumanOptionAlliance) : void {
         var _loc3_:PrismSubAreaWrapper = null;
         var _loc4_:String = null;
         var _loc5_:Vector.<String> = null;
         var _loc6_:String = null;
         if(((((!(PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.NON_AGGRESSABLE)) && (this._allianceFrame)) && (this._allianceFrame.hasAlliance)) && (!(param2.aggressable == AggressableStatusEnum.NON_AGGRESSABLE))) && (!(param2.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE)) && !(param2.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE))
         {
            _loc3_ = this._allianceFrame.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id);
            if((_loc3_) && _loc3_.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
            {
               switch(param2.aggressable)
               {
                  case AggressableStatusEnum.AvA_DISQUALIFIED:
                     if(param1 == PlayedCharacterManager.getInstance().id)
                     {
                        _loc4_ = "neutral";
                     }
                     break;
                  case AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE:
                     if(param1 == PlayedCharacterManager.getInstance().id)
                     {
                        _loc4_ = "clock";
                     }
                     else
                     {
                        _loc4_ = this.getPlayerConquestStatus(param1,param2.allianceInformations.allianceId,_loc3_.alliance.allianceId);
                     }
                     break;
                  case AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE:
                     _loc4_ = this.getPlayerConquestStatus(param1,param2.allianceInformations.allianceId,_loc3_.alliance.allianceId);
                     break;
               }
               if(_loc4_)
               {
                  _loc5_ = this.getIconNamesByCategory(param1,EntityIconEnum.AVA_CATEGORY);
                  if((_loc5_) && !(_loc5_[0] == _loc4_))
                  {
                     _loc6_ = _loc5_[0];
                     _loc5_.length = 0;
                     this.removeIcon(param1,_loc6_);
                  }
                  this.addEntityIcon(param1,_loc4_,EntityIconEnum.AVA_CATEGORY);
               }
            }
         }
         if((!_loc4_) && (this._entitiesIconsNames[param1]) && (this._entitiesIconsNames[param1][EntityIconEnum.AVA_CATEGORY]))
         {
            this.removeIconsCategory(param1,EntityIconEnum.AVA_CATEGORY);
         }
      }
      
      private function getPlayerConquestStatus(param1:int, param2:int, param3:int) : String {
         var _loc4_:String = null;
         if(param1 == PlayedCharacterManager.getInstance().id || this._allianceFrame.alliance.allianceId == param2)
         {
            _loc4_ = "ownTeam";
         }
         else
         {
            if(param2 == param3)
            {
               _loc4_ = "defender";
            }
            else
            {
               _loc4_ = "forward";
            }
         }
         return _loc4_;
      }
      
      public function addEntityIcon(param1:int, param2:String, param3:int=0) : void {
         if(!this._entitiesIconsNames[param1])
         {
            this._entitiesIconsNames[param1] = new Dictionary();
         }
         if(!this._entitiesIconsNames[param1][param3])
         {
            this._entitiesIconsNames[param1][param3] = new Vector.<String>(0);
         }
         if(this._entitiesIconsNames[param1][param3].indexOf(param2) == -1)
         {
            this._entitiesIconsNames[param1][param3].push(param2);
         }
         if(this._entitiesIcons[param1])
         {
            this._entitiesIcons[param1].needUpdate = true;
         }
      }
      
      public function updateAllIcons() : void {
         this._updateAllIcons = true;
         this.showIcons();
      }
      
      public function forceIconUpdate(param1:int) : void {
         this._entitiesIcons[param1].needUpdate = true;
      }
      
      private function removeAllIcons() : void {
         var _loc1_:* = undefined;
         for (_loc1_ in this._entitiesIconsNames)
         {
            delete this._entitiesIconsNames[[_loc1_]];
            this.removeIcon(_loc1_);
         }
      }
      
      public function removeIcon(param1:int, param2:String=null) : void {
         var _loc3_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         if(_loc3_)
         {
            _loc3_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
         }
         if(this._entitiesIcons[param1])
         {
            if(!param2)
            {
               this._entitiesIcons[param1].remove();
               delete this._entitiesIcons[[param1]];
            }
            else
            {
               this._entitiesIcons[param1].removeIcon(param2);
            }
         }
      }
      
      public function getIconNamesByCategory(param1:int, param2:int) : Vector.<String> {
         var _loc3_:Vector.<String> = null;
         if((this._entitiesIconsNames[param1]) && (this._entitiesIconsNames[param1][param2]))
         {
            _loc3_ = this._entitiesIconsNames[param1][param2];
         }
         return _loc3_;
      }
      
      public function removeIconsCategory(param1:int, param2:int) : void {
         var _loc3_:String = null;
         if((this._entitiesIconsNames[param1]) && (this._entitiesIconsNames[param1][param2]))
         {
            if(this._entitiesIcons[param1])
            {
               for each (_loc3_ in this._entitiesIconsNames[param1][param2])
               {
                  this._entitiesIcons[param1].removeIcon(_loc3_);
               }
            }
            delete this._entitiesIconsNames[param1][[param2]];
            if((this._entitiesIcons[param1]) && this._entitiesIcons[param1].length == 0)
            {
               delete this._entitiesIconsNames[[param1]];
               this.removeIcon(param1);
            }
         }
      }
      
      public function hasIcon(param1:int, param2:String=null) : Boolean {
         return this._entitiesIcons[param1]?param2?this._entitiesIcons[param1].hasIcon(param2):true:false;
      }
      
      private function showIcons(param1:Event=null) : void {
         var _loc2_:* = undefined;
         var _loc3_:DisplayObject = null;
         var _loc4_:AnimatedCharacter = null;
         var _loc5_:IRectangle = null;
         var _loc6_:Rectangle = null;
         var _loc7_:Rectangle2 = null;
         var _loc8_:EntityIcon = null;
         var _loc9_:Texture = null;
         var _loc10_:TiphonSprite = null;
         var _loc11_:DisplayObject = null;
         var _loc12_:* = undefined;
         var _loc13_:String = null;
         var _loc14_:* = false;
         for (_loc2_ in this._entitiesIconsNames)
         {
            _loc4_ = DofusEntities.getEntity(_loc2_) as AnimatedCharacter;
            if(!_loc4_)
            {
               delete this._entitiesIconsNames[[_loc2_]];
               if(this._entitiesIcons[_loc2_])
               {
                  this.removeIcon(_loc2_);
               }
            }
            else
            {
               _loc5_ = null;
               if((this._updateAllIcons) || (_loc4_.isMoving) || !this._entitiesIcons[_loc2_] || (this._entitiesIcons[_loc2_].needUpdate))
               {
                  if((this._entitiesIcons[_loc2_]) && (this._entitiesIcons[_loc2_].rendering))
                  {
                     continue;
                  }
                  _loc10_ = _loc4_ as TiphonSprite;
                  if((_loc4_.getSubEntitySlot(2,0)) && !this.isCreatureMode)
                  {
                     _loc10_ = _loc4_.getSubEntitySlot(2,0) as TiphonSprite;
                  }
                  _loc3_ = _loc10_.getSlot("Tete");
                  if(_loc3_)
                  {
                     _loc6_ = _loc3_.getBounds(StageShareManager.stage);
                     _loc7_ = new Rectangle2(_loc6_.x,_loc6_.y,_loc6_.width,_loc6_.height);
                     _loc5_ = _loc7_;
                     if(_loc5_.y - 30 - 10 < 0)
                     {
                        _loc11_ = _loc10_.getSlot("Pied");
                        if(_loc11_)
                        {
                           _loc6_ = _loc11_.getBounds(StageShareManager.stage);
                           _loc7_ = new Rectangle2(_loc6_.x,_loc6_.y + _loc5_.height + 30,_loc6_.width,_loc6_.height);
                           _loc5_ = _loc7_;
                        }
                     }
                  }
                  else
                  {
                     if(_loc10_ is IDisplayable)
                     {
                        _loc5_ = (_loc10_ as IDisplayable).absoluteBounds;
                     }
                     else
                     {
                        _loc6_ = _loc10_.getBounds(StageShareManager.stage);
                        _loc7_ = new Rectangle2(_loc6_.x,_loc6_.y,_loc6_.width,_loc6_.height);
                        _loc5_ = _loc7_;
                     }
                     if(_loc5_.y - 30 - 10 < 0)
                     {
                        _loc5_.y = _loc5_.y + (_loc5_.height + 30);
                     }
                  }
               }
               if(_loc5_)
               {
                  _loc8_ = this._entitiesIcons[_loc2_];
                  if(!_loc8_)
                  {
                     this._entitiesIcons[_loc2_] = new EntityIcon();
                     _loc8_ = this._entitiesIcons[_loc2_];
                     this._entitiesIconsContainer.addChild(_loc8_);
                  }
                  _loc14_ = false;
                  for (_loc12_ in this._entitiesIconsNames[_loc2_])
                  {
                     for each (_loc13_ in this._entitiesIconsNames[_loc2_][_loc12_])
                     {
                        if(!_loc8_.hasIcon(_loc13_))
                        {
                           _loc14_ = true;
                           _loc8_.addIcon(ICONS_FILEPATH + "|" + _loc13_,_loc13_);
                        }
                     }
                  }
                  if(!_loc14_)
                  {
                     if((this._entitiesIcons[_loc2_].needUpdate) && (!_loc4_.isMoving) && _loc4_.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == 0)
                     {
                        this._entitiesIcons[_loc2_].needUpdate = false;
                     }
                     if(_loc8_.scaleX != Atouin.getInstance().rootContainer.scaleX)
                     {
                        _loc8_.scaleX = Atouin.getInstance().rootContainer.scaleX;
                     }
                     if(_loc8_.scaleY != Atouin.getInstance().rootContainer.scaleY)
                     {
                        _loc8_.scaleY = Atouin.getInstance().rootContainer.scaleY;
                     }
                     if(_loc4_.rendered)
                     {
                        _loc8_.x = _loc5_.x + _loc5_.width / 2 - _loc8_.width / 2;
                        _loc8_.y = _loc5_.y - 10;
                     }
                     else
                     {
                        _loc8_.rendering = true;
                        _loc4_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
                        _loc4_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
                     }
                  }
               }
            }
         }
         this._updateAllIcons = false;
      }
      
      private function updateIconAfterRender(param1:TiphonEvent) : void {
         var _loc2_:AnimatedCharacter = param1.currentTarget as AnimatedCharacter;
         _loc2_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
         if(this._entitiesIcons[_loc2_.id])
         {
            this._entitiesIcons[_loc2_.id].rendering = false;
            this._entitiesIcons[_loc2_.id].needUpdate = true;
         }
      }
      
      private function onTiphonPropertyChanged(param1:PropertyChangeEvent) : void {
         if(param1.propertyName == "auraMode" && !(param1.propertyOldValue == param1.propertyValue))
         {
            if(this._auraCycleTimer.running)
            {
               this._auraCycleTimer.removeEventListener(TimerEvent.TIMER,this.onAuraCycleTimer);
               this._auraCycleTimer.stop();
            }
            switch(param1.propertyValue)
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
               default:
                  this.setEntitiesAura(true);
            }
         }
      }
      
      private function onAuraCycleTimer(param1:TimerEvent) : void {
         var _loc3_:* = 0;
         var _loc4_:AnimatedCharacter = null;
         var _loc5_:AnimatedCharacter = null;
         var _loc6_:AnimatedCharacter = null;
         var _loc2_:Vector.<int> = getEntitiesIdsList();
         if(this._auraCycleIndex >= _loc2_.length)
         {
            this._auraCycleIndex = 0;
         }
         var _loc7_:int = _loc2_.length;
         var _loc8_:* = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_ = DofusEntities.getEntity(_loc2_[_loc8_]) as AnimatedCharacter;
            if(_loc6_)
            {
               if(!_loc4_ && (_loc6_.hasAura) && _loc6_.getDirection() == DirectionsEnum.DOWN)
               {
                  _loc4_ = _loc6_;
                  _loc3_ = _loc8_;
               }
               if(_loc8_ == this._auraCycleIndex && (_loc6_.hasAura) && _loc6_.getDirection() == DirectionsEnum.DOWN)
               {
                  _loc5_ = _loc6_;
                  break;
               }
               if(!_loc6_.hasAura)
               {
                  this._auraCycleIndex++;
               }
            }
            _loc8_++;
         }
         if(this._lastEntityWithAura)
         {
            this._lastEntityWithAura.visibleAura = false;
         }
         if(_loc5_)
         {
            _loc5_.visibleAura = true;
            this._lastEntityWithAura = _loc5_;
         }
         else
         {
            if(!_loc5_ && (_loc4_))
            {
               _loc4_.visibleAura = true;
               this._lastEntityWithAura = _loc4_;
               this._auraCycleIndex = _loc3_;
            }
         }
         this._auraCycleIndex++;
      }
      
      private function setEntitiesAura(param1:Boolean) : void {
         var _loc3_:AnimatedCharacter = null;
         var _loc2_:Vector.<int> = getEntitiesIdsList();
         var _loc4_:* = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = DofusEntities.getEntity(_loc2_[_loc4_]) as AnimatedCharacter;
            if(_loc3_)
            {
               _loc3_.visibleAura = param1;
            }
            _loc4_++;
         }
      }
   }
}
