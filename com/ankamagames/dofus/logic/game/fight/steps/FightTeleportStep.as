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
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightTeleportStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightTeleportStep(param1:int, param2:MapPoint)
      {
         super();
         this._fighterId = param1;
         this._destinationCell = param2;
      }
      
      private var _fighterId:int;
      
      private var _destinationCell:MapPoint;
      
      public function get stepType() : String
      {
         return "teleport";
      }
      
      override public function start() : void
      {
         var _loc4_:FightTurnFrame = null;
         var _loc1_:IMovable = DofusEntities.getEntity(this._fighterId) as IMovable;
         if(_loc1_)
         {
            (_loc1_ as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
            _loc1_.jump(this._destinationCell);
         }
         else
         {
            _log.warn("Unable to teleport unknown entity " + this._fighterId + ".");
         }
         var _loc2_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
         _loc2_.disposition.cellId = this._destinationCell.cellId;
         if(this._fighterId == PlayedCharacterManager.getInstance().id)
         {
            _loc4_ = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if((_loc4_) && (_loc4_.myTurn))
            {
               _loc4_.drawPath();
            }
         }
         FightSpellCastFrame.updateRangeAndTarget();
         var _loc3_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if((_loc3_.showPermanentTooltips) && !(_loc3_.battleFrame.targetedEntities.indexOf(_loc1_.id) == -1))
         {
            TooltipManager.updatePosition(_loc2_ is GameFightCharacterInformations?"PlayerShortInfos" + this._fighterId:"EntityShortInfos" + this._fighterId,"tooltipOverEntity_" + this._fighterId,(_loc1_ as AnimatedCharacter).absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,_loc1_.position.cellId);
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_TELEPORTED,[this._fighterId],0,castingSpellId);
         executeCallbacks();
      }
   }
}
