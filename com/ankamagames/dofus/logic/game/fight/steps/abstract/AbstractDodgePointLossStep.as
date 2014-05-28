package com.ankamagames.dofus.logic.game.fight.steps.abstract
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class AbstractDodgePointLossStep extends AbstractSequencable
   {
      
      public function AbstractDodgePointLossStep(fighterId:int, amount:int) {
         super();
         this._fighterId = fighterId;
         this._amount = amount;
      }
      
      protected var _fighterId:int;
      
      protected var _amount:int;
   }
}
