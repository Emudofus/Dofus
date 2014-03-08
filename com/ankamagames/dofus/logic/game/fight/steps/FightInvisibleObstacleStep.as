package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightInvisibleObstacleStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightInvisibleObstacleStep(param1:int, param2:int) {
         super();
         this._fighterId = param1;
         this._spellLevelId = param2;
      }
      
      private var _fighterId:int;
      
      private var _spellLevelId:int;
      
      public function get stepType() : String {
         return "invisibleObstacle";
      }
      
      override public function start() : void {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_INVISIBLE_OBSTACLE,[this._fighterId,this._spellLevelId],this._fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
