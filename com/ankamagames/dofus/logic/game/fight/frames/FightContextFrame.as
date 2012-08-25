package com.ankamagames.dofus.logic.game.fight.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.fight.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.enum.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.messages.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.actions.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.challenge.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.action.fight.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.zones.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import com.hurlant.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.utils.*;

    public class FightContextFrame extends Object implements Frame
    {
        private const TYPE_LOG_FIGHT:uint = 30000;
        private const INVISIBLE_POSITION_SELECTION:String = "invisible_position";
        private var _entitiesFrame:FightEntitiesFrame;
        private var _preparationFrame:FightPreparationFrame;
        private var _battleFrame:FightBattleFrame;
        private var _pointCellFrame:FightPointCellFrame;
        private var _overEffectOk:GlowFilter;
        private var _overEffectKo:GlowFilter;
        private var _linkedEffect:ColorMatrixFilter;
        private var _linkedMainEffect:ColorMatrixFilter;
        private var _lastEffectEntity:WeakReference;
        private var _reachableRangeSelection:Selection;
        private var _unreachableRangeSelection:Selection;
        private var _timerFighterInfo:Timer;
        private var _timerMovementRange:Timer;
        private var _currentFighterInfo:GameFightFighterInformations;
        private var _currentMapRenderId:int = -1;
        public var _challengesList:Array;
        private var _fightType:uint;
        public var isFightLeader:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FightContextFrame));
        public static var preFightIsActive:Boolean = true;
        public static var fighterEntityTooltipId:int;
        public static var timelineOverEntityId:int;
        public static var currentCell:int = -1;

        public function FightContextFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get entitiesFrame() : FightEntitiesFrame
        {
            return this._entitiesFrame;
        }// end function

        public function get battleFrame() : FightBattleFrame
        {
            return this._battleFrame;
        }// end function

        public function get challengesList() : Array
        {
            return this._challengesList;
        }// end function

        public function get fightType() : uint
        {
            return this._fightType;
        }// end function

        public function set fightType(param1:uint) : void
        {
            this._fightType = param1;
            var _loc_2:* = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
            _loc_2.lastFightType = param1;
            return;
        }// end function

        public function pushed() : Boolean
        {
            if (!Kernel.beingInReconection)
            {
                Atouin.getInstance().displayGrid(true);
            }
            currentCell = -1;
            timelineOverEntityId = 0;
            this._overEffectOk = new GlowFilter(16777215, 1, 4, 4, 3, 1);
            this._overEffectKo = new GlowFilter(14090240, 1, 4, 4, 3, 1);
            var _loc_1:* = new Array();
            _loc_1 = _loc_1.concat([0.5, 0, 0, 0, 100]);
            _loc_1 = _loc_1.concat([0, 0.5, 0, 0, 100]);
            _loc_1 = _loc_1.concat([0, 0, 0.5, 0, 100]);
            _loc_1 = _loc_1.concat([0, 0, 0, 1, 0]);
            this._linkedEffect = new ColorMatrixFilter(_loc_1);
            var _loc_2:* = new Array();
            _loc_2 = _loc_2.concat([0.5, 0, 0, 0, 0]);
            _loc_2 = _loc_2.concat([0, 0.5, 0, 0, 0]);
            _loc_2 = _loc_2.concat([0, 0, 0.5, 0, 0]);
            _loc_2 = _loc_2.concat([0, 0, 0, 1, 0]);
            this._linkedMainEffect = new ColorMatrixFilter(_loc_2);
            this._entitiesFrame = new FightEntitiesFrame();
            this._preparationFrame = new FightPreparationFrame(this);
            this._battleFrame = new FightBattleFrame();
            this._pointCellFrame = new FightPointCellFrame();
            this._challengesList = new Array();
            this._timerFighterInfo = new Timer(100, 1);
            this._timerFighterInfo.addEventListener(TimerEvent.TIMER, this.showFighterInfo, false, 0, true);
            this._timerMovementRange = new Timer(200, 1);
            this._timerMovementRange.addEventListener(TimerEvent.TIMER, this.showMovementRange, false, 0, true);
            if (MapDisplayManager.getInstance().getDataMapContainer())
            {
                MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
            }
            return true;
        }// end function

        public function getFighterName(param1:int) : String
        {
            var _loc_2:GameFightFighterInformations = null;
            var _loc_3:GameFightTaxCollectorInformations = null;
            _loc_2 = this.getFighterInfos(param1);
            if (!_loc_2)
            {
                return "Unknown Fighter";
            }
            switch(true)
            {
                case _loc_2 is GameFightFighterNamedInformations:
                {
                    return (_loc_2 as GameFightFighterNamedInformations).name;
                }
                case _loc_2 is GameFightMonsterInformations:
                {
                    return Monster.getMonsterById((_loc_2 as GameFightMonsterInformations).creatureGenericId).name;
                }
                case _loc_2 is GameFightTaxCollectorInformations:
                {
                    _loc_3 = _loc_2 as GameFightTaxCollectorInformations;
                    return TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_3.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_3.lastNameId).name;
                }
                default:
                {
                    break;
                }
            }
            return "Unknown Fighter Type";
        }// end function

        public function getFighterLevel(param1:int) : uint
        {
            var _loc_2:GameFightFighterInformations = null;
            var _loc_3:Monster = null;
            _loc_2 = this.getFighterInfos(param1);
            if (!_loc_2)
            {
                return 0;
            }
            switch(true)
            {
                case _loc_2 is GameFightMutantInformations:
                {
                    return (_loc_2 as GameFightMutantInformations).powerLevel;
                }
                case _loc_2 is GameFightCharacterInformations:
                {
                    return (_loc_2 as GameFightCharacterInformations).level;
                }
                case _loc_2 is GameFightMonsterInformations:
                {
                    _loc_3 = Monster.getMonsterById((_loc_2 as GameFightMonsterInformations).creatureGenericId);
                    return _loc_3.getMonsterGrade((_loc_2 as GameFightMonsterInformations).creatureGrade).level;
                }
                case _loc_2 is GameFightTaxCollectorInformations:
                {
                    return (_loc_2 as GameFightTaxCollectorInformations).level;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public function getChallengeById(param1:uint) : ChallengeWrapper
        {
            var _loc_2:ChallengeWrapper = null;
            for each (_loc_2 in this._challengesList)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:GameFightStartingMessage = null;
            var _loc_3:CurrentMapMessage = null;
            var _loc_4:WorldPointWrapper = null;
            var _loc_5:ByteArray = null;
            var _loc_6:GameContextReadyMessage = null;
            var _loc_7:GameFightResumeMessage = null;
            var _loc_8:Vector.<GameFightResumeSlaveInfo> = null;
            var _loc_9:GameFightResumeSlaveInfo = null;
            var _loc_10:CurrentPlayedFighterManager = null;
            var _loc_11:int = 0;
            var _loc_12:Array = null;
            var _loc_13:Array = null;
            var _loc_14:Array = null;
            var _loc_15:CastingSpell = null;
            var _loc_16:GameFightUpdateTeamMessage = null;
            var _loc_17:GameFightSpectateMessage = null;
            var _loc_18:Array = null;
            var _loc_19:Array = null;
            var _loc_20:Array = null;
            var _loc_21:CastingSpell = null;
            var _loc_22:GameFightJoinMessage = null;
            var _loc_23:int = 0;
            var _loc_24:GameActionFightCarryCharacterMessage = null;
            var _loc_25:CellOutMessage = null;
            var _loc_26:AnimatedCharacter = null;
            var _loc_27:CellOverMessage = null;
            var _loc_28:AnimatedCharacter = null;
            var _loc_29:EntityMouseOverMessage = null;
            var _loc_30:EntityMouseOutMessage = null;
            var _loc_31:TimelineEntityOverAction = null;
            var _loc_32:TogglePointCellAction = null;
            var _loc_33:GameFightEndMessage = null;
            var _loc_34:ChallengeTargetsListRequestAction = null;
            var _loc_35:ChallengeTargetsListRequestMessage = null;
            var _loc_36:ChallengeTargetsListMessage = null;
            var _loc_37:ChallengeInfoMessage = null;
            var _loc_38:ChallengeWrapper = null;
            var _loc_39:ChallengeTargetUpdateMessage = null;
            var _loc_40:ChallengeResultMessage = null;
            var _loc_41:MapObstacleUpdateMessage = null;
            var _loc_42:GameActionFightNoSpellCastMessage = null;
            var _loc_43:uint = 0;
            var _loc_44:String = null;
            var _loc_45:GameFightResumeWithSlavesMessage = null;
            var _loc_46:int = 0;
            var _loc_47:GameFightResumeSlaveInfo = null;
            var _loc_48:int = 0;
            var _loc_49:int = 0;
            var _loc_50:GameFightSpellCooldown = null;
            var _loc_51:SpellWrapper = null;
            var _loc_52:SpellLevel = null;
            var _loc_53:SpellCastInFightManager = null;
            var _loc_54:int = 0;
            var _loc_55:SpellModificator = null;
            var _loc_56:CharacterCharacteristicsInformations = null;
            var _loc_57:CharacterSpellModification = null;
            var _loc_58:FightDispellableEffectExtendedInformations = null;
            var _loc_59:BasicBuff = null;
            var _loc_60:GameActionMark = null;
            var _loc_61:Spell = null;
            var _loc_62:GameActionMarkedCell = null;
            var _loc_63:AddGlyphGfxStep = null;
            var _loc_64:FightDispellableEffectExtendedInformations = null;
            var _loc_65:BasicBuff = null;
            var _loc_66:GameActionMark = null;
            var _loc_67:Spell = null;
            var _loc_68:GameActionMarkedCell = null;
            var _loc_69:AddGlyphGfxStep = null;
            var _loc_70:IEntity = null;
            var _loc_71:IEntity = null;
            var _loc_72:FightEndingMessage = null;
            var _loc_73:Vector.<FightResultEntryWrapper> = null;
            var _loc_74:uint = 0;
            var _loc_75:FightResultEntryWrapper = null;
            var _loc_76:Vector.<FightResultEntryWrapper> = null;
            var _loc_77:FightResultListEntry = null;
            var _loc_78:Object = null;
            var _loc_79:FightResultEntryWrapper = null;
            var _loc_80:uint = 0;
            var _loc_81:ItemWrapper = null;
            var _loc_82:int = 0;
            var _loc_83:int = 0;
            var _loc_84:FightResultEntryWrapper = null;
            var _loc_85:Number = NaN;
            var _loc_86:MapObstacle = null;
            var _loc_87:SpellLevel = null;
            var _loc_88:int = 0;
            switch(true)
            {
                case param1 is MapLoadedMessage:
                {
                    MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
                    return false;
                }
                case param1 is GameFightStartingMessage:
                {
                    _loc_2 = param1 as GameFightStartingMessage;
                    TooltipManager.hideAll();
                    Atouin.getInstance().cancelZoom();
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    MapDisplayManager.getInstance().activeIdentifiedElements(false);
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightStarting, _loc_2.fightType);
                    this.fightType = _loc_2.fightType;
                    CurrentPlayedFighterManager.getInstance().currentFighterId = PlayedCharacterManager.getInstance().id;
                    SoundManager.getInstance().manager.prepareFightMusic();
                    SoundManager.getInstance().manager.playUISound(UISoundEnum.INTRO_FIGHT);
                    return true;
                }
                case param1 is CurrentMapMessage:
                {
                    _loc_3 = param1 as CurrentMapMessage;
                    ConnectionsHandler.pause();
                    Kernel.getWorker().pause();
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide();
                    }
                    _loc_4 = new WorldPointWrapper(_loc_3.mapId);
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    Atouin.getInstance().initPreDisplay(_loc_4);
                    Atouin.getInstance().clearEntities();
                    if (_loc_3.mapKey && _loc_3.mapKey.length)
                    {
                        _loc_44 = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                        _loc_44 = "649ae451ca33ec53bbcbcc33becf15f4";
                        if (!_loc_44)
                        {
                            _loc_44 = _loc_3.mapKey;
                        }
                        _loc_5 = Hex.toArray(Hex.fromString(_loc_44));
                    }
                    this._currentMapRenderId = Atouin.getInstance().display(_loc_4, _loc_5);
                    _log.info("Ask map render for fight #" + this._currentMapRenderId);
                    PlayedCharacterManager.getInstance().currentMap = _loc_4;
                    KernelEventsManager.getInstance().processCallback(HookList.CurrentMap, _loc_3.mapId);
                    return true;
                }
                case param1 is MapsLoadingCompleteMessage:
                {
                    _log.info("MapsLoadingCompleteMessage #" + MapsLoadingCompleteMessage(param1).renderRequestId);
                    if (this._currentMapRenderId != MapsLoadingCompleteMessage(param1).renderRequestId)
                    {
                        return false;
                    }
                    Atouin.getInstance().showWorld(true);
                    Atouin.getInstance().displayGrid(true);
                    Atouin.getInstance().cellOverEnabled = true;
                    _loc_6 = new GameContextReadyMessage();
                    _loc_6.initGameContextReadyMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                    ConnectionsHandler.getConnection().send(_loc_6);
                    Kernel.getWorker().resume();
                    ConnectionsHandler.resume();
                    break;
                }
                case param1 is GameFightResumeMessage:
                {
                    _loc_7 = param1 as GameFightResumeMessage;
                    this.tacticModeHandler();
                    PlayedCharacterManager.getInstance().currentSummonedCreature = _loc_7.summonCount;
                    this._battleFrame.turnsCount = _loc_7.gameTurn - 1;
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = _loc_7.gameTurn - 1;
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, (_loc_7.gameTurn - 1));
                    if (param1 is GameFightResumeWithSlavesMessage)
                    {
                        _loc_45 = param1 as GameFightResumeWithSlavesMessage;
                        _loc_8 = _loc_45.slavesInfo;
                    }
                    else
                    {
                        _loc_8 = new Vector.<GameFightResumeSlaveInfo>;
                    }
                    _loc_9 = new GameFightResumeSlaveInfo();
                    _loc_9.spellCooldowns = _loc_7.spellCooldowns;
                    _loc_9.slaveId = PlayedCharacterManager.getInstance().id;
                    _loc_8.unshift(_loc_9);
                    _loc_10 = CurrentPlayedFighterManager.getInstance();
                    _loc_11 = _loc_8.length;
                    _loc_46 = 0;
                    while (_loc_46 < _loc_11)
                    {
                        
                        _loc_47 = _loc_8[_loc_46];
                        _loc_48 = _loc_47.spellCooldowns.length;
                        _loc_49 = 0;
                        while (_loc_49 < _loc_48)
                        {
                            
                            _loc_50 = _loc_47.spellCooldowns[_loc_49];
                            _loc_51 = SpellWrapper.getFirstSpellWrapperById(_loc_50.spellId, _loc_47.slaveId);
                            if (_loc_51)
                            {
                                _loc_52 = SpellLevel.getLevelById(_loc_51.spell.spellLevels[(_loc_51.spellLevel - 1)]);
                                _loc_53 = _loc_10.getSpellCastManagerById(_loc_47.slaveId);
                                _loc_53.castSpell(_loc_51.id, _loc_51.spellLevel, [], false);
                                _loc_54 = _loc_52.minCastInterval;
                                if (_loc_50.cooldown != 63)
                                {
                                    _loc_55 = new SpellModificator();
                                    _loc_56 = PlayedCharacterManager.getInstance().characteristics;
                                    for each (_loc_57 in _loc_56.spellModifications)
                                    {
                                        
                                        if (_loc_57.spellId == _loc_50.spellId)
                                        {
                                            switch(_loc_57.modificationType)
                                            {
                                                case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                                                {
                                                    _loc_55.castInterval = _loc_57.value;
                                                    break;
                                                }
                                                case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                                                {
                                                    _loc_55.castIntervalSet = _loc_57.value;
                                                    break;
                                                }
                                                default:
                                                {
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    if (_loc_55.getTotalBonus(_loc_55.castIntervalSet))
                                    {
                                        _loc_54 = -_loc_55.getTotalBonus(_loc_55.castInterval) + _loc_55.getTotalBonus(_loc_55.castIntervalSet);
                                    }
                                    else
                                    {
                                        _loc_54 = _loc_54 - _loc_55.getTotalBonus(_loc_55.castInterval);
                                    }
                                }
                                _loc_53.getSpellManagerBySpellId(_loc_51.id).forceLastCastTurn((_loc_7.gameTurn - 1) + _loc_50.cooldown - _loc_54);
                            }
                            _loc_49++;
                        }
                        _loc_46++;
                    }
                    _loc_12 = [];
                    for each (_loc_58 in _loc_7.effects)
                    {
                        
                        if (!_loc_12[_loc_58.effect.targetId])
                        {
                            _loc_12[_loc_58.effect.targetId] = [];
                        }
                        _loc_13 = _loc_12[_loc_58.effect.targetId];
                        if (!_loc_13[_loc_58.effect.turnDuration])
                        {
                            _loc_13[_loc_58.effect.turnDuration] = [];
                        }
                        _loc_14 = _loc_13[_loc_58.effect.turnDuration];
                        _loc_15 = _loc_14[_loc_58.effect.spellId];
                        if (!_loc_15)
                        {
                            _loc_15 = new CastingSpell();
                            _loc_15.casterId = _loc_58.sourceId;
                            _loc_15.spell = Spell.getSpellById(_loc_58.effect.spellId);
                            _loc_14[_loc_58.effect.spellId] = _loc_15;
                        }
                        _loc_59 = BuffManager.makeBuffFromEffect(_loc_58.effect, _loc_15, _loc_58.actionId);
                        BuffManager.getInstance().addBuff(_loc_59);
                    }
                    for each (_loc_60 in _loc_7.marks)
                    {
                        
                        _loc_61 = Spell.getSpellById(_loc_60.markSpellId);
                        MarkedCellsManager.getInstance().addMark(_loc_60.markId, _loc_60.markType, _loc_61, _loc_60.cells);
                        if (_loc_61.getParamByName("glyphGfxId"))
                        {
                            for each (_loc_62 in _loc_60.cells)
                            {
                                
                                _loc_63 = new AddGlyphGfxStep(_loc_61.getParamByName("glyphGfxId"), _loc_62.cellId, _loc_60.markId, _loc_60.markType);
                                _loc_63.start();
                            }
                        }
                    }
                    Kernel.beingInReconection = false;
                    return true;
                }
                case param1 is GameFightUpdateTeamMessage:
                {
                    _loc_16 = param1 as GameFightUpdateTeamMessage;
                    PlayedCharacterManager.getInstance().teamId = _loc_16.team.teamId;
                    return true;
                }
                case param1 is GameFightSpectateMessage:
                {
                    _loc_17 = param1 as GameFightSpectateMessage;
                    this._battleFrame.turnsCount = _loc_17.gameTurn - 1;
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, (_loc_17.gameTurn - 1));
                    _loc_18 = [];
                    for each (_loc_64 in _loc_17.effects)
                    {
                        
                        if (!_loc_18[_loc_64.effect.targetId])
                        {
                            _loc_18[_loc_64.effect.targetId] = [];
                        }
                        _loc_19 = _loc_18[_loc_64.effect.targetId];
                        if (!_loc_19[_loc_64.effect.turnDuration])
                        {
                            _loc_19[_loc_64.effect.turnDuration] = [];
                        }
                        _loc_20 = _loc_19[_loc_64.effect.turnDuration];
                        _loc_21 = _loc_20[_loc_64.effect.spellId];
                        if (!_loc_21)
                        {
                            _loc_21 = new CastingSpell();
                            _loc_21.casterId = _loc_64.sourceId;
                            _loc_21.spell = Spell.getSpellById(_loc_64.effect.spellId);
                            _loc_20[_loc_64.effect.spellId] = _loc_21;
                        }
                        _loc_65 = BuffManager.makeBuffFromEffect(_loc_64.effect, _loc_21, _loc_64.actionId);
                        BuffManager.getInstance().addBuff(_loc_65);
                    }
                    for each (_loc_66 in _loc_17.marks)
                    {
                        
                        _loc_67 = Spell.getSpellById(_loc_66.markSpellId);
                        MarkedCellsManager.getInstance().addMark(_loc_66.markId, _loc_66.markType, _loc_67, _loc_66.cells);
                        if (_loc_67.getParamByName("glyphGfxId"))
                        {
                            for each (_loc_68 in _loc_66.cells)
                            {
                                
                                _loc_69 = new AddGlyphGfxStep(_loc_67.getParamByName("glyphGfxId"), _loc_68.cellId, _loc_66.markId, _loc_66.markType);
                                _loc_69.start();
                            }
                        }
                    }
                    FightEventsHelper.sendAllFightEvent();
                    return true;
                }
                case param1 is INetworkMessage && INetworkMessage(param1).getMessageId() == GameFightJoinMessage.protocolId:
                {
                    _loc_22 = param1 as GameFightJoinMessage;
                    preFightIsActive = !_loc_22.isFightStarted;
                    this.fightType = _loc_22.fightType;
                    Kernel.getWorker().addFrame(this._entitiesFrame);
                    if (preFightIsActive)
                    {
                        Kernel.getWorker().addFrame(this._preparationFrame);
                    }
                    else
                    {
                        Kernel.getWorker().removeFrame(this._preparationFrame);
                        Kernel.getWorker().addFrame(this._battleFrame);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                    }
                    PlayedCharacterManager.getInstance().isSpectator = _loc_22.isSpectator;
                    PlayedCharacterManager.getInstance().isFighting = true;
                    _loc_23 = _loc_22.timeMaxBeforeFightStart;
                    if (_loc_23 == 0 && preFightIsActive)
                    {
                        _loc_23 = -1;
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightJoin, _loc_22.canBeCancelled, _loc_22.canSayReady, _loc_22.isSpectator, _loc_23, _loc_22.fightType);
                    return true;
                }
                case param1 is GameActionFightCarryCharacterMessage:
                {
                    _loc_24 = param1 as GameActionFightCarryCharacterMessage;
                    if (this._lastEffectEntity && this._lastEffectEntity.object.id == _loc_24.targetId)
                    {
                        this.process(new EntityMouseOutMessage(this._lastEffectEntity.object as IInteractive));
                    }
                    return false;
                }
                case param1 is GameFightStartMessage:
                {
                    preFightIsActive = false;
                    Kernel.getWorker().removeFrame(this._preparationFrame);
                    this._entitiesFrame.removeSwords();
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().resetInitialCooldown();
                    Kernel.getWorker().addFrame(this._battleFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                    SoundManager.getInstance().manager.playFightMusic();
                    return true;
                }
                case param1 is CellOutMessage:
                {
                    _loc_25 = param1 as CellOutMessage;
                    for each (_loc_70 in EntitiesManager.getInstance().getEntitiesOnCell(_loc_25.cellId))
                    {
                        
                        if (_loc_70 is AnimatedCharacter)
                        {
                            _loc_26 = _loc_70 as AnimatedCharacter;
                            break;
                        }
                    }
                    if (_loc_26)
                    {
                        TooltipManager.hide();
                        TooltipManager.hide("fighter");
                        this.outEntity(_loc_26.id);
                    }
                    currentCell = -1;
                    return true;
                }
                case param1 is CellOverMessage:
                {
                    _loc_27 = param1 as CellOverMessage;
                    for each (_loc_71 in EntitiesManager.getInstance().getEntitiesOnCell(_loc_27.cellId))
                    {
                        
                        if (_loc_71 is AnimatedCharacter && !(_loc_71 as AnimatedCharacter).isMoving)
                        {
                            _loc_28 = _loc_71 as AnimatedCharacter;
                            break;
                        }
                    }
                    if (_loc_28)
                    {
                        this.overEntity(_loc_28.id);
                    }
                    currentCell = _loc_27.cellId;
                    return true;
                }
                case param1 is EntityMouseOverMessage:
                {
                    _loc_29 = param1 as EntityMouseOverMessage;
                    currentCell = _loc_29.entity.position.cellId;
                    this.overEntity(_loc_29.entity.id);
                    return true;
                }
                case param1 is EntityMouseOutMessage:
                {
                    _loc_30 = param1 as EntityMouseOutMessage;
                    TooltipManager.hide();
                    TooltipManager.hide("fighter");
                    currentCell = -1;
                    this.outEntity(_loc_30.entity.id);
                    return true;
                }
                case param1 is TimelineEntityOverAction:
                {
                    _loc_31 = param1 as TimelineEntityOverAction;
                    this.overEntity(_loc_31.targetId, _loc_31.showRange);
                    timelineOverEntityId = _loc_31.targetId;
                    return true;
                }
                case param1 is TimelineEntityOutAction:
                {
                    TooltipManager.hideAll();
                    this.outEntity(TimelineEntityOutAction(param1).targetId);
                    timelineOverEntityId = 0;
                    return true;
                }
                case param1 is TogglePointCellAction:
                {
                    _loc_32 = param1 as TogglePointCellAction;
                    if (Kernel.getWorker().contains(FightPointCellFrame))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
                        Kernel.getWorker().removeFrame(this._pointCellFrame);
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(this._pointCellFrame);
                    }
                    return true;
                }
                case param1 is GameFightEndMessage:
                {
                    _loc_33 = param1 as GameFightEndMessage;
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide(true);
                    }
                    if (this._entitiesFrame.isInCreaturesFightMode())
                    {
                        this._entitiesFrame.showCreaturesInFight(false);
                    }
                    TooltipManager.hide();
                    TooltipManager.hide("fighter");
                    this.hideMovementRange();
                    CurrentPlayedFighterManager.getInstance().resetPlayerSpellList();
                    MapDisplayManager.getInstance().activeIdentifiedElements(true);
                    FightEventsHelper.sendAllFightEvent(true);
                    FightEventsHelper.sendFightEvent(FightEventEnum.FIGHT_END, [], 0, -1, true);
                    SoundManager.getInstance().manager.stopFightMusic();
                    PlayedCharacterManager.getInstance().isFighting = false;
                    SpellWrapper.removeAllSpellWrapperBut(PlayedCharacterManager.getInstance().id, SecureCenter.ACCESS_KEY);
                    SpellWrapper.resetAllCoolDown(PlayedCharacterManager.getInstance().id, SecureCenter.ACCESS_KEY);
                    if (_loc_33.results == null)
                    {
                        KernelEventsManager.getInstance().processCallback(FightHookList.SpectatorWantLeave);
                    }
                    else
                    {
                        _loc_72 = new FightEndingMessage();
                        _loc_72.initFightEndingMessage();
                        Kernel.getWorker().process(_loc_72);
                        _loc_73 = new Vector.<FightResultEntryWrapper>;
                        _loc_74 = 0;
                        _loc_76 = new Vector.<FightResultEntryWrapper>;
                        for each (_loc_77 in _loc_33.results)
                        {
                            
                            switch(true)
                            {
                                case _loc_77 is FightResultPlayerListEntry:
                                {
                                    _loc_79 = new FightResultEntryWrapper(_loc_77, this._entitiesFrame.getEntityInfos((_loc_77 as FightResultPlayerListEntry).id) as GameFightFighterInformations);
                                    _loc_79.alive = FightResultPlayerListEntry(_loc_77).alive;
                                    break;
                                }
                                case _loc_77 is FightResultTaxCollectorListEntry:
                                {
                                    _loc_79 = new FightResultEntryWrapper(_loc_77, this._entitiesFrame.getEntityInfos((_loc_77 as FightResultTaxCollectorListEntry).id) as GameFightFighterInformations);
                                    _loc_79.alive = FightResultTaxCollectorListEntry(_loc_77).alive;
                                    break;
                                }
                                case _loc_77 is FightResultFighterListEntry:
                                {
                                    _loc_79 = new FightResultEntryWrapper(_loc_77, this._entitiesFrame.getEntityInfos((_loc_77 as FightResultFighterListEntry).id) as GameFightFighterInformations);
                                    _loc_79.alive = FightResultFighterListEntry(_loc_77).alive;
                                    break;
                                }
                                case _loc_77 is FightResultListEntry:
                                {
                                    _loc_79 = new FightResultEntryWrapper(_loc_77);
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            if (_loc_77.outcome == FightOutcomeEnum.RESULT_DEFENDER_GROUP)
                            {
                                _loc_75 = _loc_79;
                            }
                            else
                            {
                                if (_loc_77.outcome == FightOutcomeEnum.RESULT_VICTORY)
                                {
                                    _loc_76.push(_loc_79);
                                }
                                _loc_73[++_loc_74] = _loc_79;
                            }
                            if (_loc_79.id == PlayedCharacterManager.getInstance().infos.id)
                            {
                                switch(_loc_77.outcome)
                                {
                                    case FightOutcomeEnum.RESULT_VICTORY:
                                    {
                                        KernelEventsManager.getInstance().processCallback(TriggerHookList.FightResultVictory);
                                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_FIGHT_WON);
                                        break;
                                    }
                                    case FightOutcomeEnum.RESULT_LOST:
                                    {
                                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_FIGHT_LOST);
                                        break;
                                    }
                                    default:
                                    {
                                        break;
                                    }
                                }
                                if (_loc_79.rewards.objects.length >= SpeakingItemManager.GREAT_DROP_LIMIT)
                                {
                                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_GREAT_DROP);
                                }
                            }
                        }
                        if (_loc_75)
                        {
                            _loc_80 = 0;
                            for each (_loc_81 in _loc_75.rewards.objects)
                            {
                                
                                _loc_76[_loc_80].rewards.objects.push(_loc_81);
                                ++_loc_80 = ++_loc_80 % _loc_76.length;
                            }
                            _loc_82 = _loc_75.rewards.kamas;
                            _loc_83 = _loc_82 / _loc_76.length;
                            if (_loc_82 % _loc_76.length != 0)
                            {
                                _loc_83++;
                            }
                            for each (_loc_84 in _loc_76)
                            {
                                
                                if (_loc_82 < _loc_83)
                                {
                                    _loc_84.rewards.kamas = _loc_82;
                                }
                                else
                                {
                                    _loc_84.rewards.kamas = _loc_83;
                                }
                                _loc_82 = _loc_82 - _loc_84.rewards.kamas;
                            }
                        }
                        _loc_78 = new Object();
                        _loc_78.results = _loc_73;
                        _loc_78.ageBonus = _loc_33.ageBonus;
                        _loc_78.duration = _loc_33.duration;
                        _loc_78.challenges = this.challengesList;
                        _loc_78.turns = this._battleFrame.turnsCount;
                        _loc_78.fightType = this._fightType;
                        _log.debug("Sending the GameFightEnd hook. " + this._battleFrame.turnsCount);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightEnd, _loc_78);
                    }
                    Kernel.getWorker().removeFrame(this);
                    return true;
                }
                case param1 is ChallengeTargetsListRequestAction:
                {
                    _loc_34 = param1 as ChallengeTargetsListRequestAction;
                    _loc_35 = new ChallengeTargetsListRequestMessage();
                    _loc_35.initChallengeTargetsListRequestMessage(_loc_34.challengeId);
                    ConnectionsHandler.getConnection().send(_loc_35);
                    return true;
                }
                case param1 is ChallengeTargetsListMessage:
                {
                    _loc_36 = param1 as ChallengeTargetsListMessage;
                    for each (_loc_85 in _loc_36.targetCells)
                    {
                        
                        if (_loc_85 != -1)
                        {
                            HyperlinkShowCellManager.showCell(_loc_85);
                        }
                    }
                    return true;
                }
                case param1 is ChallengeInfoMessage:
                {
                    _loc_37 = param1 as ChallengeInfoMessage;
                    _loc_38 = this.getChallengeById(_loc_37.challengeId);
                    if (!_loc_38)
                    {
                        _loc_38 = new ChallengeWrapper();
                        this.challengesList.push(_loc_38);
                    }
                    _loc_38.id = _loc_37.challengeId;
                    _loc_38.targetId = _loc_37.targetId;
                    _loc_38.baseXpBonus = _loc_37.baseXpBonus;
                    _loc_38.extraXpBonus = _loc_37.extraXpBonus;
                    _loc_38.baseDropBonus = _loc_37.baseDropBonus;
                    _loc_38.extraDropBonus = _loc_37.extraDropBonus;
                    _loc_38.result = 0;
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return true;
                }
                case param1 is ChallengeTargetUpdateMessage:
                {
                    _loc_39 = param1 as ChallengeTargetUpdateMessage;
                    _loc_38 = this.getChallengeById(_loc_39.challengeId);
                    if (_loc_38 == null)
                    {
                        _log.warn("Got a challenge result with no corresponding challenge (challenge id " + _loc_39.challengeId + "), skipping.");
                        return false;
                    }
                    _loc_38.targetId = _loc_39.targetId;
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return true;
                }
                case param1 is ChallengeResultMessage:
                {
                    _loc_40 = param1 as ChallengeResultMessage;
                    _loc_38 = this.getChallengeById(_loc_40.challengeId);
                    if (!_loc_38)
                    {
                        _log.warn("Got a challenge result with no corresponding challenge (challenge id " + _loc_40.challengeId + "), skipping.");
                        return false;
                    }
                    _loc_38.result = _loc_40.success ? (1) : (2);
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return true;
                }
                case param1 is MapObstacleUpdateMessage:
                {
                    _loc_41 = param1 as MapObstacleUpdateMessage;
                    for each (_loc_86 in _loc_41.obstacles)
                    {
                        
                        InteractiveCellManager.getInstance().updateCell(_loc_86.obstacleCellId, _loc_86.state == MapObstacleStateEnum.OBSTACLE_OPENED);
                    }
                    return true;
                }
                case param1 is GameActionFightNoSpellCastMessage:
                {
                    _loc_42 = param1 as GameActionFightNoSpellCastMessage;
                    if (_loc_42.spellLevelId != 0 || !PlayedCharacterManager.getInstance().currentWeapon)
                    {
                        if (_loc_42.spellLevelId == 0)
                        {
                            _loc_88 = Spell.getSpellById(0).spellLevels[0];
                            _loc_87 = SpellLevel.getLevelById(_loc_88);
                        }
                        else
                        {
                            _loc_87 = SpellLevel.getLevelById(_loc_42.spellLevelId);
                        }
                        _loc_43 = _loc_87.apCost;
                    }
                    else
                    {
                        _loc_43 = PlayedCharacterManager.getInstance().currentWeapon.apCost;
                    }
                    CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent + _loc_43;
                    return true;
                }
                case param1 is ShowTacticModeAction:
                {
                    if (PlayedCharacterApi.isInPreFight() || PlayedCharacterApi.isInFight())
                    {
                        this.tacticModeHandler(true);
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

        public function pulled() : Boolean
        {
            if (TacticModeManager.getInstance().tacticModeActivated)
            {
                TacticModeManager.getInstance().hide(true);
            }
            if (this._entitiesFrame)
            {
                Kernel.getWorker().removeFrame(this._entitiesFrame);
            }
            if (this._preparationFrame)
            {
                Kernel.getWorker().removeFrame(this._preparationFrame);
            }
            if (this._battleFrame)
            {
                Kernel.getWorker().removeFrame(this._battleFrame);
            }
            if (this._pointCellFrame)
            {
                Kernel.getWorker().removeFrame(this._pointCellFrame);
            }
            SerialSequencer.clearByType(FightSequenceFrame.FIGHT_SEQUENCERS_CATEGORY);
            this._preparationFrame = null;
            this._battleFrame = null;
            this._pointCellFrame = null;
            this._lastEffectEntity = null;
            TooltipManager.hideAll();
            this._timerFighterInfo.reset();
            this._timerFighterInfo.removeEventListener(TimerEvent.TIMER, this.showFighterInfo);
            this._timerFighterInfo = null;
            this._timerMovementRange.reset();
            this._timerMovementRange.removeEventListener(TimerEvent.TIMER, this.showMovementRange);
            this._timerMovementRange = null;
            this._currentFighterInfo = null;
            if (MapDisplayManager.getInstance().getDataMapContainer())
            {
                MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(true);
            }
            Atouin.getInstance().displayGrid(false);
            return true;
        }// end function

        public function outEntity(param1:int) : void
        {
            this._timerFighterInfo.reset();
            this._timerMovementRange.reset();
            var _loc_2:* = this._entitiesFrame.getEntitiesIdsList();
            fighterEntityTooltipId = param1;
            var _loc_3:* = DofusEntities.getEntity(fighterEntityTooltipId);
            if (!_loc_3)
            {
                if (_loc_2.indexOf(fighterEntityTooltipId) == -1)
                {
                    _log.warn("Mouse over an unknown entity : " + param1);
                    return;
                }
            }
            if (this._lastEffectEntity && this._lastEffectEntity.object)
            {
                Sprite(this._lastEffectEntity.object).filters = [];
            }
            this._lastEffectEntity = null;
            TooltipManager.hideAll();
            if (_loc_3 != null)
            {
                Sprite(_loc_3).filters = [];
            }
            this.hideMovementRange();
            var _loc_4:* = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
            if (SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION))
            {
                _loc_4.remove();
            }
            this.removeAsLinkEntityEffect();
            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, null);
            return;
        }// end function

        private function getFighterInfos(param1:int) : GameFightFighterInformations
        {
            return this.entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
        }// end function

        private function showFighterInfo(event:TimerEvent) : void
        {
            this._timerFighterInfo.reset();
            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, this._currentFighterInfo);
            return;
        }// end function

        private function showMovementRange(event:TimerEvent) : void
        {
            this._timerMovementRange.reset();
            this._reachableRangeSelection = new Selection();
            this._reachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._reachableRangeSelection.color = new Color(52326);
            this._unreachableRangeSelection = new Selection();
            this._unreachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._unreachableRangeSelection.color = new Color(6684672);
            var _loc_2:* = getTimer();
            var _loc_3:* = new FightReachableCellsMaker(this._currentFighterInfo);
            this._reachableRangeSelection.zone = new Custom(_loc_3.reachableCells);
            this._unreachableRangeSelection.zone = new Custom(_loc_3.unreachableCells);
            SelectionManager.getInstance().addSelection(this._reachableRangeSelection, "movementReachableRange", this._currentFighterInfo.disposition.cellId);
            SelectionManager.getInstance().addSelection(this._unreachableRangeSelection, "movementUnreachableRange", this._currentFighterInfo.disposition.cellId);
            return;
        }// end function

        private function hideMovementRange() : void
        {
            var _loc_1:* = SelectionManager.getInstance().getSelection("movementReachableRange");
            if (_loc_1)
            {
                _loc_1.remove();
                this._reachableRangeSelection = null;
            }
            _loc_1 = SelectionManager.getInstance().getSelection("movementUnreachableRange");
            if (_loc_1)
            {
                _loc_1.remove();
                this._unreachableRangeSelection = null;
            }
            return;
        }// end function

        private function removeAsLinkEntityEffect() : void
        {
            var _loc_1:int = 0;
            var _loc_2:DisplayObject = null;
            var _loc_3:int = 0;
            for each (_loc_1 in this._entitiesFrame.getEntitiesIdsList())
            {
                
                _loc_2 = DofusEntities.getEntity(_loc_1) as DisplayObject;
                if (_loc_2 && _loc_2.filters && _loc_2.filters.length)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2.filters.length)
                    {
                        
                        if (_loc_2.filters[_loc_3] is ColorMatrixFilter)
                        {
                            _loc_2.filters = _loc_2.filters.splice(_loc_3, _loc_3);
                            break;
                        }
                        _loc_3++;
                    }
                }
            }
            return;
        }// end function

        private function highlightAsLinkedEntity(param1:int, param2:Boolean) : void
        {
            var _loc_5:ColorMatrixFilter = null;
            var _loc_3:* = DofusEntities.getEntity(param1);
            if (!_loc_3)
            {
                return;
            }
            var _loc_4:* = _loc_3 as Sprite;
            if (_loc_3 as Sprite && Dofus.getInstance().options.showGlowOverTarget)
            {
                _loc_5 = param2 ? (this._linkedMainEffect) : (this._linkedEffect);
                if (_loc_4.filters.length)
                {
                    if (_loc_4.filters[0] != _loc_5)
                    {
                        _loc_4.filters = [_loc_5];
                    }
                }
                else
                {
                    _loc_4.filters = [_loc_5];
                }
            }
            return;
        }// end function

        private function overEntity(param1:int, param2:Boolean = true) : void
        {
            var _loc_7:int = 0;
            var _loc_10:GameFightFighterInformations = null;
            var _loc_11:Selection = null;
            var _loc_12:int = 0;
            var _loc_13:FightSpellCastFrame = null;
            var _loc_14:GlowFilter = null;
            var _loc_15:FightTurnFrame = null;
            var _loc_16:Boolean = false;
            var _loc_3:* = this._entitiesFrame.getEntitiesIdsList();
            fighterEntityTooltipId = param1;
            var _loc_4:* = DofusEntities.getEntity(fighterEntityTooltipId);
            if (!DofusEntities.getEntity(fighterEntityTooltipId))
            {
                if (_loc_3.indexOf(fighterEntityTooltipId) == -1)
                {
                    _log.warn("Mouse over an unknown entity : " + param1);
                    return;
                }
                param2 = false;
            }
            var _loc_5:* = this._entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
            if (!(this._entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations))
            {
                _log.warn("Mouse over an unknown entity : " + param1);
                return;
            }
            var _loc_6:* = _loc_5.stats.summoner;
            for each (_loc_7 in _loc_3)
            {
                
                if (_loc_7 != param1)
                {
                    _loc_10 = this._entitiesFrame.getEntityInfos(_loc_7) as GameFightFighterInformations;
                    if (_loc_10.stats.summoner == param1 || _loc_6 == _loc_7 || _loc_10.stats.summoner == _loc_6 && _loc_6)
                    {
                        this.highlightAsLinkedEntity(_loc_7, _loc_6 == _loc_7);
                    }
                }
            }
            this._currentFighterInfo = _loc_5;
            if (Dofus.getInstance().options.showEntityInfos)
            {
                this._timerFighterInfo.reset();
                this._timerFighterInfo.start();
            }
            if (_loc_5.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
            {
                _log.warn("Mouse over an invisible entity.");
                _loc_11 = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
                if (!_loc_11)
                {
                    _loc_11 = new Selection();
                    _loc_11.color = new Color(52326);
                    _loc_11.renderer = new ZoneDARenderer();
                    _loc_11.zone = new Lozenge(0, 0, DataMapProvider.getInstance());
                    SelectionManager.getInstance().addSelection(_loc_11, this.INVISIBLE_POSITION_SELECTION);
                }
                _loc_12 = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityPosition(_loc_5.contextualId);
                if (_loc_12 > -1)
                {
                    SelectionManager.getInstance().update(this.INVISIBLE_POSITION_SELECTION, _loc_12);
                }
                return;
            }
            if (_loc_5 is GameFightCharacterInformations && _loc_4 != null)
            {
                TooltipManager.show(_loc_5, (_loc_4 as IDisplayable).absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, "tooltipOverEntity_" + _loc_5.contextualId, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, null, "PlayerShortInfos");
            }
            else if (_loc_4 != null)
            {
                TooltipManager.show(_loc_5, (_loc_4 as IDisplayable).absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, "tooltipOverEntity_" + _loc_5.contextualId, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, "monsterFighter", null, null, "EntityShortInfos");
            }
            var _loc_8:* = SelectionManager.getInstance().getSelection(FightTurnFrame.SELECTION_PATH);
            if (SelectionManager.getInstance().getSelection(FightTurnFrame.SELECTION_PATH))
            {
                _loc_8.remove();
            }
            if (param2)
            {
                if (Dofus.getInstance().options.showMovementRange && Kernel.getWorker().contains(FightBattleFrame) && !Kernel.getWorker().contains(FightSpellCastFrame))
                {
                    this._timerMovementRange.reset();
                    this._timerMovementRange.start();
                }
            }
            if (this._lastEffectEntity && this._lastEffectEntity.object is Sprite && this._lastEffectEntity.object != _loc_4)
            {
                Sprite(this._lastEffectEntity.object).filters = [];
            }
            var _loc_9:* = _loc_4 as Sprite;
            if (_loc_4 as Sprite && Dofus.getInstance().options.showGlowOverTarget)
            {
                _loc_13 = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
                _loc_15 = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
                _loc_16 = _loc_15 ? (_loc_15.myTurn) : (true);
                if ((!_loc_13 || _loc_13 && _loc_13.currentTargetIsTargetable) && _loc_16)
                {
                    _loc_14 = this._overEffectOk;
                }
                else
                {
                    _loc_14 = this._overEffectKo;
                }
                if (_loc_9.filters.length)
                {
                    if (_loc_9.filters[0] != _loc_14)
                    {
                        _loc_9.filters = [_loc_14];
                    }
                }
                else
                {
                    _loc_9.filters = [_loc_14];
                }
                this._lastEffectEntity = new WeakReference(_loc_4);
            }
            return;
        }// end function

        private function tacticModeHandler(param1:Boolean = false) : void
        {
            if (param1 && !TacticModeManager.getInstance().tacticModeActivated)
            {
                TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
            }
            else if (TacticModeManager.getInstance().tacticModeActivated)
            {
                TacticModeManager.getInstance().hide();
            }
            return;
        }// end function

    }
}
