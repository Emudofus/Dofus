package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightSpellCooldownVariationStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _spellId:int;
        private var _actionId:int;
        private var _value:int;

        public function FightSpellCooldownVariationStep(param1:int, param2:int, param3:int, param4:int)
        {
            this._fighterId = param1;
            this._spellId = param3;
            this._actionId = param2;
            this._value = param4;
            return;
        }// end function

        public function get stepType() : String
        {
            return "spellCooldownVariation";
        }// end function

        override public function start() : void
        {
            var _loc_1:SpellCastInFightManager = null;
            var _loc_2:PlayedCharacterManager = null;
            var _loc_3:uint = 0;
            var _loc_4:SpellWrapper = null;
            var _loc_5:SpellManager = null;
            if (this._fighterId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
                _loc_1 = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(this._fighterId);
                _loc_2 = PlayedCharacterManager.getInstance();
                for each (_loc_4 in _loc_2.spellsInventory)
                {
                    
                    if (_loc_4.id == this._spellId)
                    {
                        _loc_3 = _loc_4.spellLevel;
                        continue;
                    }
                }
                if (_loc_1 && _loc_3 > 0)
                {
                    if (!_loc_1.getSpellManagerBySpellId(this._spellId))
                    {
                        _loc_1.castSpell(this._spellId, _loc_3, [], false);
                    }
                    _loc_5 = _loc_1.getSpellManagerBySpellId(this._spellId);
                    _loc_5.forceCooldown(this._value);
                }
            }
            executeCallbacks();
            return;
        }// end function

    }
}
