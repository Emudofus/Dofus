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
      
      public function FightMarkTriggeredStep(fighterId:int, casterId:int, markId:int) {
         super();
         this._fighterId = fighterId;
         this._casterId = casterId;
         this._markId = markId;
      }
      
      private var _fighterId:int;
      
      private var _casterId:int;
      
      private var _markId:int;
      
      public function get stepType() : String {
         return "markTriggered";
      }
      
      override public function start() : void {
         var mi:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
         if(!mi)
         {
            _log.error("Trying to trigger an unknown mark (" + this._markId + "). Aborting.");
            executeCallbacks();
            return;
         }
         var evt:String = FightEventEnum.UNKNOWN_FIGHT_EVENT;
         switch(mi.markType)
         {
            case GameActionMarkTypeEnum.GLYPH:
               this.addProjectile(1016);
               evt = FightEventEnum.FIGHTER_TRIGGERED_GLYPH;
               break;
            case GameActionMarkTypeEnum.TRAP:
               this.addProjectile(1017);
               evt = FightEventEnum.FIGHTER_TRIGGERED_TRAP;
               break;
            default:
               _log.warn("Unknown mark type triggered (" + mi.markType + ").");
         }
         FightEventsHelper.sendFightEvent(evt,[this._fighterId,this._casterId,mi.associatedSpell.id],0,castingSpellId);
         executeCallbacks();
      }
      
      private function addProjectile(gfxId:int) : void {
         var id:int = EntitiesManager.getInstance().getFreeEntityId();
         var entity:Projectile = new Projectile(id,TiphonEntityLook.fromString("{" + gfxId + "}"),true);
         entity.init();
         if(MarkedCellsManager.getInstance().getGlyph(this._markId) == null)
         {
            return;
         }
         entity.position = MarkedCellsManager.getInstance().getGlyph(this._markId).position;
         entity.display(PlacementStrataEnums.STRATA_AREA);
         entity.addEventListener(TiphonEvent.ANIMATION_END,this.removeProjectile);
      }
      
      private function removeProjectile(event:TiphonEvent) : void {
         (event.target as Projectile).remove();
      }
   }
}
