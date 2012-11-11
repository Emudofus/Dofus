package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightFighterStatsUpdateStep extends AbstractSequencable implements IFightStep
    {
        private var _stats:CharacterCharacteristicsInformations;

        public function FightFighterStatsUpdateStep(param1:CharacterCharacteristicsInformations)
        {
            this._stats = param1;
            return;
        }// end function

        public function get stepType() : String
        {
            return "fighterStatsUpdate";
        }// end function

        override public function start() : void
        {
            CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(CurrentPlayedFighterManager.getInstance().currentFighterId, this._stats);
            SpellWrapper.refreshAllPlayerSpellHolder(CurrentPlayedFighterManager.getInstance().currentFighterId);
            return;
        }// end function

    }
}
