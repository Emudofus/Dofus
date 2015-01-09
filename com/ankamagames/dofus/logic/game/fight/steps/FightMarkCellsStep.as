package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
    import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;

    public class FightMarkCellsStep extends AbstractSequencable implements IFightStep 
    {

        private var _markId:int;
        private var _markType:int;
        private var _markSpellLevel:SpellLevel;
        private var _cells:Vector.<GameActionMarkedCell>;
        private var _markSpellId:int;
        private var _markTeamId:int;
        private var _markImpactCell:int;
        private var _markActive:Boolean;

        public function FightMarkCellsStep(markId:int, markType:int, cells:Vector.<GameActionMarkedCell>, markSpellId:int, markSpellLevel:SpellLevel, markTeamId:int, markImpactCell:int, markActive:Boolean=true)
        {
            this._markId = markId;
            this._markType = markType;
            this._cells = cells;
            this._markSpellId = markSpellId;
            this._markSpellLevel = markSpellLevel;
            this._markTeamId = markTeamId;
            this._markImpactCell = markImpactCell;
            this._markActive = markActive;
        }

        public function get stepType():String
        {
            return ("markCells");
        }

        override public function start():void
        {
            var cellZone:GameActionMarkedCell;
            var step:AddGlyphGfxStep;
            var evt:String;
            var spell:Spell = Spell.getSpellById(this._markSpellId);
            if (this._markType == GameActionMarkTypeEnum.WALL)
            {
                if (((spell.getParamByName("glyphGfxId")) || (true)))
                {
                    for each (cellZone in this._cells)
                    {
                        step = new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"), cellZone.cellId, this._markId, this._markType, this._markTeamId);
                        step.start();
                    };
                };
            }
            else
            {
                if (((((spell.getParamByName("glyphGfxId")) && (!(MarkedCellsManager.getInstance().getGlyph(this._markId))))) && (!((this._markImpactCell == -1)))))
                {
                    step = new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"), this._markImpactCell, this._markId, this._markType, this._markTeamId);
                    step.start();
                };
            };
            MarkedCellsManager.getInstance().addMark(this._markId, this._markType, spell, this._markSpellLevel, this._cells, this._markTeamId, this._markActive);
            var mi:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
            if (mi)
            {
                evt = FightEventEnum.UNKNOWN_FIGHT_EVENT;
                switch (mi.markType)
                {
                    case GameActionMarkTypeEnum.GLYPH:
                        evt = FightEventEnum.GLYPH_APPEARED;
                        break;
                    case GameActionMarkTypeEnum.TRAP:
                        evt = FightEventEnum.TRAP_APPEARED;
                        break;
                    case GameActionMarkTypeEnum.PORTAL:
                        evt = FightEventEnum.PORTAL_APPEARED;
                        break;
                    default:
                        _log.warn((("Unknown mark type (" + mi.markType) + ")."));
                };
                FightEventsHelper.sendFightEvent(evt, [mi.associatedSpell.id], 0, castingSpellId);
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

