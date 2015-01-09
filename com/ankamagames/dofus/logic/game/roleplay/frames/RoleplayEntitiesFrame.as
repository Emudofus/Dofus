package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.data.XmlConfig;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import com.ankamagames.jerakine.newCache.ICache;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
    import flash.utils.Timer;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.jerakine.newCache.impl.Cache;
    import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
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
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
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
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsWithCoordsMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataInHouseMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.logic.game.roleplay.messages.DelayedActionMessage;
    import com.ankamagames.dofus.datacenter.communication.Emoticon;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HousePropertiesMessage;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
    import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayRequestMessage;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import flash.display.Sprite;
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import flash.geom.Rectangle;
    import com.ankamagames.dofus.logic.game.roleplay.types.FightTeam;
    import com.ankamagames.atouin.messages.MapLoadedMessage;
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
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
    import com.ankamagames.jerakine.types.enums.DirectionsEnum;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
    import com.ankamagames.dofus.misc.lists.PrismHookList;
    import com.ankamagames.dofus.misc.utils.EmbedAssets;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.atouin.messages.MapZoomMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.types.data.Follower;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.dofus.logic.game.roleplay.types.Fight;
    import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
    import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AlternativeMonstersInGroupLightInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformationsWithAlternatives;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupInformations;
    import com.ankamagames.dofus.network.types.game.look.IndexedEntityLook;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcWithQuestInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionFollowers;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
    import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.tiphon.types.IAnimationModifier;
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
    import com.ankamagames.jerakine.types.ASwf;
    import flash.display.MovieClip;
    import flash.utils.clearTimeout;
    import com.ankamagames.dofus.network.messages.game.context.mount.PaddockMoveItemRequestMessage;
    import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
    import com.ankamagames.dofus.network.enums.PrismStateEnum;
    import com.ankamagames.dofus.types.enums.EntityIconEnum;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.jerakine.utils.display.Rectangle2;
    import com.ankamagames.dofus.logic.game.roleplay.types.EntityIcon;
    import flash.geom.Point;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import __AS3__.vec.*;

    public class RoleplayEntitiesFrame extends AbstractEntitiesFrame implements Frame 
    {

        private static const ICONS_FILEPATH:String = (XmlConfig.getInstance().getEntry("config.content.path") + "gfx/icons/conquestIcon.swf");

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
        private var _updateAllIcons:Boolean;
        private var _waitingEmotesAnims:Dictionary;
        private var _auraCycleTimer:Timer;
        private var _auraCycleIndex:int;
        private var _lastEntityWithAura:AnimatedCharacter;
        private var _dispatchPlayerNewLook:Boolean;

        public function RoleplayEntitiesFrame()
        {
            this._paddockItem = new Dictionary();
            this._groundObjectCache = new Cache(20, new LruGarbageCollector());
            this._usableEmotes = new Array();
            this._npcList = new Dictionary(true);
            this._lastStaticAnimations = new Dictionary();
            this._entitiesIconsNames = new Dictionary();
            this._entitiesIcons = new Dictionary();
            this._waitingEmotesAnims = new Dictionary();
            super();
        }

        public function get currentEmoticon():uint
        {
            return (this._currentEmoticon);
        }

        public function set currentEmoticon(emoteId:uint):void
        {
            this._currentEmoticon = emoteId;
        }

        public function get dispatchPlayerNewLook():Boolean
        {
            return (this._dispatchPlayerNewLook);
        }

        public function set dispatchPlayerNewLook(pValue:Boolean):void
        {
            this._dispatchPlayerNewLook = pValue;
        }

        public function get fightNumber():uint
        {
            return (this._fightNumber);
        }

        public function get currentSubAreaId():uint
        {
            return (_currentSubAreaId);
        }

        public function get playersId():Array
        {
            return (this._playersId);
        }

        public function get housesInformations():Dictionary
        {
            return (this._housesList);
        }

        public function get fights():Dictionary
        {
            return (this._fights);
        }

        public function get isCreatureMode():Boolean
        {
            return (_creaturesMode);
        }

        public function get monstersIds():Vector.<int>
        {
            return (this._monstersIds);
        }

        public function get lastStaticAnimations():Dictionary
        {
            return (this._lastStaticAnimations);
        }

        override public function pushed():Boolean
        {
            var mirmsg:MapInformationsRequestMessage;
            this.initNewMap();
            this._playersId = new Array();
            this._monstersIds = new Vector.<int>();
            this._emoteTimesBySprite = new Dictionary();
            _entitiesVisibleNumber = 0;
            this._auraCycleIndex = 0;
            this._auraCycleTimer = new Timer(1800);
            if (OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_CYCLE)
            {
                this._auraCycleTimer.addEventListener(TimerEvent.TIMER, this.onAuraCycleTimer);
                this._auraCycleTimer.start();
            };
            if (MapDisplayManager.getInstance().currentMapRendered)
            {
                mirmsg = new MapInformationsRequestMessage();
                mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                ConnectionsHandler.getConnection().send(mirmsg);
            }
            else
            {
                this._waitForMap = true;
            };
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onGroundObjectLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onGroundObjectLoadFailed);
            _interactiveElements = new Vector.<InteractiveElement>();
            Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Tiphon.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onTiphonPropertyChanged);
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onAtouinPropertyChanged);
            this._allianceFrame = (Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame);
            EnterFrameDispatcher.addEventListener(this.showIcons, "showIcons", 25);
            return (super.pushed());
        }

        override public function process(msg:Message):Boolean
        {
            var char:AnimatedCharacter;
            var _local_3:MapComplementaryInformationsDataMessage;
            var _local_4:Boolean;
            var _local_5:InteractiveMapUpdateMessage;
            var _local_6:StatedMapUpdateMessage;
            var _local_7:HouseInformations;
            var _local_8:GameRolePlayShowActorMessage;
            var _local_9:GameContextRefreshEntityLookMessage;
            var _local_10:GameMapChangeOrientationMessage;
            var _local_11:GameMapChangeOrientationsMessage;
            var _local_12:int;
            var _local_13:GameRolePlaySetAnimationMessage;
            var _local_14:AnimatedCharacter;
            var _local_15:EntityMovementCompleteMessage;
            var _local_16:AnimatedCharacter;
            var _local_17:EntityMovementStoppedMessage;
            var _local_18:CharacterMovementStoppedMessage;
            var _local_19:AnimatedCharacter;
            var _local_20:GameRolePlayShowChallengeMessage;
            var _local_21:GameFightOptionStateUpdateMessage;
            var _local_22:GameFightUpdateTeamMessage;
            var _local_23:GameFightRemoveTeamMemberMessage;
            var _local_24:GameRolePlayRemoveChallengeMessage;
            var _local_25:GameContextRemoveElementMessage;
            var _local_26:uint;
            var _local_27:int;
            var _local_28:MapFightCountMessage;
            var _local_29:UpdateMapPlayersAgressableStatusMessage;
            var _local_30:int;
            var _local_31:int;
            var _local_32:GameRolePlayHumanoidInformations;
            var _local_33:*;
            var _local_34:UpdateSelfAgressableStatusMessage;
            var _local_35:GameRolePlayHumanoidInformations;
            var _local_36:*;
            var _local_37:ObjectGroundAddedMessage;
            var _local_38:ObjectGroundRemovedMessage;
            var _local_39:ObjectGroundRemovedMultipleMessage;
            var _local_40:ObjectGroundListAddedMessage;
            var _local_41:uint;
            var _local_42:PaddockRemoveItemRequestAction;
            var _local_43:PaddockRemoveItemRequestMessage;
            var _local_44:PaddockMoveItemRequestAction;
            var _local_45:Texture;
            var _local_46:ItemWrapper;
            var _local_47:GameDataPaddockObjectRemoveMessage;
            var _local_48:RoleplayContextFrame;
            var _local_49:GameDataPaddockObjectAddMessage;
            var _local_50:GameDataPaddockObjectListAddMessage;
            var _local_51:GameDataPlayFarmObjectAnimationMessage;
            var _local_52:MapNpcsQuestStatusUpdateMessage;
            var _local_53:ShowCellMessage;
            var _local_54:RoleplayContextFrame;
            var _local_55:String;
            var _local_56:String;
            var _local_57:StartZoomAction;
            var _local_58:DisplayObject;
            var _local_59:SwitchCreatureModeAction;
            var mirmsg:MapInformationsRequestMessage;
            var newSubArea:SubArea;
            var newCreatureMode:Boolean;
            var actor:GameRolePlayActorInformations;
            var mapWithNoMonsters:Boolean;
            var emoteId:int;
            var emoteStartTime:Number;
            var actor1:GameRolePlayActorInformations;
            var fight:FightCommonInformations;
            var mciwcmsg:MapComplementaryInformationsWithCoordsMessage;
            var mcidihmsg:MapComplementaryInformationsDataInHouseMessage;
            var playerHouse:Boolean;
            var ac:AnimatedCharacter;
            var hi:GameRolePlayCharacterInformations;
            var option:*;
            var dam:DelayedActionMessage;
            var emote:Emoticon;
            var staticOnly:Boolean;
            var time:Date;
            var animNameLook:TiphonEntityLook;
            var emoteAnimMsg:GameRolePlaySetAnimationMessage;
            var house:HouseInformations;
            var houseWrapper:HouseWrapper;
            var numDoors:int;
            var i:int;
            var hpmsg:HousePropertiesMessage;
            var mo:MapObstacle;
            var rpInfos:GameRolePlayCharacterInformations;
            var k:int;
            var orientation:ActorOrientation;
            var myAura:Emoticon;
            var rpEmoticonFrame:EmoticonFrame;
            var emoteId2:uint;
            var aura:Emoticon;
            var eprmsg:EmotePlayRequestMessage;
            var playerId:uint;
            var cell:uint;
            var objectId:uint;
            var item:PaddockItem;
            var cellId:uint;
            var npc:TiphonSprite;
            var questClip:Sprite;
            var iq:int;
            var nbnpcqnr:int;
            var q:Quest;
            var rect:Rectangle;
            var id:*;
            var entity:*;
            var fightTeam:FightTeam;
            switch (true)
            {
                case (msg is MapLoadedMessage):
                    if (this._waitForMap)
                    {
                        mirmsg = new MapInformationsRequestMessage();
                        mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                        ConnectionsHandler.getConnection().send(mirmsg);
                        this._waitForMap = false;
                    };
                    return (false);
                case (msg is MapComplementaryInformationsDataMessage):
                    _local_3 = (msg as MapComplementaryInformationsDataMessage);
                    _local_4 = false;
                    if (((((_worldPoint) && ((_worldPoint.mapId == _local_3.mapId)))) && (!((msg is MapComplementaryInformationsWithCoordsMessage)))))
                    {
                        _local_4 = true;
                    };
                    _interactiveElements = _local_3.interactiveElements;
                    this._fightNumber = _local_3.fights.length;
                    if (!(_local_4))
                    {
                        this.initNewMap();
                        if ((msg is MapComplementaryInformationsWithCoordsMessage))
                        {
                            mciwcmsg = (msg as MapComplementaryInformationsWithCoordsMessage);
                            if (PlayedCharacterManager.getInstance().isInHouse)
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                            };
                            PlayedCharacterManager.getInstance().isInHouse = false;
                            PlayedCharacterManager.getInstance().isInHisHouse = false;
                            PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mciwcmsg.worldX, mciwcmsg.worldY);
                            _worldPoint = new WorldPointWrapper(mciwcmsg.mapId, true, mciwcmsg.worldX, mciwcmsg.worldY);
                        }
                        else
                        {
                            if ((msg is MapComplementaryInformationsDataInHouseMessage))
                            {
                                mcidihmsg = (msg as MapComplementaryInformationsDataInHouseMessage);
                                playerHouse = (PlayerManager.getInstance().nickname == mcidihmsg.currentHouse.ownerName);
                                PlayedCharacterManager.getInstance().isInHouse = true;
                                if (playerHouse)
                                {
                                    PlayedCharacterManager.getInstance().isInHisHouse = true;
                                };
                                PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mcidihmsg.currentHouse.worldX, mcidihmsg.currentHouse.worldY);
                                KernelEventsManager.getInstance().processCallback(HookList.HouseEntered, playerHouse, mcidihmsg.currentHouse.ownerId, mcidihmsg.currentHouse.ownerName, mcidihmsg.currentHouse.price, mcidihmsg.currentHouse.isLocked, mcidihmsg.currentHouse.worldX, mcidihmsg.currentHouse.worldY, HouseWrapper.manualCreate(mcidihmsg.currentHouse.modelId, -1, mcidihmsg.currentHouse.ownerName, !((mcidihmsg.currentHouse.price == 0))));
                                _worldPoint = new WorldPointWrapper(mcidihmsg.mapId, true, mcidihmsg.currentHouse.worldX, mcidihmsg.currentHouse.worldY);
                            }
                            else
                            {
                                _worldPoint = new WorldPointWrapper(_local_3.mapId);
                                if (PlayedCharacterManager.getInstance().isInHouse)
                                {
                                    KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                                };
                                PlayedCharacterManager.getInstance().isInHouse = false;
                                PlayedCharacterManager.getInstance().isInHisHouse = false;
                            };
                        };
                        _currentSubAreaId = _local_3.subAreaId;
                        newSubArea = SubArea.getSubAreaById(_currentSubAreaId);
                        PlayedCharacterManager.getInstance().currentMap = _worldPoint;
                        PlayedCharacterManager.getInstance().currentSubArea = newSubArea;
                        TooltipManager.hide();
                        updateCreaturesLimit();
                        newCreatureMode = false;
                        if (!(this._playersId))
                        {
                            this._playersId = new Array();
                        };
                        for each (actor in _local_3.actors)
                        {
                            if ((((actor.contextualId > 0)) && ((this._playersId.indexOf(actor.contextualId) == -1))))
                            {
                                this._playersId.push(actor.contextualId);
                            };
                            if ((((actor is GameRolePlayGroupMonsterInformations)) && ((this._monstersIds.indexOf(actor.contextualId) == -1))))
                            {
                                this._monstersIds.push(actor.contextualId);
                            };
                        };
                        _entitiesVisibleNumber = (this._playersId.length + this._monstersIds.length);
                        if ((((_creaturesLimit == 0)) || ((((_creaturesLimit < 50)) && ((_entitiesVisibleNumber >= _creaturesLimit))))))
                        {
                            _creaturesMode = true;
                        };
                        mapWithNoMonsters = true;
                        emoteId = 0;
                        emoteStartTime = 0;
                        for each (actor1 in _local_3.actors)
                        {
                            ac = (this.addOrUpdateActor(actor1) as AnimatedCharacter);
                            if (ac)
                            {
                                if (ac.id == PlayedCharacterManager.getInstance().id)
                                {
                                    if (ac.libraryIsAvaible)
                                    {
                                        this.updateUsableEmotesListInit(ac.look);
                                    }
                                    else
                                    {
                                        ac.addEventListener(TiphonEvent.SPRITE_INIT, this.onPlayerSpriteInit);
                                    };
                                    if (this.dispatchPlayerNewLook)
                                    {
                                        KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange, ac.look);
                                        this.dispatchPlayerNewLook = false;
                                    };
                                };
                                hi = (actor1 as GameRolePlayCharacterInformations);
                                if (hi)
                                {
                                    emoteId = 0;
                                    emoteStartTime = 0;
                                    for each (option in hi.humanoidInfo.options)
                                    {
                                        if ((option is HumanOptionEmote))
                                        {
                                            emoteId = option.emoteId;
                                            emoteStartTime = option.emoteStartTime;
                                        }
                                        else
                                        {
                                            if ((option is HumanOptionObjectUse))
                                            {
                                                dam = new DelayedActionMessage(hi.contextualId, option.objectGID, option.delayEndTime);
                                                Kernel.getWorker().process(dam);
                                            };
                                        };
                                    };
                                    if (emoteId > 0)
                                    {
                                        emote = Emoticon.getEmoticonById(emoteId);
                                        if (((emote) && (emote.persistancy)))
                                        {
                                            this._currentEmoticon = emote.id;
                                            if (!(emote.aura))
                                            {
                                                staticOnly = false;
                                                time = new Date();
                                                if ((time.getTime() - emoteStartTime) >= emote.duration)
                                                {
                                                    staticOnly = true;
                                                };
                                                animNameLook = EntityLookAdapter.fromNetwork(hi.look);
                                                emoteAnimMsg = new GameRolePlaySetAnimationMessage(actor1, emote.getAnimName(animNameLook), emoteStartTime, !(emote.persistancy), emote.eight_directions, staticOnly);
                                                if (ac.rendered)
                                                {
                                                    this.process(emoteAnimMsg);
                                                }
                                                else
                                                {
                                                    if (emoteAnimMsg.playStaticOnly)
                                                    {
                                                        ac.visible = false;
                                                    };
                                                    this._waitingEmotesAnims[ac.id] = emoteAnimMsg;
                                                    ac.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityReadyForEmote);
                                                    ac.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityReadyForEmote);
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                            if (mapWithNoMonsters)
                            {
                                if ((actor1 is GameRolePlayGroupMonsterInformations))
                                {
                                    mapWithNoMonsters = false;
                                    KernelEventsManager.getInstance().processCallback(TriggerHookList.MapWithMonsters);
                                };
                            };
                            if ((actor1 is GameRolePlayCharacterInformations))
                            {
                                ChatAutocompleteNameManager.getInstance().addEntry((actor1 as GameRolePlayCharacterInformations).name, 0);
                            };
                        };
                        for each (fight in _local_3.fights)
                        {
                            this.addFight(fight);
                        };
                    };
                    this._housesList = new Dictionary();
                    for each (house in _local_3.houses)
                    {
                        houseWrapper = HouseWrapper.create(house);
                        numDoors = house.doorsOnMap.length;
                        i = 0;
                        while (i < numDoors)
                        {
                            this._housesList[house.doorsOnMap[i]] = houseWrapper;
                            i++;
                        };
                        hpmsg = new HousePropertiesMessage();
                        hpmsg.initHousePropertiesMessage(house);
                        Kernel.getWorker().process(hpmsg);
                    };
                    for each (mo in _local_3.obstacles)
                    {
                        InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId, (mo.state == MapObstacleStateEnum.OBSTACLE_OPENED));
                    };
                    _local_5 = new InteractiveMapUpdateMessage();
                    _local_5.initInteractiveMapUpdateMessage(_local_3.interactiveElements);
                    Kernel.getWorker().process(_local_5);
                    _local_6 = new StatedMapUpdateMessage();
                    _local_6.initStatedMapUpdateMessage(_local_3.statedElements);
                    Kernel.getWorker().process(_local_6);
                    if (!(_local_4))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData, PlayedCharacterManager.getInstance().currentMap, _currentSubAreaId, Dofus.getInstance().options.mapCoordinates);
                        if (OptionManager.getOptionManager("dofus")["allowAnimsFun"] == true)
                        {
                            AnimFunManager.getInstance().initializeByMap(_local_3.mapId);
                        };
                        this.switchPokemonMode();
                        if (Kernel.getWorker().contains(MonstersInfoFrame))
                        {
                            (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).update();
                        };
                        if (Kernel.getWorker().contains(InfoEntitiesFrame))
                        {
                            (Kernel.getWorker().getFrame(InfoEntitiesFrame) as InfoEntitiesFrame).update();
                        };
                    };
                    return (false);
                case (msg is HousePropertiesMessage):
                    _local_7 = (msg as HousePropertiesMessage).properties;
                    houseWrapper = HouseWrapper.create(_local_7);
                    numDoors = _local_7.doorsOnMap.length;
                    i = 0;
                    while (i < numDoors)
                    {
                        this._housesList[_local_7.doorsOnMap[i]] = houseWrapper;
                        i++;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.HouseProperties, _local_7.houseId, _local_7.doorsOnMap, _local_7.ownerName, _local_7.isOnSale, _local_7.modelId);
                    return (true);
                case (msg is GameRolePlayShowActorMessage):
                    _local_8 = (msg as GameRolePlayShowActorMessage);
                    char = (DofusEntities.getEntity(_local_8.informations.contextualId) as AnimatedCharacter);
                    if (((char) && ((char.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == -1))))
                    {
                        char.visibleAura = false;
                    };
                    if (!(char))
                    {
                        updateCreaturesLimit();
                    };
                    char = this.addOrUpdateActor(_local_8.informations);
                    if (((char) && ((_local_8.informations.contextualId == PlayedCharacterManager.getInstance().id))))
                    {
                        if (char.libraryIsAvaible)
                        {
                            this.updateUsableEmotesListInit(char.look);
                        }
                        else
                        {
                            char.addEventListener(TiphonEvent.SPRITE_INIT, this.onPlayerSpriteInit);
                        };
                    };
                    if (this.switchPokemonMode())
                    {
                        return (true);
                    };
                    if ((_local_8.informations is GameRolePlayCharacterInformations))
                    {
                        ChatAutocompleteNameManager.getInstance().addEntry((_local_8.informations as GameRolePlayCharacterInformations).name, 0);
                    };
                    if ((((_local_8.informations is GameRolePlayCharacterInformations)) && ((PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE))))
                    {
                        rpInfos = (_local_8.informations as GameRolePlayCharacterInformations);
                        switch (PlayedCharacterManager.getInstance().levelDiff((rpInfos.alignmentInfos.characterPower - _local_8.informations.contextualId)))
                        {
                            case -1:
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
                                break;
                            case 1:
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
                                break;
                        };
                    };
                    if ((((OptionManager.getOptionManager("dofus")["allowAnimsFun"] == true)) && ((_local_8.informations is GameRolePlayGroupMonsterInformations))))
                    {
                        AnimFunManager.getInstance().restart();
                    };
                    return (true);
                case (msg is GameContextRefreshEntityLookMessage):
                    _local_9 = (msg as GameContextRefreshEntityLookMessage);
                    char = this.updateActorLook(_local_9.id, _local_9.look, true);
                    if (((char) && ((_local_9.id == PlayedCharacterManager.getInstance().id))))
                    {
                        if (char.libraryIsAvaible)
                        {
                            this.updateUsableEmotesListInit(char.look);
                        }
                        else
                        {
                            char.addEventListener(TiphonEvent.SPRITE_INIT, this.onPlayerSpriteInit);
                        };
                    };
                    return (true);
                case (msg is GameMapChangeOrientationMessage):
                    _local_10 = (msg as GameMapChangeOrientationMessage);
                    updateActorOrientation(_local_10.orientation.id, _local_10.orientation.direction);
                    return (true);
                case (msg is GameMapChangeOrientationsMessage):
                    _local_11 = (msg as GameMapChangeOrientationsMessage);
                    _local_12 = _local_11.orientations.length;
                    k = 0;
                    while (k < _local_12)
                    {
                        orientation = _local_11.orientations[k];
                        updateActorOrientation(orientation.id, orientation.direction);
                        k++;
                    };
                    return (true);
                case (msg is GameRolePlaySetAnimationMessage):
                    _local_13 = (msg as GameRolePlaySetAnimationMessage);
                    _local_14 = (DofusEntities.getEntity(_local_13.informations.contextualId) as AnimatedCharacter);
                    if (!(_local_14))
                    {
                        _log.error((("GameRolePlaySetAnimationMessage : l'entitée " + _local_13.informations.contextualId) + " n'a pas ete trouvee"));
                        return (true);
                    };
                    this.playAnimationOnEntity(_local_14, _local_13.animation, _local_13.directions8, _local_13.duration, _local_13.playStaticOnly);
                    return (true);
                case (msg is EntityMovementCompleteMessage):
                    _local_15 = (msg as EntityMovementCompleteMessage);
                    _local_16 = (_local_15.entity as AnimatedCharacter);
                    if (_entities[_local_16.getRootEntity().id])
                    {
                        (_entities[_local_16.getRootEntity().id] as GameContextActorInformations).disposition.cellId = _local_16.position.cellId;
                    };
                    if (this._entitiesIcons[_local_15.entity.id])
                    {
                        this._entitiesIcons[_local_15.entity.id].needUpdate = true;
                    };
                    return (false);
                case (msg is EntityMovementStoppedMessage):
                    _local_17 = (msg as EntityMovementStoppedMessage);
                    if (this._entitiesIcons[_local_17.entity.id])
                    {
                        this._entitiesIcons[_local_17.entity.id].needUpdate = true;
                    };
                    return (false);
                case (msg is CharacterMovementStoppedMessage):
                    _local_18 = (msg as CharacterMovementStoppedMessage);
                    _local_19 = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter);
                    if ((((((((((OptionManager.getOptionManager("tiphon").auraMode > OptionEnum.AURA_NONE)) && (OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront))) && ((_local_19.getDirection() == DirectionsEnum.DOWN)))) && (!((_local_19.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == -1))))) && ((PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING))))
                    {
                        rpEmoticonFrame = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame);
                        for each (emoteId2 in rpEmoticonFrame.emotes)
                        {
                            aura = Emoticon.getEmoticonById(emoteId2);
                            if (((aura) && (aura.aura)))
                            {
                                if (((!(myAura)) || ((aura.weight > myAura.weight))))
                                {
                                    myAura = aura;
                                };
                            };
                        };
                        if (myAura)
                        {
                            eprmsg = new EmotePlayRequestMessage();
                            eprmsg.initEmotePlayRequestMessage(myAura.id);
                            ConnectionsHandler.getConnection().send(eprmsg);
                        };
                    };
                    return (true);
                case (msg is GameRolePlayShowChallengeMessage):
                    _local_20 = (msg as GameRolePlayShowChallengeMessage);
                    this.addFight(_local_20.commonsInfos);
                    return (true);
                case (msg is GameFightOptionStateUpdateMessage):
                    _local_21 = (msg as GameFightOptionStateUpdateMessage);
                    this.updateSwordOptions(_local_21.fightId, _local_21.teamId, _local_21.option, _local_21.state);
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightOptionStateUpdate, _local_21.fightId, _local_21.teamId, _local_21.option, _local_21.state);
                    return (true);
                case (msg is GameFightUpdateTeamMessage):
                    _local_22 = (msg as GameFightUpdateTeamMessage);
                    this.updateFight(_local_22.fightId, _local_22.team);
                    return (true);
                case (msg is GameFightRemoveTeamMemberMessage):
                    _local_23 = (msg as GameFightRemoveTeamMemberMessage);
                    this.removeFighter(_local_23.fightId, _local_23.teamId, _local_23.charId);
                    return (true);
                case (msg is GameRolePlayRemoveChallengeMessage):
                    _local_24 = (msg as GameRolePlayRemoveChallengeMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayRemoveFight, _local_24.fightId);
                    this.removeFight(_local_24.fightId);
                    return (true);
                case (msg is GameContextRemoveElementMessage):
                    _local_25 = (msg as GameContextRemoveElementMessage);
                    delete this._lastStaticAnimations[_local_25.id];
                    _local_26 = 0;
                    for each (playerId in this._playersId)
                    {
                        if (playerId == _local_25.id)
                        {
                            this._playersId.splice(_local_26, 1);
                        }
                        else
                        {
                            _local_26++;
                        };
                    };
                    _local_27 = this._monstersIds.indexOf(_local_25.id);
                    if (_local_27 != -1)
                    {
                        this._monstersIds.splice(_local_27, 1);
                    };
                    if (this._entitiesIconsNames[_local_25.id])
                    {
                        delete this._entitiesIconsNames[_local_25.id];
                    };
                    if (this._entitiesIcons[_local_25.id])
                    {
                        this.removeIcon(_local_25.id);
                    };
                    delete this._waitingEmotesAnims[_local_25.id];
                    this.removeEntityListeners(_local_25.id);
                    removeActor(_local_25.id);
                    if ((((OptionManager.getOptionManager("dofus")["allowAnimsFun"] == true)) && (!((_local_27 == -1)))))
                    {
                        AnimFunManager.getInstance().restart();
                    };
                    return (true);
                case (msg is MapFightCountMessage):
                    _local_28 = (msg as MapFightCountMessage);
                    trace(("Nombre de combat(s) sur la carte : " + _local_28.fightCount));
                    KernelEventsManager.getInstance().processCallback(HookList.MapFightCount, _local_28.fightCount);
                    return (true);
                case (msg is UpdateMapPlayersAgressableStatusMessage):
                    _local_29 = (msg as UpdateMapPlayersAgressableStatusMessage);
                    _local_31 = _local_29.playerIds.length;
                    _local_30 = 0;
                    while (_local_30 < _local_31)
                    {
                        _local_32 = (getEntityInfos(_local_29.playerIds[_local_30]) as GameRolePlayHumanoidInformations);
                        if (_local_32)
                        {
                            for each (_local_33 in _local_32.humanoidInfo.options)
                            {
                                if ((_local_33 is HumanOptionAlliance))
                                {
                                    (_local_33 as HumanOptionAlliance).aggressable = _local_29.enable[_local_30];
                                    break;
                                };
                            };
                        };
                        if (_local_29.playerIds[_local_30] == PlayedCharacterManager.getInstance().id)
                        {
                            PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = _local_29.enable[_local_30];
                            KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange, _local_29.enable[_local_30], 0);
                        };
                        _local_30++;
                    };
                    this.updateConquestIcons(_local_29.playerIds);
                    return (true);
                case (msg is UpdateSelfAgressableStatusMessage):
                    _local_34 = (msg as UpdateSelfAgressableStatusMessage);
                    _local_35 = (getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayHumanoidInformations);
                    if (_local_35)
                    {
                        for each (_local_36 in _local_35.humanoidInfo.options)
                        {
                            if ((_local_36 is HumanOptionAlliance))
                            {
                                (_local_36 as HumanOptionAlliance).aggressable = _local_34.status;
                                break;
                            };
                        };
                    };
                    if (PlayedCharacterManager.getInstance().characteristics)
                    {
                        PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = _local_34.status;
                    };
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange, _local_34.status, _local_34.probationTime);
                    this.updateConquestIcons(PlayedCharacterManager.getInstance().id);
                    return (true);
                case (msg is ObjectGroundAddedMessage):
                    _local_37 = (msg as ObjectGroundAddedMessage);
                    this.addObject(_local_37.objectGID, _local_37.cellId);
                    return (true);
                case (msg is ObjectGroundRemovedMessage):
                    _local_38 = (msg as ObjectGroundRemovedMessage);
                    this.removeObject(_local_38.cell);
                    return (true);
                case (msg is ObjectGroundRemovedMultipleMessage):
                    _local_39 = (msg as ObjectGroundRemovedMultipleMessage);
                    for each (cell in _local_39.cells)
                    {
                        this.removeObject(cell);
                    };
                    return (true);
                case (msg is ObjectGroundListAddedMessage):
                    _local_40 = (msg as ObjectGroundListAddedMessage);
                    _local_41 = 0;
                    for each (objectId in _local_40.referenceIds)
                    {
                        this.addObject(objectId, _local_40.cells[_local_41]);
                        _local_41++;
                    };
                    return (true);
                case (msg is PaddockRemoveItemRequestAction):
                    _local_42 = (msg as PaddockRemoveItemRequestAction);
                    _local_43 = new PaddockRemoveItemRequestMessage();
                    _local_43.initPaddockRemoveItemRequestMessage(_local_42.cellId);
                    ConnectionsHandler.getConnection().send(_local_43);
                    return (true);
                case (msg is PaddockMoveItemRequestAction):
                    _local_44 = (msg as PaddockMoveItemRequestAction);
                    this._currentPaddockItemCellId = _local_44.object.disposition.cellId;
                    _local_45 = new Texture();
                    _local_46 = ItemWrapper.create(0, 0, _local_44.object.item.id, 0, null, false);
                    _local_45.uri = _local_46.iconUri;
                    _local_45.finalize();
                    Kernel.getWorker().addFrame(new RoleplayPointCellFrame(this.onCellPointed, _local_45, true, this.paddockCellValidator, true));
                    return (true);
                case (msg is GameDataPaddockObjectRemoveMessage):
                    _local_47 = (msg as GameDataPaddockObjectRemoveMessage);
                    _local_48 = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
                    this.removePaddockItem(_local_47.cellId);
                    return (true);
                case (msg is GameDataPaddockObjectAddMessage):
                    _local_49 = (msg as GameDataPaddockObjectAddMessage);
                    this.addPaddockItem(_local_49.paddockItemDescription);
                    return (true);
                case (msg is GameDataPaddockObjectListAddMessage):
                    _local_50 = (msg as GameDataPaddockObjectListAddMessage);
                    for each (item in _local_50.paddockItemDescription)
                    {
                        this.addPaddockItem(item);
                    };
                    return (true);
                case (msg is GameDataPlayFarmObjectAnimationMessage):
                    _local_51 = (msg as GameDataPlayFarmObjectAnimationMessage);
                    for each (cellId in _local_51.cellId)
                    {
                        this.activatePaddockItem(cellId);
                    };
                    return (true);
                case (msg is MapNpcsQuestStatusUpdateMessage):
                    _local_52 = (msg as MapNpcsQuestStatusUpdateMessage);
                    if (MapDisplayManager.getInstance().currentMapPoint.mapId == _local_52.mapId)
                    {
                        for each (npc in this._npcList)
                        {
                            this.removeBackground(npc);
                        };
                        nbnpcqnr = _local_52.npcsIdsWithQuest.length;
                        iq = 0;
                        while (iq < nbnpcqnr)
                        {
                            npc = this._npcList[_local_52.npcsIdsWithQuest[iq]];
                            if (npc)
                            {
                                q = Quest.getFirstValidQuest(_local_52.questFlags[iq]);
                                if (q != null)
                                {
                                    if (_local_52.questFlags[iq].questsToStartId.indexOf(q.id) != -1)
                                    {
                                        if (q.repeatType == 0)
                                        {
                                            questClip = EmbedAssets.getSprite("QUEST_CLIP");
                                            npc.addBackground("questClip", questClip, true);
                                        }
                                        else
                                        {
                                            questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                                            npc.addBackground("questRepeatableClip", questClip, true);
                                        };
                                    }
                                    else
                                    {
                                        if (q.repeatType == 0)
                                        {
                                            questClip = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                                            npc.addBackground("questObjectiveClip", questClip, true);
                                        }
                                        else
                                        {
                                            questClip = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                                            npc.addBackground("questRepeatableObjectiveClip", questClip, true);
                                        };
                                    };
                                };
                            };
                            iq++;
                        };
                    };
                    return (true);
                case (msg is ShowCellMessage):
                    _local_53 = (msg as ShowCellMessage);
                    HyperlinkShowCellManager.showCell(_local_53.cellId);
                    _local_54 = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
                    _local_55 = _local_54.getActorName(_local_53.sourceId);
                    _local_56 = I18n.getUiText("ui.fight.showCell", [_local_55, (((("{cell," + _local_53.cellId) + "::") + _local_53.cellId) + "}")]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_56, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is StartZoomAction):
                    _local_57 = (msg as StartZoomAction);
                    if (Atouin.getInstance().currentZoom != 1)
                    {
                        Atouin.getInstance().cancelZoom();
                        KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                        this.updateAllIcons();
                        return (true);
                    };
                    _local_58 = (DofusEntities.getEntity(_local_57.playerId) as DisplayObject);
                    if (((_local_58) && (_local_58.stage)))
                    {
                        rect = _local_58.getRect(Atouin.getInstance().worldContainer);
                        Atouin.getInstance().zoom(_local_57.value, (rect.x + (rect.width / 2)), (rect.y + (rect.height / 2)));
                        KernelEventsManager.getInstance().processCallback(HookList.StartZoom, true);
                        this.updateAllIcons();
                    };
                    return (true);
                case (msg is SwitchCreatureModeAction):
                    _local_59 = (msg as SwitchCreatureModeAction);
                    if (_creaturesMode != _local_59.isActivated)
                    {
                        _creaturesMode = _local_59.isActivated;
                        for (id in _entities)
                        {
                            this.updateActorLook(id, (_entities[id] as GameContextActorInformations).look);
                        };
                    };
                    return (true);
                case (msg is MapZoomMessage):
                    for each (entity in _entities)
                    {
                        fightTeam = (entity as FightTeam);
                        if (((((fightTeam) && (fightTeam.fight))) && (fightTeam.teamInfos)))
                        {
                            this.updateSwordOptions(fightTeam.fight.fightId, fightTeam.teamInfos.teamId);
                        };
                    };
                    return (true);
            };
            return (false);
        }

        private function playAnimationOnEntity(characterEntity:AnimatedCharacter, animation:String, directions8:Boolean, duration:uint, playStaticOnly:Boolean):void
        {
            var f:Follower;
            var rider:TiphonSprite;
            if (animation == AnimationEnum.ANIM_STATIQUE)
            {
                this._currentEmoticon = 0;
                characterEntity.setAnimation(animation);
                this._emoteTimesBySprite[characterEntity.name] = 0;
            }
            else
            {
                if (!(directions8))
                {
                    if ((characterEntity.getDirection() % 2) == 0)
                    {
                        characterEntity.setDirection((characterEntity.getDirection() + 1));
                    };
                };
                if (((_creaturesMode) || (!(characterEntity.hasAnimation(animation, characterEntity.getDirection())))))
                {
                    _log.error((((("L'animation " + animation) + "_") + characterEntity.getDirection()) + " est introuvable."));
                    characterEntity.visible = true;
                }
                else
                {
                    if (!(_creaturesMode))
                    {
                        this._emoteTimesBySprite[characterEntity.name] = duration;
                        characterEntity.removeEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                        characterEntity.addEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                        rider = (characterEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite);
                        if (rider)
                        {
                            rider.removeEventListener(TiphonEvent.ANIMATION_ADDED, this.onAnimationAdded);
                            rider.addEventListener(TiphonEvent.ANIMATION_ADDED, this.onAnimationAdded);
                        };
                        characterEntity.setAnimation(animation);
                        if (playStaticOnly)
                        {
                            if (((characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET)) && (characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length)))
                            {
                                characterEntity.setSubEntityBehaviour(1, new AnimStatiqueSubEntityBehavior());
                            };
                            characterEntity.stopAnimationAtLastFrame();
                            if (rider)
                            {
                                rider.stopAnimationAtLastFrame();
                            };
                        };
                    };
                };
            };
            for each (f in characterEntity.followers)
            {
                if ((((f.type == Follower.TYPE_PET)) && ((f.entity is AnimatedCharacter))))
                {
                    this.playAnimationOnEntity((f.entity as AnimatedCharacter), animation, directions8, duration, playStaticOnly);
                };
            };
        }

        private function initNewMap():void
        {
            var go:*;
            for each (go in this._objectsByCellId)
            {
                (go as IDisplayable).remove();
            };
            this._npcList = new Dictionary();
            this._fights = new Dictionary();
            this._objects = new Dictionary();
            this._objectsByCellId = new Dictionary();
            this._paddockItem = new Dictionary();
        }

        override protected function switchPokemonMode():Boolean
        {
            if (super.switchPokemonMode())
            {
                KernelEventsManager.getInstance().processCallback(TriggerHookList.CreaturesMode);
                return (true);
            };
            return (false);
        }

        override public function pulled():Boolean
        {
            var fight:Fight;
            var team:FightTeam;
            for each (fight in this._fights)
            {
                for each (team in fight.teams)
                {
                    (team.teamEntity as TiphonSprite).removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onFightEntityRendered);
                    TooltipManager.hide(((("fightOptions_" + fight.fightId) + "_") + team.teamInfos.teamId));
                };
            };
            if (this._loader)
            {
                this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onGroundObjectLoaded);
                this._loader.removeEventListener(ResourceErrorEvent.ERROR, this.onGroundObjectLoadFailed);
                this._loader = null;
            };
            if (OptionManager.getOptionManager("dofus")["allowAnimsFun"] == true)
            {
                AnimFunManager.getInstance().stop();
            };
            this._fights = null;
            this._objects = null;
            this._npcList = null;
            Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Tiphon.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onTiphonPropertyChanged);
            Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onAtouinPropertyChanged);
            EnterFrameDispatcher.removeEventListener(this.showIcons);
            this.removeAllIcons();
            if (OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_CYCLE)
            {
                this._auraCycleTimer.removeEventListener(TimerEvent.TIMER, this.onAuraCycleTimer);
                this._auraCycleTimer.stop();
            };
            this._lastEntityWithAura = null;
            return (super.pulled());
        }

        public function isFight(entityId:int):Boolean
        {
            return ((_entities[entityId] is FightTeam));
        }

        public function isPaddockItem(entityId:int):Boolean
        {
            return ((_entities[entityId] is GameContextPaddockItemInformations));
        }

        public function getFightTeam(entityId:int):FightTeam
        {
            return ((_entities[entityId] as FightTeam));
        }

        public function getFightId(entityId:int):uint
        {
            return ((_entities[entityId] as FightTeam).fight.fightId);
        }

        public function getFightLeaderId(entityId:int):uint
        {
            return ((_entities[entityId] as FightTeam).teamInfos.leaderId);
        }

        public function getFightTeamType(entityId:int):uint
        {
            return ((_entities[entityId] as FightTeam).teamType);
        }

        public function updateMonstersGroups():void
        {
            var entityInfo:GameContextActorInformations;
            var entities:Dictionary = getEntitiesDictionnary();
            for each (entityInfo in entities)
            {
                if ((entityInfo is GameRolePlayGroupMonsterInformations))
                {
                    this.updateMonstersGroup((entityInfo as GameRolePlayGroupMonsterInformations));
                };
            };
        }

        private function updateMonstersGroup(pMonstersInfo:GameRolePlayGroupMonsterInformations):void
        {
            var monsterInfos:MonsterInGroupLightInformations;
            var i:uint;
            var underling:MonsterInGroupLightInformations;
            var monster:Monster;
            var monsterGrade:int;
            var monstersGroup:Vector.<MonsterInGroupLightInformations> = this.getMonsterGroup(pMonstersInfo.staticInfos);
            var groupHasMiniBoss:Boolean = Monster.getMonsterById(pMonstersInfo.staticInfos.mainCreatureLightInfos.creatureGenericId).isMiniBoss;
            if (monstersGroup)
            {
                for each (monsterInfos in monstersGroup)
                {
                    if (monsterInfos.creatureGenericId == pMonstersInfo.staticInfos.mainCreatureLightInfos.creatureGenericId)
                    {
                        monstersGroup.splice(monstersGroup.indexOf(monsterInfos), 1);
                        break;
                    };
                };
            };
            var followersLooks:Vector.<EntityLook> = ((Dofus.getInstance().options.showEveryMonsters) ? new Vector.<EntityLook>(((!(monstersGroup)) ? pMonstersInfo.staticInfos.underlings.length : monstersGroup.length), true) : null);
            var followersSpeeds:Vector.<Number> = ((followersLooks) ? new Vector.<Number>(followersLooks.length, true) : null);
            for each (underling in pMonstersInfo.staticInfos.underlings)
            {
                if (followersLooks)
                {
                    monster = Monster.getMonsterById(underling.creatureGenericId);
                    monsterGrade = -1;
                    if (!(monstersGroup))
                    {
                        monsterGrade = 0;
                    }
                    else
                    {
                        for each (monsterInfos in monstersGroup)
                        {
                            if (monsterInfos.creatureGenericId == underling.creatureGenericId)
                            {
                                monstersGroup.splice(monstersGroup.indexOf(monsterInfos), 1);
                                monsterGrade = monsterInfos.grade;
                                break;
                            };
                        };
                    };
                    if (monsterGrade >= 0)
                    {
                        followersSpeeds[i] = monster.speedAdjust;
                        followersLooks[i] = EntityLookAdapter.toNetwork(TiphonEntityLook.fromString(monster.look));
                        i++;
                    };
                };
                if (((!(groupHasMiniBoss)) && (Monster.getMonsterById(underling.creatureGenericId).isMiniBoss)))
                {
                    groupHasMiniBoss = true;
                    if (!(followersLooks))
                    {
                        break;
                    };
                };
            };
            if (followersLooks)
            {
                this.manageFollowers((DofusEntities.getEntity(pMonstersInfo.contextualId) as AnimatedCharacter), followersLooks, followersSpeeds, null, true);
            };
        }

        private function getMonsterGroup(pStaticMonsterInfos:GroupMonsterStaticInformations):Vector.<MonsterInGroupLightInformations>
        {
            var newGroup:Vector.<MonsterInGroupLightInformations>;
            var pmf:PartyManagementFrame;
            var partyMembers:Vector.<PartyMemberWrapper>;
            var nbMembers:int;
            var monsterGroup:AlternativeMonstersInGroupLightInformations;
            var _local_8:PartyMemberWrapper;
            var infos:GroupMonsterStaticInformationsWithAlternatives = (pStaticMonsterInfos as GroupMonsterStaticInformationsWithAlternatives);
            if (infos)
            {
                pmf = (Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame);
                partyMembers = pmf.partyMembers;
                nbMembers = partyMembers.length;
                if ((((nbMembers == 0)) && (PlayedCharacterManager.getInstance().hasCompanion)))
                {
                    nbMembers = 2;
                }
                else
                {
                    for each (_local_8 in partyMembers)
                    {
                        nbMembers = (nbMembers + _local_8.companions.length);
                    };
                };
                for each (monsterGroup in infos.alternatives)
                {
                    if (((!(newGroup)) || ((monsterGroup.playerCount <= nbMembers))))
                    {
                        newGroup = monsterGroup.monsters;
                    };
                };
            };
            return (((newGroup) ? newGroup.concat() : null));
        }

        override public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier=null):AnimatedCharacter
        {
            var ac:AnimatedCharacter;
            var _local_4:Sprite;
            var _local_5:Quest;
            var _local_6:GameRolePlayGroupMonsterInformations;
            var _local_7:Boolean;
            var _local_8:Vector.<EntityLook>;
            var _local_9:Vector.<uint>;
            var _local_10:Array;
            var migi:MonsterInGroupInformations;
            var option:*;
            var _local_13:Array;
            var indexedEL:IndexedEntityLook;
            var iEL:IndexedEntityLook;
            var tel:TiphonEntityLook;
            ac = super.addOrUpdateActor(infos);
            switch (true)
            {
                case (infos is GameRolePlayNpcWithQuestInformations):
                    this._npcList[infos.contextualId] = ac;
                    _local_5 = Quest.getFirstValidQuest((infos as GameRolePlayNpcWithQuestInformations).questFlag);
                    this.removeBackground(ac);
                    if (_local_5 != null)
                    {
                        if ((infos as GameRolePlayNpcWithQuestInformations).questFlag.questsToStartId.indexOf(_local_5.id) != -1)
                        {
                            if (_local_5.repeatType == 0)
                            {
                                _local_4 = EmbedAssets.getSprite("QUEST_CLIP");
                                ac.addBackground("questClip", _local_4, true);
                            }
                            else
                            {
                                _local_4 = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                                ac.addBackground("questRepeatableClip", _local_4, true);
                            };
                        }
                        else
                        {
                            if (_local_5.repeatType == 0)
                            {
                                _local_4 = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                                ac.addBackground("questObjectiveClip", _local_4, true);
                            }
                            else
                            {
                                _local_4 = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                                ac.addBackground("questRepeatableObjectiveClip", _local_4, true);
                            };
                        };
                    };
                    if (ac.look.getBone() == 1)
                    {
                        ac.addAnimationModifier(_customAnimModifier);
                    };
                    if (((_creaturesMode) || ((ac.getAnimation() == AnimationEnum.ANIM_STATIQUE))))
                    {
                        ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    };
                    break;
                case (infos is GameRolePlayGroupMonsterInformations):
                    _local_6 = (infos as GameRolePlayGroupMonsterInformations);
                    _local_7 = Monster.getMonsterById(_local_6.staticInfos.mainCreatureLightInfos.creatureGenericId).isMiniBoss;
                    if (((((!(_local_7)) && (_local_6.staticInfos.underlings))) && ((_local_6.staticInfos.underlings.length > 0))))
                    {
                        for each (migi in _local_6.staticInfos.underlings)
                        {
                            _local_7 = Monster.getMonsterById(migi.creatureGenericId).isMiniBoss;
                            if (_local_7)
                            {
                                break;
                            };
                        };
                    };
                    this.updateMonstersGroup(_local_6);
                    if (this._monstersIds.indexOf(infos.contextualId) == -1)
                    {
                        this._monstersIds.push(infos.contextualId);
                    };
                    if (Kernel.getWorker().contains(MonstersInfoFrame))
                    {
                        (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).update();
                    };
                    if (((!((PlayerManager.getInstance().serverGameType == 0))) && (_local_6.hasHardcoreDrop)))
                    {
                        this.addEntityIcon(_local_6.contextualId, "treasure");
                    };
                    if (_local_7)
                    {
                        this.addEntityIcon(_local_6.contextualId, "archmonsters");
                    };
                    if (_local_6.hasAVARewardToken)
                    {
                        this.addEntityIcon(_local_6.contextualId, "nugget");
                    };
                    break;
                case (infos is GameRolePlayHumanoidInformations):
                    if ((((((infos.contextualId > 0)) && (this._playersId))) && ((this._playersId.indexOf(infos.contextualId) == -1))))
                    {
                        this._playersId.push(infos.contextualId);
                    };
                    _local_8 = new Vector.<EntityLook>();
                    _local_9 = new Vector.<uint>();
                    for each (option in (infos as GameRolePlayHumanoidInformations).humanoidInfo.options)
                    {
                        switch (true)
                        {
                            case (option is HumanOptionFollowers):
                                _local_13 = new Array();
                                for each (indexedEL in option.followingCharactersLook)
                                {
                                    _local_13.push(indexedEL);
                                };
                                _local_13.sortOn("index");
                                for each (iEL in _local_13)
                                {
                                    _local_8.push(iEL.look);
                                    _local_9.push(Follower.TYPE_NETWORK);
                                };
                                break;
                            case (option is HumanOptionAlliance):
                                this.addConquestIcon(infos.contextualId, (option as HumanOptionAlliance));
                                break;
                        };
                    };
                    _local_10 = ac.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER);
                    for each (tel in _local_10)
                    {
                        _local_8.push(EntityLookAdapter.toNetwork(tel));
                        _local_9.push(Follower.TYPE_PET);
                    };
                    this.manageFollowers(ac, _local_8, null, _local_9);
                    if (ac.look.getBone() == 1)
                    {
                        ac.addAnimationModifier(_customAnimModifier);
                    };
                    if (((_creaturesMode) || ((ac.getAnimation() == AnimationEnum.ANIM_STATIQUE))))
                    {
                        ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    };
                    break;
                case (infos is GameRolePlayMerchantInformations):
                    if (ac.look.getBone() == 1)
                    {
                        ac.addAnimationModifier(_customAnimModifier);
                    };
                    if (((_creaturesMode) || ((ac.getAnimation() == AnimationEnum.ANIM_STATIQUE))))
                    {
                        ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    };
                    trace("Affichage d'un personnage en mode marchand");
                    break;
                case (infos is GameRolePlayTaxCollectorInformations):
                case (infos is GameRolePlayPrismInformations):
                case (infos is GameRolePlayPortalInformations):
                    ac.allowMovementThrough = true;
                    break;
                case (infos is GameRolePlayNpcInformations):
                    this._npcList[infos.contextualId] = ac;
                case (infos is GameContextPaddockItemInformations):
                    break;
                default:
                    _log.warn((("Unknown GameRolePlayActorInformations type : " + infos) + "."));
            };
            return (ac);
        }

        override protected function updateActorLook(actorId:int, newLook:EntityLook, smoke:Boolean=false):AnimatedCharacter
        {
            var anim:String;
            var pets:Array;
            var toAdd:Array;
            var found:Boolean;
            var tel:TiphonEntityLook;
            var toRemove:Array;
            var f:Follower;
            var ac:AnimatedCharacter = (DofusEntities.getEntity(actorId) as AnimatedCharacter);
            if (ac)
            {
                anim = (TiphonUtility.getEntityWithoutMount(ac) as TiphonSprite).getAnimation();
                pets = EntityLookAdapter.fromNetwork(newLook).getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER);
                toAdd = [];
                found = false;
                for each (tel in pets)
                {
                    found = false;
                    for each (f in ac.followers)
                    {
                        if ((((((f.type == Follower.TYPE_PET)) && ((f.entity is TiphonSprite)))) && ((f.entity as TiphonSprite).look.equals(tel))))
                        {
                            found = true;
                            break;
                        };
                    };
                    if (!(found))
                    {
                        toAdd.push(tel);
                    };
                };
                for each (tel in toAdd)
                {
                    ac.addFollower(this.createFollower(tel, ac, Follower.TYPE_PET), true);
                };
                toRemove = [];
                for each (f in ac.followers)
                {
                    found = false;
                    if (f.type == Follower.TYPE_PET)
                    {
                        for each (tel in pets)
                        {
                            if ((((f.entity is TiphonSprite)) && ((f.entity as TiphonSprite).look.equals(tel))))
                            {
                                found = true;
                                break;
                            };
                        };
                        if (!(found))
                        {
                            toRemove.push(f);
                        };
                    };
                };
                for each (f in toRemove)
                {
                    ac.removeFollower(f);
                };
                if (((!((anim.indexOf("_Statique_") == -1))) && (((!(this._lastStaticAnimations[actorId])) || (!((this._lastStaticAnimations[actorId] == anim)))))))
                {
                    this._lastStaticAnimations[actorId] = {"anim":anim};
                };
                if (((!((ac.look.getBone() == newLook.bonesId))) && (this._lastStaticAnimations[actorId])))
                {
                    this._lastStaticAnimations[actorId].targetBone = newLook.bonesId;
                    ac.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityRendered);
                    ac.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityRendered);
                    ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
                };
            };
            return (super.updateActorLook(actorId, newLook, smoke));
        }

        private function onEntityRendered(pEvent:TiphonEvent):void
        {
            var ac:AnimatedCharacter = (pEvent.currentTarget as AnimatedCharacter);
            if (((((((((ac) && (this._lastStaticAnimations[ac.id]))) && (ac.look))) && ((this._lastStaticAnimations[ac.id].targetBone == ac.look.getBone())))) && (ac.rendered)))
            {
                ac.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityRendered);
                ac.setAnimation(this._lastStaticAnimations[ac.id].anim);
                delete this._lastStaticAnimations[ac.id];
            };
        }

        private function removeBackground(ac:TiphonSprite):void
        {
            if (!(ac))
            {
                return;
            };
            ac.removeBackground("questClip");
            ac.removeBackground("questObjectiveClip");
            ac.removeBackground("questRepeatableClip");
            ac.removeBackground("questRepeatableObjectiveClip");
        }

        private function manageFollowers(char:AnimatedCharacter, followers:Vector.<EntityLook>, speedAdjust:Vector.<Number>=null, types:Vector.<uint>=null, areMonsters:Boolean=false):void
        {
            var num:int;
            var i:int;
            var followerBaseLook:EntityLook;
            var followerEntityLook:TiphonEntityLook;
            if (!(char.followersEqual(followers)))
            {
                char.removeAllFollowers();
                num = followers.length;
                i = 0;
                while (i < num)
                {
                    followerBaseLook = followers[i];
                    followerEntityLook = EntityLookAdapter.fromNetwork(followerBaseLook);
                    char.addFollower(this.createFollower(followerEntityLook, char, ((types) ? types[i] : ((areMonsters) ? Follower.TYPE_MONSTER : (Follower.TYPE_NETWORK))), ((!((speedAdjust == null))) ? speedAdjust[i] : null)));
                    i++;
                };
            };
        }

        private function createFollower(look:TiphonEntityLook, parent:AnimatedCharacter, type:uint, speedAdjust:Number=0):Follower
        {
            var followerEntity:AnimatedCharacter = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(), look, parent);
            if (speedAdjust)
            {
                followerEntity.speedAdjust = speedAdjust;
            };
            return (new Follower(followerEntity, type));
        }

        private function addFight(infos:FightCommonInformations):void
        {
            var team:FightTeamInformations;
            var teamEntity:IEntity;
            var fightTeam:FightTeam;
            var teams:Vector.<FightTeam> = new Vector.<FightTeam>(0, false);
            var fight:Fight = new Fight(infos.fightId, teams);
            var teamCounter:uint;
            for each (team in infos.fightTeams)
            {
                teamEntity = RolePlayEntitiesFactory.createFightEntity(infos, team, MapPoint.fromCellId(infos.fightTeamsPositions[teamCounter]));
                (teamEntity as IDisplayable).display();
                fightTeam = new FightTeam(fight, team.teamTypeId, teamEntity, team, infos.fightTeamsOptions[team.teamId]);
                _entities[teamEntity.id] = fightTeam;
                teams.push(fightTeam);
                teamCounter++;
                (teamEntity as TiphonSprite).addEventListener(TiphonEvent.RENDER_SUCCEED, this.onFightEntityRendered, false, 0, true);
            };
            this._fights[infos.fightId] = fight;
        }

        private function addObject(pObjectUID:uint, pCellId:uint):void
        {
            var objectUri:Uri = new Uri(((LangManager.getInstance().getEntry("config.gfx.path.item.vector") + Item.getItemById(pObjectUID).iconId) + ".swf"));
            var objectEntity:IInteractive = new RoleplayObjectEntity(pObjectUID, MapPoint.fromCellId(pCellId));
            (objectEntity as IDisplayable).display();
            var groundObject:GameContextActorInformations = new GroundObject(Item.getItemById(pObjectUID));
            groundObject.contextualId = objectEntity.id;
            groundObject.disposition.cellId = pCellId;
            groundObject.disposition.direction = DirectionsEnum.DOWN_RIGHT;
            if (this._objects == null)
            {
                this._objects = new Dictionary();
            };
            this._objects[objectUri] = objectEntity;
            this._objectsByCellId[pCellId] = this._objects[objectUri];
            _entities[objectEntity.id] = groundObject;
            this._loader.load(objectUri, null, null, true);
        }

        private function removeObject(pCellId:uint):void
        {
            if (this._objectsByCellId[pCellId] != null)
            {
                if (this._objects[this._objectsByCellId[pCellId]] != null)
                {
                    delete this._objects[this._objectsByCellId[pCellId]];
                };
                if (_entities[this._objectsByCellId[pCellId].id] != null)
                {
                    delete _entities[this._objectsByCellId[pCellId].id];
                };
                (this._objectsByCellId[pCellId] as IDisplayable).remove();
                delete this._objectsByCellId[pCellId];
            };
        }

        private function updateFight(fightId:uint, team:FightTeamInformations):void
        {
            var newMember:FightTeamMemberInformations;
            var present:Boolean;
            var teamMember:FightTeamMemberInformations;
            var fight:Fight = this._fights[fightId];
            if (fight == null)
            {
                return;
            };
            var fightTeam:FightTeam = fight.getTeamById(team.teamId);
            var tInfo:FightTeamInformations = (_entities[fightTeam.teamEntity.id] as FightTeam).teamInfos;
            if (tInfo.teamMembers == team.teamMembers)
            {
                return;
            };
            for each (newMember in team.teamMembers)
            {
                present = false;
                for each (teamMember in tInfo.teamMembers)
                {
                    if (teamMember.id == newMember.id)
                    {
                        present = true;
                    };
                };
                if (!(present))
                {
                    tInfo.teamMembers.push(newMember);
                };
            };
        }

        private function removeFighter(fightId:uint, teamId:uint, charId:int):void
        {
            var fightTeam:FightTeam;
            var teamInfos:FightTeamInformations;
            var newMembers:Vector.<FightTeamMemberInformations>;
            var member:FightTeamMemberInformations;
            var fight:Fight = this._fights[fightId];
            if (fight)
            {
                fightTeam = fight.teams[teamId];
                teamInfos = fightTeam.teamInfos;
                newMembers = new Vector.<FightTeamMemberInformations>(0, false);
                for each (member in teamInfos.teamMembers)
                {
                    if (member.id != charId)
                    {
                        newMembers.push(member);
                    };
                };
                teamInfos.teamMembers = newMembers;
            };
        }

        private function removeFight(fightId:uint):void
        {
            var team:FightTeam;
            var entity:Object;
            var fight:Fight = this._fights[fightId];
            if (fight == null)
            {
                return;
            };
            for each (team in fight.teams)
            {
                entity = _entities[team.teamEntity.id];
                Kernel.getWorker().process(new EntityMouseOutMessage((team.teamEntity as IInteractive)));
                (team.teamEntity as IDisplayable).remove();
                TooltipManager.hide(((("fightOptions_" + fightId) + "_") + team.teamInfos.teamId));
                delete _entities[team.teamEntity.id];
            };
            delete this._fights[fightId];
        }

        private function addPaddockItem(item:PaddockItem):void
        {
            var contextualId:int;
            var i:Item = Item.getItemById(item.objectGID);
            if (this._paddockItem[item.cellId])
            {
                contextualId = (this._paddockItem[item.cellId] as IEntity).id;
            }
            else
            {
                contextualId = EntitiesManager.getInstance().getFreeEntityId();
            };
            var gcpii:GameContextPaddockItemInformations = new GameContextPaddockItemInformations(contextualId, i.appearance, item.cellId, item.durability, i);
            var e:IEntity = this.addOrUpdateActor(gcpii);
            this._paddockItem[item.cellId] = e;
        }

        private function removePaddockItem(cellId:uint):void
        {
            var e:IEntity = this._paddockItem[cellId];
            if (!(e))
            {
                return;
            };
            (e as IDisplayable).remove();
            delete this._paddockItem[cellId];
        }

        private function activatePaddockItem(cellId:uint):void
        {
            var seq:SerialSequencer;
            var item:TiphonSprite = this._paddockItem[cellId];
            if (item)
            {
                seq = new SerialSequencer();
                seq.addStep(new PlayAnimationStep(item, AnimationEnum.ANIM_HIT));
                seq.addStep(new PlayAnimationStep(item, AnimationEnum.ANIM_STATIQUE));
                seq.start();
            };
        }

        private function onFightEntityRendered(event:TiphonEvent):void
        {
            if (((!(_entities)) || (!(event.target))))
            {
                return;
            };
            var fightTeam:FightTeam = _entities[event.target.id];
            if (((((fightTeam) && (fightTeam.fight))) && (fightTeam.teamInfos)))
            {
                this.updateSwordOptions(fightTeam.fight.fightId, fightTeam.teamInfos.teamId);
            };
        }

        private function updateSwordOptions(fightId:uint, teamId:uint, option:int=-1, state:Boolean=false):void
        {
            var opt:*;
            var fight:Fight = this._fights[fightId];
            if (fight == null)
            {
                return;
            };
            var fightTeam:FightTeam = fight.teams[teamId];
            if (fightTeam == null)
            {
                return;
            };
            if (option != -1)
            {
                fightTeam.teamOptions[option] = state;
            };
            var textures:Vector.<String> = new Vector.<String>();
            for (opt in fightTeam.teamOptions)
            {
                if (fightTeam.teamOptions[opt])
                {
                    textures.push(("fightOption" + opt));
                };
            };
            if (fightTeam.hasGroupMember())
            {
                textures.push("fightOption4");
            };
            TooltipManager.show(textures, (fightTeam.teamEntity as IDisplayable).absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, ((("fightOptions_" + fightId) + "_") + teamId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, "texturesList", null, null, null, false, 0, Atouin.getInstance().currentZoom, false);
        }

        private function paddockCellValidator(cellId:int):Boolean
        {
            var infos:GameContextActorInformations;
            var entity:IEntity = EntitiesManager.getInstance().getEntityOnCell(cellId);
            if (entity)
            {
                infos = getEntityInfos(entity.id);
                if ((infos is GameContextPaddockItemInformations))
                {
                    return (false);
                };
            };
            return (((DataMapProvider.getInstance().farmCell(MapPoint.fromCellId(cellId).x, MapPoint.fromCellId(cellId).y)) && (DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(cellId).x, MapPoint.fromCellId(cellId).y, true))));
        }

        private function removeEntityListeners(pEntityId:int):void
        {
            var rider:TiphonSprite;
            var ts:TiphonSprite = (DofusEntities.getEntity(pEntityId) as TiphonSprite);
            if (ts)
            {
                ts.removeEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                rider = (ts.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite);
                if (rider)
                {
                    rider.removeEventListener(TiphonEvent.ANIMATION_ADDED, this.onAnimationAdded);
                };
                ts.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityReadyForEmote);
            };
        }

        private function updateUsableEmotesListInit(pLook:TiphonEntityLook):void
        {
            var realEntityLook:TiphonEntityLook;
            var bonesToLoad:Array;
            if (((_entities) && (_entities[PlayedCharacterManager.getInstance().id])))
            {
                realEntityLook = EntityLookAdapter.fromNetwork((_entities[PlayedCharacterManager.getInstance().id] as GameContextActorInformations).look);
            };
            var followerPetLook:Array = realEntityLook.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER);
            if (((((((_creaturesMode) || (_creaturesFightMode))) || (((followerPetLook) && (!((followerPetLook.length == 0))))))) && (realEntityLook)))
            {
                bonesToLoad = TiphonMultiBonesManager.getInstance().getAllBonesFromLook(realEntityLook);
                TiphonMultiBonesManager.getInstance().forceBonesLoading(bonesToLoad, new Callback(this.updateUsableEmotesList, realEntityLook));
            }
            else
            {
                this.updateUsableEmotesList(pLook);
            };
        }

        private function updateUsableEmotesList(pLook:TiphonEntityLook):void
        {
            var emote:EmoteWrapper;
            var animName:String;
            var emoteAvailable:Boolean;
            var subCat:String;
            var subIndex:String;
            var sw:ShortcutWrapper;
            var emoteIndex:int;
            var isGhost:Boolean = PlayedCharacterManager.getInstance().isGhost;
            var rpEmoticonFrame:EmoticonFrame = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame);
            var emotes:Array = rpEmoticonFrame.emotesList;
            var subEntities:Array = pLook.getSubEntities();
            var updateShortcutsBar:Boolean;
            this._usableEmotes = new Array();
            var boneToTest:uint = pLook.getBone();
            for each (emote in emotes)
            {
                emoteAvailable = false;
                if (((emote) && (emote.emote)))
                {
                    animName = emote.emote.getAnimName(pLook);
                    if (((((emote.emote.aura) && (!(isGhost)))) || (Tiphon.skullLibrary.hasAnim(pLook.getBone(), animName))))
                    {
                        emoteAvailable = true;
                    }
                    else
                    {
                        if (subEntities)
                        {
                            for (subCat in subEntities)
                            {
                                for (subIndex in subEntities[subCat])
                                {
                                    if (Tiphon.skullLibrary.hasAnim(subEntities[subCat][subIndex].getBone(), animName))
                                    {
                                        emoteAvailable = true;
                                        break;
                                    };
                                };
                                if (emoteAvailable)
                                {
                                    break;
                                };
                            };
                        };
                    };
                    emoteIndex = rpEmoticonFrame.emotes.indexOf(emote.id);
                    for each (sw in InventoryManager.getInstance().shortcutBarItems)
                    {
                        if (((((((sw) && ((sw.type == 4)))) && ((sw.id == emote.id)))) && (!((sw.active == emoteAvailable)))))
                        {
                            sw.active = emoteAvailable;
                            updateShortcutsBar = true;
                            break;
                        };
                    };
                    if (emoteAvailable)
                    {
                        this._usableEmotes.push(emote.id);
                        if (emoteIndex == -1)
                        {
                            rpEmoticonFrame.emotes.push(emote.id);
                        };
                    }
                    else
                    {
                        if (emoteIndex != -1)
                        {
                            rpEmoticonFrame.emotes.splice(emoteIndex, 1);
                        };
                    };
                };
            };
            KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteUnabledListUpdated, this._usableEmotes);
            if (updateShortcutsBar)
            {
                KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
            };
        }

        private function onEntityReadyForEmote(pEvent:TiphonEvent):void
        {
            var entity:AnimatedCharacter = (pEvent.currentTarget as AnimatedCharacter);
            entity.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityReadyForEmote);
            if (this._playersId.indexOf(entity.id) != -1)
            {
                this.process(this._waitingEmotesAnims[entity.id]);
            };
            delete this._waitingEmotesAnims[entity.id];
        }

        private function onAnimationAdded(e:TiphonEvent):void
        {
            var name:String;
            var vsa:Vector.<SoundAnimation>;
            var sa:SoundAnimation;
            var dataSoundLabel:String;
            var entity:TiphonSprite = (e.currentTarget as TiphonSprite);
            entity.removeEventListener(TiphonEvent.ANIMATION_ADDED, this.onAnimationAdded);
            var animation:TiphonAnimation = entity.rawAnimation;
            var soundBones:SoundBones = SoundBones.getSoundBonesById(entity.look.getBone());
            if (soundBones)
            {
                name = getQualifiedClassName(animation);
                vsa = soundBones.getSoundAnimations(name);
                animation.spriteHandler.tiphonEventManager.removeEvents(TiphonEventsManager.BALISE_SOUND, name);
                for each (sa in vsa)
                {
                    dataSoundLabel = (((TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN) + ((((!((sa.label == null))) && (!((sa.label == "null"))))) ? sa.label : "")) + TiphonEventsManager.BALISE_PARAM_END);
                    animation.spriteHandler.tiphonEventManager.addEvent(dataSoundLabel, sa.startFrame, name);
                };
            };
        }

        private function onGroundObjectLoaded(e:ResourceLoadedEvent):void
        {
            var objectMc:MovieClip = (((e.resource is ASwf)) ? e.resource.content : e.resource);
            objectMc.width = 34;
            objectMc.height = 34;
            objectMc.x = (objectMc.x - (objectMc.width / 2));
            objectMc.y = (objectMc.y - (objectMc.height / 2));
            if (this._objects[e.uri])
            {
                this._objects[e.uri].addChild(objectMc);
            };
        }

        private function onGroundObjectLoadFailed(e:ResourceErrorEvent):void
        {
            trace(("l'objet au sol n'a pas pu être chargé / uri : " + e.uri));
        }

        public function timeoutStop(character:AnimatedCharacter):void
        {
            clearTimeout(this._timeout);
            character.setAnimation(AnimationEnum.ANIM_STATIQUE);
            this._currentEmoticon = 0;
        }

        override public function onPlayAnim(e:TiphonEvent):void
        {
            var animsRandom:Array = new Array();
            var tempStr:String = e.params.substring(6, (e.params.length - 1));
            animsRandom = tempStr.split(",");
            var whichAnim:int = (this._emoteTimesBySprite[(e.currentTarget as TiphonSprite).name] % animsRandom.length);
            e.sprite.setAnimation(animsRandom[whichAnim]);
        }

        private function onAnimationEnd(e:TiphonEvent):void
        {
            var statiqueAnim:String;
            var animNam:String;
            var tiphonSprite:TiphonSprite = (e.currentTarget as TiphonSprite);
            tiphonSprite.removeEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
            var subEnt:Object = tiphonSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (subEnt != null)
            {
                animNam = subEnt.getAnimation();
                if (animNam.indexOf("_") == -1)
                {
                    animNam = tiphonSprite.getAnimation();
                };
            }
            else
            {
                animNam = tiphonSprite.getAnimation();
            };
            if (animNam.indexOf("_Statique_") == -1)
            {
                statiqueAnim = animNam.replace("_", "_Statique_");
            }
            else
            {
                statiqueAnim = animNam;
            };
            if (((tiphonSprite.hasAnimation(statiqueAnim, tiphonSprite.getDirection())) || (((((subEnt) && ((subEnt is TiphonSprite)))) && (TiphonSprite(subEnt).hasAnimation(statiqueAnim, TiphonSprite(subEnt).getDirection()))))))
            {
                tiphonSprite.setAnimation(statiqueAnim);
            }
            else
            {
                tiphonSprite.setAnimation(AnimationEnum.ANIM_STATIQUE);
                this._currentEmoticon = 0;
            };
        }

        private function onPlayerSpriteInit(pEvent:TiphonEvent):void
        {
            var currentLook:TiphonEntityLook = (pEvent.sprite as TiphonSprite).look;
            if (pEvent.params == currentLook.getBone())
            {
                pEvent.sprite.removeEventListener(TiphonEvent.SPRITE_INIT, this.onPlayerSpriteInit);
                this.updateUsableEmotesListInit(currentLook);
            };
        }

        private function onCellPointed(success:Boolean, cellId:uint, entityId:int):void
        {
            var m:PaddockMoveItemRequestMessage;
            if (success)
            {
                m = new PaddockMoveItemRequestMessage();
                m.initPaddockMoveItemRequestMessage(this._currentPaddockItemCellId, cellId);
                ConnectionsHandler.getConnection().send(m);
            };
        }

        private function updateConquestIcons(pPlayersIds:*):void
        {
            var playerId:int;
            var infos:GameRolePlayHumanoidInformations;
            var option:*;
            if ((((pPlayersIds is Vector.<uint>)) && (((pPlayersIds as Vector.<uint>).length > 0))))
            {
                for each (playerId in pPlayersIds)
                {
                    infos = (getEntityInfos(playerId) as GameRolePlayHumanoidInformations);
                    if (infos)
                    {
                        for each (option in infos.humanoidInfo.options)
                        {
                            if ((option is HumanOptionAlliance))
                            {
                                this.addConquestIcon(infos.contextualId, (option as HumanOptionAlliance));
                                break;
                            };
                        };
                    };
                };
            }
            else
            {
                if ((pPlayersIds is int))
                {
                    infos = (getEntityInfos(pPlayersIds) as GameRolePlayHumanoidInformations);
                    if (infos)
                    {
                        for each (option in infos.humanoidInfo.options)
                        {
                            if ((option is HumanOptionAlliance))
                            {
                                this.addConquestIcon(infos.contextualId, (option as HumanOptionAlliance));
                                break;
                            };
                        };
                    };
                };
            };
        }

        private function addConquestIcon(pEntityId:int, pHumanOptionAlliance:HumanOptionAlliance):void
        {
            var prismInfo:PrismSubAreaWrapper;
            var playerConqueststatus:String;
            var iconsNames:Vector.<String>;
            var iconName:String;
            if (((((((((((!((PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.NON_AGGRESSABLE))) && (this._allianceFrame))) && (this._allianceFrame.hasAlliance))) && (!((pHumanOptionAlliance.aggressable == AggressableStatusEnum.NON_AGGRESSABLE))))) && (!((pHumanOptionAlliance.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE))))) && (!((pHumanOptionAlliance.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE)))))
            {
                prismInfo = this._allianceFrame.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id);
                if (((prismInfo) && ((prismInfo.state == PrismStateEnum.PRISM_STATE_VULNERABLE))))
                {
                    switch (pHumanOptionAlliance.aggressable)
                    {
                        case AggressableStatusEnum.AvA_DISQUALIFIED:
                            if (pEntityId == PlayedCharacterManager.getInstance().id)
                            {
                                playerConqueststatus = "neutral";
                            };
                            break;
                        case AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE:
                            if (pEntityId == PlayedCharacterManager.getInstance().id)
                            {
                                playerConqueststatus = "clock";
                            }
                            else
                            {
                                playerConqueststatus = this.getPlayerConquestStatus(pEntityId, pHumanOptionAlliance.allianceInformations.allianceId, prismInfo.alliance.allianceId);
                            };
                            break;
                        case AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE:
                            playerConqueststatus = this.getPlayerConquestStatus(pEntityId, pHumanOptionAlliance.allianceInformations.allianceId, prismInfo.alliance.allianceId);
                            break;
                    };
                    if (playerConqueststatus)
                    {
                        iconsNames = this.getIconNamesByCategory(pEntityId, EntityIconEnum.AVA_CATEGORY);
                        if (((iconsNames) && (!((iconsNames[0] == playerConqueststatus)))))
                        {
                            iconName = iconsNames[0];
                            iconsNames.length = 0;
                            this.removeIcon(pEntityId, iconName);
                        };
                        this.addEntityIcon(pEntityId, playerConqueststatus, EntityIconEnum.AVA_CATEGORY);
                    };
                };
            };
            if (((((!(playerConqueststatus)) && (this._entitiesIconsNames[pEntityId]))) && (this._entitiesIconsNames[pEntityId][EntityIconEnum.AVA_CATEGORY])))
            {
                this.removeIconsCategory(pEntityId, EntityIconEnum.AVA_CATEGORY);
            };
        }

        private function getPlayerConquestStatus(pPlayerId:int, pPlayerAllianceId:int, pPrismAllianceId:int):String
        {
            var status:String;
            if ((((pPlayerId == PlayedCharacterManager.getInstance().id)) || ((this._allianceFrame.alliance.allianceId == pPlayerAllianceId))))
            {
                status = "ownTeam";
            }
            else
            {
                if (pPlayerAllianceId == pPrismAllianceId)
                {
                    status = "defender";
                }
                else
                {
                    status = "forward";
                };
            };
            return (status);
        }

        public function addEntityIcon(pEntityId:int, pIconName:String, pIconCategory:int=0):void
        {
            if (!(this._entitiesIconsNames[pEntityId]))
            {
                this._entitiesIconsNames[pEntityId] = new Dictionary();
            };
            if (!(this._entitiesIconsNames[pEntityId][pIconCategory]))
            {
                this._entitiesIconsNames[pEntityId][pIconCategory] = new Vector.<String>(0);
            };
            if (this._entitiesIconsNames[pEntityId][pIconCategory].indexOf(pIconName) == -1)
            {
                this._entitiesIconsNames[pEntityId][pIconCategory].push(pIconName);
            };
            if (this._entitiesIcons[pEntityId])
            {
                this._entitiesIcons[pEntityId].needUpdate = true;
            };
        }

        public function updateAllIcons():void
        {
            this._updateAllIcons = true;
            this.showIcons();
        }

        public function forceIconUpdate(pEntityId:int):void
        {
            this._entitiesIcons[pEntityId].needUpdate = true;
        }

        private function removeAllIcons():void
        {
            var id:*;
            for (id in this._entitiesIconsNames)
            {
                delete this._entitiesIconsNames[id];
                this.removeIcon(id);
            };
        }

        public function removeIcon(pEntityId:int, pIconName:String=null):void
        {
            var entity:AnimatedCharacter = (DofusEntities.getEntity(pEntityId) as AnimatedCharacter);
            if (entity)
            {
                entity.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.updateIconAfterRender);
            };
            if (this._entitiesIcons[pEntityId])
            {
                if (!(pIconName))
                {
                    this._entitiesIcons[pEntityId].remove();
                    delete this._entitiesIcons[pEntityId];
                }
                else
                {
                    this._entitiesIcons[pEntityId].removeIcon(pIconName);
                };
            };
        }

        public function getIconNamesByCategory(pEntityId:int, pIconCategory:int):Vector.<String>
        {
            var iconNames:Vector.<String>;
            if (((this._entitiesIconsNames[pEntityId]) && (this._entitiesIconsNames[pEntityId][pIconCategory])))
            {
                iconNames = this._entitiesIconsNames[pEntityId][pIconCategory];
            };
            return (iconNames);
        }

        public function removeIconsCategory(pEntityId:int, pIconCategory:int):void
        {
            var iconName:String;
            if (((this._entitiesIconsNames[pEntityId]) && (this._entitiesIconsNames[pEntityId][pIconCategory])))
            {
                if (this._entitiesIcons[pEntityId])
                {
                    for each (iconName in this._entitiesIconsNames[pEntityId][pIconCategory])
                    {
                        this._entitiesIcons[pEntityId].removeIcon(iconName);
                    };
                };
                delete this._entitiesIconsNames[pEntityId][pIconCategory];
                if (((this._entitiesIcons[pEntityId]) && ((this._entitiesIcons[pEntityId].length == 0))))
                {
                    delete this._entitiesIconsNames[pEntityId];
                    this.removeIcon(pEntityId);
                };
            };
        }

        public function hasIcon(pEntityId:int, pIconName:String=null):Boolean
        {
            return (((this._entitiesIcons[pEntityId]) ? ((pIconName) ? this._entitiesIcons[pEntityId].hasIcon(pIconName) : true) : false));
        }

        private function showIcons(pEvent:Event=null):void
        {
            var entityId:*;
            var head:DisplayObject;
            var entity:AnimatedCharacter;
            var targetBounds:IRectangle;
            var r1:Rectangle;
            var r2:Rectangle2;
            var ei:EntityIcon;
            var icon:Texture;
            var tiphonspr:TiphonSprite;
            var foot:DisplayObject;
            var iconCat:*;
            var iconName:String;
            var newIcons:Boolean;
            var globalPos:Point;
            var localPos:Point;
            for (entityId in this._entitiesIconsNames)
            {
                entity = (DofusEntities.getEntity(entityId) as AnimatedCharacter);
                if (!(entity))
                {
                    delete this._entitiesIconsNames[entityId];
                    if (this._entitiesIcons[entityId])
                    {
                        this.removeIcon(entityId);
                    };
                }
                else
                {
                    targetBounds = null;
                    if (((((((this._updateAllIcons) || (entity.isMoving))) || (!(this._entitiesIcons[entityId])))) || (this._entitiesIcons[entityId].needUpdate)))
                    {
                        if (((this._entitiesIcons[entityId]) && (this._entitiesIcons[entityId].rendering)))
                        {
                            continue;
                        };
                        tiphonspr = (entity as TiphonSprite);
                        if (((entity.getSubEntitySlot(2, 0)) && (!(this.isCreatureMode))))
                        {
                            tiphonspr = (entity.getSubEntitySlot(2, 0) as TiphonSprite);
                        };
                        head = tiphonspr.getSlot("Tete");
                        if (head)
                        {
                            r1 = head.getBounds(StageShareManager.stage);
                            r2 = new Rectangle2(r1.x, r1.y, r1.width, r1.height);
                            targetBounds = r2;
                            if (((targetBounds.y - 30) - 10) < 0)
                            {
                                foot = tiphonspr.getSlot("Pied");
                                if (foot)
                                {
                                    r1 = foot.getBounds(StageShareManager.stage);
                                    r2 = new Rectangle2(r1.x, ((r1.y + targetBounds.height) + 30), r1.width, r1.height);
                                    targetBounds = r2;
                                };
                            };
                        }
                        else
                        {
                            if ((tiphonspr is IDisplayable))
                            {
                                targetBounds = (tiphonspr as IDisplayable).absoluteBounds;
                            }
                            else
                            {
                                r1 = tiphonspr.getBounds(StageShareManager.stage);
                                r2 = new Rectangle2(r1.x, r1.y, r1.width, r1.height);
                                targetBounds = r2;
                            };
                            if (((targetBounds.y - 30) - 10) < 0)
                            {
                                targetBounds.y = (targetBounds.y + (targetBounds.height + 30));
                            };
                        };
                    };
                    if (targetBounds)
                    {
                        ei = this._entitiesIcons[entityId];
                        if (!(ei))
                        {
                            this._entitiesIcons[entityId] = new EntityIcon();
                            ei = this._entitiesIcons[entityId];
                        };
                        newIcons = false;
                        for (iconCat in this._entitiesIconsNames[entityId])
                        {
                            for each (iconName in this._entitiesIconsNames[entityId][iconCat])
                            {
                                if (!(ei.hasIcon(iconName)))
                                {
                                    newIcons = true;
                                    ei.addIcon(((ICONS_FILEPATH + "|") + iconName), iconName);
                                };
                            };
                        };
                        if (newIcons)
                        {
                        }
                        else
                        {
                            if (((((this._entitiesIcons[entityId].needUpdate) && (!(entity.isMoving)))) && ((entity.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == 0))))
                            {
                                this._entitiesIcons[entityId].needUpdate = false;
                            };
                            entity.parent.addChildAt(ei, entity.parent.getChildIndex(entity));
                            if (entity.rendered)
                            {
                                globalPos = new Point(((targetBounds.x + (targetBounds.width / 2)) - (ei.width / 2)), (targetBounds.y - 10));
                                localPos = entity.parent.globalToLocal(globalPos);
                                ei.x = localPos.x;
                                ei.y = localPos.y;
                            }
                            else
                            {
                                ei.rendering = true;
                                entity.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.updateIconAfterRender);
                                entity.addEventListener(TiphonEvent.RENDER_SUCCEED, this.updateIconAfterRender);
                            };
                        };
                    };
                };
            };
            this._updateAllIcons = false;
        }

        private function updateIconAfterRender(pEvent:TiphonEvent):void
        {
            var entity:AnimatedCharacter = (pEvent.currentTarget as AnimatedCharacter);
            entity.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.updateIconAfterRender);
            if (this._entitiesIcons[entity.id])
            {
                this._entitiesIcons[entity.id].rendering = false;
                this._entitiesIcons[entity.id].needUpdate = true;
            };
        }

        private function onTiphonPropertyChanged(event:PropertyChangeEvent):void
        {
            if ((((event.propertyName == "auraMode")) && (!((event.propertyOldValue == event.propertyValue)))))
            {
                if (this._auraCycleTimer.running)
                {
                    this._auraCycleTimer.removeEventListener(TimerEvent.TIMER, this.onAuraCycleTimer);
                    this._auraCycleTimer.stop();
                };
                switch (event.propertyValue)
                {
                    case OptionEnum.AURA_CYCLE:
                        this._auraCycleTimer.addEventListener(TimerEvent.TIMER, this.onAuraCycleTimer);
                        this._auraCycleTimer.start();
                        this.setEntitiesAura(false);
                        return;
                    case OptionEnum.AURA_ON_ROLLOVER:
                    case OptionEnum.AURA_NONE:
                        this.setEntitiesAura(false);
                        return;
                    case OptionEnum.AURA_ALWAYS:
                    default:
                        this.setEntitiesAura(true);
                };
            };
        }

        private function onAuraCycleTimer(event:TimerEvent):void
        {
            var firstEntityWithAuraIndex:int;
            var firstEntityWithAura:AnimatedCharacter;
            var nextEntityWithAura:AnimatedCharacter;
            var entity:AnimatedCharacter;
            var entitiesIdsList:Vector.<int> = getEntitiesIdsList();
            if (this._auraCycleIndex >= entitiesIdsList.length)
            {
                this._auraCycleIndex = 0;
            };
            var l:int = entitiesIdsList.length;
            var i:int;
            while (i < l)
            {
                entity = (DofusEntities.getEntity(entitiesIdsList[i]) as AnimatedCharacter);
                if (!(entity))
                {
                }
                else
                {
                    if (((((!(firstEntityWithAura)) && (entity.hasAura))) && ((entity.getDirection() == DirectionsEnum.DOWN))))
                    {
                        firstEntityWithAura = entity;
                        firstEntityWithAuraIndex = i;
                    };
                    if ((((((i == this._auraCycleIndex)) && (entity.hasAura))) && ((entity.getDirection() == DirectionsEnum.DOWN))))
                    {
                        nextEntityWithAura = entity;
                        break;
                    };
                    if (!(entity.hasAura))
                    {
                        this._auraCycleIndex++;
                    };
                };
                i++;
            };
            if (this._lastEntityWithAura)
            {
                this._lastEntityWithAura.visibleAura = false;
            };
            if (nextEntityWithAura)
            {
                nextEntityWithAura.visibleAura = true;
                this._lastEntityWithAura = nextEntityWithAura;
            }
            else
            {
                if (((!(nextEntityWithAura)) && (firstEntityWithAura)))
                {
                    firstEntityWithAura.visibleAura = true;
                    this._lastEntityWithAura = firstEntityWithAura;
                    this._auraCycleIndex = firstEntityWithAuraIndex;
                };
            };
            this._auraCycleIndex++;
        }

        private function setEntitiesAura(visible:Boolean):void
        {
            var entity:AnimatedCharacter;
            var entitiesIdsList:Vector.<int> = getEntitiesIdsList();
            var i:int;
            while (i < entitiesIdsList.length)
            {
                entity = (DofusEntities.getEntity(entitiesIdsList[i]) as AnimatedCharacter);
                if (entity)
                {
                    entity.visibleAura = visible;
                };
                i++;
            };
        }

        override protected function onPropertyChanged(e:PropertyChangeEvent):void
        {
            super.onPropertyChanged(e);
            if (e.propertyName == "allowAnimsFun")
            {
                AnimFunManager.getInstance().stop();
                if (e.propertyValue == true)
                {
                    AnimFunManager.getInstance().initializeByMap(PlayedCharacterManager.getInstance().currentMap.mapId);
                };
            };
        }

        private function onAtouinPropertyChanged(e:PropertyChangeEvent):void
        {
            var entityId:*;
            if (e.propertyName == "transparentOverlayMode")
            {
                for (entityId in this._entitiesIconsNames)
                {
                    this.forceIconUpdate(entityId);
                };
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames

