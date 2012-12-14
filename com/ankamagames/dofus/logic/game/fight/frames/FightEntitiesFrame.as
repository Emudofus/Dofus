package com.ankamagames.dofus.logic.game.fight.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.house.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.enum.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.actions.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.types.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;

    public class FightEntitiesFrame extends AbstractEntitiesFrame implements Frame
    {
        private var _entitiesDematerialization:Boolean = false;
        private var _showCellStart:Number = 0;
        private var arrowId:uint;
        private var _ie:Dictionary;
        private var _tempFighterList:Array;
        private var _illusionEntities:Dictionary;
        private var _entitiesNumber:Dictionary;
        private var _lastKnownPosition:Dictionary;
        private var _lastKnownMovementPoint:Dictionary;
        private static const TEAM_CIRCLE_COLOR_1:uint = 255;
        private static const TEAM_CIRCLE_COLOR_2:uint = 16711680;

        public function FightEntitiesFrame()
        {
            this._ie = new Dictionary(true);
            this._tempFighterList = new Array();
            return;
        }// end function

        override public function pushed() : Boolean
        {
            Atouin.getInstance().cellOverEnabled = true;
            Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this._entitiesNumber = new Dictionary();
            this._illusionEntities = new Dictionary();
            this._lastKnownPosition = new Dictionary();
            this._lastKnownMovementPoint = new Dictionary();
            return super.pushed();
        }// end function

        override public function addOrUpdateActor(param1:GameContextActorInformations, param2:IAnimationModifier = null) : AnimatedCharacter
        {
            var _loc_3:* = super.addOrUpdateActor(param1, param2);
            if (param1.disposition.cellId != -1)
            {
                this._lastKnownPosition[param1.contextualId] = param1.disposition.cellId;
            }
            if (param1.contextualId > 0)
            {
                _loc_3.disableMouseEventWhenAnimated = true;
            }
            if (CurrentPlayedFighterManager.getInstance().currentFighterId == param1.contextualId)
            {
                _loc_3.setCanSeeThrough(true);
            }
            return _loc_3;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
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
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = false;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            switch(true)
            {
                case param1 is GameFightRefreshFighterMessage:
                {
                    _loc_2 = param1 as GameFightRefreshFighterMessage;
                    _loc_3 = _loc_2.informations.contextualId;
                    _loc_4 = _entities[_loc_3];
                    if (_loc_4 != null)
                    {
                        _loc_4.disposition = _loc_2.informations.disposition;
                        _loc_4.look = _loc_2.informations.look;
                        this.updateActor(_loc_4, true);
                    }
                    if (Kernel.getWorker().getFrame(FightPreparationFrame))
                    {
                        KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList, _loc_3);
                        if (Dofus.getInstance().options.orderFighters)
                        {
                            this.updateAllEntitiesNumber(this.getOrdonnedPreFighters());
                        }
                    }
                    return true;
                }
                case param1 is GameFightShowFighterMessage:
                {
                    _loc_5 = param1 as GameFightShowFighterMessage;
                    if (param1 is GameFightShowFighterRandomStaticPoseMessage)
                    {
                        _loc_23 = new CustomAnimStatiqueAnimationModifier();
                        (_loc_23 as CustomAnimStatiqueAnimationModifier).randomStatique = true;
                        this.updateFighter(_loc_5.informations, _loc_23);
                        this._illusionEntities[_loc_5.informations.contextualId] = true;
                    }
                    else
                    {
                        this.updateFighter(_loc_5.informations);
                        this._illusionEntities[_loc_5.informations.contextualId] = false;
                        if (Kernel.getWorker().getFrame(FightPreparationFrame))
                        {
                            KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList, _loc_5.informations.contextualId);
                            if (Dofus.getInstance().options.orderFighters)
                            {
                                this.updateAllEntitiesNumber(this.getOrdonnedPreFighters());
                            }
                        }
                    }
                    return true;
                }
                case param1 is GameFightHumanReadyStateMessage:
                {
                    _loc_6 = param1 as GameFightHumanReadyStateMessage;
                    _loc_7 = this.addOrUpdateActor(getEntityInfos(_loc_6.characterId) as GameFightFighterInformations);
                    if (_loc_6.isReady)
                    {
                        _loc_24 = EmbedAssets.getSprite("SWORDS_CLIP");
                        _loc_7.addBackground("readySwords", _loc_24);
                    }
                    else
                    {
                        _loc_7.removeBackground("readySwords");
                    }
                    return true;
                }
                case param1 is GameEntityDispositionMessage:
                {
                    _loc_8 = param1 as GameEntityDispositionMessage;
                    if (_loc_8.disposition.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        SoundManager.getInstance().manager.playUISound(UISoundEnum.FIGHT_POSITION);
                    }
                    this.updateActorDisposition(_loc_8.disposition.id, _loc_8.disposition);
                    KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition, _loc_8.disposition.id, _loc_8.disposition.cellId, _loc_8.disposition.direction);
                    return true;
                }
                case param1 is GameEntitiesDispositionMessage:
                {
                    _loc_9 = param1 as GameEntitiesDispositionMessage;
                    for each (_loc_25 in _loc_9.dispositions)
                    {
                        
                        if (getEntityInfos(_loc_25.id) && GameFightFighterInformations(getEntityInfos(_loc_25.id)).stats.invisibilityState != GameActionFightInvisibilityStateEnum.INVISIBLE)
                        {
                            this.updateActorDisposition(_loc_25.id, _loc_25);
                        }
                        KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition, _loc_25.id, _loc_25.cellId, _loc_25.direction);
                    }
                    return true;
                }
                case param1 is GameContextRefreshEntityLookMessage:
                {
                    _loc_10 = param1 as GameContextRefreshEntityLookMessage;
                    _loc_11 = DofusEntities.getEntity(_loc_10.id) as TiphonSprite;
                    if (_loc_11)
                    {
                        _loc_11.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    }
                    updateActorLook(_loc_10.id, _loc_10.look);
                    return true;
                }
                case param1 is ToggleDematerializationAction:
                {
                    this.showCreaturesInFight(!_creaturesFightMode);
                    KernelEventsManager.getInstance().processCallback(FightHookList.DematerializationChanged, this._entitiesDematerialization);
                    return true;
                }
                case param1 is RemoveEntityAction:
                {
                    _loc_12 = RemoveEntityAction(param1).actorId;
                    this._entitiesNumber[_loc_12] = null;
                    removeActor(_loc_12);
                    KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList);
                    return true;
                }
                case param1 is ShowCellSpectatorMessage:
                {
                    _loc_13 = param1 as ShowCellSpectatorMessage;
                    HyperlinkShowCellManager.showCell(_loc_13.cellId);
                    _loc_14 = I18n.getUiText("ui.fight.showCell", [_loc_13.playerName, _loc_13.cellId]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_14, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is ShowCellMessage:
                {
                    _loc_15 = param1 as ShowCellMessage;
                    HyperlinkShowCellManager.showCell(_loc_15.cellId);
                    _loc_16 = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                    _loc_17 = _loc_16 ? (_loc_16.getFighterName(_loc_15.sourceId)) : ("???");
                    _loc_18 = I18n.getUiText("ui.fight.showCell", [_loc_17, "{cell," + _loc_15.cellId + "::" + _loc_15.cellId + "}"]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_18, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is MapComplementaryInformationsDataMessage:
                {
                    _loc_19 = param1 as MapComplementaryInformationsDataMessage;
                    _interactiveElements = _loc_19.interactiveElements;
                    if (param1 is MapComplementaryInformationsWithCoordsMessage)
                    {
                        _loc_26 = param1 as MapComplementaryInformationsWithCoordsMessage;
                        if (PlayedCharacterManager.getInstance().isInHouse)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                        }
                        PlayedCharacterManager.getInstance().isInHouse = false;
                        PlayedCharacterManager.getInstance().isInHisHouse = false;
                        PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(_loc_26.worldX, _loc_26.worldY);
                        _worldPoint = new WorldPointWrapper(_loc_26.mapId, true, _loc_26.worldX, _loc_26.worldY);
                    }
                    else if (param1 is MapComplementaryInformationsDataInHouseMessage)
                    {
                        _loc_27 = param1 as MapComplementaryInformationsDataInHouseMessage;
                        _loc_28 = PlayerManager.getInstance().nickname == _loc_27.currentHouse.ownerName;
                        PlayedCharacterManager.getInstance().isInHouse = true;
                        if (_loc_28)
                        {
                            PlayedCharacterManager.getInstance().isInHisHouse = true;
                        }
                        PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(_loc_27.currentHouse.worldX, _loc_27.currentHouse.worldY);
                        KernelEventsManager.getInstance().processCallback(HookList.HouseEntered, _loc_28, _loc_27.currentHouse.ownerId, _loc_27.currentHouse.ownerName, _loc_27.currentHouse.price, _loc_27.currentHouse.isLocked, _loc_27.currentHouse.worldX, _loc_27.currentHouse.worldY, HouseWrapper.manualCreate(_loc_27.currentHouse.modelId, -1, _loc_27.currentHouse.ownerName, _loc_27.currentHouse.price != 0));
                        _worldPoint = new WorldPointWrapper(_loc_27.mapId, true, _loc_27.currentHouse.worldX, _loc_27.currentHouse.worldY);
                    }
                    else
                    {
                        _worldPoint = new WorldPointWrapper(_loc_19.mapId);
                        if (PlayedCharacterManager.getInstance().isInHouse)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                        }
                        PlayedCharacterManager.getInstance().isInHouse = false;
                        PlayedCharacterManager.getInstance().isInHisHouse = false;
                    }
                    _currentSubAreaId = _loc_19.subAreaId;
                    _currentSubAreaSide = _loc_19.subareaAlignmentSide;
                    PlayedCharacterManager.getInstance().currentMap = _worldPoint;
                    PlayedCharacterManager.getInstance().currentSubArea = SubArea.getSubAreaById(_currentSubAreaId);
                    TooltipManager.hide();
                    for each (_loc_29 in _loc_19.obstacles)
                    {
                        
                        InteractiveCellManager.getInstance().updateCell(_loc_29.obstacleCellId, _loc_29.state == MapObstacleStateEnum.OBSTACLE_OPENED);
                    }
                    for each (_loc_30 in _loc_19.interactiveElements)
                    {
                        
                        if (_loc_30.enabledSkills.length)
                        {
                            this.registerInteractive(_loc_30, _loc_30.enabledSkills[0].skillId);
                            continue;
                        }
                        if (_loc_30.disabledSkills.length)
                        {
                            this.registerInteractive(_loc_30, _loc_30.disabledSkills[0].skillId);
                        }
                    }
                    for each (_loc_31 in _loc_19.statedElements)
                    {
                        
                        this.updateStatedElement(_loc_31);
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData, PlayedCharacterManager.getInstance().currentMap, _currentSubAreaId, Dofus.getInstance().options.mapCoordinates, _currentSubAreaSide);
                    KernelEventsManager.getInstance().processCallback(HookList.MapFightCount, 0);
                    return true;
                }
                case param1 is GameActionFightCarryCharacterMessage:
                {
                    _loc_20 = param1 as GameActionFightCarryCharacterMessage;
                    if (_loc_20.cellId != -1)
                    {
                        for each (_loc_32 in _entities)
                        {
                            
                            if (_loc_32.contextualId == _loc_20.targetId)
                            {
                                (_loc_32.disposition as FightEntityDispositionInformations).carryingCharacterId = _loc_20.sourceId;
                                this._tempFighterList.push(new TmpFighterInfos(_loc_32.contextualId, _loc_20.sourceId));
                                break;
                            }
                        }
                    }
                    return true;
                }
                case param1 is GameActionFightThrowCharacterMessage:
                {
                    _loc_21 = param1 as GameActionFightThrowCharacterMessage;
                    this.dropEntity(_loc_21.targetId);
                    return true;
                }
                case param1 is GameActionFightDropCharacterMessage:
                {
                    _loc_22 = param1 as GameActionFightDropCharacterMessage;
                    this.dropEntity(_loc_22.targetId);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function dropEntity(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            for each (_loc_3 in _entities)
            {
                
                if (_loc_3.contextualId == param1)
                {
                    (_loc_3.disposition as FightEntityDispositionInformations).carryingCharacterId = NaN;
                    _loc_2 = this.getTmpFighterInfoIndex(_loc_3.contextualId);
                    if (this._tempFighterList != null && this._tempFighterList.length != 0 && _loc_2 != -1)
                    {
                        this._tempFighterList.splice(_loc_2, 1);
                    }
                    return;
                }
            }
            return;
        }// end function

        public function showCreaturesInFight(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _creaturesFightMode = param1;
            for each (_loc_2 in _entities)
            {
                
                this.updateFighter(_loc_2);
            }
            this._entitiesDematerialization = _creaturesFightMode;
            return;
        }// end function

        public function entityIsIllusion(param1:int) : Boolean
        {
            return this._illusionEntities[param1];
        }// end function

        public function getLastKnownEntityPosition(param1:int) : int
        {
            return this._lastKnownPosition[param1] != null ? (this._lastKnownPosition[param1]) : (-1);
        }// end function

        public function setLastKnownEntityPosition(param1:int, param2:int) : void
        {
            this._lastKnownPosition[param1] = param2;
            return;
        }// end function

        public function getLastKnownEntityMovementPoint(param1:int) : int
        {
            return this._lastKnownMovementPoint[param1] != null ? (this._lastKnownMovementPoint[param1]) : (0);
        }// end function

        public function setLastKnownEntityMovementPoint(param1:int, param2:int, param3:Boolean = false) : void
        {
            if (this._lastKnownMovementPoint[param1] == null)
            {
                this._lastKnownMovementPoint[param1] = 0;
            }
            if (!param3)
            {
                this._lastKnownMovementPoint[param1] = param2;
            }
            else
            {
                this._lastKnownMovementPoint[param1] = this._lastKnownMovementPoint[param1] + param2;
            }
            return;
        }// end function

        override public function pulled() : Boolean
        {
            var _loc_1:* = null;
            Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this._tempFighterList = null;
            for each (_loc_1 in this._ie)
            {
                
                this.removeInteractive(_loc_1.element as InteractiveElement);
            }
            return super.pulled();
        }// end function

        private function onTimeOut() : void
        {
            clearTimeout(this._showCellStart);
            removeActor(this.arrowId);
            this._showCellStart = 0;
            return;
        }// end function

        private function registerInteractive(param1:InteractiveElement, param2:int) : void
        {
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_3:* = Atouin.getInstance().getIdentifiedElement(param1.elementId);
            if (!_loc_3)
            {
                _log.error("Unknown identified element " + param1.elementId + ", unable to register it as interactive.");
                return;
            }
            var _loc_4:* = false;
            for (_loc_5 in interactiveElements)
            {
                
                _loc_7 = interactiveElements[int(_loc_5)];
                if (_loc_7.elementId == param1.elementId)
                {
                    _loc_4 = true;
                    interactiveElements[int(_loc_5)] = param1;
                    break;
                }
            }
            if (!_loc_4)
            {
                interactiveElements.push(param1);
            }
            var _loc_6:* = Atouin.getInstance().getIdentifiedElementPosition(param1.elementId);
            this._ie[_loc_3] = {element:param1, position:_loc_6, firstSkill:param2};
            return;
        }// end function

        private function updateStatedElement(param1:StatedElement) : void
        {
            var _loc_2:* = Atouin.getInstance().getIdentifiedElement(param1.elementId);
            if (!_loc_2)
            {
                _log.error("Unknown identified element " + param1.elementId + "; unable to change its state to " + param1.elementState + " !");
                return;
            }
            var _loc_3:* = _loc_2 is DisplayObjectContainer ? (this.findTiphonSprite(_loc_2 as DisplayObjectContainer)) : (null);
            if (!_loc_3)
            {
                _log.warn("Unable to find an animated element for the stated element " + param1.elementId + " on cell " + param1.elementCellId + ", this element is probably invisible.");
                return;
            }
            _loc_3.setAnimationAndDirection("AnimState" + param1.elementState, 0);
            return;
        }// end function

        private function findTiphonSprite(param1:DisplayObjectContainer) : TiphonSprite
        {
            var _loc_3:* = null;
            if (param1 is TiphonSprite)
            {
                return param1 as TiphonSprite;
            }
            if (!param1.numChildren)
            {
                return null;
            }
            var _loc_2:* = 0;
            while (_loc_2 < param1.numChildren)
            {
                
                _loc_3 = param1.getChildAt(_loc_2);
                if (_loc_3 is TiphonSprite)
                {
                    return _loc_3 as TiphonSprite;
                }
                if (_loc_3 is DisplayObjectContainer)
                {
                    return this.findTiphonSprite(_loc_3 as DisplayObjectContainer);
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

        private function removeInteractive(param1:InteractiveElement) : void
        {
            var _loc_2:* = Atouin.getInstance().getIdentifiedElement(param1.elementId);
            delete this._ie[_loc_2];
            return;
        }// end function

        public function getOrdonnedPreFighters() : Vector.<int>
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = false;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_1:* = getEntitiesIdsList();
            var _loc_2:* = new Vector.<int>;
            if (!_loc_1 || _loc_1.length <= 1)
            {
                return _loc_2;
            }
            var _loc_3:* = new Array();
            var _loc_4:* = new Array();
            for each (_loc_7 in _loc_1)
            {
                
                _loc_11 = getEntityInfos(_loc_7) as GameFightFighterInformations;
                if (_loc_11)
                {
                    _loc_12 = _loc_11.stats as GameFightMinimalStatsPreparation;
                    if (_loc_12)
                    {
                        if (_loc_11.teamId == 0)
                        {
                            _loc_4.push({fighter:_loc_7, init:_loc_12.initiative * _loc_12.lifePoints / _loc_12.maxLifePoints});
                            _loc_5 = _loc_5 + _loc_12.initiative * _loc_12.lifePoints / _loc_12.maxLifePoints;
                            continue;
                        }
                        _loc_3.push({fighter:_loc_7, init:_loc_12.initiative * _loc_12.lifePoints / _loc_12.maxLifePoints});
                        _loc_6 = _loc_6 + _loc_12.initiative * _loc_12.lifePoints / _loc_12.maxLifePoints;
                    }
                }
            }
            _loc_4.sortOn(["init", "fighter"], Array.DESCENDING | Array.NUMERIC);
            _loc_3.sortOn(["init", "fighter"], Array.DESCENDING | Array.NUMERIC);
            _loc_8 = true;
            if (_loc_4.length == 0 || _loc_3.length == 0 || _loc_5 / _loc_4.length < _loc_6 / _loc_3.length)
            {
                _loc_8 = false;
            }
            var _loc_9:* = Math.max(_loc_4.length, _loc_3.length);
            var _loc_10:* = 0;
            while (_loc_10 < _loc_9)
            {
                
                if (_loc_8)
                {
                    if (_loc_4[_loc_10])
                    {
                        _loc_2.push(_loc_4[_loc_10].fighter);
                    }
                    if (_loc_3[_loc_10])
                    {
                        _loc_2.push(_loc_3[_loc_10].fighter);
                    }
                }
                else
                {
                    if (_loc_3[_loc_10])
                    {
                        _loc_2.push(_loc_3[_loc_10].fighter);
                    }
                    if (_loc_4[_loc_10])
                    {
                        _loc_2.push(_loc_4[_loc_10].fighter);
                    }
                }
                _loc_10++;
            }
            return _loc_2;
        }// end function

        public function removeSwords() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            for each (_loc_1 in _entities)
            {
                
                if (_loc_1 is GameFightCharacterInformations && !GameFightCharacterInformations(_loc_1).alive)
                {
                    continue;
                }
                _loc_2 = this.addOrUpdateActor(_loc_1);
                _loc_2.removeBackground("readySwords");
            }
            return;
        }// end function

        public function updateFighter(param1:GameFightFighterInformations, param2:IAnimationModifier = null, param3:Array = null) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_4:* = param1.contextualId;
            if (param3)
            {
                _loc_5 = 0;
                while (_loc_5 < param3.length)
                {
                    
                    _loc_6 = BuffManager.getInstance().getAllBuff(_loc_4);
                    for each (_loc_7 in _loc_6)
                    {
                        
                        if (_loc_7.id == param3[_loc_5].id)
                        {
                            _loc_8 = param3[_loc_5] as StatBuff;
                            _loc_9 = _loc_8.statName;
                            _loc_10 = Effect.getEffectById(_loc_8.actionId);
                            if (_loc_9 && param1.stats.hasOwnProperty(_loc_9) && _loc_10.active)
                            {
                                param1.stats[_loc_9] = param1.stats[_loc_9] - param3[_loc_5].delta;
                            }
                        }
                    }
                    _loc_5++;
                }
            }
            if (param1.alive)
            {
                _loc_11 = -1;
                _loc_12 = _entities[param1.contextualId] as GameFightFighterInformations;
                if (_loc_12)
                {
                    _loc_11 = _loc_12.stats.invisibilityState;
                }
                if (_loc_11 == GameActionFightInvisibilityStateEnum.INVISIBLE && param1.stats.invisibilityState == _loc_11)
                {
                    registerActor(param1);
                    return;
                }
                if (_loc_12 != param1)
                {
                    registerActor(param1);
                }
                _loc_13 = this.addOrUpdateActor(param1, param2);
                if (param1.stats.invisibilityState != GameActionFightInvisibilityStateEnum.VISIBLE && param1.stats.invisibilityState != _loc_11)
                {
                    _loc_14 = new FightChangeVisibilityStep(_loc_4, param1.stats.invisibilityState);
                    _loc_14.start();
                }
                this.addCircleToFighter(_loc_13, param1.teamId == TeamEnum.TEAM_DEFENDER ? (TEAM_CIRCLE_COLOR_1) : (TEAM_CIRCLE_COLOR_2));
            }
            else
            {
                this.updateActor(param1, false);
            }
            this.updateCarriedEntities(param1);
            return;
        }// end function

        public function updateActor(param1:GameContextActorInformations, param2:Boolean = true, param3:IAnimationModifier = null) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = param1.contextualId;
            if (param2)
            {
                registerActor(param1);
                _loc_5 = this.addOrUpdateActor(param1, param3);
            }
            else
            {
                if (_entities[_loc_4])
                {
                    hideActor(_loc_4);
                }
                registerActor(param1);
            }
            return;
        }// end function

        private function addCircleToFighter(param1:AnimatedCharacter, param2:uint) : void
        {
            var _loc_3:* = new Sprite();
            var _loc_4:* = EmbedAssets.getSprite("TEAM_CIRCLE_CLIP");
            _loc_3.addChild(_loc_4);
            var _loc_5:* = new ColorTransform();
            new ColorTransform().color = param2;
            _loc_3.filters = [new GlowFilter(16777215, 0.5, 2, 2, 3, 3)];
            _loc_4.transform.colorTransform = _loc_5;
            param1.addBackground("teamCircle", _loc_3);
            return;
        }// end function

        private function updateCarriedEntities(param1:GameContextActorInformations) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = param1.contextualId;
            var _loc_3:* = this._tempFighterList.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this._tempFighterList[_loc_4];
                _loc_6 = _loc_5.carryingCharacterId;
                if (_loc_2 == _loc_6)
                {
                    this._tempFighterList.splice(_loc_4, 1);
                    this.startCarryStep(_loc_6, _loc_5.contextualId);
                    break;
                }
                _loc_4++;
            }
            if (param1.disposition is FightEntityDispositionInformations)
            {
                _loc_7 = param1.disposition as FightEntityDispositionInformations;
                if (_loc_7.carryingCharacterId)
                {
                    _loc_8 = DofusEntities.getEntity(_loc_7.carryingCharacterId);
                    if (!_loc_8)
                    {
                        this._tempFighterList.push(new TmpFighterInfos(param1.contextualId, _loc_7.carryingCharacterId));
                    }
                    else
                    {
                        _loc_9 = DofusEntities.getEntity(param1.contextualId);
                        if (_loc_9)
                        {
                            if (!(_loc_8 is TiphonSprite && _loc_9 is TiphonSprite && TiphonSprite(_loc_9).parentSprite == _loc_8))
                            {
                                this.startCarryStep(_loc_7.carryingCharacterId, param1.contextualId);
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        private function startCarryStep(param1:int, param2:int) : void
        {
            var _loc_3:* = new FightCarryCharacterStep(param1, param2, -1, true);
            _loc_3.start();
            FightEventsHelper.sendAllFightEvent();
            return;
        }// end function

        public function updateAllEntitiesNumber(param1:Vector.<int>) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = 1;
            for each (_loc_3 in param1)
            {
                
                if (_entities[_loc_3] && _entities[_loc_3].alive)
                {
                    this.updateEntityNumber(_loc_3, _loc_2);
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        public function updateEntityNumber(param1:int, param2:uint) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (_entities[param1] && (!(_entities[param1] is GameFightCharacterInformations) || GameFightCharacterInformations(_entities[param1]).alive))
            {
                if (!this._entitiesNumber[param1] || this._entitiesNumber[param1] == null)
                {
                    _loc_3 = new Sprite();
                    _loc_4 = new Label();
                    _loc_4.width = 30;
                    _loc_4.height = 20;
                    _loc_4.x = -45;
                    _loc_4.y = -15;
                    _loc_4.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
                    _loc_4.text = param2.toString();
                    _loc_3.addChild(_loc_4);
                    _loc_3.filters = [new GlowFilter(XmlConfig.getInstance().getEntry("colors.text.glow"), 1, 4, 4, 6, 3)];
                    this._entitiesNumber[param1] = _loc_4;
                    _loc_5 = DofusEntities.getEntity(param1) as AnimatedCharacter;
                    if (_loc_5)
                    {
                        _loc_5.addBackground("fighterNumber", _loc_3);
                    }
                }
                else
                {
                    this._entitiesNumber[param1].text = param2.toString();
                }
            }
            return;
        }// end function

        public function updateRemovedEntity(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this._entitiesNumber[param1] = null;
            if (Dofus.getInstance().options.orderFighters)
            {
                _loc_2 = 1;
                _loc_3 = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
                for each (_loc_4 in _loc_3.fightersList)
                {
                    
                    if (_loc_4 != param1 && (getEntityInfos(_loc_4) as GameFightFighterInformations).alive)
                    {
                        this.updateEntityNumber(_loc_4, _loc_2);
                        _loc_2 = _loc_2 + 1;
                    }
                }
            }
            return;
        }// end function

        public function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (event.propertyName == "cellSelectionOnly")
            {
                untargetableEntities = event.propertyValue || Kernel.getWorker().getFrame(FightPreparationFrame);
            }
            else if (event.propertyName == "orderFighters")
            {
                if (!event.propertyValue)
                {
                    for (_loc_2 in this._entitiesNumber)
                    {
                        
                        if (this._entitiesNumber[int(_loc_2)])
                        {
                            this._entitiesNumber[int(_loc_2)] = null;
                            _loc_3 = DofusEntities.getEntity(int(_loc_2)) as AnimatedCharacter;
                            if (_loc_3)
                            {
                                _loc_3.removeBackground("fighterNumber");
                            }
                        }
                    }
                }
                else
                {
                    _loc_4 = 1;
                    _loc_5 = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
                    if (_loc_5)
                    {
                        for each (_loc_6 in _loc_5.fightersList)
                        {
                            
                            if ((getEntityInfos(_loc_6) as GameFightFighterInformations).alive)
                            {
                                this.updateEntityNumber(_loc_6, _loc_4);
                                _loc_4 = _loc_4 + 1;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function set cellSelectionOnly(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in _entities)
            {
                
                _loc_3 = DofusEntities.getEntity(_loc_2.contextualId) as AnimatedCharacter;
                if (_loc_3)
                {
                    _loc_3.mouseEnabled = !param1;
                }
            }
            return;
        }// end function

        public function get dematerialization() : Boolean
        {
            return this._entitiesDematerialization;
        }// end function

        override protected function updateActorDisposition(param1:int, param2:EntityDispositionInformations) : void
        {
            var _loc_3:* = null;
            super.updateActorDisposition(param1, param2);
            if (param2.cellId == -1)
            {
                _loc_3 = DofusEntities.getEntity(param1);
                if (_loc_3)
                {
                    FightEntitiesHolder.getInstance().holdEntity(_loc_3);
                }
            }
            else
            {
                FightEntitiesHolder.getInstance().unholdEntity(param1);
            }
            return;
        }// end function

        private function getTmpFighterInfoIndex(param1:int) : int
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._tempFighterList)
            {
                
                if (_loc_2.contextualId == param1)
                {
                    return this._tempFighterList.indexOf(_loc_2);
                }
            }
            return -1;
        }// end function

        public static function getCurrentInstance() : FightEntitiesFrame
        {
            return Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.atouin.*;

import com.ankamagames.atouin.managers.*;

import com.ankamagames.berilia.components.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.datacenter.effects.*;

import com.ankamagames.dofus.datacenter.world.*;

import com.ankamagames.dofus.internalDatacenter.house.*;

import com.ankamagames.dofus.internalDatacenter.world.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.sound.*;

import com.ankamagames.dofus.kernel.sound.enum.*;

import com.ankamagames.dofus.logic.common.managers.*;

import com.ankamagames.dofus.logic.game.common.frames.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.logic.game.common.misc.*;

import com.ankamagames.dofus.logic.game.fight.actions.*;

import com.ankamagames.dofus.logic.game.fight.fightEvents.*;

import com.ankamagames.dofus.logic.game.fight.managers.*;

import com.ankamagames.dofus.logic.game.fight.miscs.*;

import com.ankamagames.dofus.logic.game.fight.steps.*;

import com.ankamagames.dofus.logic.game.fight.types.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.misc.utils.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.actions.fight.*;

import com.ankamagames.dofus.network.messages.game.context.*;

import com.ankamagames.dofus.network.messages.game.context.fight.*;

import com.ankamagames.dofus.network.messages.game.context.fight.character.*;

import com.ankamagames.dofus.network.messages.game.context.roleplay.*;

import com.ankamagames.dofus.network.types.game.context.*;

import com.ankamagames.dofus.network.types.game.context.fight.*;

import com.ankamagames.dofus.network.types.game.interactive.*;

import com.ankamagames.dofus.types.entities.*;

import com.ankamagames.dofus.types.enums.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.types.events.*;

import com.ankamagames.jerakine.types.positions.*;

import com.ankamagames.tiphon.display.*;

import com.ankamagames.tiphon.types.*;

import flash.display.*;

import flash.filters.*;

import flash.geom.*;

import flash.utils.*;

class TmpFighterInfos extends Object
{
    public var contextualId:int;
    public var carryingCharacterId:int;

    function TmpFighterInfos(param1:int, param2:int) : void
    {
        this.contextualId = param1;
        this.carryingCharacterId = param2;
        return;
    }// end function

}

