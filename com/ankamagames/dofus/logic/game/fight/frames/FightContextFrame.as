package com.ankamagames.dofus.logic.game.fight.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
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
            var _loc_2:* = null;
            var _loc_3:* = null;
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
            var _loc_2:* = null;
            var _loc_3:* = null;
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
            var _loc_2:* = null;
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
            var _loc_2:* = null;
            var _loc_3:* = null;
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
            var _loc_24:* = 0;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
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
            var _loc_44:* = 0;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = 0;
            var _loc_48:* = null;
            var _loc_49:* = 0;
            var _loc_50:* = 0;
            var _loc_51:* = null;
            var _loc_52:* = null;
            var _loc_53:* = null;
            var _loc_54:* = null;
            var _loc_55:* = 0;
            var _loc_56:* = null;
            var _loc_57:* = null;
            var _loc_58:* = null;
            var _loc_59:* = null;
            var _loc_60:* = null;
            var _loc_61:* = null;
            var _loc_62:* = null;
            var _loc_63:* = null;
            var _loc_64:* = null;
            var _loc_65:* = null;
            var _loc_66:* = null;
            var _loc_67:* = null;
            var _loc_68:* = null;
            var _loc_69:* = null;
            var _loc_70:* = null;
            var _loc_71:* = null;
            var _loc_72:* = null;
            var _loc_73:* = null;
            var _loc_74:* = null;
            var _loc_75:* = 0;
            var _loc_76:* = null;
            var _loc_77:* = null;
            var _loc_78:* = null;
            var _loc_79:* = null;
            var _loc_80:* = null;
            var _loc_81:* = 0;
            var _loc_82:* = null;
            var _loc_83:* = 0;
            var _loc_84:* = 0;
            var _loc_85:* = null;
            var _loc_86:* = NaN;
            var _loc_87:* = null;
            var _loc_88:* = null;
            var _loc_89:* = 0;
            switch(true)
            {
                case param1 is MapLoadedMessage:
                {
                    MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
                    _loc_2 = new MapInformationsRequestMessage();
                    _loc_2.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                    ConnectionsHandler.getConnection().send(_loc_2);
                    return false;
                }
                case param1 is GameFightStartingMessage:
                {
                    _loc_3 = param1 as GameFightStartingMessage;
                    TooltipManager.hideAll();
                    Atouin.getInstance().cancelZoom();
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    MapDisplayManager.getInstance().activeIdentifiedElements(false);
                    FightEventsHelper.reset();
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightStarting, _loc_3.fightType);
                    this.fightType = _loc_3.fightType;
                    CurrentPlayedFighterManager.getInstance().currentFighterId = PlayedCharacterManager.getInstance().id;
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = 0;
                    SoundManager.getInstance().manager.prepareFightMusic();
                    SoundManager.getInstance().manager.playUISound(UISoundEnum.INTRO_FIGHT);
                    return true;
                }
                case param1 is CurrentMapMessage:
                {
                    _loc_4 = param1 as CurrentMapMessage;
                    ConnectionsHandler.pause();
                    Kernel.getWorker().pause();
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide();
                    }
                    _loc_5 = new WorldPointWrapper(_loc_4.mapId);
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    Atouin.getInstance().initPreDisplay(_loc_5);
                    Atouin.getInstance().clearEntities();
                    if (_loc_4.mapKey && _loc_4.mapKey.length)
                    {
                        _loc_45 = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                        if (!_loc_45)
                        {
                            _loc_45 = _loc_4.mapKey;
                        }
                        _loc_6 = Hex.toArray(Hex.fromString(_loc_45));
                    }
                    this._currentMapRenderId = Atouin.getInstance().display(_loc_5, _loc_6);
                    _log.info("Ask map render for fight #" + this._currentMapRenderId);
                    PlayedCharacterManager.getInstance().currentMap = _loc_5;
                    KernelEventsManager.getInstance().processCallback(HookList.CurrentMap, _loc_4.mapId);
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
                    _loc_7 = new GameContextReadyMessage();
                    _loc_7.initGameContextReadyMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                    ConnectionsHandler.getConnection().send(_loc_7);
                    Kernel.getWorker().resume();
                    ConnectionsHandler.resume();
                    break;
                }
                case param1 is GameFightResumeMessage:
                {
                    _loc_8 = param1 as GameFightResumeMessage;
                    this.tacticModeHandler();
                    PlayedCharacterManager.getInstance().currentSummonedCreature = _loc_8.summonCount;
                    this._battleFrame.turnsCount = _loc_8.gameTurn - 1;
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = _loc_8.gameTurn - 1;
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, (_loc_8.gameTurn - 1));
                    if (param1 is GameFightResumeWithSlavesMessage)
                    {
                        _loc_46 = param1 as GameFightResumeWithSlavesMessage;
                        _loc_9 = _loc_46.slavesInfo;
                    }
                    else
                    {
                        _loc_9 = new Vector.<GameFightResumeSlaveInfo>;
                    }
                    _loc_10 = new GameFightResumeSlaveInfo();
                    _loc_10.spellCooldowns = _loc_8.spellCooldowns;
                    _loc_10.slaveId = PlayedCharacterManager.getInstance().id;
                    _loc_9.unshift(_loc_10);
                    _loc_11 = CurrentPlayedFighterManager.getInstance();
                    _loc_12 = _loc_9.length;
                    _loc_47 = 0;
                    while (_loc_47 < _loc_12)
                    {
                        
                        _loc_48 = _loc_9[_loc_47];
                        _loc_49 = _loc_48.spellCooldowns.length;
                        _loc_50 = 0;
                        while (_loc_50 < _loc_49)
                        {
                            
                            _loc_51 = _loc_48.spellCooldowns[_loc_50];
                            _loc_52 = SpellWrapper.getFirstSpellWrapperById(_loc_51.spellId, _loc_48.slaveId);
                            if (_loc_52)
                            {
                                _loc_53 = SpellLevel.getLevelById(_loc_52.spell.spellLevels[(_loc_52.spellLevel - 1)]);
                                _loc_54 = _loc_11.getSpellCastManagerById(_loc_48.slaveId);
                                _loc_54.castSpell(_loc_52.id, _loc_52.spellLevel, [], false);
                                _loc_55 = _loc_53.minCastInterval;
                                if (_loc_51.cooldown != 63)
                                {
                                    _loc_56 = new SpellModificator();
                                    _loc_57 = PlayedCharacterManager.getInstance().characteristics;
                                    for each (_loc_58 in _loc_57.spellModifications)
                                    {
                                        
                                        if (_loc_58.spellId == _loc_51.spellId)
                                        {
                                            switch(_loc_58.modificationType)
                                            {
                                                case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                                                {
                                                    _loc_56.castInterval = _loc_58.value;
                                                    break;
                                                }
                                                case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                                                {
                                                    _loc_56.castIntervalSet = _loc_58.value;
                                                    break;
                                                }
                                                default:
                                                {
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    if (_loc_56.getTotalBonus(_loc_56.castIntervalSet))
                                    {
                                        _loc_55 = -_loc_56.getTotalBonus(_loc_56.castInterval) + _loc_56.getTotalBonus(_loc_56.castIntervalSet);
                                    }
                                    else
                                    {
                                        _loc_55 = _loc_55 - _loc_56.getTotalBonus(_loc_56.castInterval);
                                    }
                                }
                                _loc_54.getSpellManagerBySpellId(_loc_52.id).forceLastCastTurn((_loc_8.gameTurn - 1) + _loc_51.cooldown - _loc_55);
                            }
                            _loc_50++;
                        }
                        _loc_47++;
                    }
                    _loc_13 = [];
                    for each (_loc_59 in _loc_8.effects)
                    {
                        
                        if (!_loc_13[_loc_59.effect.targetId])
                        {
                            _loc_13[_loc_59.effect.targetId] = [];
                        }
                        _loc_14 = _loc_13[_loc_59.effect.targetId];
                        if (!_loc_14[_loc_59.effect.turnDuration])
                        {
                            _loc_14[_loc_59.effect.turnDuration] = [];
                        }
                        _loc_15 = _loc_14[_loc_59.effect.turnDuration];
                        _loc_16 = _loc_15[_loc_59.effect.spellId];
                        if (!_loc_16)
                        {
                            _loc_16 = new CastingSpell();
                            _loc_16.casterId = _loc_59.sourceId;
                            _loc_16.spell = Spell.getSpellById(_loc_59.effect.spellId);
                            _loc_15[_loc_59.effect.spellId] = _loc_16;
                        }
                        _loc_60 = BuffManager.makeBuffFromEffect(_loc_59.effect, _loc_16, _loc_59.actionId);
                        BuffManager.getInstance().addBuff(_loc_60);
                    }
                    for each (_loc_61 in _loc_8.marks)
                    {
                        
                        _loc_62 = Spell.getSpellById(_loc_61.markSpellId);
                        MarkedCellsManager.getInstance().addMark(_loc_61.markId, _loc_61.markType, _loc_62, _loc_61.cells);
                        if (_loc_62.getParamByName("glyphGfxId"))
                        {
                            for each (_loc_63 in _loc_61.cells)
                            {
                                
                                _loc_64 = new AddGlyphGfxStep(_loc_62.getParamByName("glyphGfxId"), _loc_63.cellId, _loc_61.markId, _loc_61.markType);
                                _loc_64.start();
                            }
                        }
                    }
                    Kernel.beingInReconection = false;
                    return true;
                }
                case param1 is GameFightUpdateTeamMessage:
                {
                    _loc_17 = param1 as GameFightUpdateTeamMessage;
                    PlayedCharacterManager.getInstance().teamId = _loc_17.team.teamId;
                    return true;
                }
                case param1 is GameFightSpectateMessage:
                {
                    _loc_18 = param1 as GameFightSpectateMessage;
                    this.tacticModeHandler();
                    this._battleFrame.turnsCount = _loc_18.gameTurn - 1;
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, (_loc_18.gameTurn - 1));
                    _loc_19 = [];
                    for each (_loc_65 in _loc_18.effects)
                    {
                        
                        if (!_loc_19[_loc_65.effect.targetId])
                        {
                            _loc_19[_loc_65.effect.targetId] = [];
                        }
                        _loc_20 = _loc_19[_loc_65.effect.targetId];
                        if (!_loc_20[_loc_65.effect.turnDuration])
                        {
                            _loc_20[_loc_65.effect.turnDuration] = [];
                        }
                        _loc_21 = _loc_20[_loc_65.effect.turnDuration];
                        _loc_22 = _loc_21[_loc_65.effect.spellId];
                        if (!_loc_22)
                        {
                            _loc_22 = new CastingSpell();
                            _loc_22.casterId = _loc_65.sourceId;
                            _loc_22.spell = Spell.getSpellById(_loc_65.effect.spellId);
                            _loc_21[_loc_65.effect.spellId] = _loc_22;
                        }
                        _loc_66 = BuffManager.makeBuffFromEffect(_loc_65.effect, _loc_22, _loc_65.actionId);
                        BuffManager.getInstance().addBuff(_loc_66);
                    }
                    for each (_loc_67 in _loc_18.marks)
                    {
                        
                        _loc_68 = Spell.getSpellById(_loc_67.markSpellId);
                        MarkedCellsManager.getInstance().addMark(_loc_67.markId, _loc_67.markType, _loc_68, _loc_67.cells);
                        if (_loc_68.getParamByName("glyphGfxId"))
                        {
                            for each (_loc_69 in _loc_67.cells)
                            {
                                
                                _loc_70 = new AddGlyphGfxStep(_loc_68.getParamByName("glyphGfxId"), _loc_69.cellId, _loc_67.markId, _loc_67.markType);
                                _loc_70.start();
                            }
                        }
                    }
                    FightEventsHelper.sendAllFightEvent();
                    return true;
                }
                case param1 is INetworkMessage && INetworkMessage(param1).getMessageId() == GameFightJoinMessage.protocolId:
                {
                    _loc_23 = param1 as GameFightJoinMessage;
                    preFightIsActive = !_loc_23.isFightStarted;
                    this.fightType = _loc_23.fightType;
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
                    PlayedCharacterManager.getInstance().isSpectator = _loc_23.isSpectator;
                    PlayedCharacterManager.getInstance().isFighting = true;
                    _loc_24 = _loc_23.timeMaxBeforeFightStart;
                    if (_loc_24 == 0 && preFightIsActive)
                    {
                        _loc_24 = -1;
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightJoin, _loc_23.canBeCancelled, _loc_23.canSayReady, _loc_23.isSpectator, _loc_24, _loc_23.fightType);
                    return true;
                }
                case param1 is GameActionFightCarryCharacterMessage:
                {
                    _loc_25 = param1 as GameActionFightCarryCharacterMessage;
                    if (this._lastEffectEntity && this._lastEffectEntity.object.id == _loc_25.targetId)
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
                    _loc_26 = param1 as CellOutMessage;
                    for each (_loc_71 in EntitiesManager.getInstance().getEntitiesOnCell(_loc_26.cellId))
                    {
                        
                        if (_loc_71 is AnimatedCharacter)
                        {
                            _loc_27 = _loc_71 as AnimatedCharacter;
                            break;
                        }
                    }
                    if (_loc_27)
                    {
                        TooltipManager.hide();
                        TooltipManager.hide("fighter");
                        this.outEntity(_loc_27.id);
                    }
                    currentCell = -1;
                    return true;
                }
                case param1 is CellOverMessage:
                {
                    _loc_28 = param1 as CellOverMessage;
                    for each (_loc_72 in EntitiesManager.getInstance().getEntitiesOnCell(_loc_28.cellId))
                    {
                        
                        if (_loc_72 is AnimatedCharacter && !(_loc_72 as AnimatedCharacter).isMoving)
                        {
                            _loc_29 = _loc_72 as AnimatedCharacter;
                            break;
                        }
                    }
                    if (_loc_29)
                    {
                        this.overEntity(_loc_29.id);
                    }
                    currentCell = _loc_28.cellId;
                    return true;
                }
                case param1 is EntityMouseOverMessage:
                {
                    _loc_30 = param1 as EntityMouseOverMessage;
                    currentCell = _loc_30.entity.position.cellId;
                    this.overEntity(_loc_30.entity.id);
                    return true;
                }
                case param1 is EntityMouseOutMessage:
                {
                    _loc_31 = param1 as EntityMouseOutMessage;
                    TooltipManager.hide();
                    TooltipManager.hide("fighter");
                    currentCell = -1;
                    this.outEntity(_loc_31.entity.id);
                    return true;
                }
                case param1 is TimelineEntityOverAction:
                {
                    _loc_32 = param1 as TimelineEntityOverAction;
                    this.overEntity(_loc_32.targetId, _loc_32.showRange);
                    timelineOverEntityId = _loc_32.targetId;
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
                    _loc_33 = param1 as TogglePointCellAction;
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
                    _loc_34 = param1 as GameFightEndMessage;
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
                    if (_loc_34.results == null)
                    {
                        KernelEventsManager.getInstance().processCallback(FightHookList.SpectatorWantLeave);
                    }
                    else
                    {
                        _loc_73 = new FightEndingMessage();
                        _loc_73.initFightEndingMessage();
                        Kernel.getWorker().process(_loc_73);
                        _loc_74 = new Vector.<FightResultEntryWrapper>;
                        _loc_75 = 0;
                        _loc_77 = new Vector.<FightResultEntryWrapper>;
                        for each (_loc_78 in _loc_34.results)
                        {
                            
                            switch(true)
                            {
                                case _loc_78 is FightResultPlayerListEntry:
                                {
                                    _loc_80 = new FightResultEntryWrapper(_loc_78, this._entitiesFrame.getEntityInfos((_loc_78 as FightResultPlayerListEntry).id) as GameFightFighterInformations);
                                    _loc_80.alive = FightResultPlayerListEntry(_loc_78).alive;
                                    break;
                                }
                                case _loc_78 is FightResultTaxCollectorListEntry:
                                {
                                    _loc_80 = new FightResultEntryWrapper(_loc_78, this._entitiesFrame.getEntityInfos((_loc_78 as FightResultTaxCollectorListEntry).id) as GameFightFighterInformations);
                                    _loc_80.alive = FightResultTaxCollectorListEntry(_loc_78).alive;
                                    break;
                                }
                                case _loc_78 is FightResultFighterListEntry:
                                {
                                    _loc_80 = new FightResultEntryWrapper(_loc_78, this._entitiesFrame.getEntityInfos((_loc_78 as FightResultFighterListEntry).id) as GameFightFighterInformations);
                                    _loc_80.alive = FightResultFighterListEntry(_loc_78).alive;
                                    break;
                                }
                                case _loc_78 is FightResultListEntry:
                                {
                                    _loc_80 = new FightResultEntryWrapper(_loc_78);
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            if (_loc_78.outcome == FightOutcomeEnum.RESULT_DEFENDER_GROUP)
                            {
                                _loc_76 = _loc_80;
                            }
                            else
                            {
                                if (_loc_78.outcome == FightOutcomeEnum.RESULT_VICTORY)
                                {
                                    _loc_77.push(_loc_80);
                                }
                                _loc_74[++_loc_75] = _loc_80;
                            }
                            if (_loc_80.id == PlayedCharacterManager.getInstance().infos.id)
                            {
                                switch(_loc_78.outcome)
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
                                if (_loc_80.rewards.objects.length >= SpeakingItemManager.GREAT_DROP_LIMIT)
                                {
                                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_GREAT_DROP);
                                }
                            }
                        }
                        if (_loc_76)
                        {
                            _loc_81 = 0;
                            for each (_loc_82 in _loc_76.rewards.objects)
                            {
                                
                                _loc_77[_loc_81].rewards.objects.push(_loc_82);
                                ++_loc_81 = ++_loc_81 % _loc_77.length;
                            }
                            _loc_83 = _loc_76.rewards.kamas;
                            _loc_84 = _loc_83 / _loc_77.length;
                            if (_loc_83 % _loc_77.length != 0)
                            {
                                _loc_84++;
                            }
                            for each (_loc_85 in _loc_77)
                            {
                                
                                if (_loc_83 < _loc_84)
                                {
                                    _loc_85.rewards.kamas = _loc_83;
                                }
                                else
                                {
                                    _loc_85.rewards.kamas = _loc_84;
                                }
                                _loc_83 = _loc_83 - _loc_85.rewards.kamas;
                            }
                        }
                        _loc_79 = new Object();
                        _loc_79.results = _loc_74;
                        _loc_79.ageBonus = _loc_34.ageBonus;
                        _loc_79.sizeMalus = _loc_34.lootShareLimitMalus;
                        _loc_79.duration = _loc_34.duration;
                        _loc_79.challenges = this.challengesList;
                        _loc_79.turns = this._battleFrame.turnsCount;
                        _loc_79.fightType = this._fightType;
                        _log.debug("Sending the GameFightEnd hook. " + this._battleFrame.turnsCount);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightEnd, _loc_79);
                    }
                    Kernel.getWorker().removeFrame(this);
                    return true;
                }
                case param1 is ChallengeTargetsListRequestAction:
                {
                    _loc_35 = param1 as ChallengeTargetsListRequestAction;
                    _loc_36 = new ChallengeTargetsListRequestMessage();
                    _loc_36.initChallengeTargetsListRequestMessage(_loc_35.challengeId);
                    ConnectionsHandler.getConnection().send(_loc_36);
                    return true;
                }
                case param1 is ChallengeTargetsListMessage:
                {
                    _loc_37 = param1 as ChallengeTargetsListMessage;
                    for each (_loc_86 in _loc_37.targetCells)
                    {
                        
                        if (_loc_86 != -1)
                        {
                            HyperlinkShowCellManager.showCell(_loc_86);
                        }
                    }
                    return true;
                }
                case param1 is ChallengeInfoMessage:
                {
                    _loc_38 = param1 as ChallengeInfoMessage;
                    _loc_39 = this.getChallengeById(_loc_38.challengeId);
                    if (!_loc_39)
                    {
                        _loc_39 = new ChallengeWrapper();
                        this.challengesList.push(_loc_39);
                    }
                    _loc_39.id = _loc_38.challengeId;
                    _loc_39.targetId = _loc_38.targetId;
                    _loc_39.baseXpBonus = _loc_38.baseXpBonus;
                    _loc_39.extraXpBonus = _loc_38.extraXpBonus;
                    _loc_39.baseDropBonus = _loc_38.baseDropBonus;
                    _loc_39.extraDropBonus = _loc_38.extraDropBonus;
                    _loc_39.result = 0;
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return true;
                }
                case param1 is ChallengeTargetUpdateMessage:
                {
                    _loc_40 = param1 as ChallengeTargetUpdateMessage;
                    _loc_39 = this.getChallengeById(_loc_40.challengeId);
                    if (_loc_39 == null)
                    {
                        _log.warn("Got a challenge result with no corresponding challenge (challenge id " + _loc_40.challengeId + "), skipping.");
                        return false;
                    }
                    _loc_39.targetId = _loc_40.targetId;
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return true;
                }
                case param1 is ChallengeResultMessage:
                {
                    _loc_41 = param1 as ChallengeResultMessage;
                    _loc_39 = this.getChallengeById(_loc_41.challengeId);
                    if (!_loc_39)
                    {
                        _log.warn("Got a challenge result with no corresponding challenge (challenge id " + _loc_41.challengeId + "), skipping.");
                        return false;
                    }
                    _loc_39.result = _loc_41.success ? (1) : (2);
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return true;
                }
                case param1 is MapObstacleUpdateMessage:
                {
                    _loc_42 = param1 as MapObstacleUpdateMessage;
                    for each (_loc_87 in _loc_42.obstacles)
                    {
                        
                        InteractiveCellManager.getInstance().updateCell(_loc_87.obstacleCellId, _loc_87.state == MapObstacleStateEnum.OBSTACLE_OPENED);
                    }
                    return true;
                }
                case param1 is GameActionFightNoSpellCastMessage:
                {
                    _loc_43 = param1 as GameActionFightNoSpellCastMessage;
                    if (_loc_43.spellLevelId != 0 || !PlayedCharacterManager.getInstance().currentWeapon)
                    {
                        if (_loc_43.spellLevelId == 0)
                        {
                            _loc_89 = Spell.getSpellById(0).spellLevels[0];
                            _loc_88 = SpellLevel.getLevelById(_loc_89);
                        }
                        else
                        {
                            _loc_88 = SpellLevel.getLevelById(_loc_43.spellLevelId);
                        }
                        _loc_44 = _loc_88.apCost;
                    }
                    else
                    {
                        _loc_44 = PlayedCharacterManager.getInstance().currentWeapon.apCost;
                    }
                    CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent + _loc_44;
                    return true;
                }
                case param1 is ShowTacticModeAction:
                {
                    if (PlayedCharacterApi.isInPreFight())
                    {
                        return false;
                    }
                    if (PlayedCharacterApi.isInFight() || PlayedCharacterManager.getInstance().isSpectator)
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
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
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
            var _loc_5:* = null;
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
            var _loc_7:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = false;
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
                    SelectionManager.getInstance().addSelection(_loc_11, this.INVISIBLE_POSITION_SELECTION);
                }
                _loc_12 = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityPosition(_loc_5.contextualId);
                if (_loc_12 > -1)
                {
                    _loc_13 = new FightReachableCellsMaker(this._currentFighterInfo, _loc_12, FightEntitiesFrame.getCurrentInstance().getLastKnownEntityMovementPoint(_loc_5.contextualId));
                    _loc_11.zone = new Custom(_loc_13.reachableCells);
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
                _loc_14 = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
                _loc_16 = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
                _loc_17 = _loc_16 ? (_loc_16.myTurn) : (true);
                if ((!_loc_14 || _loc_14 && _loc_14.currentTargetIsTargetable) && _loc_17)
                {
                    _loc_15 = this._overEffectOk;
                }
                else
                {
                    _loc_15 = this._overEffectKo;
                }
                if (_loc_9.filters.length)
                {
                    if (_loc_9.filters[0] != _loc_15)
                    {
                        _loc_9.filters = [_loc_15];
                    }
                }
                else
                {
                    _loc_9.filters = [_loc_15];
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
