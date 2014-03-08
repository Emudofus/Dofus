package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightReducedDamagesStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightReducedDamagesStep(fighterId:int, amount:int) {
         super();
         this._fighterId = fighterId;
         this._amount = amount;
      }
      
      private var _fighterId:int;
      
      private var _amount:int;
      
      public function get stepType() : String {
         return "reducedDamages";
      }
      
      override public function start() : void {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_REDUCED_DAMAGES,[this._fighterId,this._amount],this._fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
