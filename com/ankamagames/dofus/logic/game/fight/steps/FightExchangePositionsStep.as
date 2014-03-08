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
      
      public function FightExchangePositionsStep(fighterOne:int, fighterOneNewCell:int, fighterTwo:int, fighterTwoNewCell:int) {
         super();
         this._fighterOne = fighterOne;
         this._fighterOneNewCell = fighterOneNewCell;
         this._fighterTwo = fighterTwo;
         this._fighterTwoNewCell = fighterTwoNewCell;
         var infos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterOne) as GameFightFighterInformations;
         this._fighterOneVisibility = infos.stats.invisibilityState;
         infos.disposition.cellId = this._fighterOneNewCell;
         infos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterTwo) as GameFightFighterInformations;
         infos.disposition.cellId = this._fighterTwoNewCell;
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
         var fighterInfosOne:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterOne) as GameFightFighterInformations;
         var fighterInfosTwo:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterTwo) as GameFightFighterInformations;
         fighterInfosOne.disposition.cellId = this._fighterOneNewCell;
         fighterInfosTwo.disposition.cellId = this._fighterTwoNewCell;
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTERS_POSITION_EXCHANGE,[this._fighterOne,this._fighterTwo],0,castingSpellId);
         FightSpellCastFrame.updateRangeAndTarget();
         executeCallbacks();
      }
      
      private function doJump(fighterId:int, newCell:int) : Boolean {
         var fighterEntity:IMovable = null;
         if(newCell > -1)
         {
            fighterEntity = DofusEntities.getEntity(fighterId) as IMovable;
            if(fighterEntity)
            {
               fighterEntity.jump(MapPoint.fromCellId(newCell));
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
