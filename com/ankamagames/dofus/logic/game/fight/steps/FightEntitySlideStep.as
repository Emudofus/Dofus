package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightEntitySlideStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightEntitySlideStep(fighterId:int, startCell:MapPoint, endCell:MapPoint) {
         super();
         this._fighterId = fighterId;
         this._startCell = startCell;
         this._endCell = endCell;
         var infos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(fighterId) as GameFightFighterInformations;
         infos.disposition.cellId = endCell.cellId;
      }
      
      private var _fighterId:int;
      
      private var _startCell:MapPoint;
      
      private var _endCell:MapPoint;
      
      public function get stepType() : String {
         return "entitySlide";
      }
      
      override public function start() : void {
         var fighterInfos:GameFightFighterInformations = null;
         var path:MovementPath = null;
         var entity:IMovable = DofusEntities.getEntity(this._fighterId) as IMovable;
         if(entity)
         {
            if(!entity.position.equals(this._startCell))
            {
               _log.warn("We were ordered to slide " + this._fighterId + " from " + this._startCell.cellId + ", but this fighter is on " + entity.position.cellId + ".");
            }
            if(entity is AnimatedCharacter)
            {
               (entity as AnimatedCharacter).slideOnNextMove = true;
            }
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            fighterInfos.disposition.cellId = this._endCell.cellId;
            path = new MovementPath();
            path.start = entity.position;
            path.end = this._endCell;
            path.addPoint(new PathElement(entity.position,path.start.orientationTo(path.end)));
            path.fill();
            entity.move(path,this.slideFinished);
         }
         else
         {
            _log.warn("Unable to slide unexisting fighter " + this._fighterId + ".");
            this.slideFinished();
         }
      }
      
      private function slideFinished() : void {
         FightSpellCastFrame.updateRangeAndTarget();
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SLIDE,[this._fighterId],this._fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
