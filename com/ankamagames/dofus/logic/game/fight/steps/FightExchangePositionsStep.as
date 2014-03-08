package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class FightExchangePositionsStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightExchangePositionsStep(param1:int, param2:int, param3:int, param4:int) {
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
      
      public function get stepType() : String {
         return "exchangePositions";
      }
      
      override public function start() : void {
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
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTERS_POSITION_EXCHANGE,[this._fighterOne,this._fighterTwo],0,castingSpellId);
         FightSpellCastFrame.updateRangeAndTarget();
         executeCallbacks();
      }
      
      private function doJump(param1:int, param2:int) : Boolean {
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
