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
      
      public function FightChangeLookStep(param1:int, param2:TiphonEntityLook) {
         super();
         this._fighterId = param1;
         this._newLook = param2;
      }
      
      private var _fighterId:int;
      
      private var _newLook:TiphonEntityLook;
      
      public function get stepType() : String {
         return "changeLook";
      }
      
      override public function start() : void {
         var _loc1_:GameContextRefreshEntityLookMessage = new GameContextRefreshEntityLookMessage();
         _loc1_.initGameContextRefreshEntityLookMessage(this._fighterId,EntityLookAdapter.toNetwork(this._newLook));
         Kernel.getWorker().getFrame(FightEntitiesFrame).process(_loc1_);
         this._newLook = TiphonUtility.getLookWithoutMount(this._newLook);
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CHANGE_LOOK,[this._fighterId,this._newLook],this._fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
