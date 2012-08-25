package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.factories.*;
    import com.ankamagames.dofus.internalDatacenter.house.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.mount.*;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.messages.*;
    import com.ankamagames.dofus.logic.game.roleplay.types.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.atlas.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.mount.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.*;
    import com.ankamagames.dofus.network.messages.game.interactive.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.sequence.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class RoleplayEntitiesFrame extends AbstractEntitiesFrame implements Frame
    {
        private var _fights:Dictionary;
        private var _objects:Dictionary;
        private var _uri:Dictionary;
        private var _paddockItem:Dictionary;
        private var _fightNumber:uint = 0;
        private var _timeout:Number;
        private var _loader:IResourceLoader;
        private var _groundObjectCache:ICache;
        private var _currentPaddockItemCellId:uint;
        private var _usableEmotes:Array;
        private var _currentEmoticon:uint = 0;
        private var _bRequestingAura:Boolean = false;
        private var _playersId:Array;
        private var _npcList:Array;
        private var _housesList:Dictionary;
        private var _emoteTimesBySprite:Dictionary;
        private var _waitForMap:Boolean;
        private static const QUEST_CLIP:Class = RoleplayEntitiesFrame_QUEST_CLIP;
        private static const QUEST_REPEATABLE_CLIP:Class = RoleplayEntitiesFrame_QUEST_REPEATABLE_CLIP;
        private static const QUEST_OBJECTIVE_CLIP:Class = RoleplayEntitiesFrame_QUEST_OBJECTIVE_CLIP;
        private static const QUEST_REPEATABLE_OBJECTIVE_CLIP:Class = RoleplayEntitiesFrame_QUEST_REPEATABLE_OBJECTIVE_CLIP;

        public function RoleplayEntitiesFrame()
        {
            this._paddockItem = new Dictionary();
            this._groundObjectCache = new Cache(20, new LruGarbageCollector());
            this._usableEmotes = new Array();
            this._npcList = new Array();
            return;
        }// end function

        public function get currentEmoticon() : uint
        {
            return this._currentEmoticon;
        }// end function

        public function set currentEmoticon(param1:uint) : void
        {
            this._currentEmoticon = param1;
            return;
        }// end function

        public function get usableEmoticons() : Array
        {
            return this._usableEmotes;
        }// end function

        public function get fightNumber() : uint
        {
            return this._fightNumber;
        }// end function

        public function get currentSubAreaId() : uint
        {
            return _currentSubAreaId;
        }// end function

        public function get currentSubAreaSide() : int
        {
            return _currentSubAreaSide;
        }// end function

        public function get playersId() : Array
        {
            return this._playersId;
        }// end function

        public function get housesInformations() : Dictionary
        {
            return this._housesList;
        }// end function

        public function get fights() : Dictionary
        {
            return this._fights;
        }// end function

        public function get isCreatureMode() : Boolean
        {
            return _creaturesMode;
        }// end function

        override public function pushed() : Boolean
        {
            var _loc_1:MapInformationsRequestMessage = null;
            this.initNewMap();
            this._playersId = new Array();
            this._emoteTimesBySprite = new Dictionary();
            if (MapDisplayManager.getInstance().currentMapRendered)
            {
                _loc_1 = new MapInformationsRequestMessage();
                _loc_1.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                ConnectionsHandler.getConnection().send(_loc_1);
            }
            else
            {
                this._waitForMap = true;
            }
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onGroundObjectLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onGroundObjectLoadFailed);
            _interactiveElements = new Vector.<InteractiveElement>;
            Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this._usableEmotes = new Array();
            return super.pushed();
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_2:AtlasPointInformationsMessage = null;
            var _loc_3:MapComplementaryInformationsDataMessage = null;
            var _loc_4:SubArea = null;
            var _loc_5:Boolean = false;
            var _loc_6:Boolean = false;
            var _loc_7:InteractiveMapUpdateMessage = null;
            var _loc_8:StatedMapUpdateMessage = null;
            var _loc_9:HouseInformations = null;
            var _loc_10:GameRolePlayShowActorMessage = null;
            var _loc_11:GameContextRefreshEntityLookMessage = null;
            var _loc_12:GameMapChangeOrientationMessage = null;
            var _loc_13:GameMapChangeOrientationsMessage = null;
            var _loc_14:int = 0;
            var _loc_15:GameRolePlaySetAnimationMessage = null;
            var _loc_16:AnimatedCharacter = null;
            var _loc_17:CharacterMovementStoppedMessage = null;
            var _loc_18:AnimatedCharacter = null;
            var _loc_19:GameRolePlayShowChallengeMessage = null;
            var _loc_20:GameFightOptionStateUpdateMessage = null;
            var _loc_21:GameFightUpdateTeamMessage = null;
            var _loc_22:GameFightRemoveTeamMemberMessage = null;
            var _loc_23:GameRolePlayRemoveChallengeMessage = null;
            var _loc_24:GameContextRemoveElementMessage = null;
            var _loc_25:uint = 0;
            var _loc_26:MapFightCountMessage = null;
            var _loc_27:ObjectGroundAddedMessage = null;
            var _loc_28:ObjectGroundRemovedMessage = null;
            var _loc_29:ObjectGroundListAddedMessage = null;
            var _loc_30:uint = 0;
            var _loc_31:PaddockRemoveItemRequestAction = null;
            var _loc_32:PaddockRemoveItemRequestMessage = null;
            var _loc_33:PaddockMoveItemRequestAction = null;
            var _loc_34:Texture = null;
            var _loc_35:ItemWrapper = null;
            var _loc_36:GameDataPaddockObjectRemoveMessage = null;
            var _loc_37:RoleplayContextFrame = null;
            var _loc_38:GameDataPaddockObjectAddMessage = null;
            var _loc_39:GameDataPaddockObjectListAddMessage = null;
            var _loc_40:GameDataPlayFarmObjectAnimationMessage = null;
            var _loc_41:MapNpcsQuestStatusUpdateMessage = null;
            var _loc_42:ShowCellMessage = null;
            var _loc_43:RoleplayContextFrame = null;
            var _loc_44:String = null;
            var _loc_45:String = null;
            var _loc_46:StartZoomAction = null;
            var _loc_47:DisplayObject = null;
            var _loc_48:SwitchCreatureModeAction = null;
            var _loc_49:MapInformationsRequestMessage = null;
            var _loc_50:MapCoordinatesExtended = null;
            var _loc_51:MapComplementaryInformationsWithCoordsMessage = null;
            var _loc_52:MapComplementaryInformationsDataInHouseMessage = null;
            var _loc_53:Boolean = false;
            var _loc_54:GameRolePlayActorInformations = null;
            var _loc_55:GameRolePlayActorInformations = null;
            var _loc_56:AnimatedCharacter = null;
            var _loc_57:GameRolePlayCharacterInformations = null;
            var _loc_58:Emoticon = null;
            var _loc_59:Boolean = false;
            var _loc_60:Date = null;
            var _loc_61:TiphonEntityLook = null;
            var _loc_62:FightCommonInformations = null;
            var _loc_63:HouseInformations = null;
            var _loc_64:HouseWrapper = null;
            var _loc_65:int = 0;
            var _loc_66:int = 0;
            var _loc_67:HousePropertiesMessage = null;
            var _loc_68:MapObstacle = null;
            var _loc_69:GameRolePlayCharacterInformations = null;
            var _loc_70:int = 0;
            var _loc_71:ActorOrientation = null;
            var _loc_72:Emoticon = null;
            var _loc_73:RoleplayEmoticonFrame = null;
            var _loc_74:uint = 0;
            var _loc_75:Emoticon = null;
            var _loc_76:EmotePlayRequestMessage = null;
            var _loc_77:uint = 0;
            var _loc_78:uint = 0;
            var _loc_79:PaddockItem = null;
            var _loc_80:uint = 0;
            var _loc_81:TiphonSprite = null;
            var _loc_82:Sprite = null;
            var _loc_83:int = 0;
            var _loc_84:int = 0;
            var _loc_85:int = 0;
            var _loc_86:Quest = null;
            var _loc_87:Rectangle = null;
            var _loc_88:* = undefined;
            switch(true)
            {
                case param1 is MapLoadedMessage:
                {
                    if (this._waitForMap)
                    {
                        _loc_49 = new MapInformationsRequestMessage();
                        _loc_49.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                        ConnectionsHandler.getConnection().send(_loc_49);
                        this._waitForMap = false;
                    }
                    return false;
                }
                case param1 is AtlasPointInformationsMessage:
                {
                    _loc_2 = param1 as AtlasPointInformationsMessage;
                    for each (_loc_50 in _loc_2.type.coords)
                    {
                        
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, "(MESSAGE TEMPORAIRE) Un phénix se trouve sur la map " + _loc_50.worldX + "," + _loc_50.worldY + "(TED)", ChatActivableChannelsEnum.CHANNEL_GLOBAL, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is MapComplementaryInformationsDataMessage:
                {
                    _loc_3 = param1 as MapComplementaryInformationsDataMessage;
                    this.initNewMap();
                    _interactiveElements = _loc_3.interactiveElements;
                    this._fightNumber = _loc_3.fights.length;
                    if (param1 is MapComplementaryInformationsWithCoordsMessage)
                    {
                        _loc_51 = param1 as MapComplementaryInformationsWithCoordsMessage;
                        if (PlayedCharacterManager.getInstance().isInHouse)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                        }
                        PlayedCharacterManager.getInstance().isInHouse = false;
                        PlayedCharacterManager.getInstance().isInHisHouse = false;
                        PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(_loc_51.worldX, _loc_51.worldY);
                        _worldPoint = new WorldPointWrapper(_loc_51.mapId, true, _loc_51.worldX, _loc_51.worldY);
                    }
                    else if (param1 is MapComplementaryInformationsDataInHouseMessage)
                    {
                        _loc_52 = param1 as MapComplementaryInformationsDataInHouseMessage;
                        _loc_53 = PlayerManager.getInstance().nickname == _loc_52.currentHouse.ownerName;
                        PlayedCharacterManager.getInstance().isInHouse = true;
                        if (_loc_53)
                        {
                            PlayedCharacterManager.getInstance().isInHisHouse = true;
                        }
                        PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(_loc_52.currentHouse.worldX, _loc_52.currentHouse.worldY);
                        KernelEventsManager.getInstance().processCallback(HookList.HouseEntered, _loc_53, _loc_52.currentHouse.ownerId, _loc_52.currentHouse.ownerName, _loc_52.currentHouse.price, _loc_52.currentHouse.isLocked, _loc_52.currentHouse.worldX, _loc_52.currentHouse.worldY, HouseWrapper.manualCreate(_loc_52.currentHouse.modelId, -1, _loc_52.currentHouse.ownerName, _loc_52.currentHouse.price != 0));
                        _worldPoint = new WorldPointWrapper(_loc_52.mapId, true, _loc_52.currentHouse.worldX, _loc_52.currentHouse.worldY);
                    }
                    else
                    {
                        _worldPoint = new WorldPointWrapper(_loc_3.mapId);
                        if (PlayedCharacterManager.getInstance().isInHouse)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                        }
                        PlayedCharacterManager.getInstance().isInHouse = false;
                        PlayedCharacterManager.getInstance().isInHisHouse = false;
                    }
                    _currentSubAreaId = _loc_3.subAreaId;
                    _currentSubAreaSide = _loc_3.subareaAlignmentSide;
                    _loc_4 = SubArea.getSubAreaById(_currentSubAreaId);
                    PlayedCharacterManager.getInstance().currentMap = _worldPoint;
                    PlayedCharacterManager.getInstance().currentSubArea = _loc_4;
                    TooltipManager.hide();
                    updateCreaturesLimit();
                    _loc_5 = false;
                    for each (_loc_54 in _loc_3.actors)
                    {
                        
                        var _loc_92:* = _humanNumber + 1;
                        _humanNumber = _loc_92;
                        if (_creaturesLimit < 50 && _humanNumber >= _creaturesLimit)
                        {
                            _creaturesMode = true;
                        }
                        if (_loc_54.contextualId > 0 && this._playersId && this._playersId.indexOf(_loc_54.contextualId) == -1)
                        {
                            this._playersId.push(_loc_54.contextualId);
                        }
                    }
                    _loc_6 = true;
                    for each (_loc_55 in _loc_3.actors)
                    {
                        
                        _loc_56 = this.addOrUpdateActor(_loc_55) as AnimatedCharacter;
                        if (_loc_56)
                        {
                            _loc_57 = _loc_55 as GameRolePlayCharacterInformations;
                            if (_loc_57 && _loc_57.humanoidInfo.emoteId > 0)
                            {
                                _loc_58 = Emoticon.getEmoticonById(_loc_57.humanoidInfo.emoteId);
                                if (_loc_58.persistancy)
                                {
                                    this._currentEmoticon = _loc_58.id;
                                    if (!_loc_58.aura)
                                    {
                                        _loc_59 = false;
                                        _loc_60 = new Date();
                                        if (_loc_60.getTime() - _loc_57.humanoidInfo.emoteStartTime >= _loc_58.duration)
                                        {
                                            _loc_59 = true;
                                        }
                                        _loc_61 = EntityLookAdapter.fromNetwork(_loc_57.look);
                                        this.process(new GameRolePlaySetAnimationMessage(_loc_55, _loc_58.getAnimName(_loc_61), _loc_57.humanoidInfo.emoteStartTime, !_loc_58.persistancy, _loc_58.eight_directions, _loc_59));
                                    }
                                }
                            }
                        }
                        if (_loc_6)
                        {
                            if (_loc_55 is GameRolePlayGroupMonsterInformations)
                            {
                                _loc_6 = false;
                                KernelEventsManager.getInstance().processCallback(TriggerHookList.MapWithMonsters);
                            }
                        }
                        if (_loc_55 is GameRolePlayCharacterInformations)
                        {
                            ChatAutocompleteNameManager.getInstance().addEntry((_loc_55 as GameRolePlayCharacterInformations).name, 0);
                        }
                    }
                    for each (_loc_62 in _loc_3.fights)
                    {
                        
                        this.addFight(_loc_62);
                    }
                    this._housesList = new Dictionary();
                    for each (_loc_63 in _loc_3.houses)
                    {
                        
                        _loc_64 = HouseWrapper.create(_loc_63);
                        _loc_65 = _loc_63.doorsOnMap.length;
                        _loc_66 = 0;
                        while (_loc_66 < _loc_65)
                        {
                            
                            this._housesList[_loc_63.doorsOnMap[_loc_66]] = _loc_64;
                            _loc_66++;
                        }
                        _loc_67 = new HousePropertiesMessage();
                        _loc_67.initHousePropertiesMessage(_loc_63);
                        Kernel.getWorker().process(_loc_67);
                    }
                    for each (_loc_68 in _loc_3.obstacles)
                    {
                        
                        InteractiveCellManager.getInstance().updateCell(_loc_68.obstacleCellId, _loc_68.state == MapObstacleStateEnum.OBSTACLE_OPENED);
                    }
                    _loc_7 = new InteractiveMapUpdateMessage();
                    _loc_7.initInteractiveMapUpdateMessage(_loc_3.interactiveElements);
                    Kernel.getWorker().process(_loc_7);
                    _loc_8 = new StatedMapUpdateMessage();
                    _loc_8.initStatedMapUpdateMessage(_loc_3.statedElements);
                    Kernel.getWorker().process(_loc_8);
                    KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData, PlayedCharacterManager.getInstance().currentMap, _currentSubAreaId, Dofus.getInstance().options.mapCoordinates, _currentSubAreaSide);
                    KernelEventsManager.getInstance().processCallback(HookList.MapFightCount, 0);
                    AnimFunManager.getInstance().initializeByMap(_loc_3.mapId);
                    this.switchPokemonMode();
                    return true;
                }
                case param1 is HousePropertiesMessage:
                {
                    _loc_9 = (param1 as HousePropertiesMessage).properties;
                    _loc_64 = HouseWrapper.create(_loc_9);
                    _loc_65 = _loc_9.doorsOnMap.length;
                    _loc_66 = 0;
                    while (_loc_66 < _loc_65)
                    {
                        
                        this._housesList[_loc_9.doorsOnMap[_loc_66]] = _loc_64;
                        _loc_66++;
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.HouseProperties, _loc_9.houseId, _loc_9.doorsOnMap, _loc_9.ownerName, _loc_9.isOnSale, _loc_9.modelId);
                    return true;
                }
                case param1 is GameRolePlayShowActorMessage:
                {
                    _loc_10 = param1 as GameRolePlayShowActorMessage;
                    updateCreaturesLimit();
                    var _loc_90:* = _humanNumber + 1;
                    _humanNumber = _loc_90;
                    this.addOrUpdateActor(_loc_10.informations);
                    if (this.switchPokemonMode())
                    {
                        return true;
                    }
                    if (_loc_10.informations is GameRolePlayCharacterInformations)
                    {
                        ChatAutocompleteNameManager.getInstance().addEntry((_loc_10.informations as GameRolePlayCharacterInformations).name, 0);
                    }
                    if (_loc_10.informations is GameRolePlayCharacterInformations && PlayedCharacterManager.getInstance().characteristics.alignmentInfos.pvpEnabled)
                    {
                        _loc_69 = _loc_10.informations as GameRolePlayCharacterInformations;
                        switch(PlayedCharacterManager.getInstance().levelDiff(_loc_69.alignmentInfos.characterPower - _loc_10.informations.contextualId))
                        {
                            case -1:
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
                                break;
                            }
                            case 1:
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    AnimFunManager.getInstance().restart();
                    this._bRequestingAura = false;
                    return true;
                }
                case param1 is GameContextRefreshEntityLookMessage:
                {
                    _loc_11 = param1 as GameContextRefreshEntityLookMessage;
                    updateActorLook(_loc_11.id, _loc_11.look, true);
                    return true;
                }
                case param1 is GameMapChangeOrientationMessage:
                {
                    _loc_12 = param1 as GameMapChangeOrientationMessage;
                    updateActorOrientation(_loc_12.orientation.id, _loc_12.orientation.direction);
                    return true;
                }
                case param1 is GameMapChangeOrientationsMessage:
                {
                    _loc_13 = param1 as GameMapChangeOrientationsMessage;
                    _loc_14 = _loc_13.orientations.length;
                    _loc_70 = 0;
                    while (_loc_70 < _loc_14)
                    {
                        
                        _loc_71 = _loc_13.orientations[_loc_70];
                        updateActorOrientation(_loc_71.id, _loc_71.direction);
                        _loc_70++;
                    }
                    return true;
                }
                case param1 is GameRolePlaySetAnimationMessage:
                {
                    _loc_15 = param1 as GameRolePlaySetAnimationMessage;
                    _loc_16 = DofusEntities.getEntity(_loc_15.informations.contextualId) as AnimatedCharacter;
                    if (_loc_15.animation == AnimationEnum.ANIM_STATIQUE)
                    {
                        this._currentEmoticon = 0;
                        _loc_16.setAnimation(_loc_15.animation);
                        this._emoteTimesBySprite[_loc_16.name] = 0;
                    }
                    else if (!_creaturesMode)
                    {
                        this._emoteTimesBySprite[_loc_16.name] = _loc_15.duration;
                        if (!_loc_15.directions8)
                        {
                            if (_loc_16.getDirection() % 2 == 0)
                            {
                                _loc_16.setDirection((_loc_16.getDirection() + 1));
                            }
                        }
                        _loc_16.addEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                        _loc_16.setAnimation(_loc_15.animation);
                        if (_loc_15.playStaticOnly)
                        {
                            if (_loc_16.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET) && _loc_16.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length)
                            {
                                _loc_16.setSubEntityBehaviour(1, new AnimStatiqueSubEntityBehavior());
                            }
                            _loc_16.stopAnimationAtLastFrame();
                        }
                    }
                    return true;
                }
                case param1 is CharacterMovementStoppedMessage:
                {
                    _loc_17 = param1 as CharacterMovementStoppedMessage;
                    _loc_18 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().infos.id) as AnimatedCharacter;
                    if (OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront && _loc_18.getDirection() == DirectionsEnum.DOWN && _loc_18.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) != -1 && PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
                    {
                        _loc_73 = Kernel.getWorker().getFrame(RoleplayEmoticonFrame) as RoleplayEmoticonFrame;
                        for each (_loc_74 in _loc_73.emotes)
                        {
                            
                            _loc_75 = Emoticon.getEmoticonById(_loc_74);
                            if (_loc_75.aura)
                            {
                                if (!_loc_72 || _loc_75.weight > _loc_72.weight)
                                {
                                    _loc_72 = _loc_75;
                                }
                            }
                        }
                        if (_loc_72)
                        {
                            _loc_76 = new EmotePlayRequestMessage();
                            _loc_76.initEmotePlayRequestMessage(_loc_72.id);
                            ConnectionsHandler.getConnection().send(_loc_76);
                        }
                    }
                    return true;
                }
                case param1 is GameRolePlayShowChallengeMessage:
                {
                    _loc_19 = param1 as GameRolePlayShowChallengeMessage;
                    this.addFight(_loc_19.commonsInfos);
                    return true;
                }
                case param1 is GameFightOptionStateUpdateMessage:
                {
                    _loc_20 = param1 as GameFightOptionStateUpdateMessage;
                    this.updateSwordOptions(_loc_20.fightId, _loc_20.teamId, _loc_20.option, _loc_20.state);
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightOptionStateUpdate, _loc_20.fightId, _loc_20.teamId, _loc_20.option, _loc_20.state);
                    return true;
                }
                case param1 is GameFightUpdateTeamMessage:
                {
                    _loc_21 = param1 as GameFightUpdateTeamMessage;
                    this.updateFight(_loc_21.fightId, _loc_21.team);
                    return true;
                }
                case param1 is GameFightRemoveTeamMemberMessage:
                {
                    _loc_22 = param1 as GameFightRemoveTeamMemberMessage;
                    this.removeFighter(_loc_22.fightId, _loc_22.teamId, _loc_22.charId);
                    return true;
                }
                case param1 is GameRolePlayRemoveChallengeMessage:
                {
                    _loc_23 = param1 as GameRolePlayRemoveChallengeMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayRemoveFight, _loc_23.fightId);
                    this.removeFight(_loc_23.fightId);
                    return true;
                }
                case param1 is GameContextRemoveElementMessage:
                {
                    _loc_24 = param1 as GameContextRemoveElementMessage;
                    _loc_25 = 0;
                    for each (_loc_77 in this._playersId)
                    {
                        
                        if (_loc_77 == _loc_24.id)
                        {
                            this._playersId.splice(_loc_25, 1);
                            continue;
                        }
                        _loc_25 = _loc_25 + 1;
                    }
                    removeActor(_loc_24.id);
                    return true;
                }
                case param1 is MapFightCountMessage:
                {
                    _loc_26 = param1 as MapFightCountMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.MapFightCount, _loc_26.fightCount);
                    return true;
                }
                case param1 is ObjectGroundAddedMessage:
                {
                    _loc_27 = param1 as ObjectGroundAddedMessage;
                    this.addObject(_loc_27.objectGID, _loc_27.cellId);
                    return true;
                }
                case param1 is ObjectGroundRemovedMessage:
                {
                    _loc_28 = param1 as ObjectGroundRemovedMessage;
                    this.removeObject(_loc_28.cell);
                    return true;
                }
                case param1 is ObjectGroundListAddedMessage:
                {
                    _loc_29 = param1 as ObjectGroundListAddedMessage;
                    _loc_30 = 0;
                    for each (_loc_78 in _loc_29.referenceIds)
                    {
                        
                        this.addObject(_loc_78, _loc_29.cells[_loc_30]);
                        _loc_30 = _loc_30 + 1;
                    }
                    return true;
                }
                case param1 is PaddockRemoveItemRequestAction:
                {
                    _loc_31 = param1 as PaddockRemoveItemRequestAction;
                    _loc_32 = new PaddockRemoveItemRequestMessage();
                    _loc_32.initPaddockRemoveItemRequestMessage(_loc_31.cellId);
                    ConnectionsHandler.getConnection().send(_loc_32);
                    return true;
                }
                case param1 is PaddockMoveItemRequestAction:
                {
                    _loc_33 = param1 as PaddockMoveItemRequestAction;
                    this._currentPaddockItemCellId = _loc_33.object.disposition.cellId;
                    _loc_34 = new Texture();
                    _loc_35 = ItemWrapper.create(0, 0, _loc_33.object.item.id, 0, null, false);
                    _loc_34.uri = _loc_35.iconUri;
                    _loc_34.finalize();
                    Kernel.getWorker().addFrame(new RoleplayPointCellFrame(this.onCellPointed, _loc_34, true, this.paddockCellValidator, true));
                    return true;
                }
                case param1 is GameDataPaddockObjectRemoveMessage:
                {
                    _loc_36 = param1 as GameDataPaddockObjectRemoveMessage;
                    _loc_37 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                    this.removePaddockItem(_loc_36.cellId);
                    return true;
                }
                case param1 is GameDataPaddockObjectAddMessage:
                {
                    _loc_38 = param1 as GameDataPaddockObjectAddMessage;
                    this.addPaddockItem(_loc_38.paddockItemDescription);
                    return true;
                }
                case param1 is GameDataPaddockObjectListAddMessage:
                {
                    _loc_39 = param1 as GameDataPaddockObjectListAddMessage;
                    for each (_loc_79 in _loc_39.paddockItemDescription)
                    {
                        
                        this.addPaddockItem(_loc_79);
                    }
                    return true;
                }
                case param1 is GameDataPlayFarmObjectAnimationMessage:
                {
                    _loc_40 = param1 as GameDataPlayFarmObjectAnimationMessage;
                    for each (_loc_80 in _loc_40.cellId)
                    {
                        
                        this.activatePaddockItem(_loc_80);
                    }
                    return true;
                }
                case param1 is MapNpcsQuestStatusUpdateMessage:
                {
                    _loc_41 = param1 as MapNpcsQuestStatusUpdateMessage;
                    if (MapDisplayManager.getInstance().currentMapPoint.mapId == _loc_41.mapId)
                    {
                        _loc_84 = _loc_41.npcsIdsWithQuest.length;
                        _loc_83 = 0;
                        while (_loc_83 < _loc_84)
                        {
                            
                            _loc_81 = this._npcList[_loc_41.npcsIdsWithQuest[_loc_83]];
                            if (_loc_81)
                            {
                                _loc_86 = Quest.getFirstValidQuest(_loc_41.questFlags[_loc_66]);
                                this.removeBackground(_loc_81);
                                if (_loc_86 != null)
                                {
                                    if (_loc_41.questFlags[_loc_66].questsToStartId.indexOf(_loc_86.id) != -1)
                                    {
                                        if (_loc_86.repeatType == 0)
                                        {
                                            _loc_82 = new QUEST_CLIP() as Sprite;
                                            _loc_81.addBackground("questClip", _loc_82, true);
                                        }
                                        else
                                        {
                                            _loc_82 = new QUEST_REPEATABLE_CLIP() as Sprite;
                                            _loc_81.addBackground("questRepeatableClip", _loc_82, true);
                                        }
                                    }
                                    else if (_loc_86.repeatType == 0)
                                    {
                                        _loc_82 = new QUEST_OBJECTIVE_CLIP() as Sprite;
                                        _loc_81.addBackground("questObjectiveClip", _loc_82, true);
                                    }
                                    else
                                    {
                                        _loc_82 = new QUEST_REPEATABLE_OBJECTIVE_CLIP() as Sprite;
                                        _loc_81.addBackground("questRepeatableObjectiveClip", _loc_82, true);
                                    }
                                }
                            }
                            _loc_83++;
                        }
                        _loc_85 = _loc_41.npcsIdsWithoutQuest.length;
                        _loc_83 = 0;
                        while (_loc_83 < _loc_85)
                        {
                            
                            _loc_81 = this._npcList[_loc_41.npcsIdsWithoutQuest[_loc_83]];
                            if (_loc_81)
                            {
                                this.removeBackground(_loc_81);
                            }
                            _loc_83++;
                        }
                    }
                    return true;
                }
                case param1 is ShowCellMessage:
                {
                    _loc_42 = param1 as ShowCellMessage;
                    HyperlinkShowCellManager.showCell(_loc_42.cellId);
                    _loc_43 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                    _loc_44 = _loc_43.getActorName(_loc_42.sourceId);
                    _loc_45 = I18n.getUiText("ui.fight.showCell", [_loc_44, "{cell," + _loc_42.cellId + "::" + _loc_42.cellId + "}"]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_45, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is StartZoomAction:
                {
                    _loc_46 = param1 as StartZoomAction;
                    if (Atouin.getInstance().currentZoom != 1)
                    {
                        Atouin.getInstance().cancelZoom();
                        KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                        return true;
                    }
                    _loc_47 = DofusEntities.getEntity(_loc_46.playerId) as DisplayObject;
                    if (_loc_47 && _loc_47.stage)
                    {
                        _loc_87 = _loc_47.getRect(Atouin.getInstance().worldContainer);
                        Atouin.getInstance().zoom(_loc_46.value, _loc_87.x + _loc_87.width / 2, _loc_87.y + _loc_87.height / 2);
                        KernelEventsManager.getInstance().processCallback(HookList.StartZoom, true);
                    }
                    return true;
                }
                case param1 is SwitchCreatureModeAction:
                {
                    _loc_48 = param1 as SwitchCreatureModeAction;
                    if (_creaturesMode != _loc_48.isActivated)
                    {
                        _creaturesMode = _loc_48.isActivated;
                        for (_loc_88 in _entities)
                        {
                            
                            updateActorLook(_loc_88, (_entities[_loc_88] as GameContextActorInformations).look);
                        }
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function initNewMap() : void
        {
            this._npcList = new Array();
            this._fights = new Dictionary();
            this._objects = new Dictionary();
            this._uri = new Dictionary();
            this._paddockItem = new Dictionary();
            _humanNumber = 0;
            return;
        }// end function

        override protected function switchPokemonMode() : Boolean
        {
            if (super.switchPokemonMode())
            {
                KernelEventsManager.getInstance().processCallback(TriggerHookList.CreaturesMode);
                return true;
            }
            return false;
        }// end function

        override public function pulled() : Boolean
        {
            var _loc_1:Fight = null;
            var _loc_2:FightTeam = null;
            for each (_loc_1 in this._fights)
            {
                
                for each (_loc_2 in _loc_1.teams)
                {
                    
                    TooltipManager.hide("fightOptions_" + _loc_1.fightId + "_" + _loc_2.teamInfos.teamId);
                }
            }
            if (this._loader)
            {
                this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onGroundObjectLoaded);
                this._loader.removeEventListener(ResourceErrorEvent.ERROR, this.onGroundObjectLoadFailed);
                this._loader = null;
            }
            AnimFunManager.getInstance().stopAllTimer();
            this._fights = null;
            this._objects = null;
            this._npcList = null;
            Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            return super.pulled();
        }// end function

        public function isFight(param1:int) : Boolean
        {
            return _entities[param1] is FightTeam;
        }// end function

        public function isPaddockItem(param1:int) : Boolean
        {
            return _entities[param1] is GameContextPaddockItemInformations;
        }// end function

        public function getFightTeam(param1:int) : FightTeam
        {
            return _entities[param1] as FightTeam;
        }// end function

        public function getFightId(param1:int) : uint
        {
            return (_entities[param1] as FightTeam).fight.fightId;
        }// end function

        public function getFightLeaderId(param1:int) : uint
        {
            return (_entities[param1] as FightTeam).teamInfos.leaderId;
        }// end function

        public function getFightTeamType(param1:int) : uint
        {
            return (_entities[param1] as FightTeam).teamType;
        }// end function

        override public function addOrUpdateActor(param1:GameContextActorInformations, param2:IAnimationModifier = null) : AnimatedCharacter
        {
            var _loc_4:Sprite = null;
            var _loc_5:Quest = null;
            var _loc_6:GameRolePlayGroupMonsterInformations = null;
            var _loc_7:Vector.<EntityLook> = null;
            var _loc_8:uint = 0;
            var _loc_9:MonsterInGroupInformations = null;
            var _loc_3:* = super.addOrUpdateActor(param1);
            switch(true)
            {
                case param1 is GameRolePlayNpcWithQuestInformations:
                {
                    this._npcList[param1.contextualId] = _loc_3;
                    _loc_5 = Quest.getFirstValidQuest((param1 as GameRolePlayNpcWithQuestInformations).questFlag);
                    this.removeBackground(_loc_3);
                    if (_loc_5 != null)
                    {
                        if ((param1 as GameRolePlayNpcWithQuestInformations).questFlag.questsToStartId.indexOf(_loc_5.id) != -1)
                        {
                            if (_loc_5.repeatType == 0)
                            {
                                _loc_4 = new QUEST_CLIP() as Sprite;
                                _loc_3.addBackground("questClip", _loc_4, true);
                            }
                            else
                            {
                                _loc_4 = new QUEST_REPEATABLE_CLIP() as Sprite;
                                _loc_3.addBackground("questRepeatableClip", _loc_4, true);
                            }
                        }
                        else if (_loc_5.repeatType == 0)
                        {
                            _loc_4 = new QUEST_OBJECTIVE_CLIP() as Sprite;
                            _loc_3.addBackground("questObjectiveClip", _loc_4, true);
                        }
                        else
                        {
                            _loc_4 = new QUEST_REPEATABLE_OBJECTIVE_CLIP() as Sprite;
                            _loc_3.addBackground("questRepeatableObjectiveClip", _loc_4, true);
                        }
                    }
                    if (_loc_3.look.getBone() == 1)
                    {
                        _loc_3.addAnimationModifier(_customAnimModifier);
                    }
                    if (_creaturesMode || _loc_3.getAnimation() == AnimationEnum.ANIM_STATIQUE)
                    {
                        _loc_3.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    }
                    break;
                }
                case param1 is GameRolePlayGroupMonsterInformations:
                {
                    if (Dofus.getInstance().options.showEveryMonsters)
                    {
                        _loc_6 = param1 as GameRolePlayGroupMonsterInformations;
                        _loc_7 = new Vector.<EntityLook>(_loc_6.underlings.length, true);
                        _loc_8 = 0;
                        for each (_loc_9 in _loc_6.underlings)
                        {
                            
                            _loc_7[++_loc_8] = _loc_9.look;
                        }
                        this.manageFollowers(_loc_3, _loc_7);
                    }
                    break;
                }
                case param1 is GameRolePlayHumanoidInformations:
                {
                    this._playersId.push(param1.contextualId);
                    this.manageFollowers(_loc_3, (param1 as GameRolePlayHumanoidInformations).humanoidInfo.followingCharactersLook);
                    if (_loc_3.look.getBone() == 1)
                    {
                        _loc_3.addAnimationModifier(_customAnimModifier);
                    }
                    if (_creaturesMode || _loc_3.getAnimation() == AnimationEnum.ANIM_STATIQUE)
                    {
                        _loc_3.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    }
                    break;
                }
                case param1 is GameRolePlayMerchantInformations:
                {
                    if (_loc_3.look.getBone() == 1)
                    {
                        _loc_3.addAnimationModifier(_customAnimModifier);
                    }
                    if (_creaturesMode || _loc_3.getAnimation() == AnimationEnum.ANIM_STATIQUE)
                    {
                        _loc_3.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    }
                    break;
                }
                case param1 is GameRolePlayTaxCollectorInformations:
                case param1 is GameRolePlayPrismInformations:
                {
                    break;
                }
                default:
                {
                    _log.warn("Unknown GameRolePlayActorInformations type : " + param1 + ".");
                    break;
                }
            }
            return _loc_3;
        }// end function

        private function removeBackground(param1:TiphonSprite) : void
        {
            if (!param1)
            {
                return;
            }
            param1.removeBackground("questClip");
            param1.removeBackground("questObjectiveClip");
            param1.removeBackground("questRepeatableClip");
            param1.removeBackground("questRepeatableObjectiveClip");
            return;
        }// end function

        private function manageFollowers(param1:AnimatedCharacter, param2:Vector.<EntityLook>) : void
        {
            var _loc_5:EntityLook = null;
            var _loc_6:TiphonEntityLook = null;
            var _loc_7:AnimatedCharacter = null;
            param1.removeAllFollowers();
            var _loc_3:* = param2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param2[_loc_4];
                _loc_6 = EntityLookAdapter.fromNetwork(_loc_5);
                _loc_7 = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(), _loc_6, param1);
                param1.addFollower(_loc_7);
                _loc_4++;
            }
            return;
        }// end function

        private function addFight(param1:FightCommonInformations) : void
        {
            var _loc_5:FightTeamInformations = null;
            var _loc_6:IEntity = null;
            var _loc_7:FightTeam = null;
            var _loc_2:* = new Vector.<FightTeam>(0, false);
            var _loc_3:* = new Fight(param1.fightId, _loc_2);
            var _loc_4:uint = 0;
            for each (_loc_5 in param1.fightTeams)
            {
                
                _loc_6 = RolePlayEntitiesFactory.createFightEntity(param1, _loc_5, MapPoint.fromCellId(param1.fightTeamsPositions[_loc_4]));
                (_loc_6 as IDisplayable).display();
                _loc_7 = new FightTeam(_loc_3, _loc_5.teamTypeId, _loc_6, _loc_5, param1.fightTeamsOptions[_loc_5.teamId]);
                _entities[_loc_6.id] = _loc_7;
                _loc_2.push(_loc_7);
                _loc_4 = _loc_4 + 1;
            }
            this._fights[param1.fightId] = _loc_3;
            for each (_loc_5 in param1.fightTeams)
            {
                
                this.updateSwordOptions(param1.fightId, _loc_5.teamId);
            }
            return;
        }// end function

        private function addObject(param1:uint, param2:uint) : void
        {
            var _loc_3:* = new Uri(LangManager.getInstance().getEntry("config.gfx.path.item.vector") + Item.getItemById(param1).iconId + ".swf");
            var _loc_4:* = new RoleplayObjectEntity(param1, MapPoint.fromCellId(param2));
            (new RoleplayObjectEntity(param1, MapPoint.fromCellId(param2)) as IDisplayable).display();
            var _loc_5:* = new GroundObject(Item.getItemById(param1));
            new GroundObject(Item.getItemById(param1)).contextualId = _loc_4.id;
            _loc_5.disposition.cellId = param2;
            _loc_5.disposition.direction = DirectionsEnum.DOWN_RIGHT;
            if (this._objects == null)
            {
                this._objects = new Dictionary();
            }
            this._objects[_loc_3] = _loc_4;
            this._uri[param2] = this._objects[_loc_3];
            _entities[_loc_4.id] = _loc_5;
            this._loader.load(_loc_3, null, null, true);
            return;
        }// end function

        private function removeObject(param1:uint) : void
        {
            (this._uri[param1] as IDisplayable).remove();
            delete this._objects[this._uri[param1]];
            delete _entities[this._uri[param1].id];
            delete this._uri[param1];
            return;
        }// end function

        private function updateFight(param1:uint, param2:FightTeamInformations) : void
        {
            var _loc_6:FightTeamMemberInformations = null;
            var _loc_7:Boolean = false;
            var _loc_8:Boolean = false;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:Boolean = false;
            var _loc_12:FightTeamMemberInformations = null;
            var _loc_3:* = this._fights[param1];
            if (_loc_3 == null)
            {
                return;
            }
            var _loc_4:* = _loc_3.getTeamById(param2.teamId);
            var _loc_5:* = (_entities[_loc_4.teamEntity.id] as FightTeam).teamInfos;
            if ((_entities[_loc_4.teamEntity.id] as FightTeam).teamInfos.teamMembers == param2.teamMembers)
            {
                return;
            }
            for each (_loc_6 in param2.teamMembers)
            {
                
                _loc_7 = false;
                _loc_8 = false;
                if (_loc_6 is FightTeamMemberMonsterInformations)
                {
                    _loc_8 = true;
                    _loc_10 = (_loc_6 as FightTeamMemberMonsterInformations).monsterId;
                }
                else
                {
                    _loc_10 = _loc_6.id;
                }
                _loc_11 = false;
                for each (_loc_12 in _loc_5.teamMembers)
                {
                    
                    if (_loc_12 is FightTeamMemberMonsterInformations)
                    {
                        _loc_7 = true;
                        _loc_9 = (_loc_12 as FightTeamMemberMonsterInformations).monsterId;
                    }
                    else
                    {
                        _loc_9 = _loc_12.id;
                    }
                    if (_loc_9 == _loc_10)
                    {
                        _loc_11 = true;
                    }
                }
                if (!_loc_11)
                {
                    _loc_5.teamMembers.push(_loc_6);
                }
            }
            return;
        }// end function

        private function removeFighter(param1:uint, param2:uint, param3:int) : void
        {
            var _loc_8:FightTeamMemberInformations = null;
            var _loc_4:* = this._fights[param1];
            var _loc_5:* = this._fights[param1].teams[param2];
            var _loc_6:* = this._fights[param1].teams[param2].teamInfos;
            var _loc_7:* = new Vector.<FightTeamMemberInformations>(0, false);
            for each (_loc_8 in _loc_6.teamMembers)
            {
                
                if (_loc_8.id != param3)
                {
                    _loc_7.push(_loc_8);
                }
            }
            _loc_6.teamMembers = _loc_7;
            return;
        }// end function

        private function removeFight(param1:uint) : void
        {
            var _loc_3:FightTeam = null;
            var _loc_4:Object = null;
            var _loc_2:* = this._fights[param1];
            if (_loc_2 == null)
            {
                return;
            }
            for each (_loc_3 in _loc_2.teams)
            {
                
                _loc_4 = _entities[_loc_3.teamEntity.id];
                Kernel.getWorker().process(new EntityMouseOutMessage(_loc_3.teamEntity as IInteractive));
                (_loc_3.teamEntity as IDisplayable).remove();
                TooltipManager.hide("fightOptions_" + param1 + "_" + _loc_3.teamInfos.teamId);
                delete _entities[_loc_3.teamEntity.id];
            }
            delete this._fights[param1];
            return;
        }// end function

        private function addPaddockItem(param1:PaddockItem) : void
        {
            var _loc_3:int = 0;
            var _loc_2:* = Item.getItemById(param1.objectGID);
            if (this._paddockItem[param1.cellId])
            {
                _loc_3 = (this._paddockItem[param1.cellId] as IEntity).id;
            }
            else
            {
                _loc_3 = EntitiesManager.getInstance().getFreeEntityId();
            }
            var _loc_4:* = new GameContextPaddockItemInformations(_loc_3, _loc_2.appearance, param1.cellId, param1.durability, _loc_2);
            var _loc_5:* = this.addOrUpdateActor(_loc_4);
            this._paddockItem[param1.cellId] = _loc_5;
            return;
        }// end function

        private function removePaddockItem(param1:uint) : void
        {
            var _loc_2:* = this._paddockItem[param1];
            if (!_loc_2)
            {
                return;
            }
            (_loc_2 as IDisplayable).remove();
            delete this._paddockItem[param1];
            return;
        }// end function

        private function activatePaddockItem(param1:uint) : void
        {
            var _loc_3:SerialSequencer = null;
            var _loc_2:* = this._paddockItem[param1];
            if (_loc_2)
            {
                _loc_3 = new SerialSequencer();
                _loc_3.addStep(new PlayAnimationStep(_loc_2, AnimationEnum.ANIM_HIT));
                _loc_3.addStep(new PlayAnimationStep(_loc_2, AnimationEnum.ANIM_STATIQUE));
                _loc_3.start();
            }
            return;
        }// end function

        private function updateSwordOptions(param1:uint, param2:uint, param3:int = -1, param4:Boolean = false) : void
        {
            var _loc_8:* = undefined;
            var _loc_5:* = this._fights[param1];
            if (this._fights[param1] == null)
            {
                return;
            }
            var _loc_6:* = _loc_5.teams[param2];
            if (_loc_5.teams[param2] == null)
            {
                return;
            }
            if (param3 != -1)
            {
                _loc_6.teamOptions[param3] = param4;
            }
            var _loc_7:* = new Vector.<String>;
            for (_loc_8 in _loc_6.teamOptions)
            {
                
                if (_loc_6.teamOptions[_loc_8])
                {
                    _loc_7.push("fightOption" + _loc_8);
                }
            }
            TooltipManager.show(_loc_7, (_loc_6.teamEntity as IDisplayable).absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, "fightOptions_" + param1 + "_" + param2, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, null, null, false, 0);
            return;
        }// end function

        private function paddockCellValidator(param1:int) : Boolean
        {
            var _loc_3:GameContextActorInformations = null;
            var _loc_2:* = EntitiesManager.getInstance().getEntityOnCell(param1);
            if (_loc_2)
            {
                _loc_3 = getEntityInfos(_loc_2.id);
                if (_loc_3 is GameContextPaddockItemInformations)
                {
                    return false;
                }
            }
            return DataMapProvider.getInstance().farmCell(MapPoint.fromCellId(param1).x, MapPoint.fromCellId(param1).y) && DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(param1).x, MapPoint.fromCellId(param1).y, true);
        }// end function

        private function onGroundObjectLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_2:* = event.resource;
            _loc_2.x = _loc_2.x - _loc_2.width / 2;
            _loc_2.y = _loc_2.y - _loc_2.height / 2;
            this._objects[event.uri].addChild(_loc_2);
            return;
        }// end function

        private function onGroundObjectLoadFailed(event:ResourceErrorEvent) : void
        {
            return;
        }// end function

        public function timeoutStop(param1:AnimatedCharacter) : void
        {
            clearTimeout(this._timeout);
            param1.setAnimation(AnimationEnum.ANIM_STATIQUE);
            this._currentEmoticon = 0;
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            if (event.propertyName == "mapCoordinates")
            {
                KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData, _worldPoint, _currentSubAreaId, event.propertyValue, _currentSubAreaSide);
            }
            return;
        }// end function

        override public function onPlayAnim(event:TiphonEvent) : void
        {
            var _loc_2:* = new Array();
            var _loc_3:* = event.params.substring(6, (event.params.length - 1));
            _loc_2 = _loc_3.split(",");
            var _loc_4:* = this._emoteTimesBySprite[(event.currentTarget as TiphonSprite).name] % _loc_2.length;
            event.sprite.setAnimation(_loc_2[_loc_4]);
            return;
        }// end function

        private function onAnimationEnd(event:TiphonEvent) : void
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            var _loc_2:* = event.currentTarget as TiphonSprite;
            _loc_2.removeEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
            var _loc_5:* = _loc_2.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (_loc_2.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) != null)
            {
                _loc_4 = _loc_5.getAnimation();
                if (_loc_4.indexOf("_") == -1)
                {
                    _loc_4 = _loc_2.getAnimation();
                }
            }
            else
            {
                _loc_4 = _loc_2.getAnimation();
            }
            if (_loc_4.indexOf("_Statique_") == -1)
            {
                _loc_3 = _loc_4.replace("_", "_Statique_");
            }
            else
            {
                _loc_3 = _loc_4;
            }
            if (_loc_2.hasAnimation(_loc_3, _loc_2.getDirection()))
            {
                _loc_2.setAnimation(_loc_3);
            }
            else
            {
                _loc_2.setAnimation(AnimationEnum.ANIM_STATIQUE);
                this._currentEmoticon = 0;
            }
            return;
        }// end function

        private function onCellPointed(param1:Boolean, param2:uint, param3:int) : void
        {
            var _loc_4:PaddockMoveItemRequestMessage = null;
            if (param1)
            {
                _loc_4 = new PaddockMoveItemRequestMessage();
                _loc_4.initPaddockMoveItemRequestMessage(this._currentPaddockItemCellId, param2);
                ConnectionsHandler.getConnection().send(_loc_4);
            }
            return;
        }// end function

    }
}
