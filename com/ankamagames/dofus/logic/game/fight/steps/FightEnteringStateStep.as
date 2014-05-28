package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightEnteringStateStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightEnteringStateStep(fighterId:int, stateId:int, durationString:String) {
         super();
         this._fighterId = fighterId;
         this._stateId = stateId;
         this._durationString = durationString;
      }
      
      private var _fighterId:int;
      
      private var _stateId:int;
      
      private var _durationString:String;
      
      public function get stepType() : String {
         return "enteringState";
      }
      
      override public function start() : void {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_ENTERING_STATE,[this._fighterId,this._stateId,this._durationString],this._fighterId,-1);
         executeCallbacks();
      }
   }
}
