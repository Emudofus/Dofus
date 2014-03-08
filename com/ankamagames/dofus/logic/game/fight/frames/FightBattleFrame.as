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
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.kernel.Kernel;
   import flash.events.TimerEvent;
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
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.common.managers.AFKFightManager;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightTurnFinishAction;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnStartPlayingMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnReadyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.DisableAfkAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
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
   import __AS3__.vec.*;
   
   public class FightBattleFrame extends Object implements Frame
   {
      
      public function FightBattleFrame() {
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
      
      public function get priority() : int {
         return Priority.HIGH;
      }
      
      public function get fightersList() : Vector.<int> {
         return this._turnsList;
      }
      
      public function set fightersList(param1:Vector.<int>) : void {
         this._turnsList = param1;
      }
      
      public function get deadFightersList() : Vector.<int> {
         return this._deadTurnsList;
      }
      
      public function set deadFightersList(param1:Vector.<int>) : void {
         this._deadTurnsList = param1;
      }
      
      public function get targetedEntities() : Vector.<int> {
         return this._playerTargetedEntitiesList;
      }
      
      public function get turnsCount() : uint {
         return this._turnsCount;
      }
      
      public function set turnsCount(param1:uint) : void {
         this._turnsCount = param1;
      }
      
      public function get currentPlayerId() : int {
         return this._currentPlayerId;
      }
      
      public function get executingSequence() : Boolean {
         return this._executingSequence;
      }
      
      public function get currentSequenceFrame() : FightSequenceFrame {
         return this._currentSequenceFrame;
      }
      
      public function get playingSlaveEntity() : Boolean {
         return this._playingSlaveEntity;
      }
      
      public function get slaveId() : int {
         return this._slaveId;
      }
      
      public function get masterId() : int {
         return this._masterId;
      }
      
      public function pushed() : Boolean {
         this._playingSlaveEntity = false;
         this._sequenceFrames = new Array();
         DataMapProvider.getInstance().isInFight = true;
         Kernel.getWorker().addFrame(this._turnFrame);
         this._destroyed = false;
         this._autoEndTurnTimer = new Timer(60,1);
         this._autoEndTurnTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.sendAutoEndTurn);
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GameFightTurnListMessage = null;
         var _loc3_:GameFightSynchronizeMessage = null;
         var _loc4_:SlaveSwitchContextMessage = null;
         var _loc5_:GameFightTurnStartMessage = null;
         var _loc6_:* = 0;
         var _loc7_:SoundApi = null;
         var _loc8_:GameFightFighterInformations = null;
         var _loc9_:GameFightTurnEndMessage = null;
         var _loc10_:GameContextActorInformations = null;
         var _loc11_:SequenceStartMessage = null;
         var _loc12_:SequenceEndMessage = null;
         var _loc13_:GameFightNewRoundMessage = null;
         var _loc14_:GameFightLeaveMessage = null;
         var _loc15_:GameFightFighterInformations = null;
         var _loc16_:FightSequenceFrame = null;
         var _loc17_:GameFightEndMessage = null;
         var _loc18_:uint = 0;
         var _loc19_:FighterStatsListMessage = null;
         var _loc20_:* = 0;
         var _loc21_:AnimatedCharacter = null;
         var _loc22_:SerialSequencer = null;
         var _loc23_:* = NaN;
         var _loc24_:SerialSequencer = null;
         var _loc25_:* = 0;
         var _loc26_:Action = null;
         var _loc27_:FightEntitiesFrame = null;
         var _loc28_:* = 0;
         var _loc29_:GameContextActorInformations = null;
         var _loc30_:GameFightFighterInformations = null;
         var _loc31_:GameActionFightLeaveMessage = null;
         var _loc32_:SequenceEndMessage = null;
         var _loc33_:GameFightEndMessage = null;
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
               this._playingSlaveEntity = _loc5_.id == this._slaveId;
               this._turnFrame.turnDuration = _loc5_.waitTime;
               if(!(param1 is GameFightTurnResumeMessage))
               {
                  BuffManager.getInstance().decrementDuration(_loc5_.id);
               }
               else
               {
                  if(param1 is GameFightTurnResumeMessage)
                  {
                     _loc20_ = CurrentPlayedFighterManager.getInstance().currentFighterId;
                     if((this._slaveId) && (!(this._currentPlayerId == _loc20_)) && (this._slaveId == this._currentPlayerId || this.getNextPlayableCharacterId() == this._slaveId))
                     {
                        this.prepareNextPlayableCharacter(this._masterId);
                     }
                  }
               }
               if(_loc5_.id > 0 || (this._playingSlaveEntity))
               {
                  if(!(FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc5_.id).disposition.cellId == -1) && !FightEntitiesHolder.getInstance().getEntity(_loc5_.id))
                  {
                     _loc21_ = DofusEntities.getEntity(_loc5_.id) as AnimatedCharacter;
                     if(_loc21_ != null)
                     {
                        _loc22_ = new SerialSequencer();
                        _loc22_.addStep(new AddGfxEntityStep(154,_loc21_.position.cellId));
                        _loc22_.start();
                        _loc23_ = 65 * _loc21_.look.getScaleY();
                        _loc24_ = new SerialSequencer();
                        _loc24_.addStep(new AddGfxEntityStep(153,_loc21_.position.cellId,0,-_loc23_));
                        _loc24_.start();
                     }
                     this._playerNewTurn = _loc21_;
                  }
               }
               _loc7_ = new SoundApi();
               _loc8_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc5_.id) as GameFightFighterInformations;
               if(((_loc5_.id == _loc6_) && (_loc8_)) && (_loc8_.alive) || (this._playingSlaveEntity))
               {
                  CurrentPlayedFighterManager.getInstance().currentFighterId = _loc5_.id;
                  if(_loc7_.playSoundAtTurnStart())
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
               KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStart,_loc5_.id,_loc5_.waitTime,Dofus.getInstance().options.turnPicture);
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
                     _loc25_ = getTimer();
                     if(AFKFightManager.getInstance().lastTurnSkip + 5 * 1000 < _loc25_)
                     {
                        _loc26_ = new GameFightTurnFinishAction();
                        Kernel.getWorker().process(_loc26_);
                     }
                     else
                     {
                        this._skipTurnTimer = new Timer(5 * 1000 - (_loc25_ - AFKFightManager.getInstance().lastTurnSkip),1);
                        this._skipTurnTimer.addEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
                        this._skipTurnTimer.start();
                     }
                  }
                  else
                  {
                     _loc27_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                     _loc28_ = 0;
                     for each (_loc29_ in _loc27_.getEntitiesDictionnary())
                     {
                        if(_loc29_ is GameFightCharacterInformations && (GameFightCharacterInformations(_loc29_).alive) && _loc29_.contextualId > 0)
                        {
                           _loc28_++;
                        }
                     }
                     if(_loc28_ > 1)
                     {
                        AFKFightManager.getInstance().initialize();
                     }
                  }
                  if(this._slaveId < 0 && ((FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._slaveId) as GameFightFighterInformations).alive) && ((FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._masterId) as GameFightFighterInformations).alive) && (Kernel.getWorker().contains(FightSpellCastFrame)))
                  {
                     Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
                  }
               }
               return true;
            case param1 is GameFightTurnStartPlayingMessage:
               KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnStartPlaying);
               return true;
            case param1 is GameFightTurnEndMessage:
               _loc9_ = param1 as GameFightTurnEndMessage;
               this._lastPlayerId = _loc9_.id;
               _loc10_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc9_.id);
               if(_loc10_ is GameFightFighterInformations && !(_loc10_ as GameFightFighterInformations).alive)
               {
                  _loc30_ = _loc10_ as GameFightFighterInformations;
                  BuffManager.getInstance().decrementDuration(_loc9_.id);
                  BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
                  _loc30_.stats.actionPoints = _loc30_.stats.maxActionPoints;
                  _loc30_.stats.movementPoints = _loc30_.stats.maxMovementPoints;
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd,this._lastPlayerId);
                  if(_loc9_.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                  {
                     CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
                     SpellWrapper.refreshAllPlayerSpellHolder(_loc9_.id);
                  }
               }
               if(_loc9_.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  AFKFightManager.getInstance().lastTurnSkip = getTimer();
                  AFKFightManager.getInstance().confirm = true;
                  this._turnFrame.myTurn = false;
               }
               return true;
            case param1 is SequenceStartMessage:
               this._autoEndTurn = false;
               _loc11_ = param1 as SequenceStartMessage;
               if(!this._sequenceFrameSwitcher)
               {
                  this._sequenceFrameSwitcher = new FightSequenceSwitcherFrame();
                  Kernel.getWorker().addFrame(this._sequenceFrameSwitcher);
               }
               this._currentSequenceFrame = new FightSequenceFrame(this,this._currentSequenceFrame);
               this._sequenceFrameSwitcher.currentFrame = this._currentSequenceFrame;
               return true;
            case param1 is SequenceEndMessage:
               _loc12_ = param1 as SequenceEndMessage;
               if(!this._currentSequenceFrame)
               {
                  _log.warn("Wow wow wow, I\'ve got a Sequence End but no Sequence Start? What the hell?");
                  return true;
               }
               this._currentSequenceFrame.mustAck = _loc12_.authorId == CurrentPlayedFighterManager.getInstance().currentFighterId;
               this._currentSequenceFrame.ackIdent = _loc12_.actionId;
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
            case param1 is GameFightNewRoundMessage:
               _loc13_ = param1 as GameFightNewRoundMessage;
               this._turnsCount = _loc13_.roundNumber;
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = this._turnsCount-1;
               KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated,this._turnsCount);
               return true;
            case param1 is GameFightLeaveMessage:
               _loc14_ = param1 as GameFightLeaveMessage;
               _loc15_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations;
               _loc16_ = new FightSequenceFrame(this);
               if((_loc15_) && (_loc15_.alive))
               {
                  _loc31_ = new GameActionFightLeaveMessage();
                  _loc16_.process(_loc31_.initGameActionFightLeaveMessage(0,0,_loc14_.charId));
                  this._sequenceFrames.push(_loc16_);
                  this.executeNextSequence();
               }
               if(_loc14_.charId == PlayedCharacterManager.getInstance().id && (PlayedCharacterManager.getInstance().isSpectator))
               {
                  if(this._executingSequence)
                  {
                     this._leaveSpectator = true;
                  }
                  PlayedCharacterManager.getInstance().resetSummonedCreature();
                  PlayedCharacterManager.getInstance().resetSummonedBomb();
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave,_loc14_.charId);
               }
               return true;
            case param1 is GameFightEndMessage:
               _loc17_ = param1 as GameFightEndMessage;
               _loc18_ = 5;
               while((this._currentSequenceFrame) && (--_loc18_))
               {
                  _log.error("/!\\ Fight end but no SequenceEnd was received");
                  _loc32_ = new SequenceEndMessage();
                  _loc32_.initSequenceEndMessage();
                  this.process(_loc32_);
               }
               if(this._executingSequence)
               {
                  _log.warn("Delaying fight end because we\'re still in a sequence.");
                  this._endBattle = true;
                  this._battleResults = _loc17_;
               }
               else
               {
                  this.endBattle(_loc17_);
               }
               PlayedCharacterManager.getInstance().resetSummonedCreature();
               PlayedCharacterManager.getInstance().resetSummonedBomb();
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
                  _loc33_ = new GameFightEndMessage();
                  _loc33_.initGameFightEndMessage(0,0,0,null);
                  this.process(_loc33_);
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
               _loc19_ = param1 as FighterStatsListMessage;
               CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(CurrentPlayedFighterManager.getInstance().currentFighterId,_loc19_.stats);
               SpellWrapper.refreshAllPlayerSpellHolder(CurrentPlayedFighterManager.getInstance().currentFighterId);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
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
         for each (_loc1_ in this._playerTargetedEntitiesList)
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
      
      public function delayCharacterStatsList(param1:CharacterStatsListMessage) : void {
         this._delayCslmsg = param1;
      }
      
      public function prepareNextPlayableCharacter(param1:int=0) : void {
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
            KernelEventsManager.getInstance().processCallback(CustomUiHookList.SpellMovementAllowed,_loc3_ == this._masterId);
         }
      }
      
      private function getNextPlayableCharacterId() : int {
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
            else
            {
               if(this._turnsList[_loc5_] == this._slaveId)
               {
                  _loc3_ = _loc5_;
               }
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
      
      private function executeNextSequence() : Boolean {
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
      
      private function finishSequence(param1:FightSequenceFrame) : Function {
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
      
      private function sendAutoEndTurn(param1:TimerEvent) : void {
         var _loc2_:Action = null;
         if(this._autoEndTurn)
         {
            _loc2_ = new GameFightTurnFinishAction();
            Kernel.getWorker().process(_loc2_);
            this._autoEndTurn = false;
         }
         this._autoEndTurnTimer.stop();
      }
      
      private function updateTurnsList(param1:Vector.<int>, param2:Vector.<int>) : void {
         this._turnsList = param1;
         this._deadTurnsList = param2;
         KernelEventsManager.getInstance().processCallback(HookList.FightersListUpdated);
         if((Dofus.getInstance().options.orderFighters) && (Kernel.getWorker().getFrame(FightEntitiesFrame)))
         {
            (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).updateAllEntitiesNumber(param1);
         }
      }
      
      private function confirmTurnEnd() : void {
         var _loc3_:CharacterCharacteristicsInformations = null;
         var _loc4_:* = 0;
         var _loc1_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._lastPlayerId) as GameFightFighterInformations;
         if(_loc1_)
         {
            BuffManager.getInstance().markFinishingBuffs(this._lastPlayerId);
            KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd,this._lastPlayerId);
            if(this._lastPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
               _loc3_ = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
               _loc3_.actionPointsCurrent = _loc1_.stats.maxActionPoints;
               _loc3_.movementPointsCurrent = _loc1_.stats.maxMovementPoints;
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               CurrentPlayedFighterManager.getInstance().getSpellCastManager().nextTurn();
               SpellWrapper.refreshAllPlayerSpellHolder(this._lastPlayerId);
               for each (_loc4_ in this._playerTargetedEntitiesList)
               {
                  TooltipManager.hide("tooltip_tooltipOverEntity_" + _loc4_);
               }
               this._playerTargetedEntitiesList.length = 0;
               this.prepareNextPlayableCharacter(this._lastPlayerId);
            }
            _loc1_.stats.actionPoints = _loc1_.stats.maxActionPoints;
            _loc1_.stats.movementPoints = _loc1_.stats.maxMovementPoints;
            KernelEventsManager.getInstance().processCallback(HookList.GameFightTurnEnd,this._lastPlayerId);
         }
         var _loc2_:GameFightTurnReadyMessage = new GameFightTurnReadyMessage();
         _loc2_.initGameFightTurnReadyMessage(true);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      private function endBattle(param1:GameFightEndMessage) : void {
         var _loc4_:* = undefined;
         var _loc5_:FightContextFrame = null;
         var _loc2_:FightEntitiesHolder = FightEntitiesHolder.getInstance();
         var _loc3_:Dictionary = _loc2_.getEntities();
         for each (_loc4_ in _loc3_)
         {
            (_loc4_ as AnimatedCharacter).display();
         }
         _loc2_.reset();
         this._synchroniseFighters = null;
         Kernel.getWorker().removeFrame(this);
         _loc5_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         _loc5_.process(param1);
      }
      
      private function onSkipTurnTimeOut(param1:TimerEvent) : void {
         var _loc2_:Action = null;
         this._skipTurnTimer.removeEventListener(TimerEvent.TIMER,this.onSkipTurnTimeOut);
         this._skipTurnTimer = null;
         if(AFKFightManager.getInstance().isAfk)
         {
            _loc2_ = new GameFightTurnFinishAction();
            Kernel.getWorker().process(_loc2_);
         }
      }
      
      private function gameFightSynchronize(param1:Vector.<GameFightFighterInformations>, param2:Boolean=true) : void {
         var _loc6_:GameFightFighterInformations = null;
         var _loc3_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var _loc4_:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         var _loc5_:BuffManager = BuffManager.getInstance();
         if(param2)
         {
            BuffManager.getInstance().synchronize();
         }
         for each (_loc6_ in param1)
         {
            if(_loc6_.alive)
            {
               if(_loc4_)
               {
                  BuffManager.getInstance().markFinishingBuffs(_loc6_.contextualId,true);
               }
               _loc3_.updateFighter(_loc6_,null,BuffManager.getInstance().getFinishingBuffs(_loc6_.contextualId));
            }
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
   
   function PlayerColorTransformManager(param1:AnimatedCharacter) {
      super();
      this._player = param1;
      this._alphaValue = param1.alpha;
      this.offSetValue = 0;
   }
   
   private var _offSetValue:Number;
   
   private var _alphaValue:Number;
   
   private var _player:AnimatedCharacter;
   
   public function set offSetValue(param1:Number) : void {
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
   
   public function get offSetValue() : Number {
      return this._offSetValue;
   }
   
   public function enlightPlayer() : void {
      TweenMax.to(this,0.7,
         {
            "offSetValue":50,
            "yoyo":1
         });
   }
}
