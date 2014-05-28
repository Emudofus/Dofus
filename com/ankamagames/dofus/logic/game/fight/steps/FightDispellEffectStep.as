package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencableListener;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public class FightDispellEffectStep extends AbstractSequencable implements IFightStep, ISequencableListener
   {
      
      public function FightDispellEffectStep(fighterId:int, boostUID:int) {
         super();
         this._fighterId = fighterId;
         this._boostUID = boostUID;
      }
      
      private var _fighterId:int;
      
      private var _boostUID:int;
      
      private var _virtualStep:IFightStep;
      
      public function get stepType() : String {
         return "dispellEffect";
      }
      
      override public function start() : void {
         var sb:StateBuff = null;
         var buff:BasicBuff = BuffManager.getInstance().getBuff(this._boostUID,this._fighterId);
         if((buff) && (buff is StateBuff))
         {
            sb = buff as StateBuff;
            if(sb.actionId == 952)
            {
               this._virtualStep = new FightEnteringStateStep(sb.targetId,sb.stateId,sb.effects.durationString);
            }
            else
            {
               this._virtualStep = new FightLeavingStateStep(sb.targetId,sb.stateId);
            }
         }
         BuffManager.getInstance().dispellUniqueBuff(this._fighterId,this._boostUID,true,false,true);
         if(!this._virtualStep)
         {
            executeCallbacks();
         }
         else
         {
            this._virtualStep.addListener(this);
            this._virtualStep.start();
         }
      }
      
      public function stepFinished(step:ISequencable, withTimout:Boolean = false) : void {
         this._virtualStep.removeListener(this);
         executeCallbacks();
      }
   }
}
