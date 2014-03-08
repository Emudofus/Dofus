package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightEnteringStateStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightEnteringStateStep(param1:int, param2:int, param3:String) {
         super();
         this._fighterId = param1;
         this._stateId = param2;
         this._durationString = param3;
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
