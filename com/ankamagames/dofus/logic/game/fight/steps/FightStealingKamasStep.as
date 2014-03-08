package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightStealingKamasStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightStealingKamasStep(robberId:int, victimId:int, amount:uint) {
         super();
         this._robberId = robberId;
         this._victimId = victimId;
         this._amount = amount;
      }
      
      private var _robberId:int;
      
      private var _victimId:int;
      
      private var _amount:uint;
      
      public function get stepType() : String {
         return "stealingKamas";
      }
      
      override public function start() : void {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_STEALING_KAMAS,[this._robberId,this._victimId,this._amount],this._victimId,castingSpellId,false,3,2);
         executeCallbacks();
      }
   }
}
