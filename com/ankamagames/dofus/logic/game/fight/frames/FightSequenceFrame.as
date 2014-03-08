package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.jerakine.sequencer.ParallelStartSequenceStep;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCastMessage;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightPointsVariationMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifeAndShieldPointsLostMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsGainMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsLostMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTeleportOnSameMapMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightExchangePositionsMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSlideMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSummonMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightMarkCellsMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightUnmarkCellsMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightChangeLookMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibilityMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.logic.game.fight.messages.GameActionFightLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDeathMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightVanishMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellEffectMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellSpellMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDodgePointLossMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCooldownVariationMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellImmunityMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibleObstacleMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightKillMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReduceDamagesMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReflectDamagesMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReflectSpellMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightStealKamaMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTackledMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerGlyphTrapMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellableEffectMessage;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightModifyEffectsDurationMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightThrowCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDropCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibleDetectedMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnListMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCloseCombatMessage;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.atouin.types.GraphicCell;
   import flash.geom.Point;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
   import flash.display.Sprite;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
   import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.steps.FightLeavingStateStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightEnteringStateStep;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerEffectMessage;
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.script.BinaryScript;
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.scripts.DofusEmbedScript;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.script.ScriptExec;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.tiphon.sequence.WaitAnimationEventStep;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDeathStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightActionPointsVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightShieldPointsVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightLifeVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMarkTriggeredStep;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.dofus.types.sequences.AddGfxInLineStep;
   import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightLossAnimStep;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightEntityMovementStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTeleportStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightExchangePositionsStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightEntitySlideStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightSummonStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightVisibilityStep;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMarkCellsStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightUnmarkCellsStep;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.logic.game.fight.steps.FightChangeLookStep;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.logic.game.fight.steps.FightChangeVisibilityStep;
   import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMovementPointsVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTemporaryBoostStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightActionPointsLossDodgeStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightMovementPointsLossDodgeStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightVanishStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDispellStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDispellEffectStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDispellSpellStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightSpellCooldownVariationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightSpellImmunityStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightInvisibleObstacleStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightKillStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightReducedDamagesStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightReflectedDamagesStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightReflectedSpellStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightSpellCastStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightCloseCombatStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightStealingKamasStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTackledStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDisplayBuffStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightModifyEffectsDurationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightCarryCharacterStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightThrowCharacterStep;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.fight.steps.FightInvisibleTemporarilyDetectedStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTurnListStep;
   
   public class FightSequenceFrame extends Object implements Frame, ISpellCastProvider
   {
      
      public function FightSequenceFrame(param1:FightBattleFrame, param2:FightSequenceFrame=null) {
         super();
         this._instanceId = _currentInstanceId++;
         this._fightBattleFrame = param1;
         this._parent = param2;
         this.clearBuffer();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightSequenceFrame));
      
      private static var _lastCastingSpell:CastingSpell;
      
      private static var _currentInstanceId:uint;
      
      public static const FIGHT_SEQUENCERS_CATEGORY:String = "FightSequencer";
      
      public static function get lastCastingSpell() : CastingSpell {
         return _lastCastingSpell;
      }
      
      public static function get currentInstanceId() : uint {
         return _currentInstanceId;
      }
      
      private static function deleteTooltip(param1:int) : void {
         var _loc2_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(FightContextFrame.fighterEntityTooltipId == param1 && !(FightContextFrame.fighterEntityTooltipId == _loc2_.timelineOverEntityId))
         {
            if(_loc2_)
            {
               _loc2_.outEntity(param1);
            }
         }
      }
      
      private var _fxScriptId:uint;
      
      private var _scriptStarted:uint;
      
      private var _castingSpell:CastingSpell;
      
      private var _stepsBuffer:Vector.<ISequencable>;
      
      public var mustAck:Boolean;
      
      public var ackIdent:int;
      
      private var _sequenceEndCallback:Function;
      
      private var _subSequenceWaitingCount:uint = 0;
      
      private var _scriptInit:Boolean;
      
      private var _sequencer:SerialSequencer;
      
      private var _parent:FightSequenceFrame;
      
      private var _fightBattleFrame:FightBattleFrame;
      
      private var _fightEntitiesFrame:FightEntitiesFrame;
      
      private var _instanceId:uint;
      
      public function get priority() : int {
         return Priority.HIGHEST;
      }
      
      public function get castingSpell() : CastingSpell {
         return this._castingSpell;
      }
      
      public function get stepsBuffer() : Vector.<ISequencable> {
         return this._stepsBuffer;
      }
      
      public function get parent() : FightSequenceFrame {
         return this._parent;
      }
      
      public function get isWaiting() : Boolean {
         return !(this._subSequenceWaitingCount == 0) || !this._scriptInit;
      }
      
      public function get instanceId() : uint {
         return this._instanceId;
      }
      
      public function pushed() : Boolean {
         this._scriptInit = false;
         return true;
      }
      
      public function pulled() : Boolean {
         this._stepsBuffer = null;
         this._castingSpell = null;
         _lastCastingSpell = null;
         this._sequenceEndCallback = null;
         this._parent = null;
         this._fightBattleFrame = null;
         this._fightEntitiesFrame = null;
         this._sequencer.clear();
         return true;
      }
      
      public function get fightEntitiesFrame() : FightEntitiesFrame {
         if(!this._fightEntitiesFrame)
         {
            this._fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         }
         return this._fightEntitiesFrame;
      }
      
      public function addSubSequence(param1:ISequencer) : void {
         this._subSequenceWaitingCount++;
         this._stepsBuffer.push(new ParallelStartSequenceStep([param1],false));
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GameActionFightSpellCastMessage = null;
         var _loc3_:* = false;
         var _loc4_:uint = 0;
         var _loc5_:* = 0;
         var _loc6_:* = false;
         var _loc7_:Dictionary = null;
         var _loc8_:GameFightFighterInformations = null;
         var _loc9_:PlayedCharacterManager = null;
         var _loc10_:* = false;
         var _loc11_:GameFightFighterInformations = null;
         var _loc12_:GameMapMovementMessage = null;
         var _loc13_:GameActionFightPointsVariationMessage = null;
         var _loc14_:GameActionFightLifeAndShieldPointsLostMessage = null;
         var _loc15_:GameActionFightLifePointsGainMessage = null;
         var _loc16_:GameActionFightLifePointsLostMessage = null;
         var _loc17_:GameActionFightTeleportOnSameMapMessage = null;
         var _loc18_:GameActionFightExchangePositionsMessage = null;
         var _loc19_:GameActionFightSlideMessage = null;
         var _loc20_:GameActionFightSummonMessage = null;
         var _loc21_:GameActionFightMarkCellsMessage = null;
         var _loc22_:GameActionFightUnmarkCellsMessage = null;
         var _loc23_:GameActionFightChangeLookMessage = null;
         var _loc24_:GameActionFightInvisibilityMessage = null;
         var _loc25_:GameContextActorInformations = null;
         var _loc26_:GameActionFightLeaveMessage = null;
         var _loc27_:Dictionary = null;
         var _loc28_:GameContextActorInformations = null;
         var _loc29_:GameActionFightDeathMessage = null;
         var _loc30_:Dictionary = null;
         var _loc31_:* = 0;
         var _loc32_:GameFightFighterInformations = null;
         var _loc33_:GameFightFighterInformations = null;
         var _loc34_:GameFightFighterInformations = null;
         var _loc35_:GameContextActorInformations = null;
         var _loc36_:FightTurnFrame = null;
         var _loc37_:* = false;
         var _loc38_:FightContextFrame = null;
         var _loc39_:GameActionFightVanishMessage = null;
         var _loc40_:GameContextActorInformations = null;
         var _loc41_:FightContextFrame = null;
         var _loc42_:GameActionFightDispellEffectMessage = null;
         var _loc43_:GameActionFightDispellSpellMessage = null;
         var _loc44_:GameActionFightDispellMessage = null;
         var _loc45_:GameActionFightDodgePointLossMessage = null;
         var _loc46_:GameActionFightSpellCooldownVariationMessage = null;
         var _loc47_:GameActionFightSpellImmunityMessage = null;
         var _loc48_:GameActionFightInvisibleObstacleMessage = null;
         var _loc49_:GameActionFightKillMessage = null;
         var _loc50_:GameActionFightReduceDamagesMessage = null;
         var _loc51_:GameActionFightReflectDamagesMessage = null;
         var _loc52_:GameActionFightReflectSpellMessage = null;
         var _loc53_:GameActionFightStealKamaMessage = null;
         var _loc54_:GameActionFightTackledMessage = null;
         var _loc55_:GameActionFightTriggerGlyphTrapMessage = null;
         var _loc56_:* = 0;
         var _loc57_:GameActionFightDispellableEffectMessage = null;
         var _loc58_:CastingSpell = null;
         var _loc59_:AbstractFightDispellableEffect = null;
         var _loc60_:BasicBuff = null;
         var _loc61_:GameActionFightModifyEffectsDurationMessage = null;
         var _loc62_:GameActionFightCarryCharacterMessage = null;
         var _loc63_:GameActionFightThrowCharacterMessage = null;
         var _loc64_:uint = 0;
         var _loc65_:GameActionFightDropCharacterMessage = null;
         var _loc66_:uint = 0;
         var _loc67_:GameActionFightInvisibleDetectedMessage = null;
         var _loc68_:GameFightTurnListMessage = null;
         var _loc69_:GameActionFightCloseCombatMessage = null;
         var _loc70_:Array = null;
         var _loc71_:* = false;
         var _loc72_:SpellLevel = null;
         var _loc73_:SpellWrapper = null;
         var _loc74_:Spell = null;
         var _loc75_:SpellLevel = null;
         var _loc76_:Dictionary = null;
         var _loc77_:GameFightFighterInformations = null;
         var _loc78_:SpellInventoryManagementFrame = null;
         var _loc79_:* = 0;
         var _loc80_:GameFightSpellCooldown = null;
         var _loc81_:uint = 0;
         var _loc82_:EffectInstance = null;
         var _loc83_:TiphonSprite = null;
         var _loc84_:GraphicCell = null;
         var _loc85_:Point = null;
         var _loc86_:GameFightShowFighterRandomStaticPoseMessage = null;
         var _loc87_:Sprite = null;
         var _loc88_:GameFightShowFighterMessage = null;
         var _loc89_:Sprite = null;
         var _loc90_:* = false;
         var _loc91_:* = false;
         var _loc92_:GameContextActorInformations = null;
         var _loc93_:GameFightMonsterInformations = null;
         var _loc94_:Monster = null;
         var _loc95_:GameFightCharacterInformations = null;
         var _loc96_:GameContextActorInformations = null;
         var _loc97_:* = 0;
         var _loc98_:GameFightMonsterInformations = null;
         var _loc99_:Monster = null;
         var _loc100_:GameContextActorInformations = null;
         var _loc101_:* = 0;
         var _loc102_:GameFightMonsterInformations = null;
         var _loc103_:GameFightFighterInformations = null;
         var _loc104_:StateBuff = null;
         var _loc105_:Object = null;
         var _loc106_:* = 0;
         switch(true)
         {
            case param1 is GameActionFightCloseCombatMessage:
            case param1 is GameActionFightSpellCastMessage:
               if(param1 is GameActionFightSpellCastMessage)
               {
                  _loc2_ = param1 as GameActionFightSpellCastMessage;
               }
               else
               {
                  _loc69_ = param1 as GameActionFightCloseCombatMessage;
                  _loc3_ = true;
                  _loc4_ = _loc69_.weaponGenericId;
                  _loc2_ = new GameActionFightSpellCastMessage();
                  _loc2_.initGameActionFightSpellCastMessage(_loc69_.actionId,_loc69_.sourceId,_loc69_.targetId,_loc69_.destinationCellId,_loc69_.critical,_loc69_.silentCast,0,1);
               }
               _loc5_ = this.fightEntitiesFrame.getEntityInfos(_loc2_.sourceId).disposition.cellId;
               if(this._castingSpell)
               {
                  if((_loc3_) && !(_loc4_ == 0))
                  {
                     this.pushCloseCombatStep(_loc2_.sourceId,_loc4_,_loc2_.critical);
                  }
                  else
                  {
                     this.pushSpellCastStep(_loc2_.sourceId,_loc2_.destinationCellId,_loc5_,_loc2_.spellId,_loc2_.spellLevel,_loc2_.critical);
                  }
                  _log.error("Il ne peut y avoir qu\'un seul cast de sort par séquence (" + param1 + ")");
                  break;
               }
               this._castingSpell = new CastingSpell();
               this._castingSpell.casterId = _loc2_.sourceId;
               this._castingSpell.spell = Spell.getSpellById(_loc2_.spellId);
               this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(_loc2_.spellLevel);
               this._castingSpell.isCriticalFail = _loc2_.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL;
               this._castingSpell.isCriticalHit = _loc2_.critical == FightSpellCastCriticalEnum.CRITICAL_HIT;
               this._castingSpell.silentCast = _loc2_.silentCast;
               if(_loc2_.destinationCellId != -1)
               {
                  this._castingSpell.targetedCell = MapPoint.fromCellId(_loc2_.destinationCellId);
               }
               else
               {
                  _log.error("PAS D\'INFO");
               }
               if(this._castingSpell.isCriticalFail)
               {
                  this._fxScriptId = 0;
               }
               else
               {
                  this._fxScriptId = this._castingSpell.spell.getScriptId(this._castingSpell.isCriticalHit);
               }
               if(param1 is GameActionFightCloseCombatMessage)
               {
                  this._fxScriptId = 7;
                  this._castingSpell.weaponId = GameActionFightCloseCombatMessage(param1).weaponGenericId;
               }
               if(_loc2_.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId && !(_loc2_.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL))
               {
                  _loc70_ = new Array();
                  _loc70_.push(_loc2_.targetId);
                  CurrentPlayedFighterManager.getInstance().getSpellCastManager().castSpell(_loc2_.spellId,_loc2_.spellLevel,_loc70_);
               }
               _loc6_ = _loc2_.critical == FightSpellCastCriticalEnum.CRITICAL_HIT;
               _loc7_ = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               _loc8_ = _loc7_[_loc2_.sourceId];
               if((_loc3_) && !(_loc4_ == 0))
               {
                  this.pushCloseCombatStep(_loc2_.sourceId,_loc4_,_loc2_.critical);
               }
               else
               {
                  this.pushSpellCastStep(_loc2_.sourceId,_loc2_.destinationCellId,_loc5_,_loc2_.spellId,_loc2_.spellLevel,_loc2_.critical);
               }
               if(_loc2_.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.FightSpellCast);
               }
               _loc9_ = PlayedCharacterManager.getInstance();
               _loc10_ = false;
               if((_loc7_[_loc9_.id]) && (_loc8_) && (_loc7_[_loc9_.id] as GameFightFighterInformations).teamId == _loc8_.teamId)
               {
                  _loc10_ = true;
               }
               if(!(_loc2_.sourceId == _loc9_.id) && (_loc10_) && !this._castingSpell.isCriticalFail)
               {
                  _loc71_ = false;
                  for each (_loc73_ in _loc9_.spellsInventory)
                  {
                     if(_loc73_.id == _loc2_.spellId)
                     {
                        _loc71_ = true;
                        _loc72_ = _loc73_.spellLevelInfos;
                        break;
                     }
                  }
                  _loc74_ = Spell.getSpellById(_loc2_.spellId);
                  _loc75_ = _loc74_.getSpellLevel(_loc2_.spellLevel);
                  if(_loc75_.globalCooldown)
                  {
                     if(_loc71_)
                     {
                        if(_loc75_.globalCooldown == -1)
                        {
                           _loc79_ = _loc72_.minCastInterval;
                        }
                        else
                        {
                           _loc79_ = _loc75_.globalCooldown;
                        }
                        this.pushSpellCooldownVariationStep(_loc9_.id,0,_loc2_.spellId,_loc79_);
                     }
                     _loc76_ = this.fightEntitiesFrame.getEntitiesDictionnary();
                     _loc78_ = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
                     for each (_loc77_ in _loc76_)
                     {
                        if(_loc77_ is GameFightCompanionInformations && !(_loc2_.sourceId == _loc77_.contextualId) && (_loc77_ as GameFightCompanionInformations).masterId == _loc9_.id)
                        {
                           _loc80_ = new GameFightSpellCooldown();
                           _loc80_.initGameFightSpellCooldown(_loc2_.spellId,_loc75_.globalCooldown);
                           _loc78_.addSpellGlobalCoolDownInfo(_loc77_.contextualId,_loc80_);
                        }
                     }
                  }
               }
               _loc31_ = PlayedCharacterManager.getInstance().id;
               _loc32_ = this.fightEntitiesFrame.getEntityInfos(_loc2_.sourceId) as GameFightFighterInformations;
               _loc34_ = this.fightEntitiesFrame.getEntityInfos(_loc31_) as GameFightFighterInformations;
               if(_loc6_)
               {
                  if(_loc2_.sourceId == _loc31_)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_OWNER);
                  }
                  else
                  {
                     if((_loc34_) && _loc32_.teamId == _loc34_.teamId)
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ALLIED);
                     }
                     else
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ENEMY);
                     }
                  }
               }
               else
               {
                  if(_loc2_.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
                  {
                     if(_loc2_.sourceId == _loc31_)
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_OWNER);
                     }
                     else
                     {
                        if((_loc34_) && _loc32_.teamId == _loc34_.teamId)
                        {
                           SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ALLIED);
                        }
                        else
                        {
                           SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ENEMY);
                        }
                     }
                  }
               }
               _loc11_ = this.fightEntitiesFrame.getEntityInfos(_loc2_.targetId) as GameFightFighterInformations;
               if((_loc11_) && _loc11_.disposition.cellId == -1)
               {
                  for each (_loc82_ in this._castingSpell.spellRank.effects)
                  {
                     if(_loc82_.hasOwnProperty("zoneShape"))
                     {
                        _loc81_ = _loc82_.zoneShape;
                        break;
                     }
                  }
                  if(_loc81_ == SpellShapeEnum.P)
                  {
                     _loc83_ = DofusEntities.getEntity(_loc2_.targetId) as TiphonSprite;
                     if((_loc83_) && (this._castingSpell) && (this._castingSpell.targetedCell))
                     {
                        _loc84_ = InteractiveCellManager.getInstance().getCell(this._castingSpell.targetedCell.cellId);
                        _loc85_ = _loc84_.parent.localToGlobal(new Point(_loc84_.x + _loc84_.width / 2,_loc84_.y + _loc84_.height / 2));
                        _loc83_.x = _loc85_.x;
                        _loc83_.y = _loc85_.y;
                     }
                  }
               }
               return true;
            case param1 is GameMapMovementMessage:
               _loc12_ = param1 as GameMapMovementMessage;
               if(_loc12_.actorId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerFightMove);
               }
               this.pushMovementStep(_loc12_.actorId,MapMovementAdapter.getClientMovement(_loc12_.keyMovements));
               return true;
            case param1 is GameActionFightPointsVariationMessage:
               _loc13_ = param1 as GameActionFightPointsVariationMessage;
               this.pushPointsVariationStep(_loc13_.targetId,_loc13_.actionId,_loc13_.delta);
               return true;
            case param1 is GameActionFightLifeAndShieldPointsLostMessage:
               _loc14_ = param1 as GameActionFightLifeAndShieldPointsLostMessage;
               this.pushShieldPointsVariationStep(_loc14_.targetId,-_loc14_.shieldLoss,_loc14_.actionId);
               this.pushLifePointsVariationStep(_loc14_.targetId,-_loc14_.loss,-_loc14_.permanentDamages,_loc14_.actionId);
               return true;
            case param1 is GameActionFightLifePointsGainMessage:
               _loc15_ = param1 as GameActionFightLifePointsGainMessage;
               this.pushLifePointsVariationStep(_loc15_.targetId,_loc15_.delta,0,_loc15_.actionId);
               return true;
            case param1 is GameActionFightLifePointsLostMessage:
               _loc16_ = param1 as GameActionFightLifePointsLostMessage;
               this.pushLifePointsVariationStep(_loc16_.targetId,-_loc16_.loss,-_loc16_.permanentDamages,_loc16_.actionId);
               return true;
            case param1 is GameActionFightTeleportOnSameMapMessage:
               _loc17_ = param1 as GameActionFightTeleportOnSameMapMessage;
               this.pushTeleportStep(_loc17_.targetId,_loc17_.cellId);
               return true;
            case param1 is GameActionFightExchangePositionsMessage:
               _loc18_ = param1 as GameActionFightExchangePositionsMessage;
               this.pushExchangePositionsStep(_loc18_.sourceId,_loc18_.casterCellId,_loc18_.targetId,_loc18_.targetCellId);
               return true;
            case param1 is GameActionFightSlideMessage:
               _loc19_ = param1 as GameActionFightSlideMessage;
               this.pushSlideStep(_loc19_.targetId,_loc19_.startCellId,_loc19_.endCellId);
               return true;
            case param1 is GameActionFightSummonMessage:
               _loc20_ = param1 as GameActionFightSummonMessage;
               if(_loc20_.actionId == 1024 || _loc20_.actionId == 1097)
               {
                  _loc86_ = new GameFightShowFighterRandomStaticPoseMessage();
                  _loc86_.initGameFightShowFighterRandomStaticPoseMessage(_loc20_.summon);
                  Kernel.getWorker().getFrame(FightEntitiesFrame).process(_loc86_);
                  _loc87_ = DofusEntities.getEntity(_loc20_.summon.contextualId) as Sprite;
                  if(_loc87_)
                  {
                     _loc87_.visible = false;
                  }
                  this.pushVisibilityStep(_loc20_.summon.contextualId,true);
               }
               else
               {
                  _loc88_ = new GameFightShowFighterMessage();
                  _loc88_.initGameFightShowFighterMessage(_loc20_.summon);
                  Kernel.getWorker().getFrame(FightEntitiesFrame).process(_loc88_);
                  _loc89_ = DofusEntities.getEntity(_loc20_.summon.contextualId) as Sprite;
                  if(_loc89_)
                  {
                     _loc89_.visible = false;
                  }
                  this.pushSummonStep(_loc20_.sourceId,_loc20_.summon);
                  if(_loc20_.sourceId == PlayedCharacterManager.getInstance().id && !(_loc20_.actionId == 185))
                  {
                     _loc90_ = false;
                     _loc91_ = false;
                     if(_loc20_.actionId == 1008)
                     {
                        _loc90_ = true;
                     }
                     else
                     {
                        _loc92_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc20_.summon.contextualId);
                        _loc90_ = false;
                        _loc93_ = _loc92_ as GameFightMonsterInformations;
                        if(_loc93_)
                        {
                           _loc94_ = Monster.getMonsterById(_loc93_.creatureGenericId);
                           if((_loc94_) && (_loc94_.useBombSlot))
                           {
                              _loc90_ = true;
                           }
                           if((_loc94_) && (_loc94_.useSummonSlot))
                           {
                              _loc91_ = true;
                           }
                        }
                        else
                        {
                           _loc95_ = _loc92_ as GameFightCharacterInformations;
                        }
                     }
                     if((_loc91_) || (_loc95_))
                     {
                        PlayedCharacterManager.getInstance().addSummonedCreature();
                     }
                     else
                     {
                        if(_loc90_)
                        {
                           PlayedCharacterManager.getInstance().addSummonedBomb();
                        }
                     }
                  }
               }
               return true;
            case param1 is GameActionFightMarkCellsMessage:
               _loc21_ = param1 as GameActionFightMarkCellsMessage;
               if(this._castingSpell)
               {
                  this._castingSpell.markId = _loc21_.mark.markId;
                  this._castingSpell.markType = _loc21_.mark.markType;
                  this.pushMarkCellsStep(_loc21_.mark.markId,_loc21_.mark.markType,_loc21_.mark.cells,_loc21_.mark.markSpellId);
               }
               return true;
            case param1 is GameActionFightUnmarkCellsMessage:
               _loc22_ = param1 as GameActionFightUnmarkCellsMessage;
               this.pushUnmarkCellsStep(_loc22_.markId);
               return true;
            case param1 is GameActionFightChangeLookMessage:
               _loc23_ = param1 as GameActionFightChangeLookMessage;
               this.pushChangeLookStep(_loc23_.targetId,_loc23_.entityLook);
               return true;
            case param1 is GameActionFightInvisibilityMessage:
               _loc24_ = param1 as GameActionFightInvisibilityMessage;
               _loc25_ = this.fightEntitiesFrame.getEntityInfos(_loc24_.targetId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(_loc24_.targetId,_loc25_.disposition.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_loc24_.targetId,0,true);
               this.pushChangeVisibilityStep(_loc24_.targetId,_loc24_.state);
               return true;
            case param1 is GameActionFightLeaveMessage:
               _loc26_ = param1 as GameActionFightLeaveMessage;
               _loc27_ = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               for each (_loc96_ in _loc27_)
               {
                  if(_loc96_ is GameFightFighterInformations)
                  {
                     _loc97_ = (_loc96_ as GameFightFighterInformations).stats.summoner;
                     if(_loc97_ == _loc26_.targetId)
                     {
                        this.pushDeathStep(_loc96_.contextualId);
                     }
                  }
               }
               this.pushDeathStep(_loc26_.targetId,false);
               _loc28_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc26_.targetId);
               if(_loc28_ is GameFightMonsterInformations)
               {
                  _loc98_ = _loc28_ as GameFightMonsterInformations;
                  if(_loc98_.stats.summoner == PlayedCharacterManager.getInstance().id)
                  {
                     _loc99_ = Monster.getMonsterById(_loc98_.creatureGenericId);
                     if(_loc99_.useSummonSlot)
                     {
                        PlayedCharacterManager.getInstance().removeSummonedCreature();
                     }
                     if(_loc99_.useBombSlot)
                     {
                        PlayedCharacterManager.getInstance().removeSummonedBomb();
                     }
                  }
               }
               return true;
            case param1 is GameActionFightDeathMessage:
               _loc29_ = param1 as GameActionFightDeathMessage;
               _loc30_ = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               for each (_loc100_ in _loc30_)
               {
                  if(_loc100_ is GameFightFighterInformations)
                  {
                     _loc101_ = (_loc100_ as GameFightFighterInformations).stats.summoner;
                     if(_loc101_ == _loc29_.targetId)
                     {
                        this.pushDeathStep(_loc100_.contextualId);
                     }
                  }
               }
               _loc31_ = PlayedCharacterManager.getInstance().id;
               _loc32_ = this.fightEntitiesFrame.getEntityInfos(_loc29_.sourceId) as GameFightFighterInformations;
               _loc33_ = this.fightEntitiesFrame.getEntityInfos(_loc29_.targetId) as GameFightFighterInformations;
               _loc34_ = this.fightEntitiesFrame.getEntityInfos(_loc31_) as GameFightFighterInformations;
               if(this._fightBattleFrame.slaveId == _loc29_.targetId || this._fightBattleFrame.masterId == _loc29_.targetId)
               {
                  this._fightBattleFrame.prepareNextPlayableCharacter(_loc29_.targetId);
               }
               if(_loc29_.targetId == _loc31_)
               {
                  if(_loc29_.sourceId == _loc29_.targetId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_HIMSELF);
                  }
                  else
                  {
                     if(_loc32_.teamId != _loc34_.teamId)
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                     }
                     else
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                     }
                  }
               }
               else
               {
                  if(_loc29_.sourceId == _loc31_)
                  {
                     if(_loc33_.teamId != _loc34_.teamId)
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ENEMY);
                     }
                     else
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ALLY);
                     }
                  }
               }
               this.pushDeathStep(_loc29_.targetId);
               _loc35_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc29_.targetId);
               _loc36_ = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
               _loc37_ = ((_loc36_) && (_loc36_.myTurn)) && !(_loc29_.targetId == _loc31_) && (TackleUtil.isTackling(_loc34_,_loc33_,_loc36_.lastPath));
               if(_loc35_ is GameFightMonsterInformations)
               {
                  _loc102_ = _loc35_ as GameFightMonsterInformations;
                  _loc102_.alive = false;
                  if(_loc102_.stats.summoner == PlayedCharacterManager.getInstance().id)
                  {
                     _loc99_ = Monster.getMonsterById(_loc102_.creatureGenericId);
                     if(_loc99_.useSummonSlot)
                     {
                        PlayedCharacterManager.getInstance().removeSummonedCreature();
                     }
                     if(_loc99_.useBombSlot)
                     {
                        PlayedCharacterManager.getInstance().removeSummonedBomb();
                     }
                     SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
                  }
               }
               else
               {
                  if(_loc35_ is GameFightFighterInformations)
                  {
                     (_loc35_ as GameFightFighterInformations).alive = false;
                     if((_loc35_ as GameFightFighterInformations).stats.summoner != 0)
                     {
                        _loc103_ = _loc35_ as GameFightFighterInformations;
                        if(_loc103_.stats.summoner == PlayedCharacterManager.getInstance().id)
                        {
                           PlayedCharacterManager.getInstance().removeSummonedCreature();
                           SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
                        }
                     }
                  }
               }
               _loc38_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(_loc38_)
               {
                  _loc38_.outEntity(_loc29_.targetId);
               }
               FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(_loc29_.targetId);
               if(_loc37_)
               {
                  _loc36_.updatePath();
               }
               return true;
            case param1 is GameActionFightVanishMessage:
               _loc39_ = param1 as GameActionFightVanishMessage;
               this.pushVanishStep(_loc39_.targetId,_loc39_.sourceId);
               _loc40_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc39_.targetId);
               if(_loc40_ is GameFightFighterInformations)
               {
                  (_loc40_ as GameFightFighterInformations).alive = false;
               }
               _loc41_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(_loc41_)
               {
                  _loc41_.outEntity(_loc39_.targetId);
               }
               FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(_loc39_.targetId);
               return true;
            case param1 is GameActionFightTriggerEffectMessage:
               return true;
            case param1 is GameActionFightDispellEffectMessage:
               _loc42_ = param1 as GameActionFightDispellEffectMessage;
               this.pushDispellEffectStep(_loc42_.targetId,_loc42_.boostUID);
               return true;
            case param1 is GameActionFightDispellSpellMessage:
               _loc43_ = param1 as GameActionFightDispellSpellMessage;
               this.pushDispellSpellStep(_loc43_.targetId,_loc43_.spellId);
               return true;
            case param1 is GameActionFightDispellMessage:
               _loc44_ = param1 as GameActionFightDispellMessage;
               this.pushDispellStep(_loc44_.targetId);
               return true;
            case param1 is GameActionFightDodgePointLossMessage:
               _loc45_ = param1 as GameActionFightDodgePointLossMessage;
               this.pushPointsLossDodgeStep(_loc45_.targetId,_loc45_.actionId,_loc45_.amount);
               return true;
            case param1 is GameActionFightSpellCooldownVariationMessage:
               _loc46_ = param1 as GameActionFightSpellCooldownVariationMessage;
               this.pushSpellCooldownVariationStep(_loc46_.targetId,_loc46_.actionId,_loc46_.spellId,_loc46_.value);
               return true;
            case param1 is GameActionFightSpellImmunityMessage:
               _loc47_ = param1 as GameActionFightSpellImmunityMessage;
               this.pushSpellImmunityStep(_loc47_.targetId);
               return true;
            case param1 is GameActionFightInvisibleObstacleMessage:
               _loc48_ = param1 as GameActionFightInvisibleObstacleMessage;
               this.pushInvisibleObstacleStep(_loc48_.sourceId,_loc48_.sourceSpellId);
               return true;
            case param1 is GameActionFightKillMessage:
               _loc49_ = param1 as GameActionFightKillMessage;
               this.pushKillStep(_loc49_.targetId,_loc49_.sourceId);
               return true;
            case param1 is GameActionFightReduceDamagesMessage:
               _loc50_ = param1 as GameActionFightReduceDamagesMessage;
               this.pushReducedDamagesStep(_loc50_.targetId,_loc50_.amount);
               return true;
            case param1 is GameActionFightReflectDamagesMessage:
               _loc51_ = param1 as GameActionFightReflectDamagesMessage;
               this.pushReflectedDamagesStep(_loc51_.sourceId);
               return true;
            case param1 is GameActionFightReflectSpellMessage:
               _loc52_ = param1 as GameActionFightReflectSpellMessage;
               this.pushReflectedSpellStep(_loc52_.targetId);
               return true;
            case param1 is GameActionFightStealKamaMessage:
               _loc53_ = param1 as GameActionFightStealKamaMessage;
               this.pushStealKamasStep(_loc53_.sourceId,_loc53_.targetId,_loc53_.amount);
               return true;
            case param1 is GameActionFightTackledMessage:
               _loc54_ = param1 as GameActionFightTackledMessage;
               this.pushTackledStep(_loc54_.sourceId);
               return true;
            case param1 is GameActionFightTriggerGlyphTrapMessage:
               if(this._castingSpell)
               {
                  this._fightBattleFrame.process(new SequenceEndMessage());
                  this._fightBattleFrame.process(new SequenceStartMessage());
                  this._fightBattleFrame.currentSequenceFrame.process(param1);
                  return true;
               }
               _loc55_ = param1 as GameActionFightTriggerGlyphTrapMessage;
               this.pushMarkTriggeredStep(_loc55_.triggeringCharacterId,_loc55_.sourceId,_loc55_.markId);
               this._fxScriptId = 1;
               this._castingSpell = new CastingSpell();
               this._castingSpell.casterId = _loc55_.sourceId;
               _loc56_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc55_.triggeringCharacterId).disposition.cellId;
               if(_loc56_ != -1)
               {
                  this._castingSpell.targetedCell = MapPoint.fromCellId(_loc56_);
                  this._castingSpell.spell = Spell.getSpellById(1750);
                  this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(1);
               }
               else
               {
                  _log.error("PAS D\'INFO");
               }
               return true;
            case param1 is GameActionFightDispellableEffectMessage:
               _loc57_ = param1 as GameActionFightDispellableEffectMessage;
               if(_loc57_.actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST)
               {
                  _loc58_ = new CastingSpell(false);
               }
               else
               {
                  _loc58_ = new CastingSpell(this._castingSpell == null);
               }
               if(this._castingSpell)
               {
                  _loc58_.castingSpellId = this._castingSpell.castingSpellId;
                  if(this._castingSpell.spell.id == _loc57_.effect.spellId)
                  {
                     _loc58_.spellRank = this._castingSpell.spellRank;
                  }
               }
               _loc58_.spell = Spell.getSpellById(_loc57_.effect.spellId);
               _loc58_.casterId = _loc57_.sourceId;
               _loc59_ = _loc57_.effect;
               _loc60_ = BuffManager.makeBuffFromEffect(_loc59_,_loc58_,_loc57_.actionId);
               if(_loc60_ is StateBuff)
               {
                  _loc104_ = _loc60_ as StateBuff;
                  if(_loc104_.actionId == 952)
                  {
                     _loc105_ = new FightLeavingStateStep(_loc104_.targetId,_loc104_.stateId);
                  }
                  else
                  {
                     _loc105_ = new FightEnteringStateStep(_loc104_.targetId,_loc104_.stateId,_loc104_.effects.durationString);
                  }
                  if(_loc58_ != null)
                  {
                     _loc105_.castingSpellId = _loc58_.castingSpellId;
                  }
                  this._stepsBuffer.push(_loc105_);
               }
               if(_loc59_ is FightTemporaryBoostEffect)
               {
                  _loc106_ = _loc57_.actionId;
                  if(!(_loc106_ == ActionIdConverter.ACTION_CHARACTER_MAKE_INVISIBLE) && !(_loc106_ == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST) && !(_loc106_ == ActionIdConverter.ACTION_CHARACTER_CHANGE_LOOK) && !(_loc106_ == ActionIdConverter.ACTION_CHARACTER_CHANGE_COLOR) && !(_loc106_ == ActionIdConverter.ACTION_CHARACTER_ADD_APPEARANCE) && !(_loc106_ == ActionIdConverter.ACTION_FIGHT_SET_STATE))
                  {
                     this.pushTemporaryBoostStep(_loc57_.effect.targetId,_loc60_.effects.description,_loc60_.effects.duration,_loc60_.effects.durationString);
                  }
               }
               this.pushDisplayBuffStep(_loc60_);
               return true;
            case param1 is GameActionFightModifyEffectsDurationMessage:
               _loc61_ = param1 as GameActionFightModifyEffectsDurationMessage;
               this.pushModifyEffectsDurationStep(_loc61_.sourceId,_loc61_.targetId,_loc61_.delta);
               return false;
            case param1 is GameActionFightCarryCharacterMessage:
               _loc62_ = param1 as GameActionFightCarryCharacterMessage;
               if(_loc62_.cellId != -1)
               {
                  this.pushCarryCharacterStep(_loc62_.sourceId,_loc62_.targetId,_loc62_.cellId);
               }
               return false;
            case param1 is GameActionFightThrowCharacterMessage:
               _loc63_ = param1 as GameActionFightThrowCharacterMessage;
               _loc64_ = this._castingSpell?this._castingSpell.targetedCell.cellId:_loc63_.cellId;
               this.pushThrowCharacterStep(_loc63_.sourceId,_loc63_.targetId,_loc64_);
               return false;
            case param1 is GameActionFightDropCharacterMessage:
               _loc65_ = param1 as GameActionFightDropCharacterMessage;
               _loc66_ = _loc65_.cellId;
               if(_loc66_ == -1 && (this._castingSpell))
               {
                  _loc66_ = this._castingSpell.targetedCell.cellId;
               }
               this.pushThrowCharacterStep(_loc65_.sourceId,_loc65_.targetId,_loc66_);
               return false;
            case param1 is GameActionFightInvisibleDetectedMessage:
               _loc67_ = param1 as GameActionFightInvisibleDetectedMessage;
               this.pushFightInvisibleTemporarilyDetectedStep(_loc67_.sourceId,_loc67_.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(_loc67_.targetId,_loc67_.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_loc67_.targetId,0);
               return true;
            case param1 is GameFightTurnListMessage:
               _loc68_ = param1 as GameFightTurnListMessage;
               this.pushTurnListStep(_loc68_.ids,_loc68_.deadsIds);
               return true;
            case param1 is AbstractGameActionMessage:
               _log.error("Unsupported game action " + param1 + " ! This action was discarded.");
               return true;
         }
         return false;
      }
      
      public function execute(param1:Function=null) : void {
         var _loc2_:BinaryScript = null;
         var _loc3_:SpellFxRunner = null;
         this._sequencer = new SerialSequencer(FIGHT_SEQUENCERS_CATEGORY);
         if(this._parent)
         {
            _log.info("Process sub sequence");
            this._parent.addSubSequence(this._sequencer);
         }
         else
         {
            _log.info("Execute sequence");
         }
         if(this._fxScriptId > 0)
         {
            _loc2_ = DofusEmbedScript.getScript(this._fxScriptId);
            _loc3_ = new SpellFxRunner(this);
            this._scriptStarted = getTimer();
            ScriptExec.exec(_loc2_,_loc3_,true,new Callback(this.executeBuffer,param1,true,true),new Callback(this.executeBuffer,param1,true,false));
         }
         else
         {
            this.executeBuffer(param1,false);
         }
      }
      
      private function executeBuffer(param1:Function, param2:Boolean, param3:Boolean=false) : void {
         var _loc8_:ISequencable = null;
         var _loc10_:* = false;
         var _loc11_:* = false;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:* = false;
         var _loc15_:Dictionary = null;
         var _loc16_:Dictionary = null;
         var _loc17_:Dictionary = null;
         var _loc18_:Dictionary = null;
         var _loc19_:Dictionary = null;
         var _loc20_:* = 0;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc23_:WaitAnimationEventStep = null;
         var _loc24_:uint = 0;
         var _loc25_:PlayAnimationStep = null;
         var _loc26_:FightDeathStep = null;
         var _loc27_:* = 0;
         var _loc28_:FightActionPointsVariationStep = null;
         var _loc29_:FightShieldPointsVariationStep = null;
         var _loc30_:FightLifeVariationStep = null;
         var _loc31_:* = 0;
         var _loc32_:* = 0;
         var _loc33_:* = undefined;
         var _loc34_:uint = 0;
         if(param2)
         {
            _loc24_ = getTimer() - this._scriptStarted;
            if(!param3)
            {
               _log.warn("Script failed during a fight sequence, but still took " + _loc24_ + "ms.");
            }
            else
            {
               _log.info("Script successfuly executed in " + _loc24_ + "ms.");
            }
         }
         var _loc4_:Array = [];
         var _loc5_:Dictionary = new Dictionary(true);
         var _loc6_:Dictionary = new Dictionary(true);
         var _loc7_:Dictionary = new Dictionary(true);
         var _loc9_:* = false;
         for each (_loc8_ in this._stepsBuffer)
         {
            switch(true)
            {
               case _loc8_ is FightMarkTriggeredStep:
                  _loc9_ = true;
                  continue;
               default:
                  continue;
            }
         }
         _loc10_ = OptionManager.getOptionManager("dofus")["allowHitAnim"];
         _loc11_ = OptionManager.getOptionManager("dofus")["allowSpellEffects"];
         _loc12_ = [];
         _loc13_ = [];
         _loc15_ = new Dictionary();
         _loc16_ = new Dictionary(true);
         _loc17_ = new Dictionary(true);
         _loc18_ = new Dictionary(true);
         _loc19_ = new Dictionary(true);
         _loc20_ = this._stepsBuffer.length;
         while(--_loc20_ >= 0)
         {
            if((_loc14_) && (_loc8_))
            {
               _loc8_.clear();
            }
            _loc14_ = true;
            _loc8_ = this._stepsBuffer[_loc20_];
            switch(true)
            {
               case _loc8_ is PlayAnimationStep:
                  _loc25_ = _loc8_ as PlayAnimationStep;
                  if(_loc25_.animation.indexOf(AnimationEnum.ANIM_HIT) != -1)
                  {
                     if(!_loc10_)
                     {
                        continue;
                     }
                     _loc25_.waitEvent = _loc9_;
                     if(_loc25_.target == null)
                     {
                        continue;
                     }
                     if(_loc5_[EntitiesManager.getInstance().getEntityID(_loc25_.target as IEntity)])
                     {
                        continue;
                     }
                     if(_loc6_[_loc25_.target])
                     {
                        continue;
                     }
                     if(!(_loc25_.animation == AnimationEnum.ANIM_HIT) && !(_loc25_.animation == AnimationEnum.ANIM_HIT_CARRYING) && !_loc25_.target.hasAnimation(_loc25_.animation,1))
                     {
                        _loc25_.animation = AnimationEnum.ANIM_HIT;
                     }
                     _loc6_[_loc25_.target] = true;
                  }
                  if(this._castingSpell.casterId < 0)
                  {
                     if(_loc15_[_loc25_.target])
                     {
                        _loc4_.unshift(_loc15_[_loc25_.target]);
                        delete _loc15_[[_loc25_.target]];
                     }
                     if(_loc25_.animation.indexOf(AnimationEnum.ANIM_ATTAQUE_BASE) != -1)
                     {
                        _loc15_[_loc25_.target] = new WaitAnimationEventStep(_loc25_);
                     }
                  }
                  break;
               case _loc8_ is FightDeathStep:
                  _loc26_ = _loc8_ as FightDeathStep;
                  _loc5_[_loc26_.entityId] = true;
                  _loc27_ = this._fightBattleFrame.targetedEntities.indexOf(_loc26_.entityId);
                  if(_loc27_ != -1)
                  {
                     this._fightBattleFrame.targetedEntities.splice(_loc27_,1);
                     TooltipManager.hide("tooltipOverEntity_" + _loc26_.entityId);
                  }
                  break;
               case _loc8_ is FightActionPointsVariationStep:
                  _loc28_ = _loc8_ as FightActionPointsVariationStep;
                  if(_loc28_.voluntarlyUsed)
                  {
                     _loc12_.push(_loc28_);
                     _loc14_ = false;
                     continue;
                  }
                  break;
               case _loc8_ is FightShieldPointsVariationStep:
                  _loc29_ = _loc8_ as FightShieldPointsVariationStep;
                  if(_loc18_[_loc29_.target] == null)
                  {
                     _loc18_[_loc29_.target] = 0;
                  }
                  _loc18_[_loc29_.target] = _loc18_[_loc29_.target] + _loc29_.value;
                  _loc19_[_loc29_.target] = _loc29_;
                  this.showTargetTooltip(_loc29_.target.id);
                  break;
               case _loc8_ is FightLifeVariationStep:
                  _loc30_ = _loc8_ as FightLifeVariationStep;
                  if(_loc30_.delta < 0)
                  {
                     _loc7_[_loc30_.target] = _loc30_;
                  }
                  if(_loc16_[_loc30_.target] == null)
                  {
                     _loc16_[_loc30_.target] = 0;
                  }
                  _loc16_[_loc30_.target] = _loc16_[_loc30_.target] + _loc30_.delta;
                  _loc17_[_loc30_.target] = _loc30_;
                  this.showTargetTooltip(_loc30_.target.id);
                  break;
               case _loc8_ is AddGfxEntityStep:
               case _loc8_ is AddGfxInLineStep:
               case _loc8_ is ParableGfxMovementStep:
               case _loc8_ is AddWorldEntityStep:
                  if(!_loc11_)
                  {
                     continue;
                  }
                  break;
            }
            _loc14_ = false;
            _loc4_.unshift(_loc8_);
         }
         for each (_loc21_ in _loc4_)
         {
            if(_loc21_ is FightLifeVariationStep && _loc16_[_loc21_.target] == 0 && !(_loc18_[_loc21_.target] == null))
            {
               _loc21_.skipTextEvent = true;
            }
         }
         for (_loc22_ in _loc16_)
         {
            if(!(_loc22_ == "null") && !(_loc16_[_loc22_] == 0))
            {
               _loc31_ = _loc4_.indexOf(_loc17_[_loc22_]);
               _loc4_.splice(_loc31_,0,new FightLossAnimStep(_loc22_,_loc16_[_loc22_],FightLifeVariationStep.COLOR));
            }
            _loc17_[_loc22_] = -1;
            _loc16_[_loc22_] = 0;
         }
         for (_loc22_ in _loc18_)
         {
            if(!(_loc22_ == "null") && !(_loc18_[_loc22_] == 0))
            {
               _loc32_ = _loc4_.indexOf(_loc19_[_loc22_]);
               _loc4_.splice(_loc32_,0,new FightLossAnimStep(_loc22_,_loc18_[_loc22_],FightShieldPointsVariationStep.COLOR));
            }
            _loc19_[_loc22_] = -1;
            _loc18_[_loc22_] = 0;
         }
         for each (_loc23_ in _loc15_)
         {
            _loc13_.push(_loc23_);
         }
         if(_loc10_)
         {
            for (_loc33_ in _loc7_)
            {
               if(!_loc6_[_loc33_])
               {
                  _loc34_ = 0;
                  while(_loc34_ < _loc4_.length)
                  {
                     if(_loc4_[_loc34_] == _loc7_[_loc33_])
                     {
                        _loc4_.splice(_loc34_,0,new PlayAnimationStep(_loc33_ as TiphonSprite,AnimationEnum.ANIM_HIT,true,false));
                        break;
                     }
                     _loc34_++;
                  }
               }
            }
         }
         _loc4_ = _loc12_.concat(_loc4_).concat(_loc13_);
         for each (_loc8_ in _loc4_)
         {
            this._sequencer.addStep(_loc8_);
         }
         this.clearBuffer();
         if(!(param1 == null) && !this._parent)
         {
            this._sequenceEndCallback = param1;
            this._sequencer.addEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         }
         _lastCastingSpell = this._castingSpell;
         this._scriptInit = true;
         if(!this._parent)
         {
            if(!this._subSequenceWaitingCount)
            {
               this._sequencer.start();
            }
            else
            {
               _log.warn("Waiting sub sequence init end (" + this._subSequenceWaitingCount + " seq)");
            }
         }
         else
         {
            if(param1 != null)
            {
               param1();
            }
            this._parent.subSequenceInitDone();
         }
      }
      
      private function onSequenceEnd(param1:SequencerEvent) : void {
         this._sequencer.removeEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         this._sequenceEndCallback();
      }
      
      private function subSequenceInitDone() : void {
         this._subSequenceWaitingCount--;
         if((!this.isWaiting) && (this._sequencer) && !this._sequencer.running)
         {
            _log.warn("Sub sequence init end -- Run main sequence");
            this._sequencer.start();
         }
      }
      
      private function pushMovementStep(param1:int, param2:MovementPath) : void {
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param1)));
         var _loc3_:FightEntityMovementStep = new FightEntityMovementStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushTeleportStep(param1:int, param2:int) : void {
         var _loc3_:FightTeleportStep = null;
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param1)));
         if(param2 != -1)
         {
            _loc3_ = new FightTeleportStep(param1,MapPoint.fromCellId(param2));
            if(this.castingSpell != null)
            {
               _loc3_.castingSpellId = this.castingSpell.castingSpellId;
            }
            this._stepsBuffer.push(_loc3_);
         }
      }
      
      private function pushExchangePositionsStep(param1:int, param2:int, param3:int, param4:int) : void {
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param1)));
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param3)));
         var _loc5_:FightExchangePositionsStep = new FightExchangePositionsStep(param1,param2,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushSlideStep(param1:int, param2:int, param3:int) : void {
         if(param2 < 0 || param3 < 0)
         {
            return;
         }
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param1)));
         var _loc4_:FightEntitySlideStep = new FightEntitySlideStep(param1,MapPoint.fromCellId(param2),MapPoint.fromCellId(param3));
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushSummonStep(param1:int, param2:GameFightFighterInformations) : void {
         var _loc3_:FightSummonStep = new FightSummonStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushVisibilityStep(param1:int, param2:Boolean) : void {
         var _loc3_:FightVisibilityStep = new FightVisibilityStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushMarkCellsStep(param1:int, param2:int, param3:Vector.<GameActionMarkedCell>, param4:int) : void {
         var _loc5_:FightMarkCellsStep = new FightMarkCellsStep(param1,param2,this._castingSpell.spellRank,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushUnmarkCellsStep(param1:int) : void {
         var _loc2_:FightUnmarkCellsStep = new FightUnmarkCellsStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushChangeLookStep(param1:int, param2:EntityLook) : void {
         var _loc3_:FightChangeLookStep = new FightChangeLookStep(param1,EntityLookAdapter.fromNetwork(param2));
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushChangeVisibilityStep(param1:int, param2:int) : void {
         var _loc3_:FightChangeVisibilityStep = new FightChangeVisibilityStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushPointsVariationStep(param1:int, param2:uint, param3:int) : void {
         var _loc4_:IFightStep = null;
         switch(param2)
         {
            case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_USE:
               _loc4_ = new FightActionPointsVariationStep(param1,param3,true);
               break;
            case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_LOST:
            case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_WIN:
               _loc4_ = new FightActionPointsVariationStep(param1,param3,false);
               break;
            case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_USE:
               _loc4_ = new FightMovementPointsVariationStep(param1,param3,true);
               break;
            case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_LOST:
            case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_WIN:
               _loc4_ = new FightMovementPointsVariationStep(param1,param3,false);
               break;
            default:
               _log.warn("Points variation with unsupported action (" + param2 + "), skipping.");
               return;
         }
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushShieldPointsVariationStep(param1:int, param2:int, param3:int) : void {
         var _loc4_:FightShieldPointsVariationStep = new FightShieldPointsVariationStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushTemporaryBoostStep(param1:int, param2:String, param3:int, param4:String) : void {
         var _loc5_:FightTemporaryBoostStep = new FightTemporaryBoostStep(param1,param2,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushPointsLossDodgeStep(param1:int, param2:uint, param3:int) : void {
         var _loc4_:IFightStep = null;
         switch(param2)
         {
            case ActionIdConverter.ACTION_FIGHT_SPELL_DODGED_PA:
               _loc4_ = new FightActionPointsLossDodgeStep(param1,param3);
               break;
            case ActionIdConverter.ACTION_FIGHT_SPELL_DODGED_PM:
               _loc4_ = new FightMovementPointsLossDodgeStep(param1,param3);
               break;
            default:
               _log.warn("Points dodge with unsupported action (" + param2 + "), skipping.");
               return;
         }
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushLifePointsVariationStep(param1:int, param2:int, param3:int, param4:int) : void {
         var _loc5_:FightLifeVariationStep = new FightLifeVariationStep(param1,param2,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushDeathStep(param1:int, param2:Boolean=true) : void {
         var _loc3_:FightDeathStep = new FightDeathStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushVanishStep(param1:int, param2:int) : void {
         var _loc3_:FightVanishStep = new FightVanishStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushDispellStep(param1:int) : void {
         var _loc2_:FightDispellStep = new FightDispellStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushDispellEffectStep(param1:int, param2:int) : void {
         var _loc3_:FightDispellEffectStep = new FightDispellEffectStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushDispellSpellStep(param1:int, param2:int) : void {
         var _loc3_:FightDispellSpellStep = new FightDispellSpellStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushSpellCooldownVariationStep(param1:int, param2:int, param3:int, param4:int) : void {
         var _loc5_:FightSpellCooldownVariationStep = new FightSpellCooldownVariationStep(param1,param2,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushSpellImmunityStep(param1:int) : void {
         var _loc2_:FightSpellImmunityStep = new FightSpellImmunityStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushInvisibleObstacleStep(param1:int, param2:int) : void {
         var _loc3_:FightInvisibleObstacleStep = new FightInvisibleObstacleStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushKillStep(param1:int, param2:int) : void {
         var _loc3_:FightKillStep = new FightKillStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushReducedDamagesStep(param1:int, param2:int) : void {
         var _loc3_:FightReducedDamagesStep = new FightReducedDamagesStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushReflectedDamagesStep(param1:int) : void {
         var _loc2_:FightReflectedDamagesStep = new FightReflectedDamagesStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushReflectedSpellStep(param1:int) : void {
         var _loc2_:FightReflectedSpellStep = new FightReflectedSpellStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushSpellCastStep(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:uint) : void {
         var _loc7_:FightSpellCastStep = new FightSpellCastStep(param1,param2,param3,param4,param5,param6);
         if(this.castingSpell != null)
         {
            _loc7_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc7_);
      }
      
      private function pushCloseCombatStep(param1:int, param2:uint, param3:uint) : void {
         var _loc4_:FightCloseCombatStep = new FightCloseCombatStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushStealKamasStep(param1:int, param2:int, param3:uint) : void {
         var _loc4_:FightStealingKamasStep = new FightStealingKamasStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushTackledStep(param1:int) : void {
         var _loc2_:FightTackledStep = new FightTackledStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushMarkTriggeredStep(param1:int, param2:int, param3:int) : void {
         var _loc4_:FightMarkTriggeredStep = new FightMarkTriggeredStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushDisplayBuffStep(param1:BasicBuff) : void {
         var _loc2_:FightDisplayBuffStep = new FightDisplayBuffStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushModifyEffectsDurationStep(param1:int, param2:int, param3:int) : void {
         var _loc4_:FightModifyEffectsDurationStep = new FightModifyEffectsDurationStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushCarryCharacterStep(param1:int, param2:int, param3:int) : void {
         var _loc4_:FightCarryCharacterStep = new FightCarryCharacterStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param2)));
      }
      
      private function pushThrowCharacterStep(param1:int, param2:int, param3:int) : void {
         var _loc4_:FightThrowCharacterStep = new FightThrowCharacterStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushFightInvisibleTemporarilyDetectedStep(param1:int, param2:uint) : void {
         var _loc3_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         var _loc4_:FightInvisibleTemporarilyDetectedStep = new FightInvisibleTemporarilyDetectedStep(_loc3_,param2);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushTurnListStep(param1:Vector.<int>, param2:Vector.<int>) : void {
         var _loc3_:FightTurnListStep = new FightTurnListStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function clearBuffer() : void {
         this._stepsBuffer = new Vector.<ISequencable>(0,false);
      }
      
      private function showTargetTooltip(param1:int) : void {
         var _loc2_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var _loc3_:GameFightFighterInformations = this.fightEntitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
         if((((_loc3_.alive) && (this._castingSpell)) && (this._castingSpell.casterId == PlayedCharacterManager.getInstance().id || _loc2_.battleFrame.playingSlaveEntity)) && (!(param1 == this.castingSpell.casterId)) && this._fightBattleFrame.targetedEntities.indexOf(param1) == -1)
         {
            this._fightBattleFrame.targetedEntities.push(param1);
            if(OptionManager.getOptionManager("dofus")["showPermanentTargetsTooltips"] == true)
            {
               _loc2_.displayEntityTooltip(param1);
            }
         }
      }
   }
}
