package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.atouin.entities.behaviours.movements.SlideMovementBehavior;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import flash.events.Event;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.kernel.Kernel;
   
   public class FightEntitySlideStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightEntitySlideStep(param1:int, param2:MapPoint, param3:MapPoint)
      {
         super();
         this._fighterId = param1;
         this._startCell = param2;
         this._endCell = param3;
         var _loc4_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(param1) as GameFightFighterInformations;
         _loc4_.disposition.cellId = param3.cellId;
         this._entity = DofusEntities.getEntity(this._fighterId) as AnimatedCharacter;
         if(this._entity)
         {
            this._entity.slideOnNextMove = true;
         }
         this._fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
      }
      
      private var _fighterId:int;
      
      private var _startCell:MapPoint;
      
      private var _endCell:MapPoint;
      
      private var _entity:AnimatedCharacter;
      
      private var _fightContextFrame:FightContextFrame;
      
      private var _ttCacheName:String;
      
      private var _ttName:String;
      
      public function get stepType() : String
      {
         return "entitySlide";
      }
      
      override public function start() : void
      {
         var _loc1_:GameFightFighterInformations = null;
         var _loc2_:MovementPath = null;
         if(this._entity)
         {
            if(!this._entity.position.equals(this._startCell))
            {
               _log.warn("We were ordered to slide " + this._fighterId + " from " + this._startCell.cellId + ", but this fighter is on " + this._entity.position.cellId + ".");
            }
            _loc1_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            _loc1_.disposition.cellId = this._endCell.cellId;
            _loc2_ = new MovementPath();
            _loc2_.start = this._entity.position;
            _loc2_.end = this._endCell;
            _loc2_.addPoint(new PathElement(this._entity.position,_loc2_.start.orientationTo(_loc2_.end)));
            _loc2_.fill();
            this._ttCacheName = _loc1_ is GameFightCharacterInformations?"PlayerShortInfos" + this._fighterId:"EntityShortInfos" + this._fighterId;
            this._ttName = "tooltipOverEntity_" + this._fighterId;
            EnterFrameDispatcher.addEventListener(this.onEnterFrame,"slideStep");
            this._entity.move(_loc2_,this.slideFinished,SlideMovementBehavior.getInstance());
            this._entity.slideOnNextMove = false;
         }
         else
         {
            _log.warn("Unable to slide unexisting fighter " + this._fighterId + ".");
            this.slideFinished();
         }
      }
      
      private function slideFinished() : void
      {
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         if((this._fightContextFrame.timelineOverEntity) || (this._fightContextFrame.showPermanentTooltips) && !(this._fightContextFrame.battleFrame.targetedEntities.indexOf(this._entity.id) == -1))
         {
            TooltipManager.updatePosition(this._ttCacheName,this._ttName,this._entity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,this._entity.position.cellId);
         }
         FightSpellCastFrame.updateRangeAndTarget();
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SLIDE,[this._fighterId],this._fighterId,castingSpellId);
         executeCallbacks();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if((this._fightContextFrame.timelineOverEntity) || (this._fightContextFrame.showPermanentTooltips) && !(this._fightContextFrame.battleFrame.targetedEntities.indexOf(this._entity.id) == -1))
         {
            TooltipManager.updatePosition(this._ttCacheName,this._ttName,this._entity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,this._entity.position.cellId);
         }
      }
   }
}
