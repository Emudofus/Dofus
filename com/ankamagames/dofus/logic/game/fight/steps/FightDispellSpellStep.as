package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   
   public class FightDispellSpellStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightDispellSpellStep(fighterId:int, spellId:int) {
         super();
         this._fighterId = fighterId;
         this._spellId = spellId;
      }
      
      private var _fighterId:int;
      
      private var _spellId:int;
      
      public function get stepType() : String {
         return "dispellSpell";
      }
      
      override public function start() : void {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SPELL_DISPELLED,[this._fighterId,this._spellId],this._fighterId,castingSpellId);
         BuffManager.getInstance().dispellSpell(this._fighterId,this._spellId,true);
         executeCallbacks();
      }
   }
}
