package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   
   public class FightMarkCellsStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightMarkCellsStep(markId:int, markType:int, associatedSpellRank:SpellLevel, cells:Vector.<GameActionMarkedCell>, markSpellId:int) {
         super();
         this._markId = markId;
         this._cells = cells;
         this._markType = markType;
         this._associatedSpellRank = associatedSpellRank;
         this._markSpellId = markSpellId;
      }
      
      private var _markId:int;
      
      private var _markType:int;
      
      private var _associatedSpellRank:SpellLevel;
      
      private var _cells:Vector.<GameActionMarkedCell>;
      
      private var _markSpellId:int;
      
      public function get stepType() : String {
         return "markCells";
      }
      
      override public function start() : void {
         var cellZone:GameActionMarkedCell = null;
         var step:AddGlyphGfxStep = null;
         var evt:String = null;
         var spell:Spell = Spell.getSpellById(this._markSpellId);
         MarkedCellsManager.getInstance().addMark(this._markId,this._markType,spell,this._cells);
         if(this._markType == GameActionMarkTypeEnum.WALL)
         {
            if(spell.getParamByName("glyphGfxId"))
            {
               for each(cellZone in this._cells)
               {
                  step = new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"),cellZone.cellId,this._markId,this._markType);
                  step.start();
               }
            }
         }
         var mi:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
         if(mi)
         {
            evt = FightEventEnum.UNKNOWN_FIGHT_EVENT;
            switch(mi.markType)
            {
               case GameActionMarkTypeEnum.GLYPH:
                  evt = FightEventEnum.GLYPH_APPEARED;
                  break;
               case GameActionMarkTypeEnum.TRAP:
                  evt = FightEventEnum.TRAP_APPEARED;
                  break;
               default:
                  _log.warn("Unknown mark type (" + mi.markType + ").");
            }
            FightEventsHelper.sendFightEvent(evt,[mi.associatedSpell.id],0,castingSpellId);
         }
         executeCallbacks();
      }
   }
}
