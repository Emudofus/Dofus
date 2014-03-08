package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   
   public class FightDeathStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightDeathStep(entityId:int, naturalDeath:Boolean=true) {
         super();
         this._entityId = entityId;
         this._naturalDeath = naturalDeath;
         var fightContexteFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(fightContexteFrame)
         {
            this._targetName = fightContexteFrame.getFighterName(entityId);
         }
         else
         {
            this._targetName = "???";
         }
      }
      
      private var _entityId:int;
      
      private var _deathSubSequence:ISequencer;
      
      private var _naturalDeath:Boolean;
      
      private var _targetName:String;
      
      private var _needToWarn:Boolean = true;
      
      private var _timeOut:Boolean = false;
      
      public function get stepType() : String {
         return "death";
      }
      
      public function get entityId() : int {
         return this._entityId;
      }
      
      override public function start() : void {
         var dyingEntity:IEntity = DofusEntities.getEntity(this._entityId);
         if(!dyingEntity)
         {
            _log.warn("Unable to play death of an unexisting fighter " + this._entityId + ".");
            this._needToWarn = true;
            this.deathFinished();
            return;
         }
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
         var fightBattleFrame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fightBattleFrame)
         {
            fightBattleFrame.deadFightersList.push(this._entityId);
         }
         this._needToWarn = true;
         BuffManager.getInstance().dispell(dyingEntity.id,false,false,true);
         var impactedTarget:Array = BuffManager.getInstance().removeLinkedBuff(dyingEntity.id,false,true);
         BuffManager.getInstance().reaffectBuffs(dyingEntity.id);
         fighterInfos.stats.lifePoints = 0;
         if(PlayedCharacterManager.getInstance().id == this._entityId)
         {
            PlayedCharacterManager.getInstance().characteristics.lifePoints = 0;
         }
         this._deathSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
         if(dyingEntity is TiphonSprite)
         {
            this._deathSubSequence.addStep(new PlayAnimationStep(dyingEntity as TiphonSprite,AnimationEnum.ANIM_MORT));
            this._deathSubSequence.addStep(new CallbackStep(new Callback(this.onAnimEnd,dyingEntity)));
         }
         this._deathSubSequence.addStep(new CallbackStep(new Callback(this.manualRollOut,this._entityId)));
         this._deathSubSequence.addStep(new FightDestroyEntityStep(dyingEntity));
         this._deathSubSequence.addEventListener(SequencerEvent.SEQUENCE_TIMEOUT,this.deathTimeOut);
         this._deathSubSequence.addEventListener(SequencerEvent.SEQUENCE_END,this.deathFinished);
         this._deathSubSequence.start();
      }
      
      override public function clear() : void {
         if(this._deathSubSequence)
         {
            this._deathSubSequence.clear();
         }
         super.clear();
      }
      
      private function manualRollOut(fighterId:int) : void {
         var fightContextFrame:FightContextFrame = null;
         if(FightContextFrame.fighterEntityTooltipId == fighterId)
         {
            fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            if(fightContextFrame)
            {
               fightContextFrame.outEntity(fighterId);
            }
         }
      }
      
      private function onAnimEnd(dyingEntity:TiphonSprite) : void {
         var rider:TiphonSprite = dyingEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
         if(rider)
         {
            dyingEntity = rider;
         }
         var carriedEntity:DisplayObjectContainer = dyingEntity.getSubEntitySlot(FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX);
         if(carriedEntity)
         {
            dyingEntity.removeSubEntity(carriedEntity);
         }
      }
      
      private function deathTimeOut(e:Event=null) : void {
         if(this._deathSubSequence)
         {
            this._deathSubSequence.removeEventListener(SequencerEvent.SEQUENCE_TIMEOUT,this.deathTimeOut);
         }
         this._timeOut = true;
      }
      
      private function deathFinished(e:Event=null) : void {
         if(this._deathSubSequence)
         {
            this._deathSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END,this.deathFinished);
            this._deathSubSequence = null;
         }
         if(this._needToWarn)
         {
            if(this._naturalDeath)
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_DEATH,[this._entityId,this._targetName],this._entityId,castingSpellId,this._timeOut);
            }
            else
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVE,[this._entityId,this._targetName],this._entityId,castingSpellId,this._timeOut);
            }
         }
         FightSpellCastFrame.updateRangeAndTarget();
         var ftf:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if((ftf) && (ftf.myTurn))
         {
            ftf.updatePath();
         }
         executeCallbacks();
      }
   }
}
