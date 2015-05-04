package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
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
   import com.ankamagames.jerakine.messages.Message;
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
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnStartPlayingMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnReadyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.DisableAfkAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   import gs.TweenMax;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
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
   
   public class FightBattleFrame extends Object implements Frame
   {
      
      public function FightBattleFrame()
      {
         this._turnFrame = new FightTurnFrame();
         this._playerTargetedEntitiesList = new Vector.<int>(0);
         this._infoEntitiesFrame = new InfoEntitiesFrame();
         super();
      }
      
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
      
      private var _synchroniseFightersInstanceId:uint = 4.294967295E9;
      
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
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      public function get fightersList() : Vector.<int>
      {
         return this._turnsList;
      }
      
      public function set fightersList(param1:Vector.<int>) : void
      {
         this._turnsList = param1;
      }
      
      public function get deadFightersList() : Vector.<int>
      {
         return this._deadTurnsList;
      }
      
      public function set deadFightersList(param1:Vector.<int>) : void
      {
         this._deadTurnsList = param1;
      }
      
      public function get targetedEntities() : Vector.<int>
      {
         return this._playerTargetedEntitiesList;
      }
      
      public function get turnsCount() : uint
      {
         return this._turnsCount;
      }
      
      public function set turnsCount(param1:uint) : void
      {
         this._turnsCount = param1;
      }
      
      public function get currentPlayerId() : int
      {
         return this._currentPlayerId;
      }
      
      public function get executingSequence() : Boolean
      {
         return this._executingSequence;
      }
      
      public function get currentSequenceFrame() : FightSequenceFrame
      {
         return this._currentSequenceFrame;
      }
      
      public function get playingSlaveEntity() : Boolean
      {
         return this._playingSlaveEntity;
      }
      
      public function get slaveId() : int
      {
         return this._slaveId;
      }
      
      public function get masterId() : int
      {
         return this._masterId;
      }
      
      public function pushed() : Boolean
      {
         this._playingSlaveEntity = false;
         this._sequenceFrames = new Array();
         DataMapProvider.getInstance().isInFight = true;
         Kernel.getWorker().addFrame(this._turnFrame);
         this._destroyed = false;
         this._autoEndTurnTimer = new Timer(60,1);
         this._autoEndTurnTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.sendAutoEndTurn);
         this._waveSound = new SoundDofus(UISoundEnum.FIGHT_NEW_WAVE);
         this._waveSound.volume = 1;
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:GameFightTurnListMessage = null;
         var _loc3_:GameFightSynchronizeMessage = null;
         var _loc4_:SlaveSwitchContextMessage = null;
         var _loc5_:GameFightTurnStartMessage = null;
         var _loc6_:* = 0;
         var _loc7_:* = false;
         var _loc8_:SoundApi = null;
         var _loc9_:GameFightFighterInformations = null;
         var _loc10_:GameFightFighterInformations = null;
         var _loc11_:* = false;
         var _loc12_:* = false;
         var _loc13_:FightContextFrame = null;
         var _loc14_:Array = null;
         var _loc15_:GameFightTurnEndMessage = null;
         var _loc16_:GameContextActorInformations = null;
         var _loc17_:SequenceStartMessage = null;
         var _loc18_:SequenceEndMessage = null;
         var _loc19_:GameFightNewWaveMessage = null;
         var _loc20_:GameFightNewRoundMessage = null;
         var _loc21_:GameFightLeaveMessage = null;
         var _loc22_:GameFightFighterInformations = null;
         var _loc23_:FightSequenceFrame = null;
         var _loc24_:GameFightEndMessage = null;
         var _loc25_:uint = 0;
         var _loc26_:FighterStatsListMessage = null;
         var _loc27_:GameFightFighterInformations = null;
         var _loc28_:* = 0;
         var _loc29_:AnimatedCharacter = null;
         var _loc30_:SerialSequencer = null;
         var _loc31_:* = NaN;
         var _loc32_:SerialSequencer = null;
         var _loc33_:* = 0;
         var _loc34_:Action = null;
         var _loc35_:FightEntitiesFrame = null;
         var _loc36_:* = 0;
         var _loc37_:GameContextActorInformations = null;
         var _loc38_:Object = null;
         var _loc39_:* = 0;
         var _loc40_:* = 0;
         var _loc41_:GameFightFighterInformations = null;
         var _loc42_:GameActionFightLeaveMessage = null;
         var _loc43_:SequenceEndMessage = null;
         var _loc44_:GameFightEndMessage = null;
         switch(true)
         {
            case param1 is GameFightTurnListMessage:
               _loc2_ = param1 as GameFightTurnListMessage;
               if((this._executingSequence) || (this._currentSequenceFrame))
               {
                  _log.warn("There was a turns list update during this sequence... Let\'s wait its finish before doing it.");
                  this._refreshTurnsList = true;
                  this._newTurnsList = _loc2_.ids;
                  this._newDeadTurnsList = _loc2_.deadsIds;
               }
               else
               {
                  this.updateTurnsList(_loc2_.ids,_loc2_.deadsIds);
               }
               return true;
            case param1 is GameFightSynchronizeMessage:
               _loc3_ = param1 as GameFightSynchronizeMessage;
               if(this._newWave)
               {
                  for each(_loc27_ in _loc3_.fighters)
                  {
                     if((_loc27_.alive) && _loc27_.wave == this._newWaveId && !FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc27_.contextualId))
                     {
                        FightEntitiesFrame.getCurrentInstance().registerActor(_loc27_);
                     }
                  }
               }
               if(this._executingSequence)
               {
                  this._synchroniseFighters = _loc3_.fighters;
                  this._synchroniseFightersInstanceId = FightSequenceFrame.currentInstanceId;
               }
               else
               {
                  this.gameFightSynchronize(_loc3_.fighters,false);
               }
               return true;
            case param1 is SlaveSwitchContextMessage:
               _loc4_ = param1 as SlaveSwitchContextMessage;
               _loc6_ = PlayedCharacterManager.getInstance().id;
               if(_loc4_.masterId == _loc6_)
               {
                  this._masterId = _loc4_.masterId;
                  this._slaveId = _loc4_.slaveId;
                  if(!this._currentPlayerId && this._turnsList.indexOf(this._masterId) > this._turnsList.indexOf(this._slaveId))
                  {
                     this.prepareNextPlayableCharacter(this._masterId);
                  }
               }
               return false;
            case param1 is GameFightTurnStartMessage:
               _loc5_ = param1 as GameFightTurnStartMessage;
               _loc6_ = PlayedCharacterManager.getInstance().id;
               this._currentPlayerId = _loc5_.id;
               _log.info("Start turn for entityId: " + this._currentPlayerId);
               this._playingSlaveEntity = _loc5_.id == this._slaveId;
               this._turnFrame.turnDuration = _loc5_.waitTime;
               _loc7_ = param1 is GameFightTurnResumeMessage;
               if(!_loc7_)
               {
                  BuffManager.getInstance().decrementDuration(_loc5_.id);
               }
               else
               {
                  _loc28_ = CurrentPlayedFighterManager.getInstance().currentFighterId;
                  if((this._slaveId) && (!(this._currentPlayerId == _loc28_)) && (this._slaveId == this._currentPlayerId || this.getNextPlayableCharacterId() == this._slaveId))
                  {
                     this.prepareNextPlayableCharacter(this._masterId);
                  }
               }
               if(_loc5_.id > 0 || (this._playingSlaveEntity))
               {
                  if(!(FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc5_.id).disposition.cellId == -1) && !FightEntitiesHolder.getInstance().getEntity(_loc5_.id))
                  {
                     _loc29_ = DofusEntities.getEntity(_loc5_.id) as AnimatedCharacter;
                     if(_loc29_ != null)
                     {
                        _loc30_ = new SerialSequencer();
                        _loc30_.addStep(new AddGfxEntityStep(154,_loc29_.position.cellId));
                        _loc30_.start();
                        _loc31_ = 65 * _loc29_.look.getScaleY();
                        _loc32_ = new SerialSequencer();
                        _loc32_.addStep(new AddGfxEntityStep(153,_loc29_.position.cellId,0,-_loc31_));
                        _loc32_.start();
                     }
                     this._playerNewTurn = _loc29_;
                  }
               }
               _loc8_ = new SoundApi();
               _loc9_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc5_.id) as GameFightFighterInformations;
               if((_loc5_.id == _loc6_ && _loc9_) && (_loc9_.alive) || (this._playingSlaveEntity))
               {
                  CurrentPlayedFighterManager.getInstance().currentFighterId = _loc5_.id;
                  if(_loc8_.playSoundAtTurnStart())
                  {
                     SoundManager.getInstance().manager.playUISound(UISoundEnum.PLAYER_TURN);
                  }
                  SpellWrapper.refreshAllPlayerSpellHolder(_loc5_.id);
                  this._turnFrame.myTurn = true;
               }
               else
               {
                  this._turnFrame.myTurn = false;
               }
               KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStart,_loc5_.id,_loc5_.waitTime,_loc7_?(param1 as GameFightTurnResumeMessage).remainingTime:_loc5_.waitTime,Dofus.getInstance().options.turnPicture);
               if(this._skipTurnTimer)
               {
                  this._skipTurnTimer.stop();
                  this._skipTurnTimer.removeEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
                  this._skipTurnTimer = null;
               }
               if(_loc5_.id == _loc6_ || (this._playingSlaveEntity))
               {
                  if(AFKFightManager.getInstance().isAfk)
                  {
                     _loc33_ = getTimer();
                     if(AFKFightManager.getInstance().lastTurnSkip + 5 * 1000 < _loc33_)
                     {
                        _loc34_ = new GameFightTurnFinishAction();
                        Kernel.getWorker().process(_loc34_);
                     }
                     else
                     {
                        this._skipTurnTimer = new Timer(5 * 1000 - (_loc33_ - AFKFightManager.getInstance().lastTurnSkip),1);
                        this._skipTurnTimer.addEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
                        this._skipTurnTimer.start();
                     }
                  }
                  else
                  {
                     _loc35_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                     _loc36_ = 0;
                     for each(_loc37_ in _loc35_.getEntitiesDictionnary())
                     {
                        if(_loc37_ is GameFightCharacterInformations && (GameFightCharacterInformations(_loc37_).alive) && _loc37_.contextualId > 0)
                        {
                           _loc36_++;
                        }
                     }
                     if(_loc36_ > 1)
                     {
                        AFKFightManager.getInstance().initialize();
                     }
                  }
                  if(this._slaveId < 0 && ((FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._slaveId) as GameFightFighterInformations).alive) && ((FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._masterId) as GameFightFighterInformations).alive) && (Kernel.getWorker().contains(FightSpellCastFrame)))
                  {
                     Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
                  }
               }
               _loc10_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(FightContextFrame.fighterEntityTooltipId) as GameFightFighterInformations;
               _loc11_ = (_loc10_) && _loc10_.disposition.cellId == FightContextFrame.currentCell;
               _loc12_ = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame).timelineOverEntity;
               if(!_loc11_ && !_loc12_ && (PlayedCharacterManager.getInstance().isSpectator) && OptionManager.getOptionManager("dofus")["spectatorAutoShowCurrentFighterInfo"] == true)
               {
                  KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate,FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc5_.id) as GameFightFighterInformations);
               }
               _loc13_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               _loc14_ = _loc13_.fightersPositionsHistory[_loc5_.id];
               if(_loc14_)
               {
                  _loc40_ = _loc14_.length;
                  _loc39_ = 0;
                  while(_loc39_ < _loc40_)
                  {
                     _loc38_ = _loc14_[_loc39_];
                     _loc38_.lives--;
                     if(_loc38_.lives == 0)
                     {
                        _loc14_.splice(_loc39_,1);
                        _loc39_--;
                        _loc40_--;
                     }
                     _loc39_++;
                  }
               }
               return true;
            case param1 is GameFightTurnStartPlayingMessage:
               KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStartPlaying);
               return true;
            case param1 is GameFightTurnEndMessage:
               _loc15_ = param1 as GameFightTurnEndMessage;
               this._lastPlayerId = _loc15_.id;
               _loc16_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc15_.id);
               if(_loc16_ is GameFightFighterInformations && !(_loc16_ as GameFightFighterInformations).alive)
               {
                  _loc41_ = _loc16_ as GameFightFighterInformations;
                  BuffManager.getInstance().decrementDuration(_loc15_.id);
                  BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
                  _loc41_.stats.actionPoints = _loc41_.stats.maxActionPoints;
                  _loc41_.stats.movementPoints = _loc41_.stats.maxMovementPoints;
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd,this._lastPlayerId);
                  if(_loc15_.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                  {
                     CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
                     SpellWrapper.refreshAllPlayerSpellHolder(_loc15_.id);
                  }
               }
               if(_loc15_.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  AFKFightManager.getInstance().lastTurnSkip = getTimer();
                  AFKFightManager.getInstance().confirm = true;
                  this._turnFrame.myTurn = false;
               }
               return true;
            case param1 is SequenceStartMessage:
               this._autoEndTurn = false;
               _loc17_ = param1 as SequenceStartMessage;
               if(!this._sequenceFrameSwitcher)
               {
                  this._sequenceFrameSwitcher = new FightSequenceSwitcherFrame();
                  Kernel.getWorker().addFrame(this._sequenceFrameSwitcher);
               }
               this._currentSequenceFrame = new FightSequenceFrame(this,this._currentSequenceFrame);
               this._sequenceFrameSwitcher.currentFrame = this._currentSequenceFrame;
               return true;
            case param1 is SequenceEndMessage:
               _loc18_ = param1 as SequenceEndMessage;
               if(!this._currentSequenceFrame)
               {
                  _log.warn("Wow wow wow, I\'ve got a Sequence End but no Sequence Start? What the hell?");
                  return true;
               }
               this._currentSequenceFrame.mustAck = _loc18_.authorId == CurrentPlayedFighterManager.getInstance().currentFighterId;
               this._currentSequenceFrame.ackIdent = _loc18_.actionId;
               this._sequenceFrameSwitcher.currentFrame = null;
               if(!this._currentSequenceFrame.parent)
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
            case param1 is GameFightTurnReadyRequestMessage:
               if(this._executingSequence)
               {
                  _log.warn("Delaying turn end acknowledgement because we\'re still in a sequence.");
                  this._confirmTurnEnd = true;
               }
               else
               {
                  this.confirmTurnEnd();
               }
               return true;
            case param1 is GameFightNewWaveMessage:
               _loc19_ = param1 as GameFightNewWaveMessage;
               this._newWaveId = _loc19_.id;
               this._newWave = true;
               KernelEventsManager.getInstance().processCallback(FightHookList.WaveUpdated,_loc19_.teamId,_loc19_.id,_loc19_.nbTurnBeforeNextWave);
               return true;
            case param1 is GameFightNewRoundMessage:
               _loc20_ = param1 as GameFightNewRoundMessage;
               this._turnsCount = _loc20_.roundNumber;
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = this._turnsCount - 1;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,this._turnsCount);
               BuffManager.getInstance().spellBuffsToIgnore.length = 0;
               return true;
            case param1 is GameFightLeaveMessage:
               _loc21_ = param1 as GameFightLeaveMessage;
               _loc22_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations;
               _loc23_ = new FightSequenceFrame(this);
               if((_loc22_) && (_loc22_.alive))
               {
                  _loc42_ = new GameActionFightLeaveMessage();
                  _loc23_.process(_loc42_.initGameActionFightLeaveMessage(0,0,_loc21_.charId));
                  this._sequenceFrames.push(_loc23_);
                  this.executeNextSequence();
               }
               if(_loc21_.charId == PlayedCharacterManager.getInstance().id && (PlayedCharacterManager.getInstance().isSpectator))
               {
                  if(this._executingSequence)
                  {
                     this._leaveSpectator = true;
                  }
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave,_loc21_.charId);
               }
               return true;
            case param1 is GameFightEndMessage:
               _loc24_ = param1 as GameFightEndMessage;
               _loc25_ = 5;
               while((this._currentSequenceFrame) && (--_loc25_))
               {
                  _log.error("/!\\ Fight end but no SequenceEnd was received");
                  _loc43_ = new SequenceEndMessage();
                  _loc43_.initSequenceEndMessage();
                  this.process(_loc43_);
               }
               if(this._executingSequence)
               {
                  _log.warn("Delaying fight end because we\'re still in a sequence.");
                  this._endBattle = true;
                  this._battleResults = _loc24_;
               }
               else
               {
                  this.endBattle(_loc24_);
               }
               FightersStateManager.getInstance().endFight();
               CurrentPlayedFighterManager.getInstance().endFight();
               return true;
            case param1 is GameContextDestroyMessage:
               if(this._battleResults)
               {
                  _log.debug("Fin de combat propre (resultat connu)");
                  this.endBattle(this._battleResults);
               }
               else
               {
                  _log.debug("Fin de combat brutale (pas de resultat connu)");
                  this._executingSequence = false;
                  _loc44_ = new GameFightEndMessage();
                  _loc44_.initGameFightEndMessage(0,0,0,null);
                  this.process(_loc44_);
               }
               return true;
            case param1 is DisableAfkAction:
               AFKFightManager.getInstance().confirm = false;
               AFKFightManager.getInstance().enabled = false;
               return true;
            case param1 is ShowAllNamesAction:
               if(Kernel.getWorker().contains(InfoEntitiesFrame))
               {
                  Kernel.getWorker().removeFrame(this._infoEntitiesFrame);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._infoEntitiesFrame);
               }
               return true;
            case param1 is FighterStatsListMessage:
               _loc26_ = param1 as FighterStatsListMessage;
               CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(PlayedCharacterManager.getInstance().id,_loc26_.stats);
               SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         var _loc1_:* = 0;
         var _loc2_:FightSequenceFrame = null;
         DataMapProvider.getInstance().isInFight = false;
         TweenMax.killAllTweens(false);
         if(Kernel.getWorker().contains(FightTurnFrame))
         {
            Kernel.getWorker().removeFrame(this._turnFrame);
         }
         BuffManager.getInstance().destroy();
         MarkedCellsManager.getInstance().destroy();
         LinkedCellsManager.getInstance().destroy();
         if((this._executingSequence) || (Kernel.getWorker().contains(FightSequenceFrame)))
         {
            _log.warn("Wow, wait. We\'re pulling FightBattle but there\'s still sequences inside the worker !!");
            _loc2_ = Kernel.getWorker().getFrame(FightSequenceFrame) as FightSequenceFrame;
            Kernel.getWorker().removeFrame(_loc2_);
         }
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
         if(this._playerNewTurn)
         {
            this._playerNewTurn.destroy();
         }
         if(this._skipTurnTimer)
         {
            this._skipTurnTimer.reset();
            this._skipTurnTimer.removeEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
            this._skipTurnTimer = null;
         }
         this._destroyed = true;
         for each(_loc1_ in this._playerTargetedEntitiesList)
         {
            TooltipManager.hide("tooltipOverEntity_" + _loc1_);
         }
         TooltipManager.hide("tooltipOverEntity_" + PlayedCharacterManager.getInstance().id);
         if(this._autoEndTurnTimer)
         {
            this._autoEndTurnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.sendAutoEndTurn);
            this._autoEndTurnTimer = null;
         }
         return true;
      }
      
      public function delayCharacterStatsList(param1:CharacterStatsListMessage) : void
      {
         this._delayCslmsg = param1;
      }
      
      public function prepareNextPlayableCharacter(param1:int = 0) : void
      {
         var _loc2_:GameFightFighterInformations = null;
         var _loc3_:* = 0;
         if(this._slaveId)
         {
            if(param1)
            {
               _loc3_ = param1 == this._slaveId?this._masterId:this._slaveId;
            }
            else
            {
               _loc3_ = this.getNextPlayableCharacterId();
            }
            _loc2_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc3_) as GameFightFighterInformations;
            if(!_loc2_ || !_loc2_.alive)
            {
               return;
            }
            CurrentPlayedFighterManager.getInstance().currentFighterId = _loc3_;
            if(_loc3_ == this._masterId)
            {
               CurrentPlayedFighterManager.getInstance().resetPlayerSpellList();
            }
            if(_loc3_ == this._slaveId)
            {
               KernelEventsManager.getInstance().processCallback(CustomUiHookList.SpellMovementAllowed,false);
            }
         }
      }
      
      public function getNextPlayableCharacterId() : int
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc1_:int = CurrentPlayedFighterManager.getInstance().currentFighterId;
         if(!this._slaveId || !this._turnsList)
         {
            return _loc1_;
         }
         var _loc5_:* = 0;
         while(_loc5_ < this._turnsList.length)
         {
            if(this._turnsList[_loc5_] == this._masterId)
            {
               _loc2_ = _loc5_;
            }
            else if(this._turnsList[_loc5_] == this._slaveId)
            {
               _loc3_ = _loc5_;
            }
            
            if(this._turnsList[_loc5_] == this._currentPlayerId)
            {
               _loc4_ = _loc5_;
            }
            _loc5_++;
         }
         if(_loc2_ == _loc4_)
         {
            return this._slaveId;
         }
         if(_loc3_ == _loc4_)
         {
            return this._masterId;
         }
         if(_loc2_ < _loc4_ && _loc3_ > _loc4_)
         {
            return this._slaveId;
         }
         if(_loc2_ > _loc4_ && _loc3_ < _loc4_)
         {
            return this._masterId;
         }
         if(_loc2_ > _loc3_ && _loc2_ < _loc4_)
         {
            return this._slaveId;
         }
         if(_loc2_ < _loc3_ && _loc2_ < _loc4_)
         {
            return this._masterId;
         }
         if(_loc2_ > _loc3_ && _loc2_ > _loc4_)
         {
            return this._slaveId;
         }
         if(_loc2_ < _loc3_ && _loc2_ > _loc4_)
         {
            return this._masterId;
         }
         return 0;
      }
      
      private function executeNextSequence() : Boolean
      {
         if(this._executingSequence)
         {
            return false;
         }
         var _loc1_:FightSequenceFrame = this._sequenceFrames.shift();
         if(_loc1_)
         {
            this._executingSequence = true;
            _loc1_.execute(this.finishSequence(_loc1_));
            return true;
         }
         return false;
      }
      
      private function finishSequence(param1:FightSequenceFrame) : Function
      {
         var sequenceFrame:FightSequenceFrame = param1;
         return function():void
         {
            var ack:* = undefined;
            var characterFrame:* = undefined;
            if(_destroyed)
            {
               return;
            }
            if(sequenceFrame.mustAck)
            {
               ack = new GameActionAcknowledgementMessage();
               ack.initGameActionAcknowledgementMessage(true,sequenceFrame.ackIdent);
               try
               {
                  ConnectionsHandler.getConnection().send(ack);
               }
               catch(e:Error)
               {
                  return;
               }
            }
            FightEventsHelper.sendAllFightEvent(true);
            _log.info("Sequence finished.");
            _executingSequence = false;
            if(_refreshTurnsList)
            {
               _log.warn("There was a turns list refresh delayed, what about updating it now?");
               _refreshTurnsList = false;
               updateTurnsList(_newTurnsList,_newDeadTurnsList);
               _newTurnsList = null;
               _newDeadTurnsList = null;
            }
            if((!_executingSequence) && (_sequenceFrames.length) && _sequenceFrames[0].instanceId >= _synchroniseFightersInstanceId)
            {
               gameFightSynchronize(_synchroniseFighters,false);
               _synchroniseFighters = null;
            }
            if(executeNextSequence())
            {
               return;
            }
            if(_synchroniseFighters)
            {
               gameFightSynchronize(_synchroniseFighters);
               _synchroniseFighters = null;
            }
            if(_delayCslmsg)
            {
               characterFrame = Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame;
               if(characterFrame)
               {
                  characterFrame.updateCharacterStatsList(_delayCslmsg);
               }
               _delayCslmsg = null;
            }
            if(_endBattle)
            {
               _log.warn("This fight must end ! Finishing things now.");
               _endBattle = false;
               endBattle(_battleResults);
               _battleResults = null;
               return;
            }
            if(_confirmTurnEnd)
            {
               _log.warn("There was a turn end delayed, dispatching now.");
               _confirmTurnEnd = false;
               confirmTurnEnd();
            }
         };
      }
      
      private function sendAutoEndTurn(param1:TimerEvent) : void
      {
         var _loc2_:Action = null;
         if(this._autoEndTurn)
         {
            _loc2_ = new GameFightTurnFinishAction();
            Kernel.getWorker().process(_loc2_);
            this._autoEndTurn = false;
         }
         this._autoEndTurnTimer.stop();
      }
      
      private function updateTurnsList(param1:Vector.<int>, param2:Vector.<int>) : void
      {
         this._turnsList = param1;
         this._deadTurnsList = param2;
         KernelEventsManager.getInstance().processCallback(HookList.FightersListUpdated);
         if((Dofus.getInstance().options.orderFighters) && (Kernel.getWorker().getFrame(FightEntitiesFrame)))
         {
            (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).updateAllEntitiesNumber(param1);
         }
      }
      
      private function confirmTurnEnd() : void
      {
         var _loc3_:CharacterCharacteristicsInformations = null;
         var _loc4_:* = 0;
         var _loc1_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations;
         if(_loc1_)
         {
            BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
            _loc1_.stats.actionPoints = _loc1_.stats.maxActionPoints;
            _loc1_.stats.movementPoints = _loc1_.stats.maxMovementPoints;
            if(this._lastPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
               _loc3_ = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
               _loc3_.actionPointsCurrent = _loc1_.stats.maxActionPoints;
               _loc3_.movementPointsCurrent = _loc1_.stats.maxMovementPoints;
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
               SpellWrapper.refreshAllPlayerSpellHolder(this._lastPlayerId);
               for each(_loc4_ in this._playerTargetedEntitiesList)
               {
                  TooltipManager.hide("tooltip_tooltipOverEntity_" + _loc4_);
               }
               this._playerTargetedEntitiesList.length = 0;
               this.prepareNextPlayableCharacter(this._lastPlayerId);
            }
            KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd,this._lastPlayerId);
         }
         var _loc2_:GameFightTurnReadyMessage = new GameFightTurnReadyMessage();
         _loc2_.initGameFightTurnReadyMessage(true);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      private function endBattle(param1:GameFightEndMessage) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:FightContextFrame = null;
         var _loc2_:FightEntitiesHolder = FightEntitiesHolder.getInstance();
         var _loc3_:Dictionary = _loc2_.getEntities();
         for each(_loc4_ in _loc3_)
         {
            (_loc4_ as AnimatedCharacter).display();
         }
         _loc2_.reset();
         this._synchroniseFighters = null;
         Kernel.getWorker().removeFrame(this);
         _loc5_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         _loc5_.process(param1);
      }
      
      private function onSkipTurnTimeOut(param1:TimerEvent) : void
      {
         var _loc2_:Action = null;
         this._skipTurnTimer.removeEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
         this._skipTurnTimer = null;
         if(AFKFightManager.getInstance().isAfk)
         {
            _loc2_ = new GameFightTurnFinishAction();
            Kernel.getWorker().process(_loc2_);
         }
      }
      
      private function gameFightSynchronize(param1:Vector.<GameFightFighterInformations>, param2:Boolean = true) : void
      {
         var _loc6_:* = false;
         var _loc7_:* = false;
         var _loc8_:* = 0;
         var _loc9_:GameFightFighterInformations = null;
         var _loc10_:* = 0;
         var _loc11_:SerialSequencer = null;
         var _loc3_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var _loc4_:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         var _loc5_:BuffManager = BuffManager.getInstance();
         if(param2)
         {
            _loc10_ = 0;
            if(this.currentPlayerId == this.masterId || this.currentPlayerId == this.slaveId)
            {
               _loc10_ = this.currentPlayerId == this.slaveId?this.masterId:this.slaveId;
            }
            BuffManager.getInstance().synchronize(_loc10_);
         }
         for each(_loc9_ in param1)
         {
            if(_loc9_.alive)
            {
               if(_loc4_)
               {
                  BuffManager.getInstance().markFinishingBuffs(_loc9_.contextualId,true);
               }
               _loc7_ = _loc9_.wave == this._newWaveId && !DofusEntities.getEntity(_loc9_.contextualId);
               _loc3_.updateFighter(_loc9_,null,BuffManager.getInstance().getFinishingBuffs(_loc9_.contextualId));
               if(_loc7_)
               {
                  _loc6_ = true;
                  (DofusEntities.getEntity(_loc9_.contextualId) as AnimatedCharacter).visible = false;
                  if(!OptionManager.getOptionManager("tubul")["tubulIsDesactivated"] && _loc8_ == 0)
                  {
                     this._waveSound.play();
                  }
                  _loc11_ = new SerialSequencer();
                  _loc11_.addStep(new WaitStep(300 * _loc8_));
                  _loc11_.addStep(new AddGfxEntityStep(2715,_loc9_.disposition.cellId));
                  _loc11_.addStep(new FightVisibilityStep(_loc9_.contextualId,true));
                  _loc11_.start();
                  _loc8_++;
               }
            }
         }
         if(_loc6_)
         {
            this._newWave = false;
            this._newWaveId = -1;
         }
      }
   }
}
import com.ankamagames.dofus.types.entities.AnimatedCharacter;
import com.ankamagames.atouin.Atouin;
import flash.geom.ColorTransform;
import com.ankamagames.atouin.AtouinConstants;
import gs.TweenMax;

class PlayerColorTransformManager extends Object
{
   
   function PlayerColorTransformManager(param1:AnimatedCharacter)
   {
      super();
      this._player = param1;
      this._alphaValue = param1.alpha;
      this.offSetValue = 0;
   }
   
   private var _offSetValue:Number;
   
   private var _alphaValue:Number;
   
   private var _player:AnimatedCharacter;
   
   public function set offSetValue(param1:Number) : void
   {
      this._offSetValue = param1;
      if(Atouin.getInstance().options.transparentOverlayMode)
      {
         this._player.transform.colorTransform = new ColorTransform(1,1,1,this._alphaValue != 1?this._alphaValue:AtouinConstants.OVERLAY_MODE_ALPHA,param1,param1,param1,0);
      }
      else
      {
         this._player.transform.colorTransform = new ColorTransform(1,1,1,this._alphaValue,param1,param1,param1,0);
      }
   }
   
   public function get offSetValue() : Number
   {
      return this._offSetValue;
   }
   
   public function enlightPlayer() : void
   {
      TweenMax.to(this,0.7,{
         "offSetValue":50,
         "yoyo":1
      });
   }
}
