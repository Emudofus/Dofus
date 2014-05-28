package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightTeleportStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightTeleportStep(fighterId:int, destinationCell:MapPoint) {
         super();
         this._fighterId = fighterId;
         this._destinationCell = destinationCell;
      }
      
      private var _fighterId:int;
      
      private var _destinationCell:MapPoint;
      
      public function get stepType() : String {
         return "teleport";
      }
      
      override public function start() : void {
         var fightTurnFrame:FightTurnFrame = null;
         var entity:IMovable = DofusEntities.getEntity(this._fighterId) as IMovable;
         if(entity)
         {
            (entity as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
            entity.jump(this._destinationCell);
         }
         else
         {
            _log.warn("Unable to teleport unknown entity " + this._fighterId + ".");
         }
         var infos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
         infos.disposition.cellId = this._destinationCell.cellId;
         if(this._fighterId == PlayedCharacterManager.getInstance().id)
         {
            fightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if((fightTurnFrame) && (fightTurnFrame.myTurn))
            {
               fightTurnFrame.drawPath();
            }
         }
         FightSpellCastFrame.updateRangeAndTarget();
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_TELEPORTED,[this._fighterId],0,castingSpellId);
         executeCallbacks();
      }
   }
}
