package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   
   public class FightCloseCombatStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightCloseCombatStep(param1:int, param2:uint, param3:uint) {
         super();
         this._fighterId = param1;
         this._weaponId = param2;
         this._critical = param3;
      }
      
      private var _fighterId:int;
      
      private var _weaponId:uint;
      
      private var _critical:uint;
      
      public function get stepType() : String {
         return "closeCombat";
      }
      
      override public function start() : void {
         var _loc1_:GameFightFighterInformations = null;
         var _loc2_:SerialSequencer = null;
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CLOSE_COMBAT,[this._fighterId,this._weaponId,this._critical],this._fighterId,castingSpellId,true);
         if(this._critical == FightSpellCastCriticalEnum.CRITICAL_HIT)
         {
            _loc1_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            if(_loc1_)
            {
               _loc2_ = new SerialSequencer();
               _loc2_.addStep(new AddGfxEntityStep(1062,_loc1_.disposition.cellId));
               _loc2_.start();
            }
         }
         executeCallbacks();
      }
   }
}
