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
      
      public function FightUnmarkCellsStep(markId:int) {
         super();
         this._markId = markId;
      }
      
      private var _markId:int;
      
      public function get stepType() : String {
         return "unmarkCells";
      }
      
      override public function start() : void {
         var mi:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
         if(!mi)
         {
            _log.error("Trying to remove an unknown mark (" + this._markId + "). Aborting.");
            executeCallbacks();
            return;
         }
         MarkedCellsManager.getInstance().removeGlyph(this._markId);
         var evt:String = FightEventEnum.UNKNOWN_FIGHT_EVENT;
         switch(mi.markType)
         {
            case GameActionMarkTypeEnum.GLYPH:
               evt = FightEventEnum.GLYPH_DISAPPEARED;
               break;
            case GameActionMarkTypeEnum.TRAP:
               evt = FightEventEnum.TRAP_DISAPPEARED;
               break;
            default:
               _log.warn("Unknown mark type (" + mi.markType + ").");
         }
         FightEventsHelper.sendFightEvent(evt,[mi.associatedSpell.id],0,castingSpellId);
         MarkedCellsManager.getInstance().removeMark(this._markId);
         executeCallbacks();
      }
   }
}
