package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencableListener;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightTackledStep extends AbstractSequencable implements IFightStep, ISequencableListener
   {
      
      public function FightTackledStep(fighterId:int) {
         super();
         this._fighterId = fighterId;
      }
      
      private var _fighterId:int;
      
      private var _animStep:ISequencable;
      
      public function get stepType() : String {
         return "tackled";
      }
      
      override public function start() : void {
         var tackledEntity:IEntity = DofusEntities.getEntity(this._fighterId);
         if(!tackledEntity)
         {
            _log.warn("Unable to play tackle of an unexisting fighter " + this._fighterId + ".");
            this.stepFinished(this);
            return;
         }
         this._animStep = new PlayAnimationStep(tackledEntity as TiphonSprite,AnimationEnum.ANIM_TACLE);
         this._animStep.addListener(this);
         this._animStep.start();
      }
      
      public function stepFinished(step:ISequencable, withTimout:Boolean=false) : void {
         this._animStep.removeListener(this);
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_GOT_TACKLED,[this._fighterId],0,castingSpellId);
         executeCallbacks();
      }
   }
}
