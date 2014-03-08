package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightReflectedSpellStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightReflectedSpellStep(fighterId:int) {
         super();
         this._fighterId = fighterId;
      }
      
      private var _fighterId:int;
      
      public function get stepType() : String {
         return "reflectedSpell";
      }
      
      override public function start() : void {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_REFLECTED_SPELL,[this._fighterId],this._fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
