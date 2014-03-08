package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   
   public class FightTurnListStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightTurnListStep(turnsList:Vector.<int>, deadTurnsList:Vector.<int>) {
         super();
         this._turnsList = turnsList;
         this._deadTurnsList = deadTurnsList;
      }
      
      private var _throwSubSequence:ISequencer;
      
      private var _newTurnsList:Vector.<int>;
      
      private var _newDeadTurnsList:Vector.<int>;
      
      private var _turnsList:Vector.<int>;
      
      private var _deadTurnsList:Vector.<int>;
      
      public function get stepType() : String {
         return "turnList";
      }
      
      override public function start() : void {
         var fbf:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fbf)
         {
            fbf.fightersList = this._turnsList;
            fbf.deadFightersList = this._deadTurnsList;
         }
         KernelEventsManager.getInstance().processCallback(HookList.FightersListUpdated);
         if((Dofus.getInstance().options.orderFighters) && (Kernel.getWorker().getFrame(FightEntitiesFrame)))
         {
            (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).updateAllEntitiesNumber(this._turnsList);
         }
         executeCallbacks();
      }
   }
}
