package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightStealingKamasStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightStealingKamasStep(param1:int, param2:int, param3:uint) {
         super();
         this._robberId = param1;
         this._victimId = param2;
         this._amount = param3;
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
