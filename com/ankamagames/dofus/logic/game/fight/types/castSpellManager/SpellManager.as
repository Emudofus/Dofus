package com.ankamagames.dofus.logic.game.fight.types.castSpellManager
{
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SpellManager extends Object
    {
        private var _spellId:uint;
        private var _spellLevel:uint;
        private var _lastCastTurn:int;
        private var _lastInitialCooldownReset:int;
        private var _castThisTurn:uint;
        private var _targetsThisTurn:Dictionary;
        private var _spellCastManager:SpellCastInFightManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellManager));

        public function SpellManager(param1:SpellCastInFightManager, param2:uint, param3:uint)
        {
            this._spellCastManager = param1;
            this._spellId = param2;
            this._spellLevel = param3;
            this._targetsThisTurn = new Dictionary();
            return;
        }// end function

        public function get lastCastTurn() : int
        {
            return this._lastCastTurn;
        }// end function

        public function get numberCastThisTurn() : uint
        {
            return this._castThisTurn;
        }// end function

        public function set spellLevel(param1:uint) : void
        {
            this._spellLevel = param1;
            return;
        }// end function

        public function get spellLevel() : uint
        {
            return this._spellLevel;
        }// end function

        public function get spell() : Spell
        {
            return Spell.getSpellById(this._spellId);
        }// end function

        public function get spellLevelObject() : SpellLevel
        {
            return Spell.getSpellById(this._spellId).getSpellLevel(this._spellLevel);
        }// end function

        public function cast(param1:int, param2:Array, param3:Boolean = true) : void
        {
            var _loc_4:* = 0;
            this._lastCastTurn = param1;
            for each (_loc_4 in param2)
            {
                
                if (this._targetsThisTurn[_loc_4] == null)
                {
                    this._targetsThisTurn[_loc_4] = 0;
                }
                (this._targetsThisTurn[_loc_4] + 1);
            }
            if (param3)
            {
                var _loc_5:* = this;
                var _loc_6:* = this._castThisTurn + 1;
                _loc_5._castThisTurn = _loc_6;
            }
            this.updateSpellWrapper();
            return;
        }// end function

        public function resetInitialCooldown(param1:int) : void
        {
            this._lastInitialCooldownReset = param1;
            this.updateSpellWrapper();
            return;
        }// end function

        public function getCastOnEntity(param1:int) : uint
        {
            if (this._targetsThisTurn[param1] == null)
            {
                return 0;
            }
            return this._targetsThisTurn[param1];
        }// end function

        public function newTurn() : void
        {
            this._castThisTurn = 0;
            this._targetsThisTurn = new Dictionary();
            this.updateSpellWrapper();
            return;
        }// end function

        public function get cooldown() : int
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_8:* = 0;
            var _loc_1:* = Spell.getSpellById(this._spellId);
            var _loc_2:* = SpellLevel.getLevelById(_loc_1.spellLevels[(this._spellLevel - 1)]);
            var _loc_3:* = new SpellModificator();
            var _loc_4:* = PlayedCharacterManager.getInstance().characteristics;
            for each (_loc_5 in _loc_4.spellModifications)
            {
                
                if (_loc_5.spellId == this._spellId)
                {
                    switch(_loc_5.modificationType)
                    {
                        case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                        {
                            _loc_3.castInterval = _loc_5.value;
                            break;
                        }
                        case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                        {
                            _loc_3.castIntervalSet = _loc_5.value;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            if (_loc_3.getTotalBonus(_loc_3.castIntervalSet))
            {
                _loc_6 = -_loc_3.getTotalBonus(_loc_3.castInterval) + _loc_3.getTotalBonus(_loc_3.castIntervalSet);
            }
            else
            {
                _loc_6 = _loc_2.minCastInterval - _loc_3.getTotalBonus(_loc_3.castInterval);
            }
            if (_loc_6 == 63)
            {
                return 63;
            }
            var _loc_7:* = this._lastInitialCooldownReset + _loc_2.initialCooldown - this._spellCastManager.currentTurn;
            if (this._lastCastTurn >= this._lastInitialCooldownReset + _loc_2.initialCooldown)
            {
                _loc_8 = _loc_6 + this._lastCastTurn - this._spellCastManager.currentTurn;
            }
            else
            {
                _loc_8 = _loc_7;
            }
            if (_loc_8 <= 0)
            {
                _loc_8 = 0;
            }
            return _loc_8;
        }// end function

        public function forceCooldown(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = Spell.getSpellById(this._spellId);
            var _loc_3:* = SpellLevel.getLevelById(_loc_2.spellLevels[(this._spellLevel - 1)]);
            this._lastCastTurn = param1 + this._spellCastManager.currentTurn - _loc_3.minCastInterval;
            var _loc_4:* = SpellWrapper.getSpellWrappersById(this._spellId, this._spellCastManager.entityId);
            for each (_loc_5 in _loc_4)
            {
                
                _loc_5.actualCooldown = param1;
            }
            return;
        }// end function

        public function forceLastCastTurn(param1:int, param2:Boolean = false) : void
        {
            this._lastCastTurn = param1;
            this.updateSpellWrapper(param2);
            return;
        }// end function

        private function updateSpellWrapper(param1:Boolean = false) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = SpellWrapper.getSpellWrappersById(this._spellId, this._spellCastManager.entityId);
            var _loc_3:* = Spell.getSpellById(this._spellId);
            var _loc_4:* = SpellLevel.getLevelById(_loc_3.spellLevels[(this._spellLevel - 1)]);
            for each (_loc_5 in _loc_2)
            {
                
                if (_loc_5.actualCooldown != 63)
                {
                    _loc_5.actualCooldown = this.cooldown;
                }
            }
            return;
        }// end function

    }
}
