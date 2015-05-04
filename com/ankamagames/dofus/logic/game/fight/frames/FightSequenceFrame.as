package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
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
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightPointsVariationMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifeAndShieldPointsLostMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsGainMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsLostMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTeleportOnSameMapMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightExchangePositionsMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSlideMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSummonMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightMarkCellsMessage;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
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
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightActivateGlyphTrapMessage;
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
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.atouin.types.GraphicCell;
   import flash.geom.Point;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
   import flash.display.Sprite;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
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
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.steps.FightLeavingStateStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightEnteringStateStep;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerEffectMessage;
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.scripts.SpellScriptManager;
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
   import com.ankamagames.dofus.logic.game.fight.steps.FightMarkActivateStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDisplayBuffStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightModifyEffectsDurationStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightCarryCharacterStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightThrowCharacterStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightInvisibleTemporarilyDetectedStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightTurnListStep;
   
   public class FightSequenceFrame extends Object implements Frame, ISpellCastProvider
   {
      
      public function FightSequenceFrame(param1:FightBattleFrame, param2:FightSequenceFrame = null)
      {
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
      
      public static function get lastCastingSpell() : CastingSpell
      {
         return _lastCastingSpell;
      }
      
      public static function get currentInstanceId() : uint
      {
         return _currentInstanceId;
      }
      
      private static function deleteTooltip(param1:int) : void
      {
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
      
      private var _teleportThroughPortal:Boolean;
      
      private var _teleportPortalId:int;
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function get castingSpell() : CastingSpell
      {
         return this._castingSpell;
      }
      
      public function get stepsBuffer() : Vector.<ISequencable>
      {
         return this._stepsBuffer;
      }
      
      public function get parent() : FightSequenceFrame
      {
         return this._parent;
      }
      
      public function get isWaiting() : Boolean
      {
         return !(this._subSequenceWaitingCount == 0) || !this._scriptInit;
      }
      
      public function get instanceId() : uint
      {
         return this._instanceId;
      }
      
      public function pushed() : Boolean
      {
         this._scriptInit = false;
         return true;
      }
      
      public function pulled() : Boolean
      {
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
      
      public function get fightEntitiesFrame() : FightEntitiesFrame
      {
         if(!this._fightEntitiesFrame)
         {
            this._fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         }
         return this._fightEntitiesFrame;
      }
      
      public function addSubSequence(param1:ISequencer) : void
      {
         this._subSequenceWaitingCount++;
         this._stepsBuffer.push(new ParallelStartSequenceStep([param1],false));
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:FightContextFrame = null;
         var _loc3_:GameActionFightSpellCastMessage = null;
         var _loc4_:* = false;
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc7_:* = false;
         var _loc8_:Dictionary = null;
         var _loc9_:GameFightFighterInformations = null;
         var _loc10_:PlayedCharacterManager = null;
         var _loc11_:* = false;
         var _loc12_:GameFightFighterInformations = null;
         var _loc13_:GameMapMovementMessage = null;
         var _loc14_:MovementPath = null;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:FightSpellCastFrame = null;
         var _loc19_:GameActionFightPointsVariationMessage = null;
         var _loc20_:GameActionFightLifeAndShieldPointsLostMessage = null;
         var _loc21_:GameActionFightLifePointsGainMessage = null;
         var _loc22_:GameActionFightLifePointsLostMessage = null;
         var _loc23_:GameActionFightTeleportOnSameMapMessage = null;
         var _loc24_:GameActionFightExchangePositionsMessage = null;
         var _loc25_:GameActionFightSlideMessage = null;
         var _loc26_:GameActionFightSummonMessage = null;
         var _loc27_:GameActionFightMarkCellsMessage = null;
         var _loc28_:uint = 0;
         var _loc29_:SpellLevel = null;
         var _loc30_:GameActionFightUnmarkCellsMessage = null;
         var _loc31_:GameActionFightChangeLookMessage = null;
         var _loc32_:GameActionFightInvisibilityMessage = null;
         var _loc33_:GameContextActorInformations = null;
         var _loc34_:GameActionFightLeaveMessage = null;
         var _loc35_:Dictionary = null;
         var _loc36_:GameContextActorInformations = null;
         var _loc37_:GameActionFightDeathMessage = null;
         var _loc38_:Dictionary = null;
         var _loc39_:GameFightFighterInformations = null;
         var _loc40_:* = 0;
         var _loc41_:GameFightFighterInformations = null;
         var _loc42_:GameFightFighterInformations = null;
         var _loc43_:GameFightFighterInformations = null;
         var _loc44_:GameContextActorInformations = null;
         var _loc45_:FightTurnFrame = null;
         var _loc46_:* = false;
         var _loc47_:GameActionFightVanishMessage = null;
         var _loc48_:GameContextActorInformations = null;
         var _loc49_:GameActionFightDispellEffectMessage = null;
         var _loc50_:GameActionFightDispellSpellMessage = null;
         var _loc51_:GameActionFightDispellMessage = null;
         var _loc52_:GameActionFightDodgePointLossMessage = null;
         var _loc53_:GameActionFightSpellCooldownVariationMessage = null;
         var _loc54_:GameActionFightSpellImmunityMessage = null;
         var _loc55_:GameActionFightInvisibleObstacleMessage = null;
         var _loc56_:GameActionFightKillMessage = null;
         var _loc57_:GameActionFightReduceDamagesMessage = null;
         var _loc58_:GameActionFightReflectDamagesMessage = null;
         var _loc59_:GameActionFightReflectSpellMessage = null;
         var _loc60_:GameActionFightStealKamaMessage = null;
         var _loc61_:GameActionFightTackledMessage = null;
         var _loc62_:GameActionFightTriggerGlyphTrapMessage = null;
         var _loc63_:* = 0;
         var _loc64_:MarkInstance = null;
         var _loc65_:GameActionFightActivateGlyphTrapMessage = null;
         var _loc66_:GameActionFightDispellableEffectMessage = null;
         var _loc67_:CastingSpell = null;
         var _loc68_:AbstractFightDispellableEffect = null;
         var _loc69_:BasicBuff = null;
         var _loc70_:GameActionFightModifyEffectsDurationMessage = null;
         var _loc71_:GameActionFightCarryCharacterMessage = null;
         var _loc72_:GameActionFightThrowCharacterMessage = null;
         var _loc73_:uint = 0;
         var _loc74_:GameActionFightDropCharacterMessage = null;
         var _loc75_:uint = 0;
         var _loc76_:GameActionFightInvisibleDetectedMessage = null;
         var _loc77_:GameFightTurnListMessage = null;
         var _loc78_:GameActionFightCloseCombatMessage = null;
         var _loc79_:Array = null;
         var _loc80_:* = false;
         var _loc81_:SpellLevel = null;
         var _loc82_:SpellWrapper = null;
         var _loc83_:Spell = null;
         var _loc84_:SpellLevel = null;
         var _loc85_:Dictionary = null;
         var _loc86_:GameFightFighterInformations = null;
         var _loc87_:SpellInventoryManagementFrame = null;
         var _loc88_:* = 0;
         var _loc89_:GameFightSpellCooldown = null;
         var _loc90_:uint = 0;
         var _loc91_:EffectInstance = null;
         var _loc92_:TiphonSprite = null;
         var _loc93_:GraphicCell = null;
         var _loc94_:Point = null;
         var _loc95_:TiphonSprite = null;
         var _loc96_:AnimatedCharacter = null;
         var _loc97_:GameFightShowFighterRandomStaticPoseMessage = null;
         var _loc98_:Sprite = null;
         var _loc99_:GameFightShowFighterMessage = null;
         var _loc100_:Sprite = null;
         var _loc101_:* = 0;
         var _loc102_:* = false;
         var _loc103_:* = false;
         var _loc104_:GameContextActorInformations = null;
         var _loc105_:GameFightMonsterInformations = null;
         var _loc106_:Monster = null;
         var _loc107_:GameFightCharacterInformations = null;
         var _loc108_:Spell = null;
         var _loc109_:EffectInstanceDice = null;
         var _loc110_:GameContextActorInformations = null;
         var _loc111_:* = 0;
         var _loc112_:GameFightMonsterInformations = null;
         var _loc113_:Monster = null;
         var _loc114_:GameContextActorInformations = null;
         var _loc115_:GameFightMonsterInformations = null;
         var _loc116_:GameFightFighterInformations = null;
         var _loc117_:StateBuff = null;
         var _loc118_:Object = null;
         var _loc119_:* = 0;
         switch(true)
         {
            case param1 is GameActionFightCloseCombatMessage:
            case param1 is GameActionFightSpellCastMessage:
               if(param1 is GameActionFightSpellCastMessage)
               {
                  _loc3_ = param1 as GameActionFightSpellCastMessage;
               }
               else
               {
                  _loc78_ = param1 as GameActionFightCloseCombatMessage;
                  _loc4_ = true;
                  _loc5_ = _loc78_.weaponGenericId;
                  _loc3_ = new GameActionFightSpellCastMessage();
                  _loc3_.initGameActionFightSpellCastMessage(_loc78_.actionId,_loc78_.sourceId,_loc78_.targetId,_loc78_.destinationCellId,_loc78_.critical,_loc78_.silentCast,0,1);
               }
               _loc6_ = this.fightEntitiesFrame.getEntityInfos(_loc3_.sourceId).disposition.cellId;
               if(this._castingSpell)
               {
                  if((_loc4_) && !(_loc5_ == 0))
                  {
                     this.pushCloseCombatStep(_loc3_.sourceId,_loc5_,_loc3_.critical);
                  }
                  else
                  {
                     this.pushSpellCastStep(_loc3_.sourceId,_loc3_.destinationCellId,_loc6_,_loc3_.spellId,_loc3_.spellLevel,_loc3_.critical);
                  }
                  _log.error("Il ne peut y avoir qu\'un seul cast de sort par séquence (" + param1 + ")");
                  break;
               }
               this._castingSpell = new CastingSpell();
               this._castingSpell.casterId = _loc3_.sourceId;
               this._castingSpell.spell = Spell.getSpellById(_loc3_.spellId);
               this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(_loc3_.spellLevel);
               this._castingSpell.isCriticalFail = _loc3_.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL;
               this._castingSpell.isCriticalHit = _loc3_.critical == FightSpellCastCriticalEnum.CRITICAL_HIT;
               this._castingSpell.silentCast = _loc3_.silentCast;
               this._castingSpell.portalIds = _loc3_.portalsIds;
               this._castingSpell.portalMapPoints = MarkedCellsManager.getInstance().getMapPointsFromMarkIds(_loc3_.portalsIds);
               if(!this._fightBattleFrame.currentPlayerId)
               {
                  BuffManager.getInstance().spellBuffsToIgnore.push(this._castingSpell);
               }
               if(_loc3_.destinationCellId != -1)
               {
                  this._castingSpell.targetedCell = MapPoint.fromCellId(_loc3_.destinationCellId);
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
               if(_loc3_.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId && !(_loc3_.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL))
               {
                  _loc79_ = new Array();
                  _loc79_.push(_loc3_.targetId);
                  CurrentPlayedFighterManager.getInstance().getSpellCastManager().castSpell(_loc3_.spellId,_loc3_.spellLevel,_loc79_);
               }
               _loc7_ = _loc3_.critical == FightSpellCastCriticalEnum.CRITICAL_HIT;
               _loc8_ = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               _loc9_ = _loc8_[_loc3_.sourceId];
               if((_loc4_) && !(_loc5_ == 0))
               {
                  this.pushCloseCombatStep(_loc3_.sourceId,_loc5_,_loc3_.critical);
               }
               else
               {
                  this.pushSpellCastStep(_loc3_.sourceId,_loc3_.destinationCellId,_loc6_,_loc3_.spellId,_loc3_.spellLevel,_loc3_.critical);
               }
               if(_loc3_.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.FightSpellCast);
               }
               _loc10_ = PlayedCharacterManager.getInstance();
               _loc11_ = false;
               if((_loc8_[_loc10_.id]) && (_loc9_) && (_loc8_[_loc10_.id] as GameFightFighterInformations).teamId == _loc9_.teamId)
               {
                  _loc11_ = true;
               }
               if(!(_loc3_.sourceId == _loc10_.id) && (_loc11_) && !this._castingSpell.isCriticalFail)
               {
                  _loc80_ = false;
                  for each(_loc82_ in _loc10_.spellsInventory)
                  {
                     if(_loc82_.id == _loc3_.spellId)
                     {
                        _loc80_ = true;
                        _loc81_ = _loc82_.spellLevelInfos;
                        break;
                     }
                  }
                  _loc83_ = Spell.getSpellById(_loc3_.spellId);
                  _loc84_ = _loc83_.getSpellLevel(_loc3_.spellLevel);
                  if(_loc84_.globalCooldown)
                  {
                     if(_loc80_)
                     {
                        if(_loc84_.globalCooldown == -1)
                        {
                           _loc88_ = _loc81_.minCastInterval;
                        }
                        else
                        {
                           _loc88_ = _loc84_.globalCooldown;
                        }
                        this.pushSpellCooldownVariationStep(_loc10_.id,0,_loc3_.spellId,_loc88_);
                     }
                     _loc85_ = this.fightEntitiesFrame.getEntitiesDictionnary();
                     _loc87_ = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
                     for each(_loc86_ in _loc85_)
                     {
                        if(_loc86_ is GameFightCompanionInformations && !(_loc3_.sourceId == _loc86_.contextualId) && (_loc86_ as GameFightCompanionInformations).masterId == _loc10_.id)
                        {
                           _loc89_ = new GameFightSpellCooldown();
                           _loc89_.initGameFightSpellCooldown(_loc3_.spellId,_loc84_.globalCooldown);
                           _loc87_.addSpellGlobalCoolDownInfo(_loc86_.contextualId,_loc89_);
                        }
                     }
                  }
               }
               _loc40_ = PlayedCharacterManager.getInstance().id;
               _loc41_ = this.fightEntitiesFrame.getEntityInfos(_loc3_.sourceId) as GameFightFighterInformations;
               _loc43_ = this.fightEntitiesFrame.getEntityInfos(_loc40_) as GameFightFighterInformations;
               if(_loc7_)
               {
                  if(_loc3_.sourceId == _loc40_)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_OWNER);
                  }
                  else if((_loc43_) && _loc41_.teamId == _loc43_.teamId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ALLIED);
                  }
                  else
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ENEMY);
                  }
                  
               }
               else if(_loc3_.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
               {
                  if(_loc3_.sourceId == _loc40_)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_OWNER);
                  }
                  else if((_loc43_) && _loc41_.teamId == _loc43_.teamId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ALLIED);
                  }
                  else
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ENEMY);
                  }
                  
               }
               
               _loc12_ = this.fightEntitiesFrame.getEntityInfos(_loc3_.targetId) as GameFightFighterInformations;
               if((_loc12_) && _loc12_.disposition.cellId == -1)
               {
                  for each(_loc91_ in this._castingSpell.spellRank.effects)
                  {
                     if(_loc91_.hasOwnProperty("zoneShape"))
                     {
                        _loc90_ = _loc91_.zoneShape;
                        break;
                     }
                  }
                  if(_loc90_ == SpellShapeEnum.P)
                  {
                     _loc92_ = DofusEntities.getEntity(_loc3_.targetId) as TiphonSprite;
                     if((_loc92_) && (this._castingSpell) && (this._castingSpell.targetedCell))
                     {
                        _loc93_ = InteractiveCellManager.getInstance().getCell(this._castingSpell.targetedCell.cellId);
                        _loc94_ = _loc93_.parent.localToGlobal(new Point(_loc93_.x + _loc93_.width / 2,_loc93_.y + _loc93_.height / 2));
                        _loc92_.x = _loc94_.x;
                        _loc92_.y = _loc94_.y;
                     }
                  }
               }
               return true;
            case param1 is GameMapMovementMessage:
               _loc13_ = param1 as GameMapMovementMessage;
               if(_loc13_.actorId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerFightMove);
               }
               _loc14_ = MapMovementAdapter.getClientMovement(_loc13_.keyMovements);
               _loc15_ = _loc14_.getCells();
               _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               _loc17_ = _loc15_.length;
               _loc16_ = 0;
               while(_loc16_ < _loc17_ - 1)
               {
                  _loc2_.saveFighterPosition(_loc13_.actorId,_loc15_[_loc16_]);
                  _loc95_ = DofusEntities.getEntity(_loc13_.actorId) as TiphonSprite;
                  _loc96_ = _loc95_.carriedEntity as AnimatedCharacter;
                  while(_loc96_)
                  {
                     _loc2_.saveFighterPosition(_loc96_.id,_loc15_[_loc16_]);
                     _loc96_ = _loc96_.carriedEntity as AnimatedCharacter;
                  }
                  _loc16_++;
               }
               _loc18_ = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
               if(_loc18_)
               {
                  _loc18_.entityMovement(_loc13_.actorId);
               }
               this.pushMovementStep(_loc13_.actorId,_loc14_);
               return true;
            case param1 is GameActionFightPointsVariationMessage:
               _loc19_ = param1 as GameActionFightPointsVariationMessage;
               this.pushPointsVariationStep(_loc19_.targetId,_loc19_.actionId,_loc19_.delta);
               return true;
            case param1 is GameActionFightLifeAndShieldPointsLostMessage:
               _loc20_ = param1 as GameActionFightLifeAndShieldPointsLostMessage;
               this.pushShieldPointsVariationStep(_loc20_.targetId,-_loc20_.shieldLoss,_loc20_.actionId);
               this.pushLifePointsVariationStep(_loc20_.targetId,-_loc20_.loss,-_loc20_.permanentDamages,_loc20_.actionId);
               return true;
            case param1 is GameActionFightLifePointsGainMessage:
               _loc21_ = param1 as GameActionFightLifePointsGainMessage;
               this.pushLifePointsVariationStep(_loc21_.targetId,_loc21_.delta,0,_loc21_.actionId);
               return true;
            case param1 is GameActionFightLifePointsLostMessage:
               _loc22_ = param1 as GameActionFightLifePointsLostMessage;
               this.pushLifePointsVariationStep(_loc22_.targetId,-_loc22_.loss,-_loc22_.permanentDamages,_loc22_.actionId);
               return true;
            case param1 is GameActionFightTeleportOnSameMapMessage:
               _loc23_ = param1 as GameActionFightTeleportOnSameMapMessage;
               _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(!this.isSpellTeleportingToPreviousPosition())
               {
                  if(!this._teleportThroughPortal)
                  {
                     _loc2_.saveFighterPosition(_loc23_.targetId,_loc2_.entitiesFrame.getEntityInfos(_loc23_.targetId).disposition.cellId);
                  }
                  else
                  {
                     _loc2_.saveFighterPosition(_loc23_.targetId,MarkedCellsManager.getInstance().getMarkDatas(this._teleportPortalId).cells[0]);
                  }
               }
               else if(_loc2_.getFighterPreviousPosition(_loc23_.targetId) == _loc23_.cellId)
               {
                  _loc2_.deleteFighterPreviousPosition(_loc23_.targetId);
               }
               
               this.pushTeleportStep(_loc23_.targetId,_loc23_.cellId);
               this._teleportThroughPortal = false;
               return true;
            case param1 is GameActionFightExchangePositionsMessage:
               _loc24_ = param1 as GameActionFightExchangePositionsMessage;
               _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(!this.isSpellTeleportingToPreviousPosition())
               {
                  _loc2_.saveFighterPosition(_loc24_.sourceId,_loc2_.entitiesFrame.getEntityInfos(_loc24_.sourceId).disposition.cellId);
               }
               else
               {
                  _loc2_.deleteFighterPreviousPosition(_loc24_.sourceId);
               }
               _loc2_.saveFighterPosition(_loc24_.targetId,_loc2_.entitiesFrame.getEntityInfos(_loc24_.targetId).disposition.cellId);
               this.pushExchangePositionsStep(_loc24_.sourceId,_loc24_.casterCellId,_loc24_.targetId,_loc24_.targetCellId);
               return true;
            case param1 is GameActionFightSlideMessage:
               _loc25_ = param1 as GameActionFightSlideMessage;
               _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               _loc2_.saveFighterPosition(_loc25_.targetId,_loc2_.entitiesFrame.getEntityInfos(_loc25_.targetId).disposition.cellId);
               this.pushSlideStep(_loc25_.targetId,_loc25_.startCellId,_loc25_.endCellId);
               return true;
            case param1 is GameActionFightSummonMessage:
               _loc26_ = param1 as GameActionFightSummonMessage;
               if(_loc26_.actionId == 1024 || _loc26_.actionId == 1097)
               {
                  _loc97_ = new GameFightShowFighterRandomStaticPoseMessage();
                  _loc97_.initGameFightShowFighterRandomStaticPoseMessage(_loc26_.summon);
                  Kernel.getWorker().getFrame(FightEntitiesFrame).process(_loc97_);
                  _loc98_ = DofusEntities.getEntity(_loc26_.summon.contextualId) as Sprite;
                  if(_loc98_)
                  {
                     _loc98_.visible = false;
                  }
                  this.pushVisibilityStep(_loc26_.summon.contextualId,true);
               }
               else
               {
                  _loc99_ = new GameFightShowFighterMessage();
                  _loc99_.initGameFightShowFighterMessage(_loc26_.summon);
                  Kernel.getWorker().getFrame(FightEntitiesFrame).process(_loc99_);
                  _loc100_ = DofusEntities.getEntity(_loc26_.summon.contextualId) as Sprite;
                  if(_loc100_)
                  {
                     _loc100_.visible = false;
                  }
                  this.pushSummonStep(_loc26_.sourceId,_loc26_.summon);
                  if(_loc26_.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId && !(_loc26_.actionId == 185))
                  {
                     _loc102_ = false;
                     _loc103_ = false;
                     if(_loc26_.actionId == 1008)
                     {
                        _loc102_ = true;
                     }
                     else
                     {
                        _loc104_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc26_.summon.contextualId);
                        _loc102_ = false;
                        _loc105_ = _loc104_ as GameFightMonsterInformations;
                        if(_loc105_)
                        {
                           _loc106_ = Monster.getMonsterById(_loc105_.creatureGenericId);
                           if((_loc106_) && (_loc106_.useBombSlot))
                           {
                              _loc102_ = true;
                           }
                           if((_loc106_) && (_loc106_.useSummonSlot))
                           {
                              _loc103_ = true;
                           }
                        }
                        else
                        {
                           _loc107_ = _loc104_ as GameFightCharacterInformations;
                        }
                     }
                     if((_loc103_) || (_loc107_))
                     {
                        CurrentPlayedFighterManager.getInstance().addSummonedCreature();
                     }
                     else if(_loc102_)
                     {
                        CurrentPlayedFighterManager.getInstance().addSummonedBomb();
                     }
                     
                  }
                  _loc101_ = this._fightBattleFrame.getNextPlayableCharacterId();
                  if(!(this._fightBattleFrame.currentPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId) && !(_loc101_ == CurrentPlayedFighterManager.getInstance().currentFighterId) && _loc101_ == _loc26_.summon.contextualId)
                  {
                     this._fightBattleFrame.prepareNextPlayableCharacter();
                  }
               }
               return true;
            case param1 is GameActionFightMarkCellsMessage:
               _loc27_ = param1 as GameActionFightMarkCellsMessage;
               _loc28_ = _loc27_.mark.markSpellId;
               if((this._castingSpell) && (this._castingSpell.spell) && !(this._castingSpell.spell.id == 1750))
               {
                  this._castingSpell.markId = _loc27_.mark.markId;
                  this._castingSpell.markType = _loc27_.mark.markType;
                  _loc29_ = this._castingSpell.spellRank;
               }
               else
               {
                  _loc108_ = Spell.getSpellById(_loc28_);
                  _loc29_ = _loc108_.getSpellLevel(_loc27_.mark.markSpellLevel);
                  for each(_loc109_ in _loc29_.effects)
                  {
                     if(_loc109_.effectId == ActionIdConverter.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL || _loc109_.effectId == ActionIdConverter.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL || _loc109_.effectId == ActionIdConverter.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL_ENDTURN)
                     {
                        _loc28_ = _loc109_.parameter0 as uint;
                        _loc29_ = Spell.getSpellById(_loc28_).getSpellLevel(_loc109_.parameter1 as uint);
                        break;
                     }
                  }
               }
               this.pushMarkCellsStep(_loc27_.mark.markId,_loc27_.mark.markType,_loc27_.mark.cells,_loc28_,_loc29_,_loc27_.mark.markTeamId,_loc27_.mark.markimpactCell);
               return true;
            case param1 is GameActionFightUnmarkCellsMessage:
               _loc30_ = param1 as GameActionFightUnmarkCellsMessage;
               this.pushUnmarkCellsStep(_loc30_.markId);
               return true;
            case param1 is GameActionFightChangeLookMessage:
               _loc31_ = param1 as GameActionFightChangeLookMessage;
               this.pushChangeLookStep(_loc31_.targetId,_loc31_.entityLook);
               return true;
            case param1 is GameActionFightInvisibilityMessage:
               _loc32_ = param1 as GameActionFightInvisibilityMessage;
               _loc33_ = this.fightEntitiesFrame.getEntityInfos(_loc32_.targetId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(_loc32_.targetId,_loc33_.disposition.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_loc32_.targetId,0,true);
               this.pushChangeVisibilityStep(_loc32_.targetId,_loc32_.state);
               return true;
            case param1 is GameActionFightLeaveMessage:
               _loc34_ = param1 as GameActionFightLeaveMessage;
               _loc35_ = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               for each(_loc110_ in _loc35_)
               {
                  if(_loc110_ is GameFightFighterInformations)
                  {
                     _loc111_ = (_loc110_ as GameFightFighterInformations).stats.summoner;
                     if(_loc111_ == _loc34_.targetId)
                     {
                        this.pushDeathStep(_loc110_.contextualId);
                     }
                  }
               }
               this.pushDeathStep(_loc34_.targetId,false);
               _loc36_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc34_.targetId);
               if(_loc36_ is GameFightMonsterInformations)
               {
                  _loc112_ = _loc36_ as GameFightMonsterInformations;
                  if(CurrentPlayedFighterManager.getInstance().checkPlayableEntity(_loc112_.stats.summoner))
                  {
                     _loc113_ = Monster.getMonsterById(_loc112_.creatureGenericId);
                     if(_loc113_.useSummonSlot)
                     {
                        CurrentPlayedFighterManager.getInstance().removeSummonedCreature(_loc112_.stats.summoner);
                     }
                     if(_loc113_.useBombSlot)
                     {
                        CurrentPlayedFighterManager.getInstance().removeSummonedBomb(_loc112_.stats.summoner);
                     }
                  }
               }
               return true;
            case param1 is GameActionFightDeathMessage:
               _loc37_ = param1 as GameActionFightDeathMessage;
               _loc38_ = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               for each(_loc114_ in _loc38_)
               {
                  if(_loc114_ is GameFightFighterInformations)
                  {
                     _loc39_ = _loc114_ as GameFightFighterInformations;
                     if((_loc39_.alive) && _loc39_.stats.summoner == _loc37_.targetId)
                     {
                        this.pushDeathStep(_loc114_.contextualId);
                     }
                  }
               }
               _loc40_ = PlayedCharacterManager.getInstance().id;
               _loc41_ = this.fightEntitiesFrame.getEntityInfos(_loc37_.sourceId) as GameFightFighterInformations;
               _loc42_ = this.fightEntitiesFrame.getEntityInfos(_loc37_.targetId) as GameFightFighterInformations;
               _loc43_ = this.fightEntitiesFrame.getEntityInfos(_loc40_) as GameFightFighterInformations;
               if(!(_loc37_.targetId == this._fightBattleFrame.currentPlayerId) && (this._fightBattleFrame.slaveId == _loc37_.targetId || this._fightBattleFrame.masterId == _loc37_.targetId))
               {
                  this._fightBattleFrame.prepareNextPlayableCharacter(_loc37_.targetId);
               }
               if(_loc37_.targetId == _loc40_)
               {
                  if(_loc37_.sourceId == _loc37_.targetId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_HIMSELF);
                  }
                  else if(_loc41_.teamId != _loc43_.teamId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                  }
                  else
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                  }
                  
               }
               else if(_loc37_.sourceId == _loc40_)
               {
                  if(_loc42_.teamId != _loc43_.teamId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ENEMY);
                  }
                  else
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ALLY);
                  }
               }
               
               this.pushDeathStep(_loc37_.targetId);
               _loc44_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc37_.targetId);
               _loc45_ = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
               _loc46_ = (_loc45_ && _loc45_.myTurn) && !(_loc37_.targetId == _loc40_) && (TackleUtil.isTackling(_loc43_,_loc42_,_loc45_.lastPath));
               if(_loc44_ is GameFightMonsterInformations)
               {
                  _loc115_ = _loc44_ as GameFightMonsterInformations;
                  _loc115_.alive = false;
                  if(CurrentPlayedFighterManager.getInstance().checkPlayableEntity(_loc115_.stats.summoner))
                  {
                     _loc113_ = Monster.getMonsterById(_loc115_.creatureGenericId);
                     if(_loc113_.useSummonSlot)
                     {
                        CurrentPlayedFighterManager.getInstance().removeSummonedCreature(_loc115_.stats.summoner);
                     }
                     if(_loc113_.useBombSlot)
                     {
                        CurrentPlayedFighterManager.getInstance().removeSummonedBomb(_loc115_.stats.summoner);
                     }
                     SpellWrapper.refreshAllPlayerSpellHolder(_loc115_.stats.summoner);
                  }
               }
               else if(_loc44_ is GameFightFighterInformations)
               {
                  (_loc44_ as GameFightFighterInformations).alive = false;
                  if((_loc44_ as GameFightFighterInformations).stats.summoner != 0)
                  {
                     _loc116_ = _loc44_ as GameFightFighterInformations;
                     if(CurrentPlayedFighterManager.getInstance().checkPlayableEntity(_loc116_.stats.summoner))
                     {
                        CurrentPlayedFighterManager.getInstance().removeSummonedCreature(_loc116_.stats.summoner);
                        SpellWrapper.refreshAllPlayerSpellHolder(_loc116_.stats.summoner);
                     }
                  }
               }
               
               _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(_loc2_)
               {
                  _loc2_.outEntity(_loc37_.targetId);
               }
               FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(_loc37_.targetId);
               if(_loc46_)
               {
                  _loc45_.updatePath();
               }
               return true;
            case param1 is GameActionFightVanishMessage:
               _loc47_ = param1 as GameActionFightVanishMessage;
               this.pushVanishStep(_loc47_.targetId,_loc47_.sourceId);
               _loc48_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc47_.targetId);
               if(_loc48_ is GameFightFighterInformations)
               {
                  (_loc48_ as GameFightFighterInformations).alive = false;
               }
               _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(_loc2_)
               {
                  _loc2_.outEntity(_loc47_.targetId);
               }
               FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(_loc47_.targetId);
               return true;
            case param1 is GameActionFightTriggerEffectMessage:
               return true;
            case param1 is GameActionFightDispellEffectMessage:
               _loc49_ = param1 as GameActionFightDispellEffectMessage;
               this.pushDispellEffectStep(_loc49_.targetId,_loc49_.boostUID);
               return true;
            case param1 is GameActionFightDispellSpellMessage:
               _loc50_ = param1 as GameActionFightDispellSpellMessage;
               this.pushDispellSpellStep(_loc50_.targetId,_loc50_.spellId);
               return true;
            case param1 is GameActionFightDispellMessage:
               _loc51_ = param1 as GameActionFightDispellMessage;
               this.pushDispellStep(_loc51_.targetId);
               return true;
            case param1 is GameActionFightDodgePointLossMessage:
               _loc52_ = param1 as GameActionFightDodgePointLossMessage;
               this.pushPointsLossDodgeStep(_loc52_.targetId,_loc52_.actionId,_loc52_.amount);
               return true;
            case param1 is GameActionFightSpellCooldownVariationMessage:
               _loc53_ = param1 as GameActionFightSpellCooldownVariationMessage;
               this.pushSpellCooldownVariationStep(_loc53_.targetId,_loc53_.actionId,_loc53_.spellId,_loc53_.value);
               return true;
            case param1 is GameActionFightSpellImmunityMessage:
               _loc54_ = param1 as GameActionFightSpellImmunityMessage;
               this.pushSpellImmunityStep(_loc54_.targetId);
               return true;
            case param1 is GameActionFightInvisibleObstacleMessage:
               _loc55_ = param1 as GameActionFightInvisibleObstacleMessage;
               this.pushInvisibleObstacleStep(_loc55_.sourceId,_loc55_.sourceSpellId);
               return true;
            case param1 is GameActionFightKillMessage:
               _loc56_ = param1 as GameActionFightKillMessage;
               this.pushKillStep(_loc56_.targetId,_loc56_.sourceId);
               return true;
            case param1 is GameActionFightReduceDamagesMessage:
               _loc57_ = param1 as GameActionFightReduceDamagesMessage;
               this.pushReducedDamagesStep(_loc57_.targetId,_loc57_.amount);
               return true;
            case param1 is GameActionFightReflectDamagesMessage:
               _loc58_ = param1 as GameActionFightReflectDamagesMessage;
               this.pushReflectedDamagesStep(_loc58_.sourceId);
               return true;
            case param1 is GameActionFightReflectSpellMessage:
               _loc59_ = param1 as GameActionFightReflectSpellMessage;
               this.pushReflectedSpellStep(_loc59_.targetId);
               return true;
            case param1 is GameActionFightStealKamaMessage:
               _loc60_ = param1 as GameActionFightStealKamaMessage;
               this.pushStealKamasStep(_loc60_.sourceId,_loc60_.targetId,_loc60_.amount);
               return true;
            case param1 is GameActionFightTackledMessage:
               _loc61_ = param1 as GameActionFightTackledMessage;
               this.pushTackledStep(_loc61_.sourceId);
               return true;
            case param1 is GameActionFightTriggerGlyphTrapMessage:
               if(this._castingSpell)
               {
                  this._fightBattleFrame.process(new SequenceEndMessage());
                  this._fightBattleFrame.process(new SequenceStartMessage());
                  this._fightBattleFrame.currentSequenceFrame.process(param1);
                  return true;
               }
               _loc62_ = param1 as GameActionFightTriggerGlyphTrapMessage;
               this.pushMarkTriggeredStep(_loc62_.triggeringCharacterId,_loc62_.sourceId,_loc62_.markId);
               this._fxScriptId = 1;
               this._castingSpell = new CastingSpell();
               this._castingSpell.casterId = _loc62_.sourceId;
               _loc63_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc62_.triggeringCharacterId).disposition.cellId;
               if(_loc63_ != -1)
               {
                  this._castingSpell.targetedCell = MapPoint.fromCellId(_loc63_);
                  this._castingSpell.spell = Spell.getSpellById(1750);
                  this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(1);
               }
               _loc64_ = MarkedCellsManager.getInstance().getMarkDatas(_loc62_.markId);
               if((_loc64_) && _loc64_.markType == GameActionMarkTypeEnum.PORTAL)
               {
                  this._teleportThroughPortal = true;
                  this._teleportPortalId = _loc64_.markId;
               }
               return true;
            case param1 is GameActionFightActivateGlyphTrapMessage:
               _loc65_ = param1 as GameActionFightActivateGlyphTrapMessage;
               this.pushMarkActivateStep(_loc65_.markId,_loc65_.active);
               return true;
            case param1 is GameActionFightDispellableEffectMessage:
               _loc66_ = param1 as GameActionFightDispellableEffectMessage;
               if(_loc66_.actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST)
               {
                  _loc67_ = new CastingSpell(false);
               }
               else
               {
                  _loc67_ = new CastingSpell(this._castingSpell == null);
               }
               if(this._castingSpell)
               {
                  _loc67_.castingSpellId = this._castingSpell.castingSpellId;
                  if(this._castingSpell.castingSpellId == _loc66_.effect.spellId)
                  {
                     _loc67_.spellRank = this._castingSpell.spellRank;
                  }
               }
               _loc67_.spell = Spell.getSpellById(_loc66_.effect.spellId);
               _loc67_.casterId = _loc66_.sourceId;
               _loc68_ = _loc66_.effect;
               _loc69_ = BuffManager.makeBuffFromEffect(_loc68_,_loc67_,_loc66_.actionId);
               if(_loc69_ is StateBuff)
               {
                  _loc117_ = _loc69_ as StateBuff;
                  if(_loc117_.actionId == ActionIdConverter.ACTION_FIGHT_DISABLE_STATE)
                  {
                     _loc118_ = new FightLeavingStateStep(_loc117_.targetId,_loc117_.stateId);
                  }
                  else
                  {
                     _loc118_ = new FightEnteringStateStep(_loc117_.targetId,_loc117_.stateId,_loc117_.effects.durationString);
                  }
                  if(_loc67_ != null)
                  {
                     _loc118_.castingSpellId = _loc67_.castingSpellId;
                  }
                  this._stepsBuffer.push(_loc118_);
               }
               if(_loc68_ is FightTemporaryBoostEffect)
               {
                  _loc119_ = _loc66_.actionId;
                  if(!(_loc119_ == ActionIdConverter.ACTION_CHARACTER_MAKE_INVISIBLE) && !(_loc119_ == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST) && !(_loc119_ == ActionIdConverter.ACTION_CHARACTER_CHANGE_LOOK) && !(_loc119_ == ActionIdConverter.ACTION_CHARACTER_CHANGE_COLOR) && !(_loc119_ == ActionIdConverter.ACTION_CHARACTER_ADD_APPEARANCE) && !(_loc119_ == ActionIdConverter.ACTION_FIGHT_SET_STATE))
                  {
                     this.pushTemporaryBoostStep(_loc66_.effect.targetId,_loc69_.effects.description,_loc69_.effects.duration,_loc69_.effects.durationString);
                  }
                  if(_loc119_ == ActionIdConverter.ACTION_CHARACTER_BOOST_SHIELD)
                  {
                     this.pushShieldPointsVariationStep(_loc66_.effect.targetId,(_loc69_ as StatBuff).delta,_loc119_);
                  }
               }
               this.pushDisplayBuffStep(_loc69_);
               return true;
            case param1 is GameActionFightModifyEffectsDurationMessage:
               _loc70_ = param1 as GameActionFightModifyEffectsDurationMessage;
               this.pushModifyEffectsDurationStep(_loc70_.sourceId,_loc70_.targetId,_loc70_.delta);
               return false;
            case param1 is GameActionFightCarryCharacterMessage:
               _loc71_ = param1 as GameActionFightCarryCharacterMessage;
               if(_loc71_.cellId != -1)
               {
                  _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                  _loc2_.saveFighterPosition(_loc71_.targetId,_loc71_.cellId);
                  this.pushCarryCharacterStep(_loc71_.sourceId,_loc71_.targetId,_loc71_.cellId);
               }
               return false;
            case param1 is GameActionFightThrowCharacterMessage:
               _loc72_ = param1 as GameActionFightThrowCharacterMessage;
               _loc73_ = this._castingSpell?this._castingSpell.targetedCell.cellId:_loc72_.cellId;
               _loc2_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               _loc2_.saveFighterPosition(_loc72_.targetId,DofusEntities.getEntity(_loc72_.targetId).position.cellId);
               this.pushThrowCharacterStep(_loc72_.sourceId,_loc72_.targetId,_loc73_);
               return false;
            case param1 is GameActionFightDropCharacterMessage:
               _loc74_ = param1 as GameActionFightDropCharacterMessage;
               _loc75_ = _loc74_.cellId;
               if(_loc75_ == -1 && (this._castingSpell))
               {
                  _loc75_ = this._castingSpell.targetedCell.cellId;
               }
               this.pushThrowCharacterStep(_loc74_.sourceId,_loc74_.targetId,_loc75_);
               return false;
            case param1 is GameActionFightInvisibleDetectedMessage:
               _loc76_ = param1 as GameActionFightInvisibleDetectedMessage;
               this.pushFightInvisibleTemporarilyDetectedStep(_loc76_.sourceId,_loc76_.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(_loc76_.targetId,_loc76_.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(_loc76_.targetId,0);
               return true;
            case param1 is GameFightTurnListMessage:
               _loc77_ = param1 as GameFightTurnListMessage;
               this.pushTurnListStep(_loc77_.ids,_loc77_.deadsIds);
               return true;
            case param1 is AbstractGameActionMessage:
               _log.error("Unsupported game action " + param1 + " ! This action was discarded.");
               return true;
         }
         return false;
      }
      
      public function execute(param1:Function = null) : void
      {
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
            if((this._castingSpell) && (this._castingSpell.spell))
            {
               _log.info("Executing SpellScript" + this._fxScriptId + " for spell \'" + this._castingSpell.spell.name + "\' (" + this._castingSpell.spell.id + ")");
            }
            else
            {
               _log.info("Executing SpellScript" + this._fxScriptId + " for unknown spell");
            }
            this._scriptStarted = getTimer();
            SpellScriptManager.getInstance().runSpellScript(this._fxScriptId,this,new Callback(this.executeBuffer,param1,true,true),new Callback(this.executeBuffer,param1,true,false));
         }
         else
         {
            this.executeBuffer(param1,false);
         }
      }
      
      private function executeBuffer(param1:Function, param2:Boolean, param3:Boolean = false) : void
      {
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
         for each(_loc8_ in this._stepsBuffer)
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
                        delete _loc15_[_loc25_.target];
                        true;
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
                  if(_loc29_.target == null)
                  {
                     break;
                  }
                  if(_loc29_.value < 0)
                  {
                     _loc29_.virtual = true;
                     if(_loc18_[_loc29_.target] == null)
                     {
                        _loc18_[_loc29_.target] = 0;
                     }
                     _loc18_[_loc29_.target] = _loc18_[_loc29_.target] + _loc29_.value;
                     _loc19_[_loc29_.target] = _loc29_;
                  }
                  this.showTargetTooltip(_loc29_.target.id);
                  break;
               case _loc8_ is FightLifeVariationStep:
                  _loc30_ = _loc8_ as FightLifeVariationStep;
                  if(_loc30_.target == null)
                  {
                     break;
                  }
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
         for each(_loc21_ in _loc4_)
         {
            if(_loc21_ is FightLifeVariationStep && _loc16_[_loc21_.target] == 0 && !(_loc18_[_loc21_.target] == null))
            {
               _loc21_.skipTextEvent = true;
            }
         }
         for(_loc22_ in _loc16_)
         {
            if(!(_loc22_ == "null") && !(_loc16_[_loc22_] == 0))
            {
               _loc31_ = _loc4_.indexOf(_loc17_[_loc22_]);
               _loc4_.splice(_loc31_,0,new FightLossAnimStep(_loc22_,_loc16_[_loc22_],FightLifeVariationStep.COLOR));
            }
            _loc17_[_loc22_] = -1;
            _loc16_[_loc22_] = 0;
         }
         for(_loc22_ in _loc18_)
         {
            if(!(_loc22_ == "null") && !(_loc18_[_loc22_] == 0))
            {
               _loc32_ = _loc4_.indexOf(_loc19_[_loc22_]);
               _loc4_.splice(_loc32_,0,new FightLossAnimStep(_loc22_,_loc18_[_loc22_],FightShieldPointsVariationStep.COLOR));
            }
            _loc19_[_loc22_] = -1;
            _loc18_[_loc22_] = 0;
         }
         for each(_loc23_ in _loc15_)
         {
            _loc13_.push(_loc23_);
         }
         if(_loc10_)
         {
            for(_loc33_ in _loc7_)
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
         for each(_loc8_ in _loc4_)
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
      
      private function onSequenceEnd(param1:SequencerEvent) : void
      {
         this._sequencer.removeEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         this._sequenceEndCallback();
      }
      
      private function subSequenceInitDone() : void
      {
         this._subSequenceWaitingCount--;
         if((!this.isWaiting) && (this._sequencer) && !this._sequencer.running)
         {
            _log.warn("Sub sequence init end -- Run main sequence");
            this._sequencer.start();
         }
      }
      
      private function pushMovementStep(param1:int, param2:MovementPath) : void
      {
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param1)));
         var _loc3_:FightEntityMovementStep = new FightEntityMovementStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushTeleportStep(param1:int, param2:int) : void
      {
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
      
      private function pushExchangePositionsStep(param1:int, param2:int, param3:int, param4:int) : void
      {
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param1)));
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param3)));
         var _loc5_:FightExchangePositionsStep = new FightExchangePositionsStep(param1,param2,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushSlideStep(param1:int, param2:int, param3:int) : void
      {
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
      
      private function pushSummonStep(param1:int, param2:GameFightFighterInformations) : void
      {
         var _loc3_:FightSummonStep = new FightSummonStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushVisibilityStep(param1:int, param2:Boolean) : void
      {
         var _loc3_:FightVisibilityStep = new FightVisibilityStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushMarkCellsStep(param1:int, param2:int, param3:Vector.<GameActionMarkedCell>, param4:int, param5:SpellLevel, param6:int, param7:int) : void
      {
         var _loc8_:FightMarkCellsStep = new FightMarkCellsStep(param1,param2,param3,param4,param5,param6,param7);
         if(this.castingSpell != null)
         {
            _loc8_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc8_);
      }
      
      private function pushUnmarkCellsStep(param1:int) : void
      {
         var _loc2_:FightUnmarkCellsStep = new FightUnmarkCellsStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushChangeLookStep(param1:int, param2:EntityLook) : void
      {
         var _loc3_:FightChangeLookStep = new FightChangeLookStep(param1,EntityLookAdapter.fromNetwork(param2));
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushChangeVisibilityStep(param1:int, param2:int) : void
      {
         var _loc3_:FightChangeVisibilityStep = new FightChangeVisibilityStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushPointsVariationStep(param1:int, param2:uint, param3:int) : void
      {
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
      
      private function pushShieldPointsVariationStep(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:FightShieldPointsVariationStep = new FightShieldPointsVariationStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushTemporaryBoostStep(param1:int, param2:String, param3:int, param4:String) : void
      {
         var _loc5_:FightTemporaryBoostStep = new FightTemporaryBoostStep(param1,param2,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushPointsLossDodgeStep(param1:int, param2:uint, param3:int) : void
      {
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
      
      private function pushLifePointsVariationStep(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:FightLifeVariationStep = new FightLifeVariationStep(param1,param2,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushDeathStep(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:FightDeathStep = new FightDeathStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushVanishStep(param1:int, param2:int) : void
      {
         var _loc3_:FightVanishStep = new FightVanishStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushDispellStep(param1:int) : void
      {
         var _loc2_:FightDispellStep = new FightDispellStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushDispellEffectStep(param1:int, param2:int) : void
      {
         var _loc3_:FightDispellEffectStep = new FightDispellEffectStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushDispellSpellStep(param1:int, param2:int) : void
      {
         var _loc3_:FightDispellSpellStep = new FightDispellSpellStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushSpellCooldownVariationStep(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:FightSpellCooldownVariationStep = new FightSpellCooldownVariationStep(param1,param2,param3,param4);
         if(this.castingSpell != null)
         {
            _loc5_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc5_);
      }
      
      private function pushSpellImmunityStep(param1:int) : void
      {
         var _loc2_:FightSpellImmunityStep = new FightSpellImmunityStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushInvisibleObstacleStep(param1:int, param2:int) : void
      {
         var _loc3_:FightInvisibleObstacleStep = new FightInvisibleObstacleStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushKillStep(param1:int, param2:int) : void
      {
         var _loc3_:FightKillStep = new FightKillStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushReducedDamagesStep(param1:int, param2:int) : void
      {
         var _loc3_:FightReducedDamagesStep = new FightReducedDamagesStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushReflectedDamagesStep(param1:int) : void
      {
         var _loc2_:FightReflectedDamagesStep = new FightReflectedDamagesStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushReflectedSpellStep(param1:int) : void
      {
         var _loc2_:FightReflectedSpellStep = new FightReflectedSpellStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushSpellCastStep(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:uint) : void
      {
         var _loc7_:FightSpellCastStep = new FightSpellCastStep(param1,param2,param3,param4,param5,param6);
         if(this.castingSpell != null)
         {
            _loc7_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc7_);
      }
      
      private function pushCloseCombatStep(param1:int, param2:uint, param3:uint) : void
      {
         var _loc4_:FightCloseCombatStep = new FightCloseCombatStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushStealKamasStep(param1:int, param2:int, param3:uint) : void
      {
         var _loc4_:FightStealingKamasStep = new FightStealingKamasStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushTackledStep(param1:int) : void
      {
         var _loc2_:FightTackledStep = new FightTackledStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushMarkTriggeredStep(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:FightMarkTriggeredStep = new FightMarkTriggeredStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushMarkActivateStep(param1:int, param2:Boolean) : void
      {
         var _loc3_:FightMarkActivateStep = new FightMarkActivateStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function pushDisplayBuffStep(param1:BasicBuff) : void
      {
         var _loc2_:FightDisplayBuffStep = new FightDisplayBuffStep(param1);
         if(this.castingSpell != null)
         {
            _loc2_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc2_);
      }
      
      private function pushModifyEffectsDurationStep(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:FightModifyEffectsDurationStep = new FightModifyEffectsDurationStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushCarryCharacterStep(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:FightCarryCharacterStep = new FightCarryCharacterStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,param2)));
      }
      
      private function pushThrowCharacterStep(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:FightThrowCharacterStep = new FightThrowCharacterStep(param1,param2,param3);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
            _loc4_.portals = this.castingSpell.portalMapPoints;
            _loc4_.portalIds = this.castingSpell.portalIds;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushFightInvisibleTemporarilyDetectedStep(param1:int, param2:uint) : void
      {
         var _loc3_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         var _loc4_:FightInvisibleTemporarilyDetectedStep = new FightInvisibleTemporarilyDetectedStep(_loc3_,param2);
         if(this.castingSpell != null)
         {
            _loc4_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc4_);
      }
      
      private function pushTurnListStep(param1:Vector.<int>, param2:Vector.<int>) : void
      {
         var _loc3_:FightTurnListStep = new FightTurnListStep(param1,param2);
         if(this.castingSpell != null)
         {
            _loc3_.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(_loc3_);
      }
      
      private function clearBuffer() : void
      {
         this._stepsBuffer = new Vector.<ISequencable>(0,false);
      }
      
      private function showTargetTooltip(param1:int) : void
      {
         var _loc2_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var _loc3_:GameFightFighterInformations = this.fightEntitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
         if((_loc3_.alive && this._castingSpell && (this._castingSpell.casterId == PlayedCharacterManager.getInstance().id || _loc2_.battleFrame.playingSlaveEntity)) && (!(param1 == this.castingSpell.casterId)) && this._fightBattleFrame.targetedEntities.indexOf(param1) == -1)
         {
            this._fightBattleFrame.targetedEntities.push(param1);
            if(OptionManager.getOptionManager("dofus")["showPermanentTargetsTooltips"] == true)
            {
               _loc2_.displayEntityTooltip(param1);
            }
         }
      }
      
      private function isSpellTeleportingToPreviousPosition() : Boolean
      {
         var _loc1_:EffectInstanceDice = null;
         if((this._castingSpell) && (this._castingSpell.spellRank))
         {
            for each(_loc1_ in this._castingSpell.spellRank.effects)
            {
               if(_loc1_.effectId == 1100)
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}
