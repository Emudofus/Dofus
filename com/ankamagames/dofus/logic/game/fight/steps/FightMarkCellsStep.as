package com.ankamagames.dofus.logic.game.fight.steps
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightMarkCellsStep extends AbstractSequencable implements IFightStep
    {
        private var _markId:int;
        private var _markType:int;
        private var _associatedSpellRank:SpellLevel;
        private var _cells:Vector.<GameActionMarkedCell>;
        private var _markSpellId:int;

        public function FightMarkCellsStep(param1:int, param2:int, param3:SpellLevel, param4:Vector.<GameActionMarkedCell>, param5:int)
        {
            this._markId = param1;
            this._cells = param4;
            this._markType = param2;
            this._associatedSpellRank = param3;
            this._markSpellId = param5;
            return;
        }// end function

        public function get stepType() : String
        {
            return "markCells";
        }// end function

        override public function start() : void
        {
            var _loc_4:GameActionMarkedCell = null;
            var _loc_5:AddGlyphGfxStep = null;
            var _loc_1:* = Spell.getSpellById(this._markSpellId);
            MarkedCellsManager.getInstance().addMark(this._markId, this._markType, _loc_1, this._cells);
            if (this._markType == GameActionMarkTypeEnum.WALL)
            {
                if (_loc_1.getParamByName("glyphGfxId"))
                {
                    for each (_loc_4 in this._cells)
                    {
                        
                        _loc_5 = new AddGlyphGfxStep(_loc_1.getParamByName("glyphGfxId"), _loc_4.cellId, this._markId, this._markType);
                        _loc_5.start();
                    }
                }
            }
            var _loc_2:* = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
            var _loc_3:* = FightEventEnum.UNKNOWN_FIGHT_EVENT;
            switch(_loc_2.markType)
            {
                case GameActionMarkTypeEnum.GLYPH:
                {
                    _loc_3 = FightEventEnum.GLYPH_APPEARED;
                    break;
                }
                case GameActionMarkTypeEnum.TRAP:
                {
                    _loc_3 = FightEventEnum.TRAP_APPEARED;
                    break;
                }
                default:
                {
                    _log.warn("Unknown mark type (" + _loc_2.markType + ").");
                    break;
                    break;
                }
            }
            FightEventsHelper.sendFightEvent(_loc_3, [_loc_2.associatedSpell.id], 0, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
