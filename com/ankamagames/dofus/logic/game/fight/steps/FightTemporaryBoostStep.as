package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightTemporaryBoostStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightTemporaryBoostStep(param1:int, param2:String, param3:int, param4:String) {
         super();
         this._fighterId = param1;
         this._statName = param2;
         this._duration = param3;
         this._durationText = param4;
      }
      
      private var _fighterId:int;
      
      private var _statName:String;
      
      private var _duration:int;
      
      private var _durationText:String;
      
      public function get stepType() : String {
         return "temporaryBoost";
      }
      
      override public function start() : void {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_TEMPORARY_BOOSTED,[this._fighterId,this._statName,this._duration,this._durationText],this._fighterId,castingSpellId,false,2);
         executeCallbacks();
      }
   }
}
