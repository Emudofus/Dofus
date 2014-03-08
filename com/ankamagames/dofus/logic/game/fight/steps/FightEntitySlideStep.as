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
      
      public function FightEntitySlideStep(param1:int, param2:MapPoint, param3:MapPoint) {
         super();
         this._fighterId = param1;
         this._startCell = param2;
         this._endCell = param3;
         var _loc4_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(param1) as GameFightFighterInformations;
         _loc4_.disposition.cellId = param3.cellId;
      }
      
      private var _fighterId:int;
      
      private var _startCell:MapPoint;
      
      private var _endCell:MapPoint;
      
      public function get stepType() : String {
         return "entitySlide";
      }
      
      override public function start() : void {
         var _loc2_:GameFightFighterInformations = null;
         var _loc3_:MovementPath = null;
         var _loc1_:IMovable = DofusEntities.getEntity(this._fighterId) as IMovable;
         if(_loc1_)
         {
            if(!_loc1_.position.equals(this._startCell))
            {
               _log.warn("We were ordered to slide " + this._fighterId + " from " + this._startCell.cellId + ", but this fighter is on " + _loc1_.position.cellId + ".");
            }
            if(_loc1_ is AnimatedCharacter)
            {
               (_loc1_ as AnimatedCharacter).slideOnNextMove = true;
            }
            _loc2_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            _loc2_.disposition.cellId = this._endCell.cellId;
            _loc3_ = new MovementPath();
            _loc3_.start = _loc1_.position;
            _loc3_.end = this._endCell;
            _loc3_.addPoint(new PathElement(_loc1_.position,_loc3_.start.orientationTo(_loc3_.end)));
            _loc3_.fill();
            _loc1_.move(_loc3_,this.slideFinished);
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
