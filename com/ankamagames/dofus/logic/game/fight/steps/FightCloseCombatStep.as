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
      
      public function FightCloseCombatStep(fighterId:int, weaponId:uint, critical:uint) {
         super();
         this._fighterId = fighterId;
         this._weaponId = weaponId;
         this._critical = critical;
      }
      
      private var _fighterId:int;
      
      private var _weaponId:uint;
      
      private var _critical:uint;
      
      public function get stepType() : String {
         return "closeCombat";
      }
      
      override public function start() : void {
         var fighterInfos:GameFightFighterInformations = null;
         var seq:SerialSequencer = null;
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CLOSE_COMBAT,[this._fighterId,this._weaponId,this._critical],this._fighterId,castingSpellId,true);
         if(this._critical == FightSpellCastCriticalEnum.CRITICAL_HIT)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            if(fighterInfos)
            {
               seq = new SerialSequencer();
               seq.addStep(new AddGfxEntityStep(1062,fighterInfos.disposition.cellId));
               seq.start();
            }
         }
         executeCallbacks();
      }
   }
}
