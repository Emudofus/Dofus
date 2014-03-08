package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightChangeLookStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightChangeLookStep(fighterId:int, newLook:TiphonEntityLook) {
         super();
         this._fighterId = fighterId;
         this._newLook = newLook;
      }
      
      private var _fighterId:int;
      
      private var _newLook:TiphonEntityLook;
      
      public function get stepType() : String {
         return "changeLook";
      }
      
      override public function start() : void {
         var gcrelmsg:GameContextRefreshEntityLookMessage = new GameContextRefreshEntityLookMessage();
         gcrelmsg.initGameContextRefreshEntityLookMessage(this._fighterId,EntityLookAdapter.toNetwork(this._newLook));
         Kernel.getWorker().getFrame(FightEntitiesFrame).process(gcrelmsg);
         this._newLook = TiphonUtility.getLookWithoutMount(this._newLook);
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CHANGE_LOOK,[this._fighterId,this._newLook],this._fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
