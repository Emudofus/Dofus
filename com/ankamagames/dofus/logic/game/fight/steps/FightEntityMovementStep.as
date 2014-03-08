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
      
      public function FightEntityMovementStep(param1:int, param2:MovementPath) {
         super();
         this._entityId = param1;
         this._path = param2;
         timeout = param2.length * 1000;
      }
      
      private var _entityId:int;
      
      private var _path:MovementPath;
      
      public function get stepType() : String {
         return "entityMovement";
      }
      
      override public function start() : void {
         var _loc2_:GameFightFighterInformations = null;
         var _loc1_:IMovable = DofusEntities.getEntity(this._entityId) as IMovable;
         if(_loc1_)
         {
            _loc2_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
            _loc2_.disposition.cellId = this._path.end.cellId;
            _loc1_.move(this._path,this.movementEnd);
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
