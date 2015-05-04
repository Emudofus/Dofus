package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import flash.events.Event;
   import com.ankamagames.dofus.kernel.Kernel;
   
   public class FightEntityMovementStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightEntityMovementStep(param1:int, param2:MovementPath)
      {
         super();
         this._entityId = param1;
         this._path = param2;
         timeout = param2.length * 1000;
         this._fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
      }
      
      private var _entityId:int;
      
      private var _entity:AnimatedCharacter;
      
      private var _path:MovementPath;
      
      private var _fightContextFrame:FightContextFrame;
      
      private var _ttCacheName:String;
      
      private var _ttName:String;
      
      public function get stepType() : String
      {
         return "entityMovement";
      }
      
      override public function start() : void
      {
         var _loc1_:GameFightFighterInformations = null;
         this._entity = DofusEntities.getEntity(this._entityId) as AnimatedCharacter;
         if(this._entity)
         {
            _loc1_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
            _loc1_.disposition.cellId = this._path.end.cellId;
            this._ttCacheName = _loc1_ is GameFightCharacterInformations?"PlayerShortInfos" + this._entityId:"EntityShortInfos" + this._entityId;
            this._ttName = "tooltipOverEntity_" + this._entityId;
            EnterFrameDispatcher.addEventListener(this.onEnterFrame,"movementStep");
            this._entity.move(this._path,this.movementEnd);
         }
         else
         {
            _log.warn("Unable to move unknown entity " + this._entityId + ".");
            this.movementEnd();
         }
      }
      
      private function showCarriedEntityTooltip() : void
      {
         var _loc2_:GameFightFighterInformations = null;
         var _loc3_:String = null;
         var _loc1_:AnimatedCharacter = this._entity.carriedEntity as AnimatedCharacter;
         if((_loc1_) && ((this._fightContextFrame.timelineOverEntity) && this._fightContextFrame.timelineOverEntityId == _loc1_.id || (this._fightContextFrame.showPermanentTooltips) && !(this._fightContextFrame.battleFrame.targetedEntities.indexOf(_loc1_.id) == -1)))
         {
            _loc2_ = this._fightContextFrame.entitiesFrame.getEntityInfos(_loc1_.id) as GameFightFighterInformations;
            _loc3_ = _loc2_ is GameFightCharacterInformations?"PlayerShortInfos" + _loc1_.id:"EntityShortInfos" + _loc1_.id;
            TooltipManager.updatePosition(_loc3_,"tooltipOverEntity_" + _loc1_.id,_loc1_.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,this._entity.position.cellId);
         }
      }
      
      private function movementEnd() : void
      {
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         if((this._fightContextFrame.timelineOverEntity) || (this._fightContextFrame.showPermanentTooltips) && !(this._fightContextFrame.battleFrame.targetedEntities.indexOf(this._entity.id) == -1))
         {
            TooltipManager.updatePosition(this._ttCacheName,this._ttName,this._entity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,this._entity.position.cellId);
         }
         this.showCarriedEntityTooltip();
         FightSpellCastFrame.updateRangeAndTarget();
         executeCallbacks();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if((this._fightContextFrame.timelineOverEntity) || (this._fightContextFrame.showPermanentTooltips) && !(this._fightContextFrame.battleFrame.targetedEntities.indexOf(this._entity.id) == -1))
         {
            TooltipManager.updatePosition(this._ttCacheName,this._ttName,this._entity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,this._entity.position.cellId);
         }
         this.showCarriedEntityTooltip();
      }
   }
}
