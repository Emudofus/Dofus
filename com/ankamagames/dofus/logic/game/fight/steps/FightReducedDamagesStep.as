package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightReducedDamagesStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightReducedDamagesStep(param1:int, param2:int) {
         super();
         this._fighterId = param1;
         this._amount = param2;
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
