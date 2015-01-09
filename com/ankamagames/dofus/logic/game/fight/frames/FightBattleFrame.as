package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterStatsListMessage;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import flash.utils.Timer;
    import com.ankamagames.dofus.logic.game.roleplay.frames.InfoEntitiesFrame;
    import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.kernel.Kernel;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnListMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSynchronizeMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.SlaveSwitchContextMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnStartMessage;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnEndMessage;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightNewWaveMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightNewRoundMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.FighterStatsListMessage;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.dofus.logic.game.fight.messages.GameActionFightLeaveMessage;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnResumeMessage;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.common.managers.AFKFightManager;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.logic.game.fight.actions.GameFightTurnFinishAction;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.misc.lists.FightHookList;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnStartPlayingMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnReadyRequestMessage;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
    import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.DisableAfkAction;
    import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
    import com.ankamagames.jerakine.messages.Message;
    import gs.TweenMax;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.misc.lists.CustomUiHookList;
    import com.ankamagames.dofus.network.messages.game.actions.GameActionAcknowledgementMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnReadyMessage;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.logic.game.common.steps.WaitStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightVisibilityStep;
    import __AS3__.vec.*;

    public class FightBattleFrame implements Frame 
    {

        public static const FIGHT_SEQUENCER_NAME:String = "FightBattleSequencer";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightBattleFrame));

        private var _sequenceFrameSwitcher:FightSequenceSwitcherFrame;
        private var _turnFrame:FightTurnFrame;
        private var _currentSequenceFrame:FightSequenceFrame;
        private var _sequenceFrames:Array;
        private var _executingSequence:Boolean;
        private var _confirmTurnEnd:Boolean;
        private var _endBattle:Boolean;
        private var _leaveSpectator:Boolean;
        private var _battleResults:GameFightEndMessage;
        private var _refreshTurnsList:Boolean;
        private var _newTurnsList:Vector.<int>;
        private var _newDeadTurnsList:Vector.<int>;
        private var _turnsList:Vector.<int>;
        private var _deadTurnsList:Vector.<int>;
        private var _playerTargetedEntitiesList:Vector.<int>;
        private var _synchroniseFighters:Vector.<GameFightFighterInformations> = null;
        private var _synchroniseFightersInstanceId:uint = 0xFFFFFFFF;
        private var _delayCslmsg:CharacterStatsListMessage;
        private var _playerNewTurn:AnimatedCharacter;
        private var _turnsCount:uint = 0;
        private var _destroyed:Boolean;
        private var _playingSlaveEntity:Boolean = false;
        private var _lastPlayerId:int;
        private var _currentPlayerId:int;
        private var _skipTurnTimer:Timer;
        private var _infoEntitiesFrame:InfoEntitiesFrame;
        private var _masterId:int;
        private var _slaveId:int;
        private var _autoEndTurn:Boolean = false;
        private var _autoEndTurnTimer:Timer;
        private var _newWave:Boolean;
        private var _newWaveId:int;
        private var _waveSound:SoundDofus;

        public function FightBattleFrame()
        {
            this._turnFrame = new FightTurnFrame();
            this._playerTargetedEntitiesList = new Vector.<int>(0);
            this._infoEntitiesFrame = new InfoEntitiesFrame();
            super();
        }

        public function get priority():int
        {
            return (Priority.HIGH);
        }

        public function get fightersList():Vector.<int>
        {
            return (this._turnsList);
        }

        public function set fightersList(turnList:Vector.<int>):void
        {
            this._turnsList = turnList;
        }

        public function get deadFightersList():Vector.<int>
        {
            return (this._deadTurnsList);
        }

        public function set deadFightersList(deadTurnList:Vector.<int>):void
        {
            this._deadTurnsList = deadTurnList;
        }

        public function get targetedEntities():Vector.<int>
        {
            return (this._playerTargetedEntitiesList);
        }

        public function get turnsCount():uint
        {
            return (this._turnsCount);
        }

        public function set turnsCount(turn:uint):void
        {
            this._turnsCount = turn;
        }

        public function get currentPlayerId():int
        {
            return (this._currentPlayerId);
        }

        public function get executingSequence():Boolean
        {
            return (this._executingSequence);
        }

        public function get currentSequenceFrame():FightSequenceFrame
        {
            return (this._currentSequenceFrame);
        }

        public function get playingSlaveEntity():Boolean
        {
            return (this._playingSlaveEntity);
        }

        public function get slaveId():int
        {
            return (this._slaveId);
        }

        public function get masterId():int
        {
            return (this._masterId);
        }

        public function pushed():Boolean
        {
            this._playingSlaveEntity = false;
            this._sequenceFrames = new Array();
            DataMapProvider.getInstance().isInFight = true;
            Kernel.getWorker().addFrame(this._turnFrame);
            this._destroyed = false;
            this._autoEndTurnTimer = new Timer(60, 1);
            this._autoEndTurnTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.sendAutoEndTurn);
            this._waveSound = new SoundDofus(UISoundEnum.FIGHT_NEW_WAVE);
            this._waveSound.volume = 1;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:GameFightTurnListMessage;
            var _local_3:GameFightSynchronizeMessage;
            var _local_4:SlaveSwitchContextMessage;
            var _local_5:GameFightTurnStartMessage;
            var _local_6:int;
            var _local_7:SoundApi;
            var _local_8:GameFightFighterInformations;
            var _local_9:GameFightFighterInformations;
            var _local_10:Boolean;
            var _local_11:Boolean;
            var _local_12:GameFightTurnEndMessage;
            var _local_13:GameContextActorInformations;
            var _local_14:SequenceStartMessage;
            var _local_15:SequenceEndMessage;
            var _local_16:GameFightNewWaveMessage;
            var _local_17:GameFightNewRoundMessage;
            var _local_18:GameFightLeaveMessage;
            var _local_19:GameFightFighterInformations;
            var _local_20:FightSequenceFrame;
            var _local_21:GameFightEndMessage;
            var _local_22:uint;
            var _local_23:FighterStatsListMessage;
            var fighter:GameFightFighterInformations;
            var currentPlayedFighterId:int;
            var entity:AnimatedCharacter;
            var ss:SerialSequencer;
            var yOffset:Number;
            var ss2:SerialSequencer;
            var time:int;
            var action:Action;
            var _local_32:FightEntitiesFrame;
            var _local_33:int;
            var _local_34:GameContextActorInformations;
            var fighterInfosTE:GameFightFighterInformations;
            var fakeDeathMessage:GameActionFightLeaveMessage;
            var seqEnd:SequenceEndMessage;
            var _local_38:GameFightEndMessage;
            switch (true)
            {
                case (msg is GameFightTurnListMessage):
                    _local_2 = (msg as GameFightTurnListMessage);
                    if (((this._executingSequence) || (this._currentSequenceFrame)))
                    {
                        _log.warn("There was a turns list update during this sequence... Let's wait its finish before doing it.");
                        this._refreshTurnsList = true;
                        this._newTurnsList = _local_2.ids;
                        this._newDeadTurnsList = _local_2.deadsIds;
                    }
                    else
                    {
                        this.updateTurnsList(_local_2.ids, _local_2.deadsIds);
                    };
                    return (true);
                case (msg is GameFightSynchronizeMessage):
                    _local_3 = (msg as GameFightSynchronizeMessage);
                    if (this._newWave)
                    {
                        for each (fighter in _local_3.fighters)
                        {
                            if (((((fighter.alive) && ((fighter.wave == this._newWaveId)))) && (!(FightEntitiesFrame.getCurrentInstance().getEntityInfos(fighter.contextualId)))))
                            {
                                FightEntitiesFrame.getCurrentInstance().registerActor(fighter);
                            };
                        };
                    };
                    if (this._executingSequence)
                    {
                        this._synchroniseFighters = _local_3.fighters;
                        this._synchroniseFightersInstanceId = FightSequenceFrame.currentInstanceId;
                    }
                    else
                    {
                        this.gameFightSynchronize(_local_3.fighters, false);
                    };
                    return (true);
                case (msg is SlaveSwitchContextMessage):
                    _local_4 = (msg as SlaveSwitchContextMessage);
                    _local_6 = PlayedCharacterManager.getInstance().id;
                    if (_local_4.masterId == _local_6)
                    {
                        this._masterId = _local_4.masterId;
                        this._slaveId = _local_4.slaveId;
                        if (((!(this._currentPlayerId)) && ((this._turnsList.indexOf(this._masterId) > this._turnsList.indexOf(this._slaveId)))))
                        {
                            this.prepareNextPlayableCharacter(this._masterId);
                        };
                    };
                    return (false);
                case (msg is GameFightTurnStartMessage):
                    _local_5 = (msg as GameFightTurnStartMessage);
                    _local_6 = PlayedCharacterManager.getInstance().id;
                    this._currentPlayerId = _local_5.id;
                    this._playingSlaveEntity = (_local_5.id == this._slaveId);
                    this._turnFrame.turnDuration = _local_5.waitTime;
                    if (!((msg is GameFightTurnResumeMessage)))
                    {
                        BuffManager.getInstance().decrementDuration(_local_5.id);
                    }
                    else
                    {
                        if ((msg is GameFightTurnResumeMessage))
                        {
                            currentPlayedFighterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
                            if (((((this._slaveId) && (!((this._currentPlayerId == currentPlayedFighterId))))) && ((((this._slaveId == this._currentPlayerId)) || ((this.getNextPlayableCharacterId() == this._slaveId))))))
                            {
                                this.prepareNextPlayableCharacter(this._masterId);
                            };
                        };
                    };
                    if ((((_local_5.id > 0)) || (this._playingSlaveEntity)))
                    {
                        if (((!((FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_5.id).disposition.cellId == -1))) && (!(FightEntitiesHolder.getInstance().getEntity(_local_5.id)))))
                        {
                            entity = (DofusEntities.getEntity(_local_5.id) as AnimatedCharacter);
                            if (entity != null)
                            {
                                ss = new SerialSequencer();
                                ss.addStep(new AddGfxEntityStep(154, entity.position.cellId));
                                ss.start();
                                yOffset = (65 * entity.look.getScaleY());
                                ss2 = new SerialSequencer();
                                ss2.addStep(new AddGfxEntityStep(153, entity.position.cellId, 0, -(yOffset)));
                                ss2.start();
                            };
                            this._playerNewTurn = entity;
                        };
                    };
                    _local_7 = new SoundApi();
                    _local_8 = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_5.id) as GameFightFighterInformations);
                    if ((((((((_local_5.id == _local_6)) && (_local_8))) && (_local_8.alive))) || (this._playingSlaveEntity)))
                    {
                        CurrentPlayedFighterManager.getInstance().currentFighterId = _local_5.id;
                        if (_local_7.playSoundAtTurnStart())
                        {
                            SoundManager.getInstance().manager.playUISound(UISoundEnum.PLAYER_TURN);
                        };
                        SpellWrapper.refreshAllPlayerSpellHolder(_local_5.id);
                        this._turnFrame.myTurn = true;
                    }
                    else
                    {
                        this._turnFrame.myTurn = false;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStart, _local_5.id, _local_5.waitTime, Dofus.getInstance().options.turnPicture);
                    if (this._skipTurnTimer)
                    {
                        this._skipTurnTimer.stop();
                        this._skipTurnTimer.removeEventListener(TimerEvent.TIMER, this.onSkipTurnTimeOut);
                        this._skipTurnTimer = null;
                    };
                    if ((((_local_5.id == _local_6)) || (this._playingSlaveEntity)))
                    {
                        if (AFKFightManager.getInstance().isAfk)
                        {
                            time = getTimer();
                            if ((AFKFightManager.getInstance().lastTurnSkip + (5 * 1000)) < time)
                            {
                                action = new GameFightTurnFinishAction();
                                Kernel.getWorker().process(action);
                            }
                            else
                            {
                                this._skipTurnTimer = new Timer(((5 * 1000) - (time - AFKFightManager.getInstance().lastTurnSkip)), 1);
                                this._skipTurnTimer.addEventListener(TimerEvent.TIMER, this.onSkipTurnTimeOut);
                                this._skipTurnTimer.start();
                            };
                        }
                        else
                        {
                            _local_32 = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                            _local_33 = 0;
                            for each (_local_34 in _local_32.getEntitiesDictionnary())
                            {
                                if ((((((_local_34 is GameFightCharacterInformations)) && (GameFightCharacterInformations(_local_34).alive))) && ((_local_34.contextualId > 0))))
                                {
                                    _local_33++;
                                };
                            };
                            if (_local_33 > 1)
                            {
                                AFKFightManager.getInstance().initialize();
                            };
                        };
                        if ((((((((this._slaveId < 0)) && ((FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._slaveId) as GameFightFighterInformations).alive))) && ((FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._masterId) as GameFightFighterInformations).alive))) && (Kernel.getWorker().contains(FightSpellCastFrame))))
                        {
                            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
                        };
                    };
                    _local_9 = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(FightContextFrame.fighterEntityTooltipId) as GameFightFighterInformations);
                    _local_10 = ((_local_9) && ((_local_9.disposition.cellId == FightContextFrame.currentCell)));
                    _local_11 = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame).timelineOverEntity;
                    if (((((((!(_local_10)) && (!(_local_11)))) && (PlayedCharacterManager.getInstance().isSpectator))) && ((OptionManager.getOptionManager("dofus")["spectatorAutoShowCurrentFighterInfo"] == true))))
                    {
                        KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, (FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_5.id) as GameFightFighterInformations));
                    };
                    return (true);
                case (msg is GameFightTurnStartPlayingMessage):
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStartPlaying);
                    return (true);
                case (msg is GameFightTurnEndMessage):
                    _local_12 = (msg as GameFightTurnEndMessage);
                    this._lastPlayerId = _local_12.id;
                    _local_13 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_local_12.id);
                    if ((((_local_13 is GameFightFighterInformations)) && (!((_local_13 as GameFightFighterInformations).alive))))
                    {
                        fighterInfosTE = (_local_13 as GameFightFighterInformations);
                        BuffManager.getInstance().decrementDuration(_local_12.id);
                        BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
                        fighterInfosTE.stats.actionPoints = fighterInfosTE.stats.maxActionPoints;
                        fighterInfosTE.stats.movementPoints = fighterInfosTE.stats.maxMovementPoints;
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd, this._lastPlayerId);
                        if (_local_12.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                        {
                            CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
                            SpellWrapper.refreshAllPlayerSpellHolder(_local_12.id);
                        };
                    };
                    if (_local_12.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        AFKFightManager.getInstance().lastTurnSkip = getTimer();
                        AFKFightManager.getInstance().confirm = true;
                        this._turnFrame.myTurn = false;
                    };
                    return (true);
                case (msg is SequenceStartMessage):
                    this._autoEndTurn = false;
                    _local_14 = (msg as SequenceStartMessage);
                    if (!(this._sequenceFrameSwitcher))
                    {
                        this._sequenceFrameSwitcher = new FightSequenceSwitcherFrame();
                        Kernel.getWorker().addFrame(this._sequenceFrameSwitcher);
                    };
                    this._currentSequenceFrame = new FightSequenceFrame(this, this._currentSequenceFrame);
                    this._sequenceFrameSwitcher.currentFrame = this._currentSequenceFrame;
                    return (true);
                case (msg is SequenceEndMessage):
                    _local_15 = (msg as SequenceEndMessage);
                    if (!(this._currentSequenceFrame))
                    {
                        _log.warn("Wow wow wow, I've got a Sequence End but no Sequence Start? What the hell?");
                        return (true);
                    };
                    this._currentSequenceFrame.mustAck = (_local_15.authorId == CurrentPlayedFighterManager.getInstance().currentFighterId);
                    this._currentSequenceFrame.ackIdent = _local_15.actionId;
                    this._sequenceFrameSwitcher.currentFrame = null;
                    if (!(this._currentSequenceFrame.parent))
                    {
                        Kernel.getWorker().removeFrame(this._sequenceFrameSwitcher);
                        this._sequenceFrameSwitcher = null;
                        this._sequenceFrames.push(this._currentSequenceFrame);
                        this._currentSequenceFrame = null;
                        this.executeNextSequence();
                    }
                    else
                    {
                        this._currentSequenceFrame.execute();
                        this._sequenceFrameSwitcher.currentFrame = this._currentSequenceFrame.parent;
                        this._currentSequenceFrame = this._currentSequenceFrame.parent;
                    };
                    return (true);
                case (msg is GameFightTurnReadyRequestMessage):
                    if (this._executingSequence)
                    {
                        _log.warn("Delaying turn end acknowledgement because we're still in a sequence.");
                        this._confirmTurnEnd = true;
                    }
                    else
                    {
                        this.confirmTurnEnd();
                    };
                    return (true);
                case (msg is GameFightNewWaveMessage):
                    _local_16 = (msg as GameFightNewWaveMessage);
                    this._newWaveId = _local_16.id;
                    this._newWave = true;
                    KernelEventsManager.getInstance().processCallback(FightHookList.WaveUpdated, _local_16.teamId, _local_16.id, _local_16.nbTurnBeforeNextWave);
                    return (true);
                case (msg is GameFightNewRoundMessage):
                    _local_17 = (msg as GameFightNewRoundMessage);
                    this._turnsCount = _local_17.roundNumber;
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = (this._turnsCount - 1);
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, this._turnsCount);
                    BuffManager.getInstance().spellBuffsToIgnore.length = 0;
                    return (true);
                case (msg is GameFightLeaveMessage):
                    _local_18 = (msg as GameFightLeaveMessage);
                    _local_19 = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations);
                    _local_20 = new FightSequenceFrame(this);
                    if (((_local_19) && (_local_19.alive)))
                    {
                        fakeDeathMessage = new GameActionFightLeaveMessage();
                        _local_20.process(fakeDeathMessage.initGameActionFightLeaveMessage(0, 0, _local_18.charId));
                        this._sequenceFrames.push(_local_20);
                        this.executeNextSequence();
                    };
                    if ((((_local_18.charId == PlayedCharacterManager.getInstance().id)) && (PlayedCharacterManager.getInstance().isSpectator)))
                    {
                        if (this._executingSequence)
                        {
                            this._leaveSpectator = true;
                        };
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave, _local_18.charId);
                    };
                    return (true);
                case (msg is GameFightEndMessage):
                    _local_21 = (msg as GameFightEndMessage);
                    _local_22 = 5;
                    while (((this._currentSequenceFrame) && (--_local_22)))
                    {
                        _log.error("/!\\ Fight end but no SequenceEnd was received");
                        seqEnd = new SequenceEndMessage();
                        seqEnd.initSequenceEndMessage();
                        this.process(seqEnd);
                    };
                    if (this._executingSequence)
                    {
                        _log.warn("Delaying fight end because we're still in a sequence.");
                        this._endBattle = true;
                        this._battleResults = _local_21;
                    }
                    else
                    {
                        this.endBattle(_local_21);
                    };
                    FightersStateManager.getInstance().endFight();
                    CurrentPlayedFighterManager.getInstance().endFight();
                    return (true);
                case (msg is GameContextDestroyMessage):
                    if (this._battleResults)
                    {
                        _log.debug("Fin de combat propre (resultat connu)");
                        this.endBattle(this._battleResults);
                    }
                    else
                    {
                        _log.debug("Fin de combat brutale (pas de resultat connu)");
                        this._executingSequence = false;
                        _local_38 = new GameFightEndMessage();
                        _local_38.initGameFightEndMessage(0, 0, 0, null);
                        this.process(_local_38);
                    };
                    return (true);
                case (msg is DisableAfkAction):
                    AFKFightManager.getInstance().confirm = false;
                    AFKFightManager.getInstance().enabled = false;
                    return (true);
                case (msg is ShowAllNamesAction):
                    if (Kernel.getWorker().contains(InfoEntitiesFrame))
                    {
                        Kernel.getWorker().removeFrame(this._infoEntitiesFrame);
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(this._infoEntitiesFrame);
                    };
                    return (true);
                case (msg is FighterStatsListMessage):
                    _local_23 = (msg as FighterStatsListMessage);
                    CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(PlayedCharacterManager.getInstance().id, _local_23.stats);
                    SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            var entityId:int;
            var fsf:FightSequenceFrame;
            DataMapProvider.getInstance().isInFight = false;
            TweenMax.killAllTweens(false);
            if (Kernel.getWorker().contains(FightTurnFrame))
            {
                Kernel.getWorker().removeFrame(this._turnFrame);
            };
            BuffManager.getInstance().destroy();
            MarkedCellsManager.getInstance().destroy();
            if (((this._executingSequence) || (Kernel.getWorker().contains(FightSequenceFrame))))
            {
                _log.warn("Wow, wait. We're pulling FightBattle but there's still sequences inside the worker !!");
                fsf = (Kernel.getWorker().getFrame(FightSequenceFrame) as FightSequenceFrame);
                Kernel.getWorker().removeFrame(fsf);
            };
            SerialSequencer.clearByType(FIGHT_SEQUENCER_NAME);
            SerialSequencer.clearByType(FightSequenceFrame.FIGHT_SEQUENCERS_CATEGORY);
            AFKFightManager.getInstance().enabled = false;
            this._currentSequenceFrame = null;
            this._sequenceFrameSwitcher = null;
            this._turnFrame = null;
            this._battleResults = null;
            this._newTurnsList = null;
            this._newDeadTurnsList = null;
            this._turnsList = null;
            this._deadTurnsList = null;
            this._sequenceFrames = null;
            this._playingSlaveEntity = false;
            this._masterId = 0;
            this._slaveId = 0;
            if (this._playerNewTurn)
            {
                this._playerNewTurn.destroy();
            };
            if (this._skipTurnTimer)
            {
                this._skipTurnTimer.reset();
                this._skipTurnTimer.removeEventListener(TimerEvent.TIMER, this.onSkipTurnTimeOut);
                this._skipTurnTimer = null;
            };
            this._destroyed = true;
            for each (entityId in this._playerTargetedEntitiesList)
            {
                TooltipManager.hide(("tooltipOverEntity_" + entityId));
            };
            TooltipManager.hide(("tooltipOverEntity_" + PlayedCharacterManager.getInstance().id));
            if (this._autoEndTurnTimer)
            {
                this._autoEndTurnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.sendAutoEndTurn);
                this._autoEndTurnTimer = null;
            };
            return (true);
        }

        public function delayCharacterStatsList(msg:CharacterStatsListMessage):void
        {
            this._delayCslmsg = msg;
        }

        public function prepareNextPlayableCharacter(currentCharacterId:int=0):void
        {
            var nextCharacterEntity:GameFightFighterInformations;
            var nextCharacterId:int;
            if (this._slaveId)
            {
                if (currentCharacterId)
                {
                    nextCharacterId = (((currentCharacterId == this._slaveId)) ? this._masterId : this._slaveId);
                }
                else
                {
                    nextCharacterId = this.getNextPlayableCharacterId();
                };
                nextCharacterEntity = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(nextCharacterId) as GameFightFighterInformations);
                if (((!(nextCharacterEntity)) || (!(nextCharacterEntity.alive))))
                {
                    return;
                };
                CurrentPlayedFighterManager.getInstance().currentFighterId = nextCharacterId;
                if (nextCharacterId == this._masterId)
                {
                    CurrentPlayedFighterManager.getInstance().resetPlayerSpellList();
                };
                if (nextCharacterId == this._slaveId)
                {
                    KernelEventsManager.getInstance().processCallback(CustomUiHookList.SpellMovementAllowed, false);
                };
            };
        }

        public function getNextPlayableCharacterId():int
        {
            var masterIdx:int;
            var slaveIdx:int;
            var currentCharacterIdx:int;
            var currentPlayedCharacterId:int = CurrentPlayedFighterManager.getInstance().currentFighterId;
            if (((!(this._slaveId)) || (!(this._turnsList))))
            {
                return (currentPlayedCharacterId);
            };
            var i:int;
            while (i < this._turnsList.length)
            {
                if (this._turnsList[i] == this._masterId)
                {
                    masterIdx = i;
                }
                else
                {
                    if (this._turnsList[i] == this._slaveId)
                    {
                        slaveIdx = i;
                    };
                };
                if (this._turnsList[i] == this._currentPlayerId)
                {
                    currentCharacterIdx = i;
                };
                i++;
            };
            if (masterIdx == currentCharacterIdx)
            {
                return (this._slaveId);
            };
            if (slaveIdx == currentCharacterIdx)
            {
                return (this._masterId);
            };
            if ((((masterIdx < currentCharacterIdx)) && ((slaveIdx > currentCharacterIdx))))
            {
                return (this._slaveId);
            };
            if ((((masterIdx > currentCharacterIdx)) && ((slaveIdx < currentCharacterIdx))))
            {
                return (this._masterId);
            };
            if ((((masterIdx > slaveIdx)) && ((masterIdx < currentCharacterIdx))))
            {
                return (this._slaveId);
            };
            if ((((masterIdx < slaveIdx)) && ((masterIdx < currentCharacterIdx))))
            {
                return (this._masterId);
            };
            if ((((masterIdx > slaveIdx)) && ((masterIdx > currentCharacterIdx))))
            {
                return (this._slaveId);
            };
            if ((((masterIdx < slaveIdx)) && ((masterIdx > currentCharacterIdx))))
            {
                return (this._masterId);
            };
            return (0);
        }

        private function executeNextSequence():Boolean
        {
            if (this._executingSequence)
            {
                return (false);
            };
            var nextSequenceFrame:FightSequenceFrame = this._sequenceFrames.shift();
            if (nextSequenceFrame)
            {
                this._executingSequence = true;
                nextSequenceFrame.execute(this.finishSequence(nextSequenceFrame));
                return (true);
            };
            return (false);
        }

        private function finishSequence(sequenceFrame:FightSequenceFrame):Function
        {
            return (function ():void
            {
                var ack:* = undefined;
                var characterFrame:* = undefined;
                if (_destroyed)
                {
                    return;
                };
                if (sequenceFrame.mustAck)
                {
                    ack = new GameActionAcknowledgementMessage();
                    ack.initGameActionAcknowledgementMessage(true, sequenceFrame.ackIdent);
                    try
                    {
                        ConnectionsHandler.getConnection().send(ack);
                    }
                    catch(e:Error)
                    {
                        return;
                    };
                };
                FightEventsHelper.sendAllFightEvent(true);
                _log.info("Sequence finished.");
                _executingSequence = false;
                if (_refreshTurnsList)
                {
                    _log.warn("There was a turns list refresh delayed, what about updating it now?");
                    _refreshTurnsList = false;
                    updateTurnsList(_newTurnsList, _newDeadTurnsList);
                    _newTurnsList = null;
                    _newDeadTurnsList = null;
                };
                if (((((!(_executingSequence)) && (_sequenceFrames.length))) && ((_sequenceFrames[0].instanceId >= _synchroniseFightersInstanceId))))
                {
                    gameFightSynchronize(_synchroniseFighters, false);
                    _synchroniseFighters = null;
                };
                if (executeNextSequence())
                {
                    return;
                };
                if (_synchroniseFighters)
                {
                    gameFightSynchronize(_synchroniseFighters);
                    _synchroniseFighters = null;
                };
                if (_delayCslmsg)
                {
                    characterFrame = (Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame);
                    if (characterFrame)
                    {
                        characterFrame.updateCharacterStatsList(_delayCslmsg);
                    };
                    _delayCslmsg = null;
                };
                if (_endBattle)
                {
                    _log.warn("This fight must end ! Finishing things now.");
                    _endBattle = false;
                    endBattle(_battleResults);
                    _battleResults = null;
                    return;
                };
                if (_confirmTurnEnd)
                {
                    _log.warn("There was a turn end delayed, dispatching now.");
                    _confirmTurnEnd = false;
                    confirmTurnEnd();
                };
            });
        }

        private function sendAutoEndTurn(e:TimerEvent):void
        {
            var action:Action;
            if (this._autoEndTurn)
            {
                action = new GameFightTurnFinishAction();
                Kernel.getWorker().process(action);
                this._autoEndTurn = false;
            };
            this._autoEndTurnTimer.stop();
        }

        private function updateTurnsList(turnsList:Vector.<int>, deadTurnsList:Vector.<int>):void
        {
            this._turnsList = turnsList;
            this._deadTurnsList = deadTurnsList;
            KernelEventsManager.getInstance().processCallback(HookList.FightersListUpdated);
            if (((Dofus.getInstance().options.orderFighters) && (Kernel.getWorker().getFrame(FightEntitiesFrame))))
            {
                (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).updateAllEntitiesNumber(turnsList);
            };
        }

        private function confirmTurnEnd():void
        {
            var char:CharacterCharacteristicsInformations;
            var entityId:int;
            var fighterInfos2:GameFightFighterInformations = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations);
            if (fighterInfos2)
            {
                BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
                fighterInfos2.stats.actionPoints = fighterInfos2.stats.maxActionPoints;
                fighterInfos2.stats.movementPoints = fighterInfos2.stats.maxMovementPoints;
                if (this._lastPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                {
                    char = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
                    char.actionPointsCurrent = fighterInfos2.stats.maxActionPoints;
                    char.movementPointsCurrent = fighterInfos2.stats.maxMovementPoints;
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
                    SpellWrapper.refreshAllPlayerSpellHolder(this._lastPlayerId);
                    for each (entityId in this._playerTargetedEntitiesList)
                    {
                        TooltipManager.hide(("tooltip_tooltipOverEntity_" + entityId));
                    };
                    this._playerTargetedEntitiesList.length = 0;
                    this.prepareNextPlayableCharacter(this._lastPlayerId);
                };
                KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd, this._lastPlayerId);
            };
            var turnEnd:GameFightTurnReadyMessage = new GameFightTurnReadyMessage();
            turnEnd.initGameFightTurnReadyMessage(true);
            ConnectionsHandler.getConnection().send(turnEnd);
        }

        private function endBattle(fightEnd:GameFightEndMessage):void
        {
            var coward:*;
            var fightContextFrame:FightContextFrame;
            var _holder:FightEntitiesHolder = FightEntitiesHolder.getInstance();
            var entities:Dictionary = _holder.getEntities();
            for each (coward in entities)
            {
                (coward as AnimatedCharacter).display();
            };
            _holder.reset();
            this._synchroniseFighters = null;
            Kernel.getWorker().removeFrame(this);
            fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            fightContextFrame.process(fightEnd);
        }

        private function onSkipTurnTimeOut(event:TimerEvent):void
        {
            var action:Action;
            this._skipTurnTimer.removeEventListener(TimerEvent.TIMER, this.onSkipTurnTimeOut);
            this._skipTurnTimer = null;
            if (AFKFightManager.getInstance().isAfk)
            {
                action = new GameFightTurnFinishAction();
                Kernel.getWorker().process(action);
            };
        }

        private function gameFightSynchronize(fighters:Vector.<GameFightFighterInformations>, synchronizeBuff:Boolean=true):void
        {
            var newWaveAppeared:Boolean;
            var newWaveMonster:Boolean;
            var newWaveMonsterIndex:int;
            var fighterInfos:GameFightFighterInformations;
            var sequencer:SerialSequencer;
            var entitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            var fbf:FightBattleFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
            var bm:BuffManager = BuffManager.getInstance();
            if (synchronizeBuff)
            {
                BuffManager.getInstance().synchronize();
            };
            for each (fighterInfos in fighters)
            {
                if (fighterInfos.alive)
                {
                    if (fbf)
                    {
                        BuffManager.getInstance().markFinishingBuffs(fighterInfos.contextualId, true);
                    };
                    newWaveMonster = (((fighterInfos.wave == this._newWaveId)) && (!(DofusEntities.getEntity(fighterInfos.contextualId))));
                    entitiesFrame.updateFighter(fighterInfos, null, BuffManager.getInstance().getFinishingBuffs(fighterInfos.contextualId));
                    if (newWaveMonster)
                    {
                        newWaveAppeared = true;
                        (DofusEntities.getEntity(fighterInfos.contextualId) as AnimatedCharacter).visible = false;
                        if (((!(OptionManager.getOptionManager("tubul")["tubulIsDesactivated"])) && ((newWaveMonsterIndex == 0))))
                        {
                            this._waveSound.play();
                        };
                        sequencer = new SerialSequencer();
                        sequencer.addStep(new WaitStep((300 * newWaveMonsterIndex)));
                        sequencer.addStep(new AddGfxEntityStep(2715, fighterInfos.disposition.cellId));
                        sequencer.addStep(new FightVisibilityStep(fighterInfos.contextualId, true));
                        sequencer.start();
                        newWaveMonsterIndex++;
                    };
                };
            };
            if (newWaveAppeared)
            {
                this._newWave = false;
                this._newWaveId = -1;
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.frames

import com.ankamagames.dofus.types.entities.AnimatedCharacter;
import com.ankamagames.atouin.Atouin;
import flash.geom.ColorTransform;
import com.ankamagames.atouin.AtouinConstants;
import gs.TweenMax;

class PlayerColorTransformManager 
{

    /*private*/ var _offSetValue:Number;
    /*private*/ var _alphaValue:Number;
    /*private*/ var _player:AnimatedCharacter;

    public function PlayerColorTransformManager(pPlayer:AnimatedCharacter)
    {
        this._player = pPlayer;
        this._alphaValue = pPlayer.alpha;
        this.offSetValue = 0;
    }

    public function set offSetValue(pValue:Number):void
    {
        this._offSetValue = pValue;
        if (Atouin.getInstance().options.transparentOverlayMode)
        {
            this._player.transform.colorTransform = new ColorTransform(1, 1, 1, ((!((this._alphaValue == 1))) ? this._alphaValue : AtouinConstants.OVERLAY_MODE_ALPHA), pValue, pValue, pValue, 0);
        }
        else
        {
            this._player.transform.colorTransform = new ColorTransform(1, 1, 1, this._alphaValue, pValue, pValue, pValue, 0);
        };
    }

    public function get offSetValue():Number
    {
        return (this._offSetValue);
    }

    public function enlightPlayer():void
    {
        TweenMax.to(this, 0.7, {
            "offSetValue":50,
            "yoyo":1
        });
    }


}

