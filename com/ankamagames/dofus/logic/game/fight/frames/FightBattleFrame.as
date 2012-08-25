package com.ankamagames.dofus.logic.game.fight.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.enum.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.messages.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.*;
    import com.ankamagames.dofus.network.messages.game.character.stats.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.events.*;
    import flash.utils.*;
    import gs.*;

    public class FightBattleFrame extends Object implements Frame
    {
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
        private var _synchroniseFighters:Vector.<GameFightFighterInformations> = null;
        private var _synchroniseFightersInstanceId:uint = 4.29497e+009;
        private var _delayCslmsg:CharacterStatsListMessage;
        private var _playerNewTurn:AnimatedCharacter;
        private var _turnsCount:uint = 0;
        private var _destroyed:Boolean;
        private var _playingSlaveEntity:Boolean = false;
        private var _lastPlayerId:int;
        private var _currentPlayerId:uint;
        private var _skipTurnTimer:Timer;
        private var _infoEntitiesFrame:InfoEntitiesFrame;
        public static const FIGHT_SEQUENCER_NAME:String = "FightBattleSequencer";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FightBattleFrame));

        public function FightBattleFrame()
        {
            this._turnFrame = new FightTurnFrame();
            this._infoEntitiesFrame = new InfoEntitiesFrame();
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGH;
        }// end function

        public function get fightersList() : Vector.<int>
        {
            return this._turnsList;
        }// end function

        public function get deadFightersList() : Vector.<int>
        {
            return this._deadTurnsList;
        }// end function

        public function get turnsCount() : uint
        {
            return this._turnsCount;
        }// end function

        public function set turnsCount(param1:uint) : void
        {
            this._turnsCount = param1;
            return;
        }// end function

        public function get currentPlayerId() : int
        {
            return this._currentPlayerId;
        }// end function

        public function get executingSequence() : Boolean
        {
            return this._executingSequence;
        }// end function

        public function pushed() : Boolean
        {
            this._playingSlaveEntity = false;
            this._sequenceFrames = new Array();
            DataMapProvider.getInstance().isInFight = true;
            Kernel.getWorker().addFrame(this._turnFrame);
            this._destroyed = false;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:GameFightTurnListMessage = null;
            var _loc_3:GameFightSynchronizeMessage = null;
            var _loc_4:GameFightTurnStartMessage = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:SoundApi = null;
            var _loc_8:GameFightTurnEndMessage = null;
            var _loc_9:GameContextActorInformations = null;
            var _loc_10:SequenceStartMessage = null;
            var _loc_11:SequenceEndMessage = null;
            var _loc_12:GameFightNewRoundMessage = null;
            var _loc_13:GameFightLeaveMessage = null;
            var _loc_14:FightSequenceFrame = null;
            var _loc_15:GameActionFightLeaveMessage = null;
            var _loc_16:GameFightEndMessage = null;
            var _loc_17:uint = 0;
            var _loc_18:AnimatedCharacter = null;
            var _loc_19:SerialSequencer = null;
            var _loc_20:Number = NaN;
            var _loc_21:SerialSequencer = null;
            var _loc_22:int = 0;
            var _loc_23:Action = null;
            var _loc_24:FightEntitiesFrame = null;
            var _loc_25:int = 0;
            var _loc_26:GameContextActorInformations = null;
            var _loc_27:GameFightFighterInformations = null;
            var _loc_28:SequenceEndMessage = null;
            switch(true)
            {
                case param1 is GameFightTurnListMessage:
                {
                    _loc_2 = param1 as GameFightTurnListMessage;
                    if (this._executingSequence || this._currentSequenceFrame)
                    {
                        _log.debug("There was a turns list update during this sequence... Let\'s wait its finish before doing it.");
                        this._refreshTurnsList = true;
                        this._newTurnsList = _loc_2.ids;
                        this._newDeadTurnsList = _loc_2.deadsIds;
                    }
                    else
                    {
                        this.updateTurnsList(_loc_2.ids, _loc_2.deadsIds);
                    }
                    return true;
                }
                case param1 is GameFightSynchronizeMessage:
                {
                    _loc_3 = param1 as GameFightSynchronizeMessage;
                    if (this._executingSequence)
                    {
                        this._synchroniseFighters = _loc_3.fighters;
                        this._synchroniseFightersInstanceId = FightSequenceFrame.currentInstanceId;
                    }
                    else
                    {
                        this.gameFightSynchronize(_loc_3.fighters);
                    }
                    return true;
                }
                case param1 is GameFightTurnStartMessage:
                {
                    _loc_4 = param1 as GameFightTurnStartMessage;
                    _loc_5 = PlayedCharacterManager.getInstance().id;
                    _loc_6 = 0;
                    if (param1 is GameFightTurnStartSlaveMessage)
                    {
                        _loc_6 = (param1 as GameFightTurnStartSlaveMessage).idSummoner;
                        this._playingSlaveEntity = _loc_6 == _loc_5;
                    }
                    else
                    {
                        if (this._playingSlaveEntity)
                        {
                            CurrentPlayedFighterManager.getInstance().resetPlayerSpellList();
                        }
                        this._playingSlaveEntity = false;
                    }
                    this._turnFrame.turnDuration = _loc_4.waitTime;
                    this._currentPlayerId = _loc_4.id;
                    if (!(param1 is GameFightTurnResumeMessage))
                    {
                        BuffManager.getInstance().decrementDuration(_loc_4.id);
                    }
                    if (_loc_4.id > 0 || _loc_6)
                    {
                        if (FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc_4.id).disposition.cellId != -1 && !FightEntitiesHolder.getInstance().getEntity(_loc_4.id))
                        {
                            _loc_18 = DofusEntities.getEntity(_loc_4.id) as AnimatedCharacter;
                            _loc_19 = new SerialSequencer();
                            _loc_19.addStep(new AddGfxEntityStep(154, _loc_18.position.cellId));
                            _loc_19.start();
                            _loc_20 = 65 * _loc_18.look.getScaleY();
                            _loc_21 = new SerialSequencer();
                            _loc_21.addStep(new AddGfxEntityStep(153, _loc_18.position.cellId, 0, -_loc_20));
                            _loc_21.start();
                            this._playerNewTurn = _loc_18;
                        }
                    }
                    _loc_7 = new SoundApi();
                    if (_loc_4.id == _loc_5 || this._playingSlaveEntity)
                    {
                        SystemManager.getSingleton().notifyUser();
                        CurrentPlayedFighterManager.getInstance().currentFighterId = _loc_4.id;
                        if (_loc_7.playSoundAtTurnStart())
                        {
                            SoundManager.getInstance().manager.playUISound(UISoundEnum.PLAYER_TURN);
                        }
                        SpellWrapper.refreshAllPlayerSpellHolder(_loc_4.id);
                        this._turnFrame.myTurn = true;
                    }
                    else
                    {
                        this._turnFrame.myTurn = false;
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStart, _loc_4.id, _loc_4.waitTime, Dofus.getInstance().options.turnPicture);
                    if (this._skipTurnTimer)
                    {
                        this._skipTurnTimer.stop();
                        this._skipTurnTimer.removeEventListener(TimerEvent.TIMER, this.onSkipTurnTimeOut);
                        this._skipTurnTimer = null;
                    }
                    if (_loc_4.id == _loc_5 || this._playingSlaveEntity)
                    {
                        if (AFKFightManager.getInstance().isAfk)
                        {
                            _loc_22 = getTimer();
                            if (AFKFightManager.getInstance().lastTurnSkip + 5 * 1000 < _loc_22)
                            {
                                _loc_23 = new GameFightTurnFinishAction();
                                Kernel.getWorker().process(_loc_23);
                            }
                            else
                            {
                                this._skipTurnTimer = new Timer(5 * 1000 - (_loc_22 - AFKFightManager.getInstance().lastTurnSkip), 1);
                                this._skipTurnTimer.addEventListener(TimerEvent.TIMER, this.onSkipTurnTimeOut);
                                this._skipTurnTimer.start();
                            }
                        }
                        else
                        {
                            _loc_24 = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                            _loc_25 = 0;
                            for each (_loc_26 in _loc_24.getEntitiesDictionnary())
                            {
                                
                                if (_loc_26 is GameFightCharacterInformations && GameFightCharacterInformations(_loc_26).alive && _loc_26.contextualId > 0)
                                {
                                    _loc_25++;
                                }
                            }
                            if (_loc_25 > 1)
                            {
                                AFKFightManager.getInstance().initialize();
                            }
                        }
                    }
                    return true;
                }
                case param1 is GameFightTurnEndMessage:
                {
                    _loc_8 = param1 as GameFightTurnEndMessage;
                    this._lastPlayerId = _loc_8.id;
                    _loc_9 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc_8.id);
                    if (_loc_9 is GameFightFighterInformations && !(_loc_9 as GameFightFighterInformations).alive)
                    {
                        _loc_27 = _loc_9 as GameFightFighterInformations;
                        BuffManager.getInstance().decrementDuration(_loc_8.id);
                        BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
                        _loc_27.stats.actionPoints = _loc_27.stats.maxActionPoints;
                        _loc_27.stats.movementPoints = _loc_27.stats.maxMovementPoints;
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd, this._lastPlayerId);
                        if (_loc_8.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                        {
                            CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
                            SpellWrapper.refreshAllPlayerSpellHolder(_loc_8.id);
                        }
                    }
                    if (_loc_8.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        AFKFightManager.getInstance().lastTurnSkip = getTimer();
                        AFKFightManager.getInstance().confirm = true;
                        this._turnFrame.myTurn = false;
                    }
                    return true;
                }
                case param1 is SequenceStartMessage:
                {
                    _loc_10 = param1 as SequenceStartMessage;
                    if (!this._sequenceFrameSwitcher)
                    {
                        this._sequenceFrameSwitcher = new FightSequenceSwitcherFrame();
                        Kernel.getWorker().addFrame(this._sequenceFrameSwitcher);
                    }
                    this._currentSequenceFrame = new FightSequenceFrame(this, this._currentSequenceFrame);
                    this._sequenceFrameSwitcher.currentFrame = this._currentSequenceFrame;
                    return true;
                }
                case param1 is SequenceEndMessage:
                {
                    _loc_11 = param1 as SequenceEndMessage;
                    if (!this._currentSequenceFrame)
                    {
                        _log.warn("Wow wow wow, I\'ve got a Sequence End but no Sequence Start? What the hell?");
                        return true;
                    }
                    this._currentSequenceFrame.mustAck = _loc_11.authorId == CurrentPlayedFighterManager.getInstance().currentFighterId;
                    this._currentSequenceFrame.ackIdent = _loc_11.actionId;
                    this._sequenceFrameSwitcher.currentFrame = null;
                    if (!this._currentSequenceFrame.parent)
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
                    }
                    return true;
                }
                case param1 is GameFightTurnReadyRequestMessage:
                {
                    if (this._executingSequence)
                    {
                        _log.debug("Delaying turn end acknowledgement because we\'re still in a sequence.");
                        this._confirmTurnEnd = true;
                    }
                    else
                    {
                        this.confirmTurnEnd();
                    }
                    return true;
                }
                case param1 is GameFightNewRoundMessage:
                {
                    _loc_12 = param1 as GameFightNewRoundMessage;
                    this._turnsCount = _loc_12.roundNumber;
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, this._turnsCount);
                    return true;
                }
                case param1 is GameFightLeaveMessage:
                {
                    _loc_13 = param1 as GameFightLeaveMessage;
                    _loc_14 = new FightSequenceFrame(this);
                    _loc_15 = new GameActionFightLeaveMessage();
                    _loc_14.process(_loc_15.initGameActionFightLeaveMessage(0, 0, _loc_13.charId));
                    this._sequenceFrames.push(_loc_14);
                    this.executeNextSequence();
                    if (_loc_13.charId == PlayedCharacterManager.getInstance().infos.id && PlayedCharacterManager.getInstance().isSpectator)
                    {
                        if (this._executingSequence)
                        {
                            this._leaveSpectator = true;
                        }
                        else
                        {
                            this.leaveSpectatorMode();
                        }
                        PlayedCharacterManager.getInstance().resetSummonedCreature();
                        PlayedCharacterManager.getInstance().resetSummonedBomb();
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave, _loc_13.charId);
                    }
                    return true;
                }
                case param1 is GameFightEndMessage:
                {
                    _loc_16 = param1 as GameFightEndMessage;
                    _loc_17 = 5;
                    while (this._currentSequenceFrame && --_loc_17)
                    {
                        
                        _log.error("/!\\ Fight end but no SequenceEnd was received");
                        _loc_28 = new SequenceEndMessage();
                        _loc_28.initSequenceEndMessage();
                        this.process(_loc_28);
                    }
                    if (this._executingSequence)
                    {
                        _log.debug("Delaying fight end because we\'re still in a sequence.");
                        this._endBattle = true;
                        this._battleResults = _loc_16;
                    }
                    else
                    {
                        this.endBattle(_loc_16);
                    }
                    PlayedCharacterManager.getInstance().resetSummonedCreature();
                    PlayedCharacterManager.getInstance().resetSummonedBomb();
                    FightersStateManager.getInstance().endFight();
                    CurrentPlayedFighterManager.getInstance().endFight();
                    return true;
                }
                case param1 is GameContextDestroyMessage:
                {
                    if (this._battleResults)
                    {
                        this.endBattle(this._battleResults);
                    }
                    else
                    {
                        this._executingSequence = false;
                        this.process(new GameFightEndMessage());
                    }
                    return true;
                }
                case param1 is DisableAfkAction:
                {
                    AFKFightManager.getInstance().confirm = false;
                    AFKFightManager.getInstance().enabled = false;
                    return true;
                }
                case param1 is ShowAllNamesAction:
                {
                    if (Kernel.getWorker().contains(InfoEntitiesFrame))
                    {
                        Kernel.getWorker().removeFrame(this._infoEntitiesFrame);
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(this._infoEntitiesFrame);
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
            DataMapProvider.getInstance().isInFight = false;
            TweenMax.killAllTweens(false);
            if (Kernel.getWorker().contains(FightTurnFrame))
            {
                Kernel.getWorker().removeFrame(this._turnFrame);
            }
            BuffManager.getInstance().destroy();
            MarkedCellsManager.getInstance().destroy();
            if (this._executingSequence || Kernel.getWorker().contains(FightSequenceFrame))
            {
                _log.warn("Wow, wait. We\'re pulling FightBattle but there\'s still sequences inside the worker !!");
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSequenceFrame));
            }
            SerialSequencer.clearByType(FIGHT_SEQUENCER_NAME);
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
            if (this._playerNewTurn)
            {
                this._playerNewTurn.destroy();
            }
            if (this._skipTurnTimer)
            {
                this._skipTurnTimer.reset();
                this._skipTurnTimer.removeEventListener(TimerEvent.TIMER, this.onSkipTurnTimeOut);
                this._skipTurnTimer = null;
            }
            this._destroyed = true;
            return true;
        }// end function

        public function delayCharacterStatsList(param1:CharacterStatsListMessage) : void
        {
            this._delayCslmsg = param1;
            return;
        }// end function

        private function executeNextSequence() : Boolean
        {
            if (this._executingSequence)
            {
                return false;
            }
            var _loc_1:* = this._sequenceFrames.shift();
            if (_loc_1)
            {
                this._executingSequence = true;
                _loc_1.execute(this.finishSequence(_loc_1));
                return true;
            }
            return false;
        }// end function

        private function finishSequence(param1:FightSequenceFrame) : Function
        {
            var sequenceFrame:* = param1;
            return function () : void
            {
                var ack:*;
                var characterFrame:*;
                if (_destroyed)
                {
                    return;
                }
                if (sequenceFrame.mustAck)
                {
                    ack = new GameActionAcknowledgementMessage();
                    ack.initGameActionAcknowledgementMessage(true, sequenceFrame.ackIdent);
                    try
                    {
                        ConnectionsHandler.getConnection().send(ack);
                    }
                    catch (e:Error)
                    {
                        return;
                    }
                }
                FightEventsHelper.sendAllFightEvent();
                _log.debug("Sequence finished.");
                _executingSequence = false;
                if (_refreshTurnsList)
                {
                    _log.debug("There was a turns list refresh delayed, what about updating it now?");
                    _refreshTurnsList = false;
                    updateTurnsList(_newTurnsList, _newDeadTurnsList);
                    _newTurnsList = null;
                    _newDeadTurnsList = null;
                }
                if (!_executingSequence && _sequenceFrames.length && _sequenceFrames[0].instanceId >= _synchroniseFightersInstanceId)
                {
                    gameFightSynchronize(_synchroniseFighters);
                    _synchroniseFighters = null;
                }
                if (executeNextSequence())
                {
                    return;
                }
                if (_synchroniseFighters)
                {
                    gameFightSynchronize(_synchroniseFighters);
                    _synchroniseFighters = null;
                }
                if (_delayCslmsg)
                {
                    characterFrame = Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame;
                    if (characterFrame)
                    {
                        characterFrame.updateCharacterStatsList(_delayCslmsg);
                    }
                    _delayCslmsg = null;
                }
                if (_endBattle)
                {
                    _log.debug("This fight must end ! Finishing things now.");
                    _endBattle = false;
                    endBattle(_battleResults);
                    _battleResults = null;
                    return;
                }
                if (_confirmTurnEnd)
                {
                    _log.debug("There was a turn end delayed, dispatching now.");
                    _confirmTurnEnd = false;
                    confirmTurnEnd();
                }
                return;
            }// end function
            ;
        }// end function

        private function updateTurnsList(param1:Vector.<int>, param2:Vector.<int>) : void
        {
            this._turnsList = param1;
            this._deadTurnsList = param2;
            KernelEventsManager.getInstance().processCallback(HookList.FightersListUpdated);
            if (Dofus.getInstance().options.orderFighters && Kernel.getWorker().getFrame(FightEntitiesFrame))
            {
                (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).updateAllEntitiesNumber(param1);
            }
            return;
        }// end function

        private function confirmTurnEnd() : void
        {
            var _loc_3:CharacterCharacteristicsInformations = null;
            var _loc_1:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations;
            if (_loc_1)
            {
                BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
                KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd, this._lastPlayerId);
                if (this._lastPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
                    _loc_3.actionPointsCurrent = _loc_1.stats.maxActionPoints;
                    _loc_3.movementPointsCurrent = _loc_1.stats.maxMovementPoints;
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
                    SpellWrapper.refreshAllPlayerSpellHolder(this._lastPlayerId);
                }
                _loc_1.stats.actionPoints = _loc_1.stats.maxActionPoints;
                _loc_1.stats.movementPoints = _loc_1.stats.maxMovementPoints;
                KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd, this._lastPlayerId);
            }
            var _loc_2:* = new GameFightTurnReadyMessage();
            _loc_2.initGameFightTurnReadyMessage(true);
            ConnectionsHandler.getConnection().send(_loc_2);
            return;
        }// end function

        private function leaveSpectatorMode() : void
        {
            this._synchroniseFighters = null;
            Kernel.getWorker().removeFrame(this);
            var _loc_1:* = new GameFightEndMessage();
            _loc_1.initGameFightEndMessage();
            Kernel.getWorker().process(_loc_1);
            return;
        }// end function

        private function endBattle(param1:GameFightEndMessage) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:FightContextFrame = null;
            var _loc_2:* = FightEntitiesHolder.getInstance();
            var _loc_3:* = _loc_2.getEntities();
            for each (_loc_4 in _loc_3)
            {
                
                (_loc_4 as AnimatedCharacter).display();
            }
            _loc_2.reset();
            this._synchroniseFighters = null;
            Kernel.getWorker().removeFrame(this);
            _loc_5 = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            _loc_5.process(param1);
            return;
        }// end function

        private function onSkipTurnTimeOut(event:TimerEvent) : void
        {
            var _loc_2:Action = null;
            this._skipTurnTimer.removeEventListener(TimerEvent.TIMER, this.onSkipTurnTimeOut);
            this._skipTurnTimer = null;
            if (AFKFightManager.getInstance().isAfk)
            {
                _loc_2 = new GameFightTurnFinishAction();
                Kernel.getWorker().process(_loc_2);
            }
            return;
        }// end function

        private function gameFightSynchronize(param1:Vector.<GameFightFighterInformations>) : void
        {
            var _loc_4:GameFightFighterInformations = null;
            var _loc_2:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            var _loc_3:* = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            for each (_loc_4 in param1)
            {
                
                if (_loc_4.alive)
                {
                    _loc_2.updateFighter(_loc_4);
                    if (_loc_3 && _loc_3.currentPlayerId == _loc_4.contextualId)
                    {
                        BuffManager.getInstance().markFinishingBuffs(_loc_4.contextualId, true);
                    }
                }
            }
            return;
        }// end function

    }
}
