package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightDispellStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightDispellStep(param1:int) {
         super();
         this._fighterId = param1;
      }
      
      private var _fighterId:int;
      
      public function get stepType() : String {
         return "dispell";
      }
      
      override public function start() : void {
         BuffManager.getInstance().dispell(this._fighterId);
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_GOT_DISPELLED,[this._fighterId],this._fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
