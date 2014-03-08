package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   
   public class FightUnmarkCellsStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightUnmarkCellsStep(param1:int) {
         super();
         this._markId = param1;
      }
      
      private var _markId:int;
      
      public function get stepType() : String {
         return "unmarkCells";
      }
      
      override public function start() : void {
         var _loc1_:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
         if(!_loc1_)
         {
            _log.error("Trying to remove an unknown mark (" + this._markId + "). Aborting.");
            executeCallbacks();
            return;
         }
         MarkedCellsManager.getInstance().removeGlyph(this._markId);
         var _loc2_:String = FightEventEnum.UNKNOWN_FIGHT_EVENT;
         switch(_loc1_.markType)
         {
            case GameActionMarkTypeEnum.GLYPH:
               _loc2_ = FightEventEnum.GLYPH_DISAPPEARED;
               break;
            case GameActionMarkTypeEnum.TRAP:
               _loc2_ = FightEventEnum.TRAP_DISAPPEARED;
               break;
            default:
               _log.warn("Unknown mark type (" + _loc1_.markType + ").");
         }
         FightEventsHelper.sendFightEvent(_loc2_,[_loc1_.associatedSpell.id],0,castingSpellId);
         MarkedCellsManager.getInstance().removeMark(this._markId);
         executeCallbacks();
      }
   }
}
