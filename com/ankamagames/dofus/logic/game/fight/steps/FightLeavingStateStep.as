package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightLeavingStateStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightLeavingStateStep(fighterId:int, stateId:int) {
         super();
         this._fighterId = fighterId;
         this._stateId = stateId;
      }
      
      private var _fighterId:int;
      
      private var _stateId:int;
      
      public function get stepType() : String {
         return "leavingState";
      }
      
      override public function start() : void {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVING_STATE,[this._fighterId,this._stateId],this._fighterId,-1);
         executeCallbacks();
      }
   }
}
