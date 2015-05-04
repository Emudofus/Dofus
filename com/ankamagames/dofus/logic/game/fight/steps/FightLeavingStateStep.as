package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightLeavingStateStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightLeavingStateStep(param1:int, param2:int)
      {
         super();
         this._fighterId = param1;
         this._stateId = param2;
      }
      
      private var _fighterId:int;
      
      private var _stateId:int;
      
      public function get stepType() : String
      {
         return "leavingState";
      }
      
      override public function start() : void
      {
         if(!SpellState.getSpellStateById(this._stateId).isSilent)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVING_STATE,[this._fighterId,this._stateId],this._fighterId,-1,false,2);
         }
         executeCallbacks();
      }
   }
}
