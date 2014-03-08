package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class FightMarkTriggeredStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightMarkTriggeredStep(param1:int, param2:int, param3:int) {
         super();
         this._fighterId = param1;
         this._casterId = param2;
         this._markId = param3;
      }
      
      private var _fighterId:int;
      
      private var _casterId:int;
      
      private var _markId:int;
      
      public function get stepType() : String {
         return "markTriggered";
      }
      
      override public function start() : void {
         var _loc1_:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
         if(!_loc1_)
         {
            _log.error("Trying to trigger an unknown mark (" + this._markId + "). Aborting.");
            executeCallbacks();
            return;
         }
         var _loc2_:String = FightEventEnum.UNKNOWN_FIGHT_EVENT;
         switch(_loc1_.markType)
         {
            case GameActionMarkTypeEnum.GLYPH:
               this.addProjectile(1016);
               _loc2_ = FightEventEnum.FIGHTER_TRIGGERED_GLYPH;
               break;
            case GameActionMarkTypeEnum.TRAP:
               this.addProjectile(1017);
               _loc2_ = FightEventEnum.FIGHTER_TRIGGERED_TRAP;
               break;
            default:
               _log.warn("Unknown mark type triggered (" + _loc1_.markType + ").");
         }
         FightEventsHelper.sendFightEvent(_loc2_,[this._fighterId,this._casterId,_loc1_.associatedSpell.id],0,castingSpellId);
         executeCallbacks();
      }
      
      private function addProjectile(param1:int) : void {
         var _loc2_:int = EntitiesManager.getInstance().getFreeEntityId();
         var _loc3_:Projectile = new Projectile(_loc2_,TiphonEntityLook.fromString("{" + param1 + "}"),true);
         _loc3_.init();
         if(MarkedCellsManager.getInstance().getGlyph(this._markId) == null)
         {
            return;
         }
         _loc3_.position = MarkedCellsManager.getInstance().getGlyph(this._markId).position;
         _loc3_.display(PlacementStrataEnums.STRATA_AREA);
         _loc3_.addEventListener(TiphonEvent.ANIMATION_END,this.removeProjectile);
      }
      
      private function removeProjectile(param1:TiphonEvent) : void {
         (param1.target as Projectile).remove();
      }
   }
}
