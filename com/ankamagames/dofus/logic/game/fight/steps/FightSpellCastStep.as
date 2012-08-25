package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightSpellCastStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _cellId:int;
        private var _sourceCellId:int;
        private var _spellId:int;
        private var _spellRank:uint;
        private var _critical:uint;

        public function FightSpellCastStep(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:uint)
        {
            this._fighterId = param1;
            this._cellId = param2;
            this._sourceCellId = param3;
            this._spellId = param4;
            this._spellRank = param5;
            this._critical = param6;
            return;
        }// end function

        public function get stepType() : String
        {
            return "spellCast";
        }// end function

        override public function start() : void
        {
            var _loc_1:GameFightFighterInformations = null;
            var _loc_2:SerialSequencer = null;
            var _loc_3:ChatBubble = null;
            var _loc_4:IDisplayable = null;
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CASTED_SPELL, [this._fighterId, this._cellId, this._sourceCellId, this._spellId, this._spellRank, this._critical], 0, castingSpellId, false);
            if (this._critical != FightSpellCastCriticalEnum.NORMAL)
            {
                _loc_1 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
                _loc_2 = new SerialSequencer();
                if (this._critical == FightSpellCastCriticalEnum.CRITICAL_HIT)
                {
                    _loc_2.addStep(new AddGfxEntityStep(1062, _loc_1.disposition.cellId));
                }
                else if (this._critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
                {
                    _loc_3 = new ChatBubble(I18n.getUiText("ui.fight.criticalMiss"));
                    _loc_4 = DofusEntities.getEntity(this._fighterId) as IDisplayable;
                    TooltipManager.show(_loc_3, _loc_4.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "ec" + this._fighterId, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOPRIGHT, 0, true, null, null);
                    _loc_2.addStep(new AddGfxEntityStep(1070, _loc_1.disposition.cellId));
                }
                _loc_2.start();
            }
            executeCallbacks();
            return;
        }// end function

    }
}
