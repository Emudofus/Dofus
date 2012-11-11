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
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
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
        private var _npcList:Dictionary;
        private var _housesList:Dictionary;
        private var _emoteTimesBySprite:Dictionary;
        private var _waitForMap:Boolean;

        public function RoleplayEntitiesFrame()
        {
            this._paddockItem = new Dictionary();
            this._groundObjectCache = new Cache(20, new LruGarbageCollector());
            this._usableEmotes = new Array();
            this._npcList = new Dictionary(true);
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
            var _loc_1:* = null;
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
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = 0;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = null;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = null;
            var _loc_43:* = null;
            var _loc_44:* = null;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = null;
            var _loc_48:* = null;
            var _loc_49:* = null;
            var _loc_50:* = null;
            var _loc_51:* = false;
            var _loc_52:* = null;
            var _loc_53:* = null;
            var _loc_54:* = null;
            var _loc_55:* = null;
            var _loc_56:* = null;
            var _loc_57:* = false;
            var _loc_58:* = null;
            var _loc_59:* = null;
            var _loc_60:* = null;
            var _loc_61:* = null;
            var _loc_62:* = null;
            var _loc_63:* = 0;
            var _loc_64:* = 0;
            var _loc_65:* = null;
            var _loc_66:* = null;
            var _loc_67:* = null;
            var _loc_68:* = 0;
            var _loc_69:* = null;
            var _loc_70:* = null;
            var _loc_71:* = null;
            var _loc_72:* = 0;
            var _loc_73:* = null;
            var _loc_74:* = null;
            var _loc_75:* = 0;
            var _loc_76:* = 0;
            var _loc_77:* = null;
            var _loc_78:* = 0;
            var _loc_79:* = null;
            var _loc_80:* = null;
            var _loc_81:* = 0;
            var _loc_82:* = 0;
            var _loc_83:* = null;
            var _loc_84:* = null;
            var _loc_85:* = undefined;
            switch(true)
            {
                case param1 is MapLoadedMessage:
                {
                    if (this._waitForMap)
                    {
                        _loc_48 = new MapInformationsRequestMessage();
                        _loc_48.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                        ConnectionsHandler.getConnection().send(_loc_48);
                        this._waitForMap = false;
                    }
                    return false;
                }
                case param1 is MapComplementaryInformationsDataMessage:
                {
                    _loc_2 = param1 as MapComplementaryInformationsDataMessage;
                    this.initNewMap();
                    _interactiveElements = _loc_2.interactiveElements;
                    this._fightNumber = _loc_2.fights.length;
                    if (param1 is MapComplementaryInformationsWithCoordsMessage)
                    {
                        _loc_49 = param1 as MapComplementaryInformationsWithCoordsMessage;
                        if (PlayedCharacterManager.getInstance().isInHouse)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                        }
                        PlayedCharacterManager.getInstance().isInHouse = false;
                        PlayedCharacterManager.getInstance().isInHisHouse = false;
                        PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(_loc_49.worldX, _loc_49.worldY);
                        _worldPoint = new WorldPointWrapper(_loc_49.mapId, true, _loc_49.worldX, _loc_49.worldY);
                    }
                    else if (param1 is MapComplementaryInformationsDataInHouseMessage)
                    {
                        _loc_50 = param1 as MapComplementaryInformationsDataInHouseMessage;
                        _loc_51 = PlayerManager.getInstance().nickname == _loc_50.currentHouse.ownerName;
                        PlayedCharacterManager.getInstance().isInHouse = true;
                        if (_loc_51)
                        {
                            PlayedCharacterManager.getInstance().isInHisHouse = true;
                        }
                        PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(_loc_50.currentHouse.worldX, _loc_50.currentHouse.worldY);
                        KernelEventsManager.getInstance().processCallback(HookList.HouseEntered, _loc_51, _loc_50.currentHouse.ownerId, _loc_50.currentHouse.ownerName, _loc_50.currentHouse.price, _loc_50.currentHouse.isLocked, _loc_50.currentHouse.worldX, _loc_50.currentHouse.worldY, HouseWrapper.manualCreate(_loc_50.currentHouse.modelId, -1, _loc_50.currentHouse.ownerName, _loc_50.currentHouse.price != 0));
                        _worldPoint = new WorldPointWrapper(_loc_50.mapId, true, _loc_50.currentHouse.worldX, _loc_50.currentHouse.worldY);
                    }
                    else
                    {
                        _worldPoint = new WorldPointWrapper(_loc_2.mapId);
                        if (PlayedCharacterManager.getInstance().isInHouse)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                        }
                        PlayedCharacterManager.getInstance().isInHouse = false;
                        PlayedCharacterManager.getInstance().isInHisHouse = false;
                    }
                    _currentSubAreaId = _loc_2.subAreaId;
                    _currentSubAreaSide = _loc_2.subareaAlignmentSide;
                    _loc_3 = SubArea.getSubAreaById(_currentSubAreaId);
                    PlayedCharacterManager.getInstance().currentMap = _worldPoint;
                    PlayedCharacterManager.getInstance().currentSubArea = _loc_3;
                    TooltipManager.hide();
                    updateCreaturesLimit();
                    _loc_4 = false;
                    for each (_loc_52 in _loc_2.actors)
                    {
                        
                        var _loc_89:* = _humanNumber + 1;
                        _humanNumber = _loc_89;
                        if (_creaturesLimit < 50 && _humanNumber >= _creaturesLimit)
                        {
                            _creaturesMode = true;
                        }
                        if (_loc_52.contextualId > 0 && this._playersId && this._playersId.indexOf(_loc_52.contextualId) == -1)
                        {
                            this._playersId.push(_loc_52.contextualId);
                        }
                    }
                    _loc_5 = true;
                    for each (_loc_53 in _loc_2.actors)
                    {
                        
                        _loc_54 = this.addOrUpdateActor(_loc_53) as AnimatedCharacter;
                        if (_loc_54)
                        {
                            _loc_55 = _loc_53 as GameRolePlayCharacterInformations;
                            if (_loc_55 && _loc_55.humanoidInfo.emoteId > 0)
                            {
                                _loc_56 = Emoticon.getEmoticonById(_loc_55.humanoidInfo.emoteId);
                                if (_loc_56.persistancy)
                                {
                                    this._currentEmoticon = _loc_56.id;
                                    if (!_loc_56.aura)
                                    {
                                        _loc_57 = false;
                                        _loc_58 = new Date();
                                        if (_loc_58.getTime() - _loc_55.humanoidInfo.emoteStartTime >= _loc_56.duration)
                                        {
                                            _loc_57 = true;
                                        }
                                        _loc_59 = EntityLookAdapter.fromNetwork(_loc_55.look);
                                        this.process(new GameRolePlaySetAnimationMessage(_loc_53, _loc_56.getAnimName(_loc_59), _loc_55.humanoidInfo.emoteStartTime, !_loc_56.persistancy, _loc_56.eight_directions, _loc_57));
                                    }
                                }
                            }
                        }
                        if (_loc_5)
                        {
                            if (_loc_53 is GameRolePlayGroupMonsterInformations)
                            {
                                _loc_5 = false;
                                KernelEventsManager.getInstance().processCallback(TriggerHookList.MapWithMonsters);
                            }
                        }
                        if (_loc_53 is GameRolePlayCharacterInformations)
                        {
                            ChatAutocompleteNameManager.getInstance().addEntry((_loc_53 as GameRolePlayCharacterInformations).name, 0);
                        }
                    }
                    for each (_loc_60 in _loc_2.fights)
                    {
                        
                        this.addFight(_loc_60);
                    }
                    this._housesList = new Dictionary();
                    for each (_loc_61 in _loc_2.houses)
                    {
                        
                        _loc_62 = HouseWrapper.create(_loc_61);
                        _loc_63 = _loc_61.doorsOnMap.length;
                        _loc_64 = 0;
                        while (_loc_64 < _loc_63)
                        {
                            
                            this._housesList[_loc_61.doorsOnMap[_loc_64]] = _loc_62;
                            _loc_64++;
                        }
                        _loc_65 = new HousePropertiesMessage();
                        _loc_65.initHousePropertiesMessage(_loc_61);
                        Kernel.getWorker().process(_loc_65);
                    }
                    for each (_loc_66 in _loc_2.obstacles)
                    {
                        
                        InteractiveCellManager.getInstance().updateCell(_loc_66.obstacleCellId, _loc_66.state == MapObstacleStateEnum.OBSTACLE_OPENED);
                    }
                    _loc_6 = new InteractiveMapUpdateMessage();
                    _loc_6.initInteractiveMapUpdateMessage(_loc_2.interactiveElements);
                    Kernel.getWorker().process(_loc_6);
                    _loc_7 = new StatedMapUpdateMessage();
                    _loc_7.initStatedMapUpdateMessage(_loc_2.statedElements);
                    Kernel.getWorker().process(_loc_7);
                    KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData, PlayedCharacterManager.getInstance().currentMap, _currentSubAreaId, Dofus.getInstance().options.mapCoordinates, _currentSubAreaSide);
                    KernelEventsManager.getInstance().processCallback(HookList.MapFightCount, 0);
                    AnimFunManager.getInstance().initializeByMap(_loc_2.mapId);
                    this.switchPokemonMode();
                    return true;
                }
                case param1 is HousePropertiesMessage:
                {
                    _loc_8 = (param1 as HousePropertiesMessage).properties;
                    _loc_62 = HouseWrapper.create(_loc_8);
                    _loc_63 = _loc_8.doorsOnMap.length;
                    _loc_64 = 0;
                    while (_loc_64 < _loc_63)
                    {
                        
                        this._housesList[_loc_8.doorsOnMap[_loc_64]] = _loc_62;
                        _loc_64++;
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.HouseProperties, _loc_8.houseId, _loc_8.doorsOnMap, _loc_8.ownerName, _loc_8.isOnSale, _loc_8.modelId);
                    return true;
                }
                case param1 is GameRolePlayShowActorMessage:
                {
                    _loc_9 = param1 as GameRolePlayShowActorMessage;
                    updateCreaturesLimit();
                    var _loc_87:* = _humanNumber + 1;
                    _humanNumber = _loc_87;
                    this.addOrUpdateActor(_loc_9.informations);
                    if (this.switchPokemonMode())
                    {
                        return true;
                    }
                    if (_loc_9.informations is GameRolePlayCharacterInformations)
                    {
                        ChatAutocompleteNameManager.getInstance().addEntry((_loc_9.informations as GameRolePlayCharacterInformations).name, 0);
                    }
                    if (_loc_9.informations is GameRolePlayCharacterInformations && PlayedCharacterManager.getInstance().characteristics.alignmentInfos.pvpEnabled)
                    {
                        _loc_67 = _loc_9.informations as GameRolePlayCharacterInformations;
                        switch(PlayedCharacterManager.getInstance().levelDiff(_loc_67.alignmentInfos.characterPower - _loc_9.informations.contextualId))
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
                    _loc_10 = param1 as GameContextRefreshEntityLookMessage;
                    updateActorLook(_loc_10.id, _loc_10.look, true);
                    return true;
                }
                case param1 is GameMapChangeOrientationMessage:
                {
                    _loc_11 = param1 as GameMapChangeOrientationMessage;
                    updateActorOrientation(_loc_11.orientation.id, _loc_11.orientation.direction);
                    return true;
                }
                case param1 is GameMapChangeOrientationsMessage:
                {
                    _loc_12 = param1 as GameMapChangeOrientationsMessage;
                    _loc_13 = _loc_12.orientations.length;
                    _loc_68 = 0;
                    while (_loc_68 < _loc_13)
                    {
                        
                        _loc_69 = _loc_12.orientations[_loc_68];
                        updateActorOrientation(_loc_69.id, _loc_69.direction);
                        _loc_68++;
                    }
                    return true;
                }
                case param1 is GameRolePlaySetAnimationMessage:
                {
                    _loc_14 = param1 as GameRolePlaySetAnimationMessage;
                    _loc_15 = DofusEntities.getEntity(_loc_14.informations.contextualId) as AnimatedCharacter;
                    if (_loc_14.animation == AnimationEnum.ANIM_STATIQUE)
                    {
                        this._currentEmoticon = 0;
                        _loc_15.setAnimation(_loc_14.animation);
                        this._emoteTimesBySprite[_loc_15.name] = 0;
                    }
                    else if (!_creaturesMode)
                    {
                        this._emoteTimesBySprite[_loc_15.name] = _loc_14.duration;
                        if (!_loc_14.directions8)
                        {
                            if (_loc_15.getDirection() % 2 == 0)
                            {
                                _loc_15.setDirection((_loc_15.getDirection() + 1));
                            }
                        }
                        _loc_15.addEventListener(TiphonEvent.ANIMATION_END, this.onAnimationEnd);
                        _loc_15.setAnimation(_loc_14.animation);
                        if (_loc_14.playStaticOnly)
                        {
                            if (_loc_15.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET) && _loc_15.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length)
                            {
                                _loc_15.setSubEntityBehaviour(1, new AnimStatiqueSubEntityBehavior());
                            }
                            _loc_15.stopAnimationAtLastFrame();
                        }
                    }
                    return true;
                }
                case param1 is CharacterMovementStoppedMessage:
                {
                    _loc_16 = param1 as CharacterMovementStoppedMessage;
                    _loc_17 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().infos.id) as AnimatedCharacter;
                    if (OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront && _loc_17.getDirection() == DirectionsEnum.DOWN && _loc_17.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) != -1 && PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
                    {
                        _loc_71 = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
                        for each (_loc_72 in _loc_71.emotes)
                        {
                            
                            _loc_73 = Emoticon.getEmoticonById(_loc_72);
                            if (_loc_73.aura)
                            {
                                if (!_loc_70 || _loc_73.weight > _loc_70.weight)
                                {
                                    _loc_70 = _loc_73;
                                }
                            }
                        }
                        if (_loc_70)
                        {
                            _loc_74 = new EmotePlayRequestMessage();
                            _loc_74.initEmotePlayRequestMessage(_loc_70.id);
                            ConnectionsHandler.getConnection().send(_loc_74);
                        }
                    }
                    return true;
                }
                case param1 is GameRolePlayShowChallengeMessage:
                {
                    _loc_18 = param1 as GameRolePlayShowChallengeMessage;
                    this.addFight(_loc_18.commonsInfos);
                    return true;
                }
                case param1 is GameFightOptionStateUpdateMessage:
                {
                    _loc_19 = param1 as GameFightOptionStateUpdateMessage;
                    this.updateSwordOptions(_loc_19.fightId, _loc_19.teamId, _loc_19.option, _loc_19.state);
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightOptionStateUpdate, _loc_19.fightId, _loc_19.teamId, _loc_19.option, _loc_19.state);
                    return true;
                }
                case param1 is GameFightUpdateTeamMessage:
                {
                    _loc_20 = param1 as GameFightUpdateTeamMessage;
                    this.updateFight(_loc_20.fightId, _loc_20.team);
                    return true;
                }
                case param1 is GameFightRemoveTeamMemberMessage:
                {
                    _loc_21 = param1 as GameFightRemoveTeamMemberMessage;
                    this.removeFighter(_loc_21.fightId, _loc_21.teamId, _loc_21.charId);
                    return true;
                }
                case param1 is GameRolePlayRemoveChallengeMessage:
                {
                    _loc_22 = param1 as GameRolePlayRemoveChallengeMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayRemoveFight, _loc_22.fightId);
                    this.removeFight(_loc_22.fightId);
                    return true;
                }
                case param1 is GameContextRemoveElementMessage:
                {
                    _loc_23 = param1 as GameContextRemoveElementMessage;
                    _loc_24 = 0;
                    for each (_loc_75 in this._playersId)
                    {
                        
                        if (_loc_75 == _loc_23.id)
                        {
                            this._playersId.splice(_loc_24, 1);
                            continue;
                        }
                        _loc_24 = _loc_24 + 1;
                    }
                    removeActor(_loc_23.id);
                    return true;
                }
                case param1 is MapFightCountMessage:
                {
                    _loc_25 = param1 as MapFightCountMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.MapFightCount, _loc_25.fightCount);
                    return true;
                }
                case param1 is ObjectGroundAddedMessage:
                {
                    _loc_26 = param1 as ObjectGroundAddedMessage;
                    this.addObject(_loc_26.objectGID, _loc_26.cellId);
                    return true;
                }
                case param1 is ObjectGroundRemovedMessage:
                {
                    _loc_27 = param1 as ObjectGroundRemovedMessage;
                    this.removeObject(_loc_27.cell);
                    return true;
                }
                case param1 is ObjectGroundListAddedMessage:
                {
                    _loc_28 = param1 as ObjectGroundListAddedMessage;
                    _loc_29 = 0;
                    for each (_loc_76 in _loc_28.referenceIds)
                    {
                        
                        this.addObject(_loc_76, _loc_28.cells[_loc_29]);
                        _loc_29 = _loc_29 + 1;
                    }
                    return true;
                }
                case param1 is PaddockRemoveItemRequestAction:
                {
                    _loc_30 = param1 as PaddockRemoveItemRequestAction;
                    _loc_31 = new PaddockRemoveItemRequestMessage();
                    _loc_31.initPaddockRemoveItemRequestMessage(_loc_30.cellId);
                    ConnectionsHandler.getConnection().send(_loc_31);
                    return true;
                }
                case param1 is PaddockMoveItemRequestAction:
                {
                    _loc_32 = param1 as PaddockMoveItemRequestAction;
                    this._currentPaddockItemCellId = _loc_32.object.disposition.cellId;
                    _loc_33 = new Texture();
                    _loc_34 = ItemWrapper.create(0, 0, _loc_32.object.item.id, 0, null, false);
                    _loc_33.uri = _loc_34.iconUri;
                    _loc_33.finalize();
                    Kernel.getWorker().addFrame(new RoleplayPointCellFrame(this.onCellPointed, _loc_33, true, this.paddockCellValidator, true));
                    return true;
                }
                case param1 is GameDataPaddockObjectRemoveMessage:
                {
                    _loc_35 = param1 as GameDataPaddockObjectRemoveMessage;
                    _loc_36 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                    this.removePaddockItem(_loc_35.cellId);
                    return true;
                }
                case param1 is GameDataPaddockObjectAddMessage:
                {
                    _loc_37 = param1 as GameDataPaddockObjectAddMessage;
                    this.addPaddockItem(_loc_37.paddockItemDescription);
                    return true;
                }
                case param1 is GameDataPaddockObjectListAddMessage:
                {
                    _loc_38 = param1 as GameDataPaddockObjectListAddMessage;
                    for each (_loc_77 in _loc_38.paddockItemDescription)
                    {
                        
                        this.addPaddockItem(_loc_77);
                    }
                    return true;
                }
                case param1 is GameDataPlayFarmObjectAnimationMessage:
                {
                    _loc_39 = param1 as GameDataPlayFarmObjectAnimationMessage;
                    for each (_loc_78 in _loc_39.cellId)
                    {
                        
                        this.activatePaddockItem(_loc_78);
                    }
                    return true;
                }
                case param1 is MapNpcsQuestStatusUpdateMessage:
                {
                    _loc_40 = param1 as MapNpcsQuestStatusUpdateMessage;
                    if (MapDisplayManager.getInstance().currentMapPoint.mapId == _loc_40.mapId)
                    {
                        for each (_loc_79 in this._npcList)
                        {
                            
                            this.removeBackground(_loc_79);
                        }
                        _loc_82 = _loc_40.npcsIdsWithQuest.length;
                        _loc_81 = 0;
                        while (_loc_81 < _loc_82)
                        {
                            
                            _loc_79 = this._npcList[_loc_40.npcsIdsWithQuest[_loc_81]];
                            if (_loc_79)
                            {
                                _loc_83 = Quest.getFirstValidQuest(_loc_40.questFlags[_loc_64]);
                                if (_loc_83 != null)
                                {
                                    if (_loc_40.questFlags[_loc_64].questsToStartId.indexOf(_loc_83.id) != -1)
                                    {
                                        if (_loc_83.repeatType == 0)
                                        {
                                            _loc_80 = EmbedAssets.getSprite("QUEST_CLIP");
                                            _loc_79.addBackground("questClip", _loc_80, true);
                                        }
                                        else
                                        {
                                            _loc_80 = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                                            _loc_79.addBackground("questRepeatableClip", _loc_80, true);
                                        }
                                    }
                                    else if (_loc_83.repeatType == 0)
                                    {
                                        _loc_80 = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                                        _loc_79.addBackground("questObjectiveClip", _loc_80, true);
                                    }
                                    else
                                    {
                                        _loc_80 = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                                        _loc_79.addBackground("questRepeatableObjectiveClip", _loc_80, true);
                                    }
                                }
                            }
                            _loc_81++;
                        }
                    }
                    return true;
                }
                case param1 is ShowCellMessage:
                {
                    _loc_41 = param1 as ShowCellMessage;
                    HyperlinkShowCellManager.showCell(_loc_41.cellId);
                    _loc_42 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                    _loc_43 = _loc_42.getActorName(_loc_41.sourceId);
                    _loc_44 = I18n.getUiText("ui.fight.showCell", [_loc_43, "{cell," + _loc_41.cellId + "::" + _loc_41.cellId + "}"]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_44, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is StartZoomAction:
                {
                    _loc_45 = param1 as StartZoomAction;
                    if (Atouin.getInstance().currentZoom != 1)
                    {
                        Atouin.getInstance().cancelZoom();
                        KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                        return true;
                    }
                    _loc_46 = DofusEntities.getEntity(_loc_45.playerId) as DisplayObject;
                    if (_loc_46 && _loc_46.stage)
                    {
                        _loc_84 = _loc_46.getRect(Atouin.getInstance().worldContainer);
                        Atouin.getInstance().zoom(_loc_45.value, _loc_84.x + _loc_84.width / 2, _loc_84.y + _loc_84.height / 2);
                        KernelEventsManager.getInstance().processCallback(HookList.StartZoom, true);
                    }
                    return true;
                }
                case param1 is SwitchCreatureModeAction:
                {
                    _loc_47 = param1 as SwitchCreatureModeAction;
                    if (_creaturesMode != _loc_47.isActivated)
                    {
                        _creaturesMode = _loc_47.isActivated;
                        for (_loc_85 in _entities)
                        {
                            
                            updateActorLook(_loc_85, (_entities[_loc_85] as GameContextActorInformations).look);
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
            this._npcList = new Dictionary();
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
            var _loc_1:* = null;
            var _loc_2:* = null;
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
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
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
                                _loc_4 = EmbedAssets.getSprite("QUEST_CLIP");
                                _loc_3.addBackground("questClip", _loc_4, true);
                            }
                            else
                            {
                                _loc_4 = EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                                _loc_3.addBackground("questRepeatableClip", _loc_4, true);
                            }
                        }
                        else if (_loc_5.repeatType == 0)
                        {
                            _loc_4 = EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                            _loc_3.addBackground("questObjectiveClip", _loc_4, true);
                        }
                        else
                        {
                            _loc_4 = EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
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
                        _loc_7 = new Vector.<EntityLook>(_loc_6.staticInfos.underlings.length, true);
                        _loc_8 = 0;
                        for each (_loc_9 in _loc_6.staticInfos.underlings)
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
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            param1.removeAllFollowers();
            var _loc_3:* = param2.length;
            var _loc_4:* = 0;
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
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = new Vector.<FightTeam>(0, false);
            var _loc_3:* = new Fight(param1.fightId, _loc_2);
            var _loc_4:* = 0;
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
            if (this._uri[param1] != null)
            {
                (this._uri[param1] as IDisplayable).remove();
            }
            if (this._objects[this._uri[param1]] != null)
            {
                delete this._objects[this._uri[param1]];
            }
            if (_entities[this._uri[param1].id] != null)
            {
                delete _entities[this._uri[param1].id];
            }
            if (this._uri[param1] != null)
            {
                delete this._uri[param1];
            }
            return;
        }// end function

        private function updateFight(param1:uint, param2:FightTeamInformations) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = false;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = false;
            var _loc_12:* = null;
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
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = this._fights[param1];
            if (this._fights[param1])
            {
                _loc_5 = _loc_4.teams[param2];
                _loc_6 = _loc_5.teamInfos;
                _loc_7 = new Vector.<FightTeamMemberInformations>(0, false);
                for each (_loc_8 in _loc_6.teamMembers)
                {
                    
                    if (_loc_8.id != param3)
                    {
                        _loc_7.push(_loc_8);
                    }
                }
                _loc_6.teamMembers = _loc_7;
            }
            return;
        }// end function

        private function removeFight(param1:uint) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
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
            var _loc_3:* = 0;
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
            var _loc_3:* = null;
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
            var _loc_3:* = null;
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
            var _loc_3:* = null;
            var _loc_4:* = null;
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
            if (_loc_2.hasAnimation(_loc_3, _loc_2.getDirection()) || _loc_5 && _loc_5 is TiphonSprite && TiphonSprite(_loc_5).hasAnimation(_loc_3, TiphonSprite(_loc_5).getDirection()))
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
            var _loc_4:* = null;
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
