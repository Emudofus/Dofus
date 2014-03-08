package com.ankamagames.dofus.logic.game.fight.steps.abstract
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class AbstractDodgePointLossStep extends AbstractSequencable
   {
      
      public function AbstractDodgePointLossStep(param1:int, param2:int) {
         super();
         this._fighterId = param1;
         this._amount = param2;
      }
      
      protected var _fighterId:int;
      
      protected var _amount:int;
   }
}
