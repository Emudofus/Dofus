﻿package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;

    public class FightSpellCooldownVariationStep extends AbstractSequencable implements IFightStep 
    {

        private var _fighterId:int;
        private var _spellId:int;
        private var _actionId:int;
        private var _value:int;

        public function FightSpellCooldownVariationStep(fighterId:int, actionId:int, spellId:int, value:int)
        {
            this._fighterId = fighterId;
            this._spellId = spellId;
            this._actionId = actionId;
            this._value = value;
        }

        public function get stepType():String
        {
            return ("spellCooldownVariation");
        }

        override public function start():void
        {
            var spellCastManager:SpellCastInFightManager;
            var playerManager:PlayedCharacterManager;
            var spellLvl:uint;
            var spellKnown:SpellWrapper;
            var spellManager:SpellManager;
            if (this._fighterId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
                spellCastManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(this._fighterId);
                playerManager = PlayedCharacterManager.getInstance();
                for each (spellKnown in playerManager.spellsInventory)
                {
                    if (spellKnown.id == this._spellId)
                    {
                        spellLvl = spellKnown.spellLevel;
                    };
                };
                if (((spellCastManager) && ((spellLvl > 0))))
                {
                    if (!(spellCastManager.getSpellManagerBySpellId(this._spellId)))
                    {
                        spellCastManager.castSpell(this._spellId, spellLvl, [], false);
                    };
                    spellManager = spellCastManager.getSpellManagerBySpellId(this._spellId);
                    spellManager.forceCooldown(this._value);
                };
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

