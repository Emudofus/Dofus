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
   import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
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
   import __AS3__.vec.*;
   
   public class FightSequenceFrame extends Object implements Frame, ISpellCastProvider
   {
      
      public function FightSequenceFrame(pFightBattleFrame:FightBattleFrame, parent:FightSequenceFrame=null) {
         super();
         this._instanceId = _currentInstanceId++;
         this._fightBattleFrame = pFightBattleFrame;
         this._parent = parent;
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
      
      private static function deleteTooltip(fighterId:int) : void {
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if((FightContextFrame.fighterEntityTooltipId == fighterId) && (!(FightContextFrame.fighterEntityTooltipId == fightContextFrame.timelineOverEntityId)))
         {
            if(fightContextFrame)
            {
               fightContextFrame.outEntity(fighterId);
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
         return (!(this._subSequenceWaitingCount == 0)) || (!this._scriptInit);
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
      
      public function addSubSequence(sequence:ISequencer) : void {
         this._subSequenceWaitingCount++;
         this._stepsBuffer.push(new ParallelStartSequenceStep([sequence],false));
      }
      
      public function process(msg:Message) : Boolean {
         var gafscmsg:GameActionFightSpellCastMessage = null;
         var isCloseCombat:* = false;
         var closeCombatWeaponId:uint = 0;
         var sourceCellId:* = 0;
         var critical:* = false;
         var entities:Dictionary = null;
         var fighter:GameFightFighterInformations = null;
         var playerManager:PlayedCharacterManager = null;
         var isAlly:* = false;
         var target:GameFightFighterInformations = null;
         var gmmmsg:GameMapMovementMessage = null;
         var gafpvmsg:GameActionFightPointsVariationMessage = null;
         var gaflasplmsg:GameActionFightLifeAndShieldPointsLostMessage = null;
         var gaflpgmsg:GameActionFightLifePointsGainMessage = null;
         var gaflplmsg:GameActionFightLifePointsLostMessage = null;
         var gaftosmmsg:GameActionFightTeleportOnSameMapMessage = null;
         var gafepmsg:GameActionFightExchangePositionsMessage = null;
         var gafsmsg:GameActionFightSlideMessage = null;
         var gafsnmsg:GameActionFightSummonMessage = null;
         var gafmcmsg:GameActionFightMarkCellsMessage = null;
         var gafucmsg:GameActionFightUnmarkCellsMessage = null;
         var gafclmsg:GameActionFightChangeLookMessage = null;
         var gafimsg:GameActionFightInvisibilityMessage = null;
         var inviInfo:GameContextActorInformations = null;
         var gaflmsg:GameActionFightLeaveMessage = null;
         var entitiesL:Dictionary = null;
         var entityInfosL:GameContextActorInformations = null;
         var gafdmsg:GameActionFightDeathMessage = null;
         var entitiesDictionnary:Dictionary = null;
         var playerId:* = 0;
         var sourceInfos:GameFightFighterInformations = null;
         var targetInfos:GameFightFighterInformations = null;
         var playerInfos:GameFightFighterInformations = null;
         var entityInfos:GameContextActorInformations = null;
         var ftf:FightTurnFrame = null;
         var updatePath:* = false;
         var fightContextFrame:FightContextFrame = null;
         var gafvmsg:GameActionFightVanishMessage = null;
         var entityInfosv:GameContextActorInformations = null;
         var fightContextFramev:FightContextFrame = null;
         var gafdiemsg:GameActionFightDispellEffectMessage = null;
         var gafdsmsg:GameActionFightDispellSpellMessage = null;
         var gafdimsg:GameActionFightDispellMessage = null;
         var gafdplmsg:GameActionFightDodgePointLossMessage = null;
         var gafscvmsg:GameActionFightSpellCooldownVariationMessage = null;
         var gafsimsg:GameActionFightSpellImmunityMessage = null;
         var gafiomsg:GameActionFightInvisibleObstacleMessage = null;
         var gafkmsg:GameActionFightKillMessage = null;
         var gafredmsg:GameActionFightReduceDamagesMessage = null;
         var gafrfdmsg:GameActionFightReflectDamagesMessage = null;
         var gafrsmsg:GameActionFightReflectSpellMessage = null;
         var gafskmsg:GameActionFightStealKamaMessage = null;
         var gaftmsg:GameActionFightTackledMessage = null;
         var gaftgtmsg:GameActionFightTriggerGlyphTrapMessage = null;
         var triggeredCellId:* = 0;
         var gaftbmsg:GameActionFightDispellableEffectMessage = null;
         var castingSpell:CastingSpell = null;
         var buffEffect:AbstractFightDispellableEffect = null;
         var buff:BasicBuff = null;
         var gafmedmsg:GameActionFightModifyEffectsDurationMessage = null;
         var gafccmsg:GameActionFightCarryCharacterMessage = null;
         var gaftcmsg:GameActionFightThrowCharacterMessage = null;
         var throwCellId:uint = 0;
         var gafdcmsg:GameActionFightDropCharacterMessage = null;
         var dropCellId:uint = 0;
         var gafidMsg:GameActionFightInvisibleDetectedMessage = null;
         var gftmsg:GameFightTurnListMessage = null;
         var gafccmsg2:GameActionFightCloseCombatMessage = null;
         var spellTargetEntities:Array = null;
         var isSpellKnown:* = false;
         var playerSpellLevel:SpellLevel = null;
         var spellKnown:SpellWrapper = null;
         var spell:Spell = null;
         var castSpellLevel:SpellLevel = null;
         var fightEntities:Dictionary = null;
         var fighterInfos:GameFightFighterInformations = null;
         var simf:SpellInventoryManagementFrame = null;
         var gcdValue:* = 0;
         var gfsc:GameFightSpellCooldown = null;
         var shape:uint = 0;
         var ei:EffectInstance = null;
         var ts:TiphonSprite = null;
         var targetedCell:GraphicCell = null;
         var cellPos:Point = null;
         var gfsfrsmsg:GameFightShowFighterRandomStaticPoseMessage = null;
         var illusionCreature:Sprite = null;
         var gfsgmsg:GameFightShowFighterMessage = null;
         var summonedCreature:Sprite = null;
         var isBomb:* = false;
         var isCreature:* = false;
         var entityInfosS:GameContextActorInformations = null;
         var summonedEntityInfosS:GameFightMonsterInformations = null;
         var monsterS:Monster = null;
         var summonedCharacterInfoS:GameFightCharacterInformations = null;
         var gcaiL:GameContextActorInformations = null;
         var summonerIdL:* = 0;
         var summonedEntityInfosL:GameFightMonsterInformations = null;
         var monster:Monster = null;
         var gcai:GameContextActorInformations = null;
         var summonerId:* = 0;
         var summonedEntityInfos:GameFightMonsterInformations = null;
         var summonedFighterEntityInfos:GameFightFighterInformations = null;
         var sb:StateBuff = null;
         var step:Object = null;
         var actionId:* = 0;
         switch(true)
         {
            case msg is GameActionFightCloseCombatMessage:
            case msg is GameActionFightSpellCastMessage:
               if(msg is GameActionFightSpellCastMessage)
               {
                  gafscmsg = msg as GameActionFightSpellCastMessage;
               }
               else
               {
                  gafccmsg2 = msg as GameActionFightCloseCombatMessage;
                  isCloseCombat = true;
                  closeCombatWeaponId = gafccmsg2.weaponGenericId;
                  gafscmsg = new GameActionFightSpellCastMessage();
                  gafscmsg.initGameActionFightSpellCastMessage(gafccmsg2.actionId,gafccmsg2.sourceId,gafccmsg2.targetId,gafccmsg2.destinationCellId,gafccmsg2.critical,gafccmsg2.silentCast,0,1);
               }
               sourceCellId = this.fightEntitiesFrame.getEntityInfos(gafscmsg.sourceId).disposition.cellId;
               if(this._castingSpell)
               {
                  if((isCloseCombat) && (!(closeCombatWeaponId == 0)))
                  {
                     this.pushCloseCombatStep(gafscmsg.sourceId,closeCombatWeaponId,gafscmsg.critical);
                  }
                  else
                  {
                     this.pushSpellCastStep(gafscmsg.sourceId,gafscmsg.destinationCellId,sourceCellId,gafscmsg.spellId,gafscmsg.spellLevel,gafscmsg.critical);
                  }
                  _log.error("Il ne peut y avoir qu\'un seul cast de sort par séquence (" + msg + ")");
                  break;
               }
               this._castingSpell = new CastingSpell();
               this._castingSpell.casterId = gafscmsg.sourceId;
               this._castingSpell.spell = Spell.getSpellById(gafscmsg.spellId);
               this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(gafscmsg.spellLevel);
               this._castingSpell.isCriticalFail = gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL;
               this._castingSpell.isCriticalHit = gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_HIT;
               this._castingSpell.silentCast = gafscmsg.silentCast;
               if(!this._fightBattleFrame.currentPlayerId)
               {
                  BuffManager.getInstance().spellBuffsToIgnore.push(this._castingSpell);
               }
               if(gafscmsg.destinationCellId != -1)
               {
                  this._castingSpell.targetedCell = MapPoint.fromCellId(gafscmsg.destinationCellId);
               }
               if(this._castingSpell.isCriticalFail)
               {
                  this._fxScriptId = 0;
               }
               else
               {
                  this._fxScriptId = this._castingSpell.spell.getScriptId(this._castingSpell.isCriticalHit);
               }
               if(msg is GameActionFightCloseCombatMessage)
               {
                  this._fxScriptId = 7;
                  this._castingSpell.weaponId = GameActionFightCloseCombatMessage(msg).weaponGenericId;
               }
               if((gafscmsg.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId) && (!(gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)))
               {
                  spellTargetEntities = new Array();
                  spellTargetEntities.push(gafscmsg.targetId);
                  CurrentPlayedFighterManager.getInstance().getSpellCastManager().castSpell(gafscmsg.spellId,gafscmsg.spellLevel,spellTargetEntities);
               }
               critical = gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_HIT;
               entities = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               fighter = entities[gafscmsg.sourceId];
               if((isCloseCombat) && (!(closeCombatWeaponId == 0)))
               {
                  this.pushCloseCombatStep(gafscmsg.sourceId,closeCombatWeaponId,gafscmsg.critical);
               }
               else
               {
                  this.pushSpellCastStep(gafscmsg.sourceId,gafscmsg.destinationCellId,sourceCellId,gafscmsg.spellId,gafscmsg.spellLevel,gafscmsg.critical);
               }
               if(gafscmsg.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.FightSpellCast);
               }
               playerManager = PlayedCharacterManager.getInstance();
               isAlly = false;
               if((entities[playerManager.id]) && (fighter) && ((entities[playerManager.id] as GameFightFighterInformations).teamId == fighter.teamId))
               {
                  isAlly = true;
               }
               if((!(gafscmsg.sourceId == playerManager.id)) && (isAlly) && (!this._castingSpell.isCriticalFail))
               {
                  isSpellKnown = false;
                  for each (spellKnown in playerManager.spellsInventory)
                  {
                     if(spellKnown.id == gafscmsg.spellId)
                     {
                        isSpellKnown = true;
                        playerSpellLevel = spellKnown.spellLevelInfos;
                        break;
                     }
                  }
                  spell = Spell.getSpellById(gafscmsg.spellId);
                  castSpellLevel = spell.getSpellLevel(gafscmsg.spellLevel);
                  if(castSpellLevel.globalCooldown)
                  {
                     if(isSpellKnown)
                     {
                        if(castSpellLevel.globalCooldown == -1)
                        {
                           gcdValue = playerSpellLevel.minCastInterval;
                        }
                        else
                        {
                           gcdValue = castSpellLevel.globalCooldown;
                        }
                        this.pushSpellCooldownVariationStep(playerManager.id,0,gafscmsg.spellId,gcdValue);
                     }
                     fightEntities = this.fightEntitiesFrame.getEntitiesDictionnary();
                     simf = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
                     for each (fighterInfos in fightEntities)
                     {
                        if((fighterInfos is GameFightCompanionInformations) && (!(gafscmsg.sourceId == fighterInfos.contextualId)) && ((fighterInfos as GameFightCompanionInformations).masterId == playerManager.id))
                        {
                           gfsc = new GameFightSpellCooldown();
                           gfsc.initGameFightSpellCooldown(gafscmsg.spellId,castSpellLevel.globalCooldown);
                           simf.addSpellGlobalCoolDownInfo(fighterInfos.contextualId,gfsc);
                        }
                     }
                  }
               }
               playerId = PlayedCharacterManager.getInstance().id;
               sourceInfos = this.fightEntitiesFrame.getEntityInfos(gafscmsg.sourceId) as GameFightFighterInformations;
               playerInfos = this.fightEntitiesFrame.getEntityInfos(playerId) as GameFightFighterInformations;
               if(critical)
               {
                  if(gafscmsg.sourceId == playerId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_OWNER);
                  }
                  else
                  {
                     if((playerInfos) && (sourceInfos.teamId == playerInfos.teamId))
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
                  if(gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
                  {
                     if(gafscmsg.sourceId == playerId)
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_OWNER);
                     }
                     else
                     {
                        if((playerInfos) && (sourceInfos.teamId == playerInfos.teamId))
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
               target = this.fightEntitiesFrame.getEntityInfos(gafscmsg.targetId) as GameFightFighterInformations;
               if((target) && (target.disposition.cellId == -1))
               {
                  for each (ei in this._castingSpell.spellRank.effects)
                  {
                     if(ei.hasOwnProperty("zoneShape"))
                     {
                        shape = ei.zoneShape;
                        break;
                     }
                  }
                  if(shape == SpellShapeEnum.P)
                  {
                     ts = DofusEntities.getEntity(gafscmsg.targetId) as TiphonSprite;
                     if((ts) && (this._castingSpell) && (this._castingSpell.targetedCell))
                     {
                        targetedCell = InteractiveCellManager.getInstance().getCell(this._castingSpell.targetedCell.cellId);
                        cellPos = targetedCell.parent.localToGlobal(new Point(targetedCell.x + targetedCell.width / 2,targetedCell.y + targetedCell.height / 2));
                        ts.x = cellPos.x;
                        ts.y = cellPos.y;
                     }
                  }
               }
               return true;
            case msg is GameMapMovementMessage:
               gmmmsg = msg as GameMapMovementMessage;
               if(gmmmsg.actorId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerFightMove);
               }
               this.pushMovementStep(gmmmsg.actorId,MapMovementAdapter.getClientMovement(gmmmsg.keyMovements));
               return true;
            case msg is GameActionFightPointsVariationMessage:
               gafpvmsg = msg as GameActionFightPointsVariationMessage;
               this.pushPointsVariationStep(gafpvmsg.targetId,gafpvmsg.actionId,gafpvmsg.delta);
               return true;
            case msg is GameActionFightLifeAndShieldPointsLostMessage:
               gaflasplmsg = msg as GameActionFightLifeAndShieldPointsLostMessage;
               this.pushShieldPointsVariationStep(gaflasplmsg.targetId,-gaflasplmsg.shieldLoss,gaflasplmsg.actionId);
               this.pushLifePointsVariationStep(gaflasplmsg.targetId,-gaflasplmsg.loss,-gaflasplmsg.permanentDamages,gaflasplmsg.actionId);
               return true;
            case msg is GameActionFightLifePointsGainMessage:
               gaflpgmsg = msg as GameActionFightLifePointsGainMessage;
               this.pushLifePointsVariationStep(gaflpgmsg.targetId,gaflpgmsg.delta,0,gaflpgmsg.actionId);
               return true;
            case msg is GameActionFightLifePointsLostMessage:
               gaflplmsg = msg as GameActionFightLifePointsLostMessage;
               this.pushLifePointsVariationStep(gaflplmsg.targetId,-gaflplmsg.loss,-gaflplmsg.permanentDamages,gaflplmsg.actionId);
               return true;
            case msg is GameActionFightTeleportOnSameMapMessage:
               gaftosmmsg = msg as GameActionFightTeleportOnSameMapMessage;
               this.pushTeleportStep(gaftosmmsg.targetId,gaftosmmsg.cellId);
               return true;
            case msg is GameActionFightExchangePositionsMessage:
               gafepmsg = msg as GameActionFightExchangePositionsMessage;
               this.pushExchangePositionsStep(gafepmsg.sourceId,gafepmsg.casterCellId,gafepmsg.targetId,gafepmsg.targetCellId);
               return true;
            case msg is GameActionFightSlideMessage:
               gafsmsg = msg as GameActionFightSlideMessage;
               this.pushSlideStep(gafsmsg.targetId,gafsmsg.startCellId,gafsmsg.endCellId);
               return true;
            case msg is GameActionFightSummonMessage:
               gafsnmsg = msg as GameActionFightSummonMessage;
               if((gafsnmsg.actionId == 1024) || (gafsnmsg.actionId == 1097))
               {
                  gfsfrsmsg = new GameFightShowFighterRandomStaticPoseMessage();
                  gfsfrsmsg.initGameFightShowFighterRandomStaticPoseMessage(gafsnmsg.summon);
                  Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsfrsmsg);
                  illusionCreature = DofusEntities.getEntity(gafsnmsg.summon.contextualId) as Sprite;
                  if(illusionCreature)
                  {
                     illusionCreature.visible = false;
                  }
                  this.pushVisibilityStep(gafsnmsg.summon.contextualId,true);
               }
               else
               {
                  gfsgmsg = new GameFightShowFighterMessage();
                  gfsgmsg.initGameFightShowFighterMessage(gafsnmsg.summon);
                  Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsgmsg);
                  summonedCreature = DofusEntities.getEntity(gafsnmsg.summon.contextualId) as Sprite;
                  if(summonedCreature)
                  {
                     summonedCreature.visible = false;
                  }
                  this.pushSummonStep(gafsnmsg.sourceId,gafsnmsg.summon);
                  if((gafsnmsg.sourceId == PlayedCharacterManager.getInstance().id) && (!(gafsnmsg.actionId == 185)))
                  {
                     isBomb = false;
                     isCreature = false;
                     if(gafsnmsg.actionId == 1008)
                     {
                        isBomb = true;
                     }
                     else
                     {
                        entityInfosS = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gafsnmsg.summon.contextualId);
                        isBomb = false;
                        summonedEntityInfosS = entityInfosS as GameFightMonsterInformations;
                        if(summonedEntityInfosS)
                        {
                           monsterS = Monster.getMonsterById(summonedEntityInfosS.creatureGenericId);
                           if((monsterS) && (monsterS.useBombSlot))
                           {
                              isBomb = true;
                           }
                           if((monsterS) && (monsterS.useSummonSlot))
                           {
                              isCreature = true;
                           }
                        }
                        else
                        {
                           summonedCharacterInfoS = entityInfosS as GameFightCharacterInformations;
                        }
                     }
                     if((isCreature) || (summonedCharacterInfoS))
                     {
                        PlayedCharacterManager.getInstance().addSummonedCreature();
                     }
                     else
                     {
                        if(isBomb)
                        {
                           PlayedCharacterManager.getInstance().addSummonedBomb();
                        }
                     }
                  }
                  if((this._fightBattleFrame.slaveId == gafsnmsg.summon.contextualId) || (this._fightBattleFrame.masterId == gafsnmsg.summon.contextualId))
                  {
                     this._fightBattleFrame.prepareNextPlayableCharacter();
                  }
               }
               return true;
            case msg is GameActionFightMarkCellsMessage:
               gafmcmsg = msg as GameActionFightMarkCellsMessage;
               if(this._castingSpell)
               {
                  this._castingSpell.markId = gafmcmsg.mark.markId;
                  this._castingSpell.markType = gafmcmsg.mark.markType;
                  this.pushMarkCellsStep(gafmcmsg.mark.markId,gafmcmsg.mark.markType,gafmcmsg.mark.cells,gafmcmsg.mark.markSpellId);
               }
               return true;
            case msg is GameActionFightUnmarkCellsMessage:
               gafucmsg = msg as GameActionFightUnmarkCellsMessage;
               this.pushUnmarkCellsStep(gafucmsg.markId);
               return true;
            case msg is GameActionFightChangeLookMessage:
               gafclmsg = msg as GameActionFightChangeLookMessage;
               this.pushChangeLookStep(gafclmsg.targetId,gafclmsg.entityLook);
               return true;
            case msg is GameActionFightInvisibilityMessage:
               gafimsg = msg as GameActionFightInvisibilityMessage;
               inviInfo = this.fightEntitiesFrame.getEntityInfos(gafimsg.targetId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(gafimsg.targetId,inviInfo.disposition.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(gafimsg.targetId,0,true);
               this.pushChangeVisibilityStep(gafimsg.targetId,gafimsg.state);
               return true;
            case msg is GameActionFightLeaveMessage:
               gaflmsg = msg as GameActionFightLeaveMessage;
               entitiesL = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               for each (gcaiL in entitiesL)
               {
                  if(gcaiL is GameFightFighterInformations)
                  {
                     summonerIdL = (gcaiL as GameFightFighterInformations).stats.summoner;
                     if(summonerIdL == gaflmsg.targetId)
                     {
                        this.pushDeathStep(gcaiL.contextualId);
                     }
                  }
               }
               this.pushDeathStep(gaflmsg.targetId,false);
               entityInfosL = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gaflmsg.targetId);
               if(entityInfosL is GameFightMonsterInformations)
               {
                  summonedEntityInfosL = entityInfosL as GameFightMonsterInformations;
                  if(summonedEntityInfosL.stats.summoner == PlayedCharacterManager.getInstance().id)
                  {
                     monster = Monster.getMonsterById(summonedEntityInfosL.creatureGenericId);
                     if(monster.useSummonSlot)
                     {
                        PlayedCharacterManager.getInstance().removeSummonedCreature();
                     }
                     if(monster.useBombSlot)
                     {
                        PlayedCharacterManager.getInstance().removeSummonedBomb();
                     }
                  }
               }
               return true;
            case msg is GameActionFightDeathMessage:
               gafdmsg = msg as GameActionFightDeathMessage;
               entitiesDictionnary = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
               for each (gcai in entitiesDictionnary)
               {
                  if(gcai is GameFightFighterInformations)
                  {
                     summonerId = (gcai as GameFightFighterInformations).stats.summoner;
                     if(summonerId == gafdmsg.targetId)
                     {
                        this.pushDeathStep(gcai.contextualId);
                     }
                  }
               }
               playerId = PlayedCharacterManager.getInstance().id;
               sourceInfos = this.fightEntitiesFrame.getEntityInfos(gafdmsg.sourceId) as GameFightFighterInformations;
               targetInfos = this.fightEntitiesFrame.getEntityInfos(gafdmsg.targetId) as GameFightFighterInformations;
               playerInfos = this.fightEntitiesFrame.getEntityInfos(playerId) as GameFightFighterInformations;
               if((this._fightBattleFrame.slaveId == gafdmsg.targetId) || (this._fightBattleFrame.masterId == gafdmsg.targetId))
               {
                  this._fightBattleFrame.prepareNextPlayableCharacter(gafdmsg.targetId);
               }
               if(gafdmsg.targetId == playerId)
               {
                  if(gafdmsg.sourceId == gafdmsg.targetId)
                  {
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_HIMSELF);
                  }
                  else
                  {
                     if(sourceInfos.teamId != playerInfos.teamId)
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
                  if(gafdmsg.sourceId == playerId)
                  {
                     if(targetInfos.teamId != playerInfos.teamId)
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ENEMY);
                     }
                     else
                     {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ALLY);
                     }
                  }
               }
               this.pushDeathStep(gafdmsg.targetId);
               entityInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gafdmsg.targetId);
               ftf = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
               updatePath = ((ftf) && (ftf.myTurn)) && (!(gafdmsg.targetId == playerId)) && (TackleUtil.isTackling(playerInfos,targetInfos,ftf.lastPath));
               if(entityInfos is GameFightMonsterInformations)
               {
                  summonedEntityInfos = entityInfos as GameFightMonsterInformations;
                  summonedEntityInfos.alive = false;
                  if(summonedEntityInfos.stats.summoner == PlayedCharacterManager.getInstance().id)
                  {
                     monster = Monster.getMonsterById(summonedEntityInfos.creatureGenericId);
                     if(monster.useSummonSlot)
                     {
                        PlayedCharacterManager.getInstance().removeSummonedCreature();
                     }
                     if(monster.useBombSlot)
                     {
                        PlayedCharacterManager.getInstance().removeSummonedBomb();
                     }
                     SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
                  }
               }
               else
               {
                  if(entityInfos is GameFightFighterInformations)
                  {
                     (entityInfos as GameFightFighterInformations).alive = false;
                     if((entityInfos as GameFightFighterInformations).stats.summoner != 0)
                     {
                        summonedFighterEntityInfos = entityInfos as GameFightFighterInformations;
                        if(summonedFighterEntityInfos.stats.summoner == PlayedCharacterManager.getInstance().id)
                        {
                           PlayedCharacterManager.getInstance().removeSummonedCreature();
                           SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
                        }
                     }
                  }
               }
               fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(fightContextFrame)
               {
                  fightContextFrame.outEntity(gafdmsg.targetId);
               }
               FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(gafdmsg.targetId);
               if(updatePath)
               {
                  ftf.updatePath();
               }
               return true;
            case msg is GameActionFightVanishMessage:
               gafvmsg = msg as GameActionFightVanishMessage;
               this.pushVanishStep(gafvmsg.targetId,gafvmsg.sourceId);
               entityInfosv = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gafvmsg.targetId);
               if(entityInfosv is GameFightFighterInformations)
               {
                  (entityInfosv as GameFightFighterInformations).alive = false;
               }
               fightContextFramev = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(fightContextFramev)
               {
                  fightContextFramev.outEntity(gafvmsg.targetId);
               }
               FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(gafvmsg.targetId);
               return true;
            case msg is GameActionFightTriggerEffectMessage:
               return true;
            case msg is GameActionFightDispellEffectMessage:
               gafdiemsg = msg as GameActionFightDispellEffectMessage;
               this.pushDispellEffectStep(gafdiemsg.targetId,gafdiemsg.boostUID);
               return true;
            case msg is GameActionFightDispellSpellMessage:
               gafdsmsg = msg as GameActionFightDispellSpellMessage;
               this.pushDispellSpellStep(gafdsmsg.targetId,gafdsmsg.spellId);
               return true;
            case msg is GameActionFightDispellMessage:
               gafdimsg = msg as GameActionFightDispellMessage;
               this.pushDispellStep(gafdimsg.targetId);
               return true;
            case msg is GameActionFightDodgePointLossMessage:
               gafdplmsg = msg as GameActionFightDodgePointLossMessage;
               this.pushPointsLossDodgeStep(gafdplmsg.targetId,gafdplmsg.actionId,gafdplmsg.amount);
               return true;
            case msg is GameActionFightSpellCooldownVariationMessage:
               gafscvmsg = msg as GameActionFightSpellCooldownVariationMessage;
               this.pushSpellCooldownVariationStep(gafscvmsg.targetId,gafscvmsg.actionId,gafscvmsg.spellId,gafscvmsg.value);
               return true;
            case msg is GameActionFightSpellImmunityMessage:
               gafsimsg = msg as GameActionFightSpellImmunityMessage;
               this.pushSpellImmunityStep(gafsimsg.targetId);
               return true;
            case msg is GameActionFightInvisibleObstacleMessage:
               gafiomsg = msg as GameActionFightInvisibleObstacleMessage;
               this.pushInvisibleObstacleStep(gafiomsg.sourceId,gafiomsg.sourceSpellId);
               return true;
            case msg is GameActionFightKillMessage:
               gafkmsg = msg as GameActionFightKillMessage;
               this.pushKillStep(gafkmsg.targetId,gafkmsg.sourceId);
               return true;
            case msg is GameActionFightReduceDamagesMessage:
               gafredmsg = msg as GameActionFightReduceDamagesMessage;
               this.pushReducedDamagesStep(gafredmsg.targetId,gafredmsg.amount);
               return true;
            case msg is GameActionFightReflectDamagesMessage:
               gafrfdmsg = msg as GameActionFightReflectDamagesMessage;
               this.pushReflectedDamagesStep(gafrfdmsg.sourceId);
               return true;
            case msg is GameActionFightReflectSpellMessage:
               gafrsmsg = msg as GameActionFightReflectSpellMessage;
               this.pushReflectedSpellStep(gafrsmsg.targetId);
               return true;
            case msg is GameActionFightStealKamaMessage:
               gafskmsg = msg as GameActionFightStealKamaMessage;
               this.pushStealKamasStep(gafskmsg.sourceId,gafskmsg.targetId,gafskmsg.amount);
               return true;
            case msg is GameActionFightTackledMessage:
               gaftmsg = msg as GameActionFightTackledMessage;
               this.pushTackledStep(gaftmsg.sourceId);
               return true;
            case msg is GameActionFightTriggerGlyphTrapMessage:
               if(this._castingSpell)
               {
                  this._fightBattleFrame.process(new SequenceEndMessage());
                  this._fightBattleFrame.process(new SequenceStartMessage());
                  this._fightBattleFrame.currentSequenceFrame.process(msg);
                  return true;
               }
               gaftgtmsg = msg as GameActionFightTriggerGlyphTrapMessage;
               this.pushMarkTriggeredStep(gaftgtmsg.triggeringCharacterId,gaftgtmsg.sourceId,gaftgtmsg.markId);
               this._fxScriptId = 1;
               this._castingSpell = new CastingSpell();
               this._castingSpell.casterId = gaftgtmsg.sourceId;
               triggeredCellId = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gaftgtmsg.triggeringCharacterId).disposition.cellId;
               if(triggeredCellId != -1)
               {
                  this._castingSpell.targetedCell = MapPoint.fromCellId(triggeredCellId);
                  this._castingSpell.spell = Spell.getSpellById(1750);
                  this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(1);
               }
               return true;
            case msg is GameActionFightDispellableEffectMessage:
               gaftbmsg = msg as GameActionFightDispellableEffectMessage;
               if(gaftbmsg.actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST)
               {
                  castingSpell = new CastingSpell(false);
               }
               else
               {
                  castingSpell = new CastingSpell(this._castingSpell == null);
               }
               if(this._castingSpell)
               {
                  castingSpell.castingSpellId = this._castingSpell.castingSpellId;
                  if(this._castingSpell.spell.id == gaftbmsg.effect.spellId)
                  {
                     castingSpell.spellRank = this._castingSpell.spellRank;
                  }
               }
               castingSpell.spell = Spell.getSpellById(gaftbmsg.effect.spellId);
               castingSpell.casterId = gaftbmsg.sourceId;
               buffEffect = gaftbmsg.effect;
               buff = BuffManager.makeBuffFromEffect(buffEffect,castingSpell,gaftbmsg.actionId);
               if(buff is StateBuff)
               {
                  sb = buff as StateBuff;
                  if(sb.actionId == 952)
                  {
                     step = new FightLeavingStateStep(sb.targetId,sb.stateId);
                  }
                  else
                  {
                     step = new FightEnteringStateStep(sb.targetId,sb.stateId,sb.effects.durationString);
                  }
                  if(castingSpell != null)
                  {
                     step.castingSpellId = castingSpell.castingSpellId;
                  }
                  this._stepsBuffer.push(step);
               }
               if(buffEffect is FightTemporaryBoostEffect)
               {
                  actionId = gaftbmsg.actionId;
                  if((!(actionId == ActionIdConverter.ACTION_CHARACTER_MAKE_INVISIBLE)) && (!(actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST)) && (!(actionId == ActionIdConverter.ACTION_CHARACTER_CHANGE_LOOK)) && (!(actionId == ActionIdConverter.ACTION_CHARACTER_CHANGE_COLOR)) && (!(actionId == ActionIdConverter.ACTION_CHARACTER_ADD_APPEARANCE)) && (!(actionId == ActionIdConverter.ACTION_FIGHT_SET_STATE)))
                  {
                     this.pushTemporaryBoostStep(gaftbmsg.effect.targetId,buff.effects.description,buff.effects.duration,buff.effects.durationString);
                  }
               }
               this.pushDisplayBuffStep(buff);
               return true;
            case msg is GameActionFightModifyEffectsDurationMessage:
               gafmedmsg = msg as GameActionFightModifyEffectsDurationMessage;
               this.pushModifyEffectsDurationStep(gafmedmsg.sourceId,gafmedmsg.targetId,gafmedmsg.delta);
               return false;
            case msg is GameActionFightCarryCharacterMessage:
               gafccmsg = msg as GameActionFightCarryCharacterMessage;
               if(gafccmsg.cellId != -1)
               {
                  this.pushCarryCharacterStep(gafccmsg.sourceId,gafccmsg.targetId,gafccmsg.cellId);
               }
               return false;
            case msg is GameActionFightThrowCharacterMessage:
               gaftcmsg = msg as GameActionFightThrowCharacterMessage;
               throwCellId = this._castingSpell?this._castingSpell.targetedCell.cellId:gaftcmsg.cellId;
               this.pushThrowCharacterStep(gaftcmsg.sourceId,gaftcmsg.targetId,throwCellId);
               return false;
            case msg is GameActionFightDropCharacterMessage:
               gafdcmsg = msg as GameActionFightDropCharacterMessage;
               dropCellId = gafdcmsg.cellId;
               if((dropCellId == -1) && (this._castingSpell))
               {
                  dropCellId = this._castingSpell.targetedCell.cellId;
               }
               this.pushThrowCharacterStep(gafdcmsg.sourceId,gafdcmsg.targetId,dropCellId);
               return false;
            case msg is GameActionFightInvisibleDetectedMessage:
               gafidMsg = msg as GameActionFightInvisibleDetectedMessage;
               this.pushFightInvisibleTemporarilyDetectedStep(gafidMsg.sourceId,gafidMsg.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(gafidMsg.targetId,gafidMsg.cellId);
               FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(gafidMsg.targetId,0);
               return true;
            case msg is GameFightTurnListMessage:
               gftmsg = msg as GameFightTurnListMessage;
               this.pushTurnListStep(gftmsg.ids,gftmsg.deadsIds);
               return true;
            case msg is AbstractGameActionMessage:
               _log.error("Unsupported game action " + msg + " ! This action was discarded.");
               return true;
         }
         return false;
      }
      
      public function execute(callback:Function=null) : void {
         var script:BinaryScript = null;
         var scriptRunner:SpellFxRunner = null;
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
            script = DofusEmbedScript.getScript(this._fxScriptId);
            scriptRunner = new SpellFxRunner(this);
            this._scriptStarted = getTimer();
            ScriptExec.exec(script,scriptRunner,true,new Callback(this.executeBuffer,callback,true,true),new Callback(this.executeBuffer,callback,true,false));
         }
         else
         {
            this.executeBuffer(callback,false);
         }
      }
      
      private function executeBuffer(callback:Function, hadScript:Boolean, scriptSuccess:Boolean=false) : void {
         var step:ISequencable = null;
         var allowHitAnim:* = false;
         var allowSpellEffects:* = false;
         var startStep:Array = null;
         var endStep:Array = null;
         var removed:* = false;
         var entityAttaqueAnimWait:Dictionary = null;
         var lifeLoseSum:Dictionary = null;
         var lifeLoseLastStep:Dictionary = null;
         var shieldLoseSum:Dictionary = null;
         var shieldLoseLastStep:Dictionary = null;
         var i:* = 0;
         var b:* = undefined;
         var index:* = undefined;
         var waitStep:WaitAnimationEventStep = null;
         var scriptTook:uint = 0;
         var animStep:PlayAnimationStep = null;
         var deathStep:FightDeathStep = null;
         var deadEntityIndex:* = 0;
         var fapvs:FightActionPointsVariationStep = null;
         var fspvs:FightShieldPointsVariationStep = null;
         var flvs:FightLifeVariationStep = null;
         var idx:* = 0;
         var idx2:* = 0;
         var loseLifeTarget:* = undefined;
         var j:uint = 0;
         if(hadScript)
         {
            scriptTook = getTimer() - this._scriptStarted;
            if(!scriptSuccess)
            {
               _log.warn("Script failed during a fight sequence, but still took " + scriptTook + "ms.");
            }
            else
            {
               _log.info("Script successfuly executed in " + scriptTook + "ms.");
            }
         }
         var cleanedBuffer:Array = [];
         var deathStepRef:Dictionary = new Dictionary(true);
         var hitStep:Dictionary = new Dictionary(true);
         var loseLifeStep:Dictionary = new Dictionary(true);
         var waitHitEnd:Boolean = false;
         for each (step in this._stepsBuffer)
         {
            switch(true)
            {
               case step is FightMarkTriggeredStep:
                  waitHitEnd = true;
                  continue;
            }
         }
         allowHitAnim = OptionManager.getOptionManager("dofus")["allowHitAnim"];
         allowSpellEffects = OptionManager.getOptionManager("dofus")["allowSpellEffects"];
         startStep = [];
         endStep = [];
         entityAttaqueAnimWait = new Dictionary();
         lifeLoseSum = new Dictionary(true);
         lifeLoseLastStep = new Dictionary(true);
         shieldLoseSum = new Dictionary(true);
         shieldLoseLastStep = new Dictionary(true);
         i = this._stepsBuffer.length;
         while(--i >= 0)
         {
            if((removed) && (step))
            {
               step.clear();
            }
            removed = true;
            step = this._stepsBuffer[i];
            switch(true)
            {
               case step is PlayAnimationStep:
                  animStep = step as PlayAnimationStep;
                  if(animStep.animation.indexOf(AnimationEnum.ANIM_HIT) != -1)
                  {
                     if(!allowHitAnim)
                     {
                        continue;
                     }
                     animStep.waitEvent = waitHitEnd;
                     if(animStep.target == null)
                     {
                        continue;
                     }
                     if(deathStepRef[EntitiesManager.getInstance().getEntityID(animStep.target as IEntity)])
                     {
                        continue;
                     }
                     if(hitStep[animStep.target])
                     {
                        continue;
                     }
                     if((!(animStep.animation == AnimationEnum.ANIM_HIT)) && (!(animStep.animation == AnimationEnum.ANIM_HIT_CARRYING)) && (!animStep.target.hasAnimation(animStep.animation,1)))
                     {
                        animStep.animation = AnimationEnum.ANIM_HIT;
                     }
                     hitStep[animStep.target] = true;
                  }
                  if(this._castingSpell.casterId < 0)
                  {
                     if(entityAttaqueAnimWait[animStep.target])
                     {
                        cleanedBuffer.unshift(entityAttaqueAnimWait[animStep.target]);
                        delete entityAttaqueAnimWait[[animStep.target]];
                     }
                     if(animStep.animation.indexOf(AnimationEnum.ANIM_ATTAQUE_BASE) != -1)
                     {
                        entityAttaqueAnimWait[animStep.target] = new WaitAnimationEventStep(animStep);
                     }
                  }
                  break;
               case step is FightDeathStep:
                  deathStep = step as FightDeathStep;
                  deathStepRef[deathStep.entityId] = true;
                  deadEntityIndex = this._fightBattleFrame.targetedEntities.indexOf(deathStep.entityId);
                  if(deadEntityIndex != -1)
                  {
                     this._fightBattleFrame.targetedEntities.splice(deadEntityIndex,1);
                     TooltipManager.hide("tooltipOverEntity_" + deathStep.entityId);
                  }
                  break;
               case step is FightActionPointsVariationStep:
                  fapvs = step as FightActionPointsVariationStep;
                  if(fapvs.voluntarlyUsed)
                  {
                     startStep.push(fapvs);
                     removed = false;
                     continue;
                  }
                  break;
               case step is FightShieldPointsVariationStep:
                  fspvs = step as FightShieldPointsVariationStep;
                  if(flvs.target == null)
                  {
                     break;
                  }
                  if(shieldLoseSum[fspvs.target] == null)
                  {
                     shieldLoseSum[fspvs.target] = 0;
                  }
                  shieldLoseSum[fspvs.target] = shieldLoseSum[fspvs.target] + fspvs.value;
                  shieldLoseLastStep[fspvs.target] = fspvs;
                  this.showTargetTooltip(fspvs.target.id);
                  break;
               case step is FightLifeVariationStep:
                  flvs = step as FightLifeVariationStep;
                  if(flvs.target == null)
                  {
                     break;
                  }
                  if(flvs.delta < 0)
                  {
                     loseLifeStep[flvs.target] = flvs;
                  }
                  if(lifeLoseSum[flvs.target] == null)
                  {
                     lifeLoseSum[flvs.target] = 0;
                  }
                  lifeLoseSum[flvs.target] = lifeLoseSum[flvs.target] + flvs.delta;
                  lifeLoseLastStep[flvs.target] = flvs;
                  this.showTargetTooltip(flvs.target.id);
                  break;
               case step is AddGfxEntityStep:
               case step is AddGfxInLineStep:
               case step is ParableGfxMovementStep:
               case step is AddWorldEntityStep:
                  if(!allowSpellEffects)
                  {
                     continue;
                  }
                  break;
            }
            removed = false;
            cleanedBuffer.unshift(step);
         }
         for each (b in cleanedBuffer)
         {
            if((b is FightLifeVariationStep) && (lifeLoseSum[b.target] == 0) && (!(shieldLoseSum[b.target] == null)))
            {
               b.skipTextEvent = true;
            }
         }
         for (index in lifeLoseSum)
         {
            if((!(index == "null")) && (!(lifeLoseSum[index] == 0)))
            {
               idx = cleanedBuffer.indexOf(lifeLoseLastStep[index]);
               cleanedBuffer.splice(idx,0,new FightLossAnimStep(index,lifeLoseSum[index],FightLifeVariationStep.COLOR));
            }
            lifeLoseLastStep[index] = -1;
            lifeLoseSum[index] = 0;
         }
         for (index in shieldLoseSum)
         {
            if((!(index == "null")) && (!(shieldLoseSum[index] == 0)))
            {
               idx2 = cleanedBuffer.indexOf(shieldLoseLastStep[index]);
               cleanedBuffer.splice(idx2,0,new FightLossAnimStep(index,shieldLoseSum[index],FightShieldPointsVariationStep.COLOR));
            }
            shieldLoseLastStep[index] = -1;
            shieldLoseSum[index] = 0;
         }
         for each (waitStep in entityAttaqueAnimWait)
         {
            endStep.push(waitStep);
         }
         if(allowHitAnim)
         {
            loop6:
            for (loseLifeTarget in loseLifeStep)
            {
               if(!hitStep[loseLifeTarget])
               {
                  j = 0;
                  while(j < cleanedBuffer.length)
                  {
                     if(cleanedBuffer[j] == loseLifeStep[loseLifeTarget])
                     {
                        cleanedBuffer.splice(j,0,new PlayAnimationStep(loseLifeTarget as TiphonSprite,AnimationEnum.ANIM_HIT,true,false));
                        continue loop6;
                     }
                     j++;
                  }
               }
            }
         }
         cleanedBuffer = startStep.concat(cleanedBuffer).concat(endStep);
         for each (step in cleanedBuffer)
         {
            this._sequencer.addStep(step);
         }
         this.clearBuffer();
         if((!(callback == null)) && (!this._parent))
         {
            this._sequenceEndCallback = callback;
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
            if(callback != null)
            {
               callback();
            }
            this._parent.subSequenceInitDone();
         }
      }
      
      private function onSequenceEnd(e:SequencerEvent) : void {
         this._sequencer.removeEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         this._sequenceEndCallback();
      }
      
      private function subSequenceInitDone() : void {
         this._subSequenceWaitingCount--;
         if((!this.isWaiting) && (this._sequencer) && (!this._sequencer.running))
         {
            _log.warn("Sub sequence init end -- Run main sequence");
            this._sequencer.start();
         }
      }
      
      private function pushMovementStep(fighterId:int, path:MovementPath) : void {
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,fighterId)));
         var step:FightEntityMovementStep = new FightEntityMovementStep(fighterId,path);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushTeleportStep(fighterId:int, destinationCell:int) : void {
         var step:FightTeleportStep = null;
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,fighterId)));
         if(destinationCell != -1)
         {
            step = new FightTeleportStep(fighterId,MapPoint.fromCellId(destinationCell));
            if(this.castingSpell != null)
            {
               step.castingSpellId = this.castingSpell.castingSpellId;
            }
            this._stepsBuffer.push(step);
         }
      }
      
      private function pushExchangePositionsStep(fighterOneId:int, fighterOneNewCell:int, fighterTwoId:int, fighterTwoNewCell:int) : void {
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,fighterOneId)));
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,fighterTwoId)));
         var step:FightExchangePositionsStep = new FightExchangePositionsStep(fighterOneId,fighterOneNewCell,fighterTwoId,fighterTwoNewCell);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushSlideStep(fighterId:int, startCell:int, endCell:int) : void {
         if((startCell < 0) || (endCell < 0))
         {
            return;
         }
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,fighterId)));
         var step:FightEntitySlideStep = new FightEntitySlideStep(fighterId,MapPoint.fromCellId(startCell),MapPoint.fromCellId(endCell));
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushSummonStep(summonerId:int, summonInfos:GameFightFighterInformations) : void {
         var step:FightSummonStep = new FightSummonStep(summonerId,summonInfos);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushVisibilityStep(fighterId:int, visibility:Boolean) : void {
         var step:FightVisibilityStep = new FightVisibilityStep(fighterId,visibility);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushMarkCellsStep(markId:int, markType:int, cells:Vector.<GameActionMarkedCell>, markSpellId:int) : void {
         var step:FightMarkCellsStep = new FightMarkCellsStep(markId,markType,this._castingSpell.spellRank,cells,markSpellId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushUnmarkCellsStep(markId:int) : void {
         var step:FightUnmarkCellsStep = new FightUnmarkCellsStep(markId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushChangeLookStep(fighterId:int, newLook:EntityLook) : void {
         var step:FightChangeLookStep = new FightChangeLookStep(fighterId,EntityLookAdapter.fromNetwork(newLook));
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushChangeVisibilityStep(fighterId:int, visibilityState:int) : void {
         var step:FightChangeVisibilityStep = new FightChangeVisibilityStep(fighterId,visibilityState);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushPointsVariationStep(fighterId:int, actionId:uint, delta:int) : void {
         var step:IFightStep = null;
         switch(actionId)
         {
            case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_USE:
               step = new FightActionPointsVariationStep(fighterId,delta,true);
               break;
            case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_LOST:
            case ActionIdConverter.ACTION_CHARACTER_ACTION_POINTS_WIN:
               step = new FightActionPointsVariationStep(fighterId,delta,false);
               break;
            case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_USE:
               step = new FightMovementPointsVariationStep(fighterId,delta,true);
               break;
            case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_LOST:
            case ActionIdConverter.ACTION_CHARACTER_MOVEMENT_POINTS_WIN:
               step = new FightMovementPointsVariationStep(fighterId,delta,false);
               break;
         }
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushShieldPointsVariationStep(fighterId:int, delta:int, actionId:int) : void {
         var step:FightShieldPointsVariationStep = new FightShieldPointsVariationStep(fighterId,delta,actionId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushTemporaryBoostStep(fighterId:int, statName:String, duration:int, durationText:String) : void {
         var step:FightTemporaryBoostStep = new FightTemporaryBoostStep(fighterId,statName,duration,durationText);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushPointsLossDodgeStep(fighterId:int, actionId:uint, amount:int) : void {
         var step:IFightStep = null;
         switch(actionId)
         {
            case ActionIdConverter.ACTION_FIGHT_SPELL_DODGED_PA:
               step = new FightActionPointsLossDodgeStep(fighterId,amount);
               break;
            case ActionIdConverter.ACTION_FIGHT_SPELL_DODGED_PM:
               step = new FightMovementPointsLossDodgeStep(fighterId,amount);
               break;
         }
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushLifePointsVariationStep(fighterId:int, delta:int, permanentDamages:int, action:int) : void {
         var step:FightLifeVariationStep = new FightLifeVariationStep(fighterId,delta,permanentDamages,action);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushDeathStep(fighterId:int, naturalDeath:Boolean=true) : void {
         var step:FightDeathStep = new FightDeathStep(fighterId,naturalDeath);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushVanishStep(fighterId:int, sourceId:int) : void {
         var step:FightVanishStep = new FightVanishStep(fighterId,sourceId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushDispellStep(fighterId:int) : void {
         var step:FightDispellStep = new FightDispellStep(fighterId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushDispellEffectStep(fighterId:int, boostUID:int) : void {
         var step:FightDispellEffectStep = new FightDispellEffectStep(fighterId,boostUID);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushDispellSpellStep(fighterId:int, spellId:int) : void {
         var step:FightDispellSpellStep = new FightDispellSpellStep(fighterId,spellId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushSpellCooldownVariationStep(targetId:int, actionId:int, spellId:int, delta:int) : void {
         var step:FightSpellCooldownVariationStep = new FightSpellCooldownVariationStep(targetId,actionId,spellId,delta);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushSpellImmunityStep(targetId:int) : void {
         var step:FightSpellImmunityStep = new FightSpellImmunityStep(targetId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushInvisibleObstacleStep(fighterId:int, spellLevelId:int) : void {
         var step:FightInvisibleObstacleStep = new FightInvisibleObstacleStep(fighterId,spellLevelId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushKillStep(fighterId:int, killerId:int) : void {
         var step:FightKillStep = new FightKillStep(fighterId,killerId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushReducedDamagesStep(fighterId:int, amount:int) : void {
         var step:FightReducedDamagesStep = new FightReducedDamagesStep(fighterId,amount);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushReflectedDamagesStep(fighterId:int) : void {
         var step:FightReflectedDamagesStep = new FightReflectedDamagesStep(fighterId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushReflectedSpellStep(fighterId:int) : void {
         var step:FightReflectedSpellStep = new FightReflectedSpellStep(fighterId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushSpellCastStep(fighterId:int, cellId:int, sourceCellId:int, spellId:int, spellRank:uint, critical:uint) : void {
         var step:FightSpellCastStep = new FightSpellCastStep(fighterId,cellId,sourceCellId,spellId,spellRank,critical);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushCloseCombatStep(fighterId:int, closeCombatWeaponId:uint, critical:uint) : void {
         var step:FightCloseCombatStep = new FightCloseCombatStep(fighterId,closeCombatWeaponId,critical);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushStealKamasStep(robberId:int, victimId:int, amount:uint) : void {
         var step:FightStealingKamasStep = new FightStealingKamasStep(robberId,victimId,amount);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushTackledStep(fighterId:int) : void {
         var step:FightTackledStep = new FightTackledStep(fighterId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushMarkTriggeredStep(fighterId:int, casterId:int, markId:int) : void {
         var step:FightMarkTriggeredStep = new FightMarkTriggeredStep(fighterId,casterId,markId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushDisplayBuffStep(buff:BasicBuff) : void {
         var step:FightDisplayBuffStep = new FightDisplayBuffStep(buff);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushModifyEffectsDurationStep(sourceId:int, targetId:int, delta:int) : void {
         var step:FightModifyEffectsDurationStep = new FightModifyEffectsDurationStep(sourceId,targetId,delta);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushCarryCharacterStep(fighterId:int, carriedId:int, cellId:int) : void {
         var step:FightCarryCharacterStep = new FightCarryCharacterStep(fighterId,carriedId,cellId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
         this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip,carriedId)));
      }
      
      private function pushThrowCharacterStep(fighterId:int, carriedId:int, cellId:int) : void {
         var step:FightThrowCharacterStep = new FightThrowCharacterStep(fighterId,carriedId,cellId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushFightInvisibleTemporarilyDetectedStep(targetId:int, cellId:uint) : void {
         var targetSprite:AnimatedCharacter = DofusEntities.getEntity(targetId) as AnimatedCharacter;
         var step:FightInvisibleTemporarilyDetectedStep = new FightInvisibleTemporarilyDetectedStep(targetSprite,cellId);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function pushTurnListStep(turnsList:Vector.<int>, deadTurnsList:Vector.<int>) : void {
         var step:FightTurnListStep = new FightTurnListStep(turnsList,deadTurnsList);
         if(this.castingSpell != null)
         {
            step.castingSpellId = this.castingSpell.castingSpellId;
         }
         this._stepsBuffer.push(step);
      }
      
      private function clearBuffer() : void {
         this._stepsBuffer = new Vector.<ISequencable>(0,false);
      }
      
      private function showTargetTooltip(pEntityId:int) : void {
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var entityInfos:GameFightFighterInformations = this.fightEntitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations;
         if((((entityInfos.alive) && (this._castingSpell)) && (this._castingSpell.casterId == PlayedCharacterManager.getInstance().id || fcf.battleFrame.playingSlaveEntity)) && (!(pEntityId == this.castingSpell.casterId)) && (this._fightBattleFrame.targetedEntities.indexOf(pEntityId) == -1))
         {
            this._fightBattleFrame.targetedEntities.push(pEntityId);
            if(OptionManager.getOptionManager("dofus")["showPermanentTargetsTooltips"] == true)
            {
               fcf.displayEntityTooltip(pEntityId);
            }
         }
      }
   }
}
