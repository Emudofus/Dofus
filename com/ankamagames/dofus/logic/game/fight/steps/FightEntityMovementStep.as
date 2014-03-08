package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   
   public class FightEntityMovementStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightEntityMovementStep(entityId:int, path:MovementPath) {
         super();
         this._entityId = entityId;
         this._path = path;
         timeout = path.length * 1000;
      }
      
      private var _entityId:int;
      
      private var _path:MovementPath;
      
      public function get stepType() : String {
         return "entityMovement";
      }
      
      override public function start() : void {
         var fighterInfos:GameFightFighterInformations = null;
         var entity:IMovable = DofusEntities.getEntity(this._entityId) as IMovable;
         if(entity)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
            fighterInfos.disposition.cellId = this._path.end.cellId;
            entity.move(this._path,this.movementEnd);
         }
         else
         {
            _log.warn("Unable to move unknown entity " + this._entityId + ".");
            this.movementEnd();
         }
      }
      
      private function movementEnd() : void {
         FightSpellCastFrame.updateRangeAndTarget();
         executeCallbacks();
      }
   }
}
