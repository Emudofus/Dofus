package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class FightExchangePositionsStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightExchangePositionsStep(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this._fighterOne = param1;
         this._fighterOneNewCell = param2;
         this._fighterTwo = param3;
         this._fighterTwoNewCell = param4;
         var _loc5_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterOne) as GameFightFighterInformations;
         this._fighterOneVisibility = _loc5_.stats.invisibilityState;
         _loc5_.disposition.cellId = this._fighterOneNewCell;
         _loc5_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterTwo) as GameFightFighterInformations;
         _loc5_.disposition.cellId = this._fighterTwoNewCell;
      }
      
      private var _fighterOne:int;
      
      private var _fighterOneNewCell:int;
      
      private var _fighterTwo:int;
      
      private var _fighterTwoNewCell:int;
      
      private var _fighterOneVisibility:int;
      
      public function get stepType() : String
      {
         return "exchangePositions";
      }
      
      override public function start() : void
      {
         var _loc5_:AnimatedCharacter = null;
         var _loc6_:AnimatedCharacter = null;
         if(this._fighterOneVisibility != GameActionFightInvisibilityStateEnum.INVISIBLE)
         {
            if(!this.doJump(this._fighterOne,this._fighterOneNewCell))
            {
               _log.warn("Unable to move unexisting fighter " + this._fighterOne + " (1) to " + this._fighterOneNewCell + " during a positions exchange.");
            }
         }
         if(!this.doJump(this._fighterTwo,this._fighterTwoNewCell))
         {
            _log.warn("Unable to move unexisting fighter " + this._fighterTwo + " (2) to " + this._fighterTwoNewCell + " during a positions exchange.");
         }
         var _loc1_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterOne) as GameFightFighterInformations;
         var _loc2_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterTwo) as GameFightFighterInformations;
         _loc1_.disposition.cellId = this._fighterOneNewCell;
         _loc2_.disposition.cellId = this._fighterTwoNewCell;
         var _loc3_:AnimatedCharacter = EntitiesManager.getInstance().getEntity(this._fighterOne) as AnimatedCharacter;
         this.showEntityTooltip(_loc3_,_loc1_);
         if(_loc3_.carriedEntity)
         {
            _loc5_ = _loc3_.carriedEntity as AnimatedCharacter;
            this.showEntityTooltip(_loc5_,FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc5_.id) as GameFightFighterInformations);
         }
         var _loc4_:AnimatedCharacter = EntitiesManager.getInstance().getEntity(this._fighterTwo) as AnimatedCharacter;
         this.showEntityTooltip(_loc4_,_loc2_);
         if(_loc4_.carriedEntity)
         {
            _loc6_ = _loc4_.carriedEntity as AnimatedCharacter;
            this.showEntityTooltip(_loc6_,FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc6_.id) as GameFightFighterInformations);
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTERS_POSITION_EXCHANGE,[this._fighterOne,this._fighterTwo],0,castingSpellId);
         FightSpellCastFrame.updateRangeAndTarget();
         executeCallbacks();
      }
      
      private function showEntityTooltip(param1:AnimatedCharacter, param2:GameFightFighterInformations) : void
      {
         var _loc4_:String = null;
         var _loc3_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if((param1) && ((_loc3_.timelineOverEntity) && _loc3_.timelineOverEntityId == param1.id || (_loc3_.showPermanentTooltips) && !(_loc3_.battleFrame.targetedEntities.indexOf(param1.id) == -1)))
         {
            _loc4_ = param2 is GameFightCharacterInformations?"PlayerShortInfos" + param1.id:"EntityShortInfos" + param1.id;
            TooltipManager.updatePosition(_loc4_,"tooltipOverEntity_" + param1.id,param1.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,param1.position.cellId);
         }
      }
      
      private function doJump(param1:int, param2:int) : Boolean
      {
         var _loc3_:IMovable = null;
         if(param2 > -1)
         {
            _loc3_ = DofusEntities.getEntity(param1) as IMovable;
            if(_loc3_)
            {
               _loc3_.jump(MapPoint.fromCellId(param2));
            }
            else
            {
               return false;
            }
         }
         return true;
      }
   }
}
