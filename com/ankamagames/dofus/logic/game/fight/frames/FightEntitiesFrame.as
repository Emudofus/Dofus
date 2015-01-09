package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
    import com.ankamagames.jerakine.messages.Frame;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.tiphon.types.IAnimationModifier;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightRefreshFighterMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightHumanReadyStateMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameEntityDispositionMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameEntitiesDispositionMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.dofus.network.messages.game.context.ShowCellSpectatorMessage;
    import com.ankamagames.dofus.network.messages.game.context.ShowCellMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightThrowCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDropCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
    import flash.display.Sprite;
    import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsWithCoordsMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataInHouseMessage;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.FightHookList;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
    import com.ankamagames.dofus.logic.game.fight.miscs.CustomAnimStatiqueAnimationModifier;
    import com.ankamagames.dofus.misc.utils.EmbedAssets;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
    import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
    import com.ankamagames.dofus.logic.game.fight.actions.RemoveEntityAction;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
    import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
    import com.ankamagames.jerakine.messages.Message;
    import flash.utils.clearTimeout;
    import flash.display.InteractiveObject;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMinimalStatsPreparation;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
    import com.ankamagames.dofus.datacenter.effects.Effect;
    import com.ankamagames.dofus.logic.game.fight.steps.FightChangeVisibilityStep;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import flash.geom.ColorTransform;
    import flash.filters.GlowFilter;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
    import com.ankamagames.dofus.logic.game.fight.steps.FightCarryCharacterStep;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import __AS3__.vec.*;

    public class FightEntitiesFrame extends AbstractEntitiesFrame implements Frame 
    {

        private static const TEAM_CIRCLE_COLOR_1:uint = 0xFF;
        private static const TEAM_CIRCLE_COLOR_2:uint = 0xFF0000;

        private var _showCellStart:Number = 0;
        private var arrowId:uint;
        private var _ie:Dictionary;
        private var _tempFighterList:Array;
        private var _illusionEntities:Dictionary;
        private var _entitiesNumber:Dictionary;
        private var _lastKnownPosition:Dictionary;
        private var _lastKnownMovementPoint:Dictionary;
        private var _lastKnownPlayerStatus:Dictionary;
        private var _realFightersLooks:Dictionary;

        public function FightEntitiesFrame()
        {
            this._ie = new Dictionary(true);
            this._tempFighterList = new Array();
            super();
        }

        public static function getCurrentInstance():FightEntitiesFrame
        {
            return ((Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame));
        }


        override public function pushed():Boolean
        {
            Atouin.getInstance().cellOverEnabled = true;
            Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this._entitiesNumber = new Dictionary();
            this._illusionEntities = new Dictionary();
            this._lastKnownPosition = new Dictionary();
            this._lastKnownMovementPoint = new Dictionary();
            this._lastKnownPlayerStatus = new Dictionary();
            this._realFightersLooks = new Dictionary();
            _creaturesFightMode = OptionManager.getOptionManager("dofus")["creaturesFightMode"];
            return (super.pushed());
        }

        override public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier=null):AnimatedCharacter
        {
            var res:AnimatedCharacter = super.addOrUpdateActor(infos, animationModifier);
            if (infos.disposition.cellId != -1)
            {
                this._lastKnownPosition[infos.contextualId] = infos.disposition.cellId;
            };
            if (infos.contextualId > 0)
            {
                res.disableMouseEventWhenAnimated = true;
            };
            if (CurrentPlayedFighterManager.getInstance().currentFighterId == infos.contextualId)
            {
                res.setCanSeeThrough(true);
            };
            if ((infos is GameFightCharacterInformations))
            {
                this._lastKnownPlayerStatus[infos.contextualId] = GameFightCharacterInformations(infos).status.statusId;
            };
            return (res);
        }

        override public function process(msg:Message):Boolean
        {
            var _local_2:GameFightRefreshFighterMessage;
            var _local_3:int;
            var _local_4:GameContextActorInformations;
            var _local_5:GameFightShowFighterMessage;
            var _local_6:GameFightHumanReadyStateMessage;
            var _local_7:AnimatedCharacter;
            var _local_8:GameEntityDispositionMessage;
            var _local_9:GameEntitiesDispositionMessage;
            var _local_10:GameContextRefreshEntityLookMessage;
            var _local_11:TiphonSprite;
            var _local_12:int;
            var _local_13:ShowCellSpectatorMessage;
            var _local_14:String;
            var _local_15:ShowCellMessage;
            var _local_16:FightContextFrame;
            var _local_17:String;
            var _local_18:String;
            var _local_19:MapComplementaryInformationsDataMessage;
            var _local_20:GameActionFightCarryCharacterMessage;
            var _local_21:GameActionFightThrowCharacterMessage;
            var _local_22:GameActionFightDropCharacterMessage;
            var _local_23:PlayerStatusUpdateMessage;
            var staticRandomAnimModifier:IAnimationModifier;
            var swords:Sprite;
            var disposition:IdentifiedEntityDispositionInformations;
            var mciwcmsg:MapComplementaryInformationsWithCoordsMessage;
            var mcidihmsg:MapComplementaryInformationsDataInHouseMessage;
            var playerHouse:Boolean;
            var mo:MapObstacle;
            var ie:InteractiveElement;
            var se:StatedElement;
            var ent:GameFightFighterInformations;
            switch (true)
            {
                case (msg is GameFightRefreshFighterMessage):
                    _local_2 = (msg as GameFightRefreshFighterMessage);
                    _local_3 = _local_2.informations.contextualId;
                    _local_4 = _entities[_local_3];
                    if (_local_4 != null)
                    {
                        _local_4.disposition = _local_2.informations.disposition;
                        _local_4.look = _local_2.informations.look;
                        this._realFightersLooks[_local_2.informations.contextualId] = _local_2.informations.look;
                        this.updateActor(_local_4, true);
                    };
                    if (Kernel.getWorker().getFrame(FightPreparationFrame))
                    {
                        KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList, _local_3);
                        if (Dofus.getInstance().options.orderFighters)
                        {
                            this.updateAllEntitiesNumber(this.getOrdonnedPreFighters());
                        };
                    };
                    return (true);
                case (msg is GameFightShowFighterMessage):
                    _local_5 = (msg as GameFightShowFighterMessage);
                    this._realFightersLooks[_local_5.informations.contextualId] = _local_5.informations.look;
                    if ((msg is GameFightShowFighterRandomStaticPoseMessage))
                    {
                        staticRandomAnimModifier = new CustomAnimStatiqueAnimationModifier();
                        (staticRandomAnimModifier as CustomAnimStatiqueAnimationModifier).randomStatique = true;
                        this.updateFighter(_local_5.informations, staticRandomAnimModifier);
                        this._illusionEntities[_local_5.informations.contextualId] = true;
                    }
                    else
                    {
                        this.updateFighter(_local_5.informations);
                        this._illusionEntities[_local_5.informations.contextualId] = false;
                        if (Kernel.getWorker().getFrame(FightPreparationFrame))
                        {
                            KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList, _local_5.informations.contextualId);
                            if (Dofus.getInstance().options.orderFighters)
                            {
                                this.updateAllEntitiesNumber(this.getOrdonnedPreFighters());
                            };
                        };
                    };
                    return (true);
                case (msg is GameFightHumanReadyStateMessage):
                    _local_6 = (msg as GameFightHumanReadyStateMessage);
                    _local_7 = this.addOrUpdateActor((getEntityInfos(_local_6.characterId) as GameFightFighterInformations));
                    if (_local_6.isReady)
                    {
                        swords = EmbedAssets.getSprite("SWORDS_CLIP");
                        _local_7.addBackground("readySwords", swords);
                    }
                    else
                    {
                        _local_7.removeBackground("readySwords");
                    };
                    return (true);
                case (msg is GameEntityDispositionMessage):
                    _local_8 = (msg as GameEntityDispositionMessage);
                    if (_local_8.disposition.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        SoundManager.getInstance().manager.playUISound(UISoundEnum.FIGHT_POSITION);
                    };
                    this.updateActorDisposition(_local_8.disposition.id, _local_8.disposition);
                    KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition, _local_8.disposition.id, _local_8.disposition.cellId, _local_8.disposition.direction);
                    return (true);
                case (msg is GameEntitiesDispositionMessage):
                    _local_9 = (msg as GameEntitiesDispositionMessage);
                    for each (disposition in _local_9.dispositions)
                    {
                        if (((getEntityInfos(disposition.id)) && (!((GameFightFighterInformations(getEntityInfos(disposition.id)).stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)))))
                        {
                            this.updateActorDisposition(disposition.id, disposition);
                        };
                        KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition, disposition.id, disposition.cellId, disposition.direction);
                    };
                    return (true);
                case (msg is GameContextRefreshEntityLookMessage):
                    _local_10 = (msg as GameContextRefreshEntityLookMessage);
                    _local_11 = (DofusEntities.getEntity(_local_10.id) as TiphonSprite);
                    if (_local_11)
                    {
                        _local_11.setAnimation(AnimationEnum.ANIM_STATIQUE);
                    };
                    updateActorLook(_local_10.id, _local_10.look);
                    return (true);
                case (msg is ToggleDematerializationAction):
                    this.showCreaturesInFight(!(_creaturesFightMode));
                    KernelEventsManager.getInstance().processCallback(FightHookList.DematerializationChanged, _creaturesFightMode);
                    return (true);
                case (msg is RemoveEntityAction):
                    _local_12 = RemoveEntityAction(msg).actorId;
                    this._entitiesNumber[_local_12] = null;
                    removeActor(_local_12);
                    KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList, _local_12);
                    delete this._realFightersLooks[_local_12];
                    return (true);
                case (msg is ShowCellSpectatorMessage):
                    _local_13 = (msg as ShowCellSpectatorMessage);
                    HyperlinkShowCellManager.showCell(_local_13.cellId);
                    _local_14 = I18n.getUiText("ui.fight.showCell", [_local_13.playerName, _local_13.cellId]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_14, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is ShowCellMessage):
                    _local_15 = (msg as ShowCellMessage);
                    HyperlinkShowCellManager.showCell(_local_15.cellId);
                    _local_16 = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    _local_17 = ((_local_16) ? _local_16.getFighterName(_local_15.sourceId) : "???");
                    _local_18 = I18n.getUiText("ui.fight.showCell", [_local_17, (((("{cell," + _local_15.cellId) + "::") + _local_15.cellId) + "}")]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_18, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is MapComplementaryInformationsDataMessage):
                    _local_19 = (msg as MapComplementaryInformationsDataMessage);
                    _interactiveElements = _local_19.interactiveElements;
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
                            _worldPoint = new WorldPointWrapper(_local_19.mapId);
                            if (PlayedCharacterManager.getInstance().isInHouse)
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                            };
                            PlayedCharacterManager.getInstance().isInHouse = false;
                            PlayedCharacterManager.getInstance().isInHisHouse = false;
                        };
                    };
                    _currentSubAreaId = _local_19.subAreaId;
                    PlayedCharacterManager.getInstance().currentMap = _worldPoint;
                    PlayedCharacterManager.getInstance().currentSubArea = SubArea.getSubAreaById(_currentSubAreaId);
                    TooltipManager.hide();
                    for each (mo in _local_19.obstacles)
                    {
                        InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId, (mo.state == MapObstacleStateEnum.OBSTACLE_OPENED));
                    };
                    for each (ie in _local_19.interactiveElements)
                    {
                        if (ie.enabledSkills.length)
                        {
                            this.registerInteractive(ie, ie.enabledSkills[0].skillId);
                        }
                        else
                        {
                            if (ie.disabledSkills.length)
                            {
                                this.registerInteractive(ie, ie.disabledSkills[0].skillId);
                            };
                        };
                    };
                    for each (se in _local_19.statedElements)
                    {
                        this.updateStatedElement(se);
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData, PlayedCharacterManager.getInstance().currentMap, _currentSubAreaId, Dofus.getInstance().options.mapCoordinates);
                    KernelEventsManager.getInstance().processCallback(HookList.MapFightCount, 0);
                    return (true);
                case (msg is GameActionFightCarryCharacterMessage):
                    _local_20 = (msg as GameActionFightCarryCharacterMessage);
                    if (_local_20.cellId != -1)
                    {
                        for each (ent in _entities)
                        {
                            if (ent.contextualId == _local_20.targetId)
                            {
                                (ent.disposition as FightEntityDispositionInformations).carryingCharacterId = _local_20.sourceId;
                                this._tempFighterList.push(new TmpFighterInfos(ent.contextualId, _local_20.sourceId));
                                break;
                            };
                        };
                    };
                    return (true);
                case (msg is GameActionFightThrowCharacterMessage):
                    _local_21 = (msg as GameActionFightThrowCharacterMessage);
                    this.dropEntity(_local_21.targetId);
                    return (true);
                case (msg is GameActionFightDropCharacterMessage):
                    _local_22 = (msg as GameActionFightDropCharacterMessage);
                    this.dropEntity(_local_22.targetId);
                    return (true);
                case (msg is PlayerStatusUpdateMessage):
                    _local_23 = (msg as PlayerStatusUpdateMessage);
                    this._lastKnownPlayerStatus[_local_23.playerId] = _local_23.status.statusId;
                    return (false);
            };
            return (false);
        }

        private function dropEntity(targetId:int):void
        {
            var index:int;
            var ent:GameFightFighterInformations;
            for each (ent in _entities)
            {
                if (ent.contextualId == targetId)
                {
                    (ent.disposition as FightEntityDispositionInformations).carryingCharacterId = NaN;
                    index = this.getTmpFighterInfoIndex(ent.contextualId);
                    if (((((!((this._tempFighterList == null))) && (!((this._tempFighterList.length == 0))))) && (!((index == -1)))))
                    {
                        this._tempFighterList.splice(index, 1);
                    };
                    return;
                };
            };
        }

        public function showCreaturesInFight(activated:Boolean=false):void
        {
            var ent:GameFightFighterInformations;
            var ac:AnimatedCharacter;
            _creaturesFightMode = activated;
            _justSwitchingCreaturesFightMode = true;
            for each (ent in _entities)
            {
                this.updateFighter(ent);
            };
            _justSwitchingCreaturesFightMode = false;
        }

        public function entityIsIllusion(id:int):Boolean
        {
            return (this._illusionEntities[id]);
        }

        public function getLastKnownEntityPosition(id:int):int
        {
            return (((!((this._lastKnownPosition[id] == null))) ? this._lastKnownPosition[id] : -1));
        }

        public function setLastKnownEntityPosition(id:int, value:int):void
        {
            this._lastKnownPosition[id] = value;
        }

        public function getLastKnownEntityMovementPoint(id:int):int
        {
            return (((!((this._lastKnownMovementPoint[id] == null))) ? this._lastKnownMovementPoint[id] : 0));
        }

        public function setLastKnownEntityMovementPoint(id:int, value:int, add:Boolean=false):void
        {
            if (this._lastKnownMovementPoint[id] == null)
            {
                this._lastKnownMovementPoint[id] = 0;
            };
            if (!(add))
            {
                this._lastKnownMovementPoint[id] = value;
            }
            else
            {
                this._lastKnownMovementPoint[id] = (this._lastKnownMovementPoint[id] + value);
            };
        }

        override public function pulled():Boolean
        {
            var obj:Object;
            var fighterId:*;
            Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            this._tempFighterList = null;
            for each (obj in this._ie)
            {
                this.removeInteractive((obj.element as InteractiveElement));
            };
            for (fighterId in this._realFightersLooks)
            {
                delete this._realFightersLooks[fighterId];
            };
            return (super.pulled());
        }

        private function onTimeOut():void
        {
            clearTimeout(this._showCellStart);
            removeActor(this.arrowId);
            this._showCellStart = 0;
        }

        private function registerInteractive(ie:InteractiveElement, firstSkill:int):void
        {
            var s:String;
            var cie:InteractiveElement;
            var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
            if (!(worldObject))
            {
                _log.error((("Unknown identified element " + ie.elementId) + ", unable to register it as interactive."));
                return;
            };
            var found:Boolean;
            for (s in interactiveElements)
            {
                cie = interactiveElements[int(s)];
                if (cie.elementId == ie.elementId)
                {
                    found = true;
                    interactiveElements[int(s)] = ie;
                    break;
                };
            };
            if (!(found))
            {
                interactiveElements.push(ie);
            };
            var worldPos:MapPoint = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
            this._ie[worldObject] = {
                "element":ie,
                "position":worldPos,
                "firstSkill":firstSkill
            };
        }

        private function updateStatedElement(se:StatedElement):void
        {
            var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(se.elementId);
            if (!(worldObject))
            {
                _log.error((((("Unknown identified element " + se.elementId) + "; unable to change its state to ") + se.elementState) + " !"));
                return;
            };
            var ts:TiphonSprite = (((worldObject is DisplayObjectContainer)) ? this.findTiphonSprite((worldObject as DisplayObjectContainer)) : null);
            if (!(ts))
            {
                _log.warn((((("Unable to find an animated element for the stated element " + se.elementId) + " on cell ") + se.elementCellId) + ", this element is probably invisible or is not configured as an animated element."));
                return;
            };
            ts.setAnimationAndDirection("AnimState1", 0);
        }

        private function findTiphonSprite(doc:DisplayObjectContainer):TiphonSprite
        {
            var child:DisplayObject;
            if ((doc is TiphonSprite))
            {
                return ((doc as TiphonSprite));
            };
            if (!(doc.numChildren))
            {
                return (null);
            };
            var i:uint;
            while (i < doc.numChildren)
            {
                child = doc.getChildAt(i);
                if ((child is TiphonSprite))
                {
                    return ((child as TiphonSprite));
                };
                if ((child is DisplayObjectContainer))
                {
                    return (this.findTiphonSprite((child as DisplayObjectContainer)));
                };
                i++;
            };
            return (null);
        }

        private function removeInteractive(ie:InteractiveElement):void
        {
            var interactiveElement:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
            delete this._ie[interactiveElement];
        }

        public function getOrdonnedPreFighters():Vector.<int>
        {
            var badInit:int;
            var goodInit:int;
            var id:int;
            var badStart:Boolean;
            var fighter:GameFightFighterInformations;
            var stats:GameFightMinimalStatsPreparation;
            var entitiesIds:Vector.<int> = getEntitiesIdsList();
            var fighters:Vector.<int> = new Vector.<int>();
            if (((!(entitiesIds)) || ((entitiesIds.length <= 1))))
            {
                return (fighters);
            };
            var goodGuys:Array = new Array();
            var badGuys:Array = new Array();
            for each (id in entitiesIds)
            {
                fighter = (getEntityInfos(id) as GameFightFighterInformations);
                if (fighter)
                {
                    stats = (fighter.stats as GameFightMinimalStatsPreparation);
                    if (stats)
                    {
                        if (fighter.teamId == 0)
                        {
                            badGuys.push({
                                "fighter":id,
                                "init":((stats.initiative * stats.lifePoints) / stats.maxLifePoints)
                            });
                            badInit = (badInit + ((stats.initiative * stats.lifePoints) / stats.maxLifePoints));
                        }
                        else
                        {
                            goodGuys.push({
                                "fighter":id,
                                "init":((stats.initiative * stats.lifePoints) / stats.maxLifePoints)
                            });
                            goodInit = (goodInit + ((stats.initiative * stats.lifePoints) / stats.maxLifePoints));
                        };
                    };
                };
            };
            badGuys.sortOn(["init", "fighter"], (Array.DESCENDING | Array.NUMERIC));
            goodGuys.sortOn(["init", "fighter"], (Array.DESCENDING | Array.NUMERIC));
            badStart = true;
            if ((((((badGuys.length == 0)) || ((goodGuys.length == 0)))) || (((badInit / badGuys.length) < (goodInit / goodGuys.length)))))
            {
                badStart = false;
            };
            var length:int = Math.max(badGuys.length, goodGuys.length);
            var i:int;
            while (i < length)
            {
                if (badStart)
                {
                    if (badGuys[i])
                    {
                        fighters.push(badGuys[i].fighter);
                    };
                    if (goodGuys[i])
                    {
                        fighters.push(goodGuys[i].fighter);
                    };
                }
                else
                {
                    if (goodGuys[i])
                    {
                        fighters.push(goodGuys[i].fighter);
                    };
                    if (badGuys[i])
                    {
                        fighters.push(badGuys[i].fighter);
                    };
                };
                i++;
            };
            return (fighters);
        }

        public function removeSwords():void
        {
            var entInfo:*;
            var ac:AnimatedCharacter;
            for each (entInfo in _entities)
            {
                if ((((entInfo is GameFightCharacterInformations)) && (!(GameFightCharacterInformations(entInfo).alive))))
                {
                }
                else
                {
                    ac = this.addOrUpdateActor(entInfo);
                    ac.removeBackground("readySwords");
                };
            };
        }

        public function updateFighter(fighterInfos:GameFightFighterInformations, animationModifier:IAnimationModifier=null, finishingBuff:Array=null):void
        {
            var i:int;
            var buffArray:Array;
            var buff:BasicBuff;
            var statBuff:StatBuff;
            var statName:String;
            var effect:Effect;
            var lastInvisibilityStat:int;
            var lastFighterInfo:GameFightFighterInformations;
            var ac:AnimatedCharacter;
            var inviStep:FightChangeVisibilityStep;
            var fighterId:int = fighterInfos.contextualId;
            if (finishingBuff)
            {
                i = 0;
                while (i < finishingBuff.length)
                {
                    buffArray = BuffManager.getInstance().getAllBuff(fighterId);
                    for each (buff in buffArray)
                    {
                        if (buff.id == finishingBuff[i].id)
                        {
                            statBuff = (finishingBuff[i] as StatBuff);
                            statName = statBuff.statName;
                            effect = Effect.getEffectById(statBuff.actionId);
                            if (((((statName) && (fighterInfos.stats.hasOwnProperty(statName)))) && (effect.active)))
                            {
                                if (statName == "actionPoints")
                                {
                                    fighterInfos.stats["maxActionPoints"] = (fighterInfos.stats["maxActionPoints"] - finishingBuff[i].delta);
                                };
                                fighterInfos.stats[statName] = (fighterInfos.stats[statName] - finishingBuff[i].delta);
                            };
                        };
                    };
                    i++;
                };
            };
            if (fighterInfos.alive)
            {
                lastInvisibilityStat = -1;
                lastFighterInfo = (_entities[fighterInfos.contextualId] as GameFightFighterInformations);
                if (lastFighterInfo)
                {
                    lastInvisibilityStat = lastFighterInfo.stats.invisibilityState;
                };
                if ((((lastInvisibilityStat == GameActionFightInvisibilityStateEnum.INVISIBLE)) && ((fighterInfos.stats.invisibilityState == lastInvisibilityStat))))
                {
                    registerActor(fighterInfos);
                    return;
                };
                if (lastFighterInfo != fighterInfos)
                {
                    registerActor(fighterInfos);
                    if (fighterInfos.contextualId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                    };
                };
                ac = this.addOrUpdateActor(fighterInfos, animationModifier);
                if (((!((fighterInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE))) && (!((fighterInfos.stats.invisibilityState == lastInvisibilityStat)))))
                {
                    inviStep = new FightChangeVisibilityStep(fighterId, fighterInfos.stats.invisibilityState);
                    inviStep.start();
                };
                this.addCircleToFighter(ac, (((fighterInfos.teamId == TeamEnum.TEAM_DEFENDER)) ? TEAM_CIRCLE_COLOR_1 : TEAM_CIRCLE_COLOR_2));
            }
            else
            {
                this.updateActor(fighterInfos, false);
            };
            this.updateCarriedEntities(fighterInfos);
        }

        public function updateActor(actorInfos:GameContextActorInformations, alive:Boolean=true, animationModifier:IAnimationModifier=null):void
        {
            var ac:AnimatedCharacter;
            var actorId:int = actorInfos.contextualId;
            if (alive)
            {
                registerActor(actorInfos);
                ac = this.addOrUpdateActor(actorInfos, animationModifier);
            }
            else
            {
                if (_entities[actorId])
                {
                    hideActor(actorId);
                };
                registerActor(actorInfos);
            };
        }

        private function addCircleToFighter(pAc:AnimatedCharacter, pColor:uint):void
        {
            var circle:Sprite = new Sprite();
            var teamCircle:Sprite = EmbedAssets.getSprite("TEAM_CIRCLE_CLIP");
            circle.addChild(teamCircle);
            var colorTransform:ColorTransform = new ColorTransform();
            colorTransform.color = pColor;
            circle.filters = [new GlowFilter(0xFFFFFF, 0.5, 2, 2, 3, 3)];
            teamCircle.transform.colorTransform = colorTransform;
            pAc.addBackground("teamCircle", circle);
        }

        private function updateCarriedEntities(fighterInfos:GameContextActorInformations):void
        {
            var infos:TmpFighterInfos;
            var carryingCharacterId:int;
            var fedi:FightEntityDispositionInformations;
            var carryingEntity:IEntity;
            var _local_9:IEntity;
            var hasCarryingModifier:Boolean;
            var carryingTs:TiphonSprite;
            var modifier:IAnimationModifier;
            var fighterId:int = fighterInfos.contextualId;
            var num:int = this._tempFighterList.length;
            var i:int;
            while (i < num)
            {
                infos = this._tempFighterList[i];
                carryingCharacterId = infos.carryingCharacterId;
                if (fighterId == carryingCharacterId)
                {
                    this._tempFighterList.splice(i, 1);
                    this.startCarryStep(carryingCharacterId, infos.contextualId);
                    break;
                };
                i++;
            };
            if ((fighterInfos.disposition is FightEntityDispositionInformations))
            {
                fedi = (fighterInfos.disposition as FightEntityDispositionInformations);
                if (fedi.carryingCharacterId)
                {
                    carryingEntity = DofusEntities.getEntity(fedi.carryingCharacterId);
                    if (!(carryingEntity))
                    {
                        this._tempFighterList.push(new TmpFighterInfos(fighterInfos.contextualId, fedi.carryingCharacterId));
                    }
                    else
                    {
                        _local_9 = DofusEntities.getEntity(fighterInfos.contextualId);
                        if (_local_9)
                        {
                            hasCarryingModifier = false;
                            if ((carryingEntity as AnimatedCharacter).isMounted())
                            {
                                carryingTs = ((carryingEntity as TiphonSprite).getSubEntitySlot(2, 0) as TiphonSprite);
                            }
                            else
                            {
                                carryingTs = (carryingEntity as TiphonSprite);
                            };
                            if (carryingTs)
                            {
                                carryingTs.removeAnimationModifierByClass(CustomAnimStatiqueAnimationModifier);
                                for each (modifier in carryingTs.animationModifiers)
                                {
                                    if ((modifier is CarrierAnimationModifier))
                                    {
                                        hasCarryingModifier = true;
                                        break;
                                    };
                                };
                                if (!(hasCarryingModifier))
                                {
                                    carryingTs.addAnimationModifier(CarrierAnimationModifier.getInstance());
                                };
                            };
                            if (((!(hasCarryingModifier)) || (!((((((carryingEntity is TiphonSprite)) && ((_local_9 is TiphonSprite)))) && ((TiphonSprite(_local_9).parentSprite == carryingEntity)))))))
                            {
                                this.startCarryStep(fedi.carryingCharacterId, fighterInfos.contextualId);
                            };
                        };
                    };
                };
            };
        }

        private function startCarryStep(fighterId:int, carriedId:int):void
        {
            var step:FightCarryCharacterStep = new FightCarryCharacterStep(fighterId, carriedId, -1, true);
            step.start();
            FightEventsHelper.sendAllFightEvent();
        }

        public function updateAllEntitiesNumber(ids:Vector.<int>):void
        {
            var id:int;
            var num:uint = 1;
            for each (id in ids)
            {
                if (((_entities[id]) && (_entities[id].alive)))
                {
                    this.updateEntityNumber(id, num);
                    num++;
                };
            };
        }

        public function updateEntityNumber(id:int, num:uint):void
        {
            var number:Sprite;
            var lbl_number:Label;
            var ac:AnimatedCharacter;
            if (((_entities[id]) && (((!((_entities[id] is GameFightCharacterInformations))) || (GameFightCharacterInformations(_entities[id]).alive)))))
            {
                if (((!(this._entitiesNumber[id])) || ((this._entitiesNumber[id] == null))))
                {
                    number = new Sprite();
                    lbl_number = new Label();
                    lbl_number.width = 30;
                    lbl_number.height = 20;
                    lbl_number.x = -45;
                    lbl_number.y = -15;
                    lbl_number.css = new Uri((XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css"));
                    lbl_number.text = num.toString();
                    number.addChild(lbl_number);
                    number.filters = [new GlowFilter(XmlConfig.getInstance().getEntry("colors.text.glow"), 1, 4, 4, 6, 3)];
                    this._entitiesNumber[id] = lbl_number;
                    ac = (DofusEntities.getEntity(id) as AnimatedCharacter);
                    if (ac)
                    {
                        ac.addBackground("fighterNumber", number);
                    };
                }
                else
                {
                    this._entitiesNumber[id].text = num.toString();
                };
            };
        }

        public function updateRemovedEntity(idEntity:int):void
        {
            var num:uint;
            var fightBFrame:FightBattleFrame;
            var entId:int;
            this._entitiesNumber[idEntity] = null;
            if (Dofus.getInstance().options.orderFighters)
            {
                num = 1;
                fightBFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
                for each (entId in fightBFrame.fightersList)
                {
                    if (((!((entId == idEntity))) && ((getEntityInfos(entId) as GameFightFighterInformations).alive)))
                    {
                        this.updateEntityNumber(entId, num);
                        num++;
                    };
                };
            };
        }

        override protected function onPropertyChanged(e:PropertyChangeEvent):void
        {
            var id:String;
            var ac:AnimatedCharacter;
            var _local_4:uint;
            var _local_5:FightBattleFrame;
            var entId:int;
            if (!(_worldPoint))
            {
                _worldPoint = PlayedCharacterManager.getInstance().currentMap;
            };
            if (!(_currentSubAreaId))
            {
                _currentSubAreaId = PlayedCharacterManager.getInstance().currentSubArea.id;
            };
            super.onPropertyChanged(e);
            if (e.propertyName == "cellSelectionOnly")
            {
                untargetableEntities = ((e.propertyValue) || (Kernel.getWorker().getFrame(FightPreparationFrame)));
            }
            else
            {
                if (e.propertyName == "orderFighters")
                {
                    if (!(e.propertyValue))
                    {
                        for (id in this._entitiesNumber)
                        {
                            if (this._entitiesNumber[int(id)])
                            {
                                this._entitiesNumber[int(id)] = null;
                                ac = (DofusEntities.getEntity(int(id)) as AnimatedCharacter);
                                if (ac)
                                {
                                    ac.removeBackground("fighterNumber");
                                };
                            };
                        };
                    }
                    else
                    {
                        _local_4 = 1;
                        _local_5 = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
                        if (_local_5)
                        {
                            for each (entId in _local_5.fightersList)
                            {
                                if ((getEntityInfos(entId) as GameFightFighterInformations).alive)
                                {
                                    this.updateEntityNumber(entId, _local_4);
                                    _local_4++;
                                };
                            };
                        };
                    };
                };
            };
        }

        public function set cellSelectionOnly(enabled:Boolean):void
        {
            var infos:GameContextActorInformations;
            var entity:AnimatedCharacter;
            for each (infos in _entities)
            {
                entity = (DofusEntities.getEntity(infos.contextualId) as AnimatedCharacter);
                if (entity)
                {
                    entity.mouseEnabled = !(enabled);
                };
            };
        }

        public function get dematerialization():Boolean
        {
            return (_creaturesFightMode);
        }

        public function get lastKnownPlayerStatus():Dictionary
        {
            return (this._lastKnownPlayerStatus);
        }

        public function getRealFighterLook(pFighterId:int):EntityLook
        {
            return (this._realFightersLooks[pFighterId]);
        }

        override protected function updateActorDisposition(actorId:int, newDisposition:EntityDispositionInformations):void
        {
            var actor:IEntity;
            super.updateActorDisposition(actorId, newDisposition);
            if (newDisposition.cellId == -1)
            {
                actor = DofusEntities.getEntity(actorId);
                if (actor)
                {
                    FightEntitiesHolder.getInstance().holdEntity(actor);
                };
            }
            else
            {
                FightEntitiesHolder.getInstance().unholdEntity(actorId);
            };
        }

        private function getTmpFighterInfoIndex(pId:int):int
        {
            var infos:TmpFighterInfos;
            for each (infos in this._tempFighterList)
            {
                if (infos.contextualId == pId)
                {
                    return (this._tempFighterList.indexOf(infos));
                };
            };
            return (-1);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.frames

class TmpFighterInfos 
{

    public var contextualId:int;
    public var carryingCharacterId:int;

    public function TmpFighterInfos(pId:int, pCarryindId:int):void
    {
        this.contextualId = pId;
        this.carryingCharacterId = pCarryindId;
    }

}

