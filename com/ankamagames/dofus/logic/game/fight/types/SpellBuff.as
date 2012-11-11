package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SpellBuff extends BasicBuff
    {
        public var spellId:int;
        public var delta:int;
        public var modifType:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellBuff));

        public function SpellBuff(param1:FightTemporarySpellBoostEffect = null, param2:CastingSpell = null, param3:int = 0)
        {
            if (param1)
            {
                super(param1, param2, param3, param1.boostedSpellId, null, param1.delta);
                this.spellId = param1.boostedSpellId;
                this.delta = param1.delta;
            }
            return;
        }// end function

        override public function get type() : String
        {
            return "SpellBuff";
        }// end function

        override public function onApplyed() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
                if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_RANGEABLE)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.RANGEABLE;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_DMG)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.DAMAGE;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_BASE_DMG)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.BASE_DAMAGE;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_HEAL)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.HEAL_BONUS;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_AP_COST)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.AP_COST;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.CAST_INTERVAL;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL_SET)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_CC)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_CASTOUTLINE)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.CAST_LINE;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_NOLINEOFSIGHT)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.LOS;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTURN)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTARGET)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET;
                }
                else if (actionId == ActionIdConverter.ACTION_BOOST_SPELL_RANGE)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.RANGE;
                }
                else if (actionId == ActionIdConverter.ACTION_DEBOOST_SPELL_RANGE)
                {
                    this.modifType = CharacterSpellModificationTypeEnum.RANGE;
                    this.delta = -this.delta;
                }
                _loc_1 = false;
                for each (_loc_2 in PlayedCharacterManager.getInstance().characteristics.spellModifications)
                {
                    
                    if (this.spellId == _loc_2.spellId)
                    {
                        if (_loc_2.modificationType == this.modifType)
                        {
                            _loc_1 = true;
                            _loc_2.value.contextModif = _loc_2.value.contextModif + this.delta;
                        }
                    }
                }
                if (!_loc_1)
                {
                    _loc_5 = new CharacterBaseCharacteristic();
                    _loc_5.base = 0;
                    _loc_5.alignGiftBonus = 0;
                    _loc_5.contextModif = this.delta;
                    _loc_5.objectsAndMountBonus = 0;
                    _loc_6 = new CharacterSpellModification();
                    _loc_6.modificationType = this.modifType;
                    _loc_6.spellId = this.spellId;
                    _loc_6.value = _loc_5;
                    PlayedCharacterManager.getInstance().characteristics.spellModifications.push(_loc_6);
                }
                _loc_3 = SpellWrapper.getSpellWrappersById(this.spellId, targetId);
                for each (_loc_4 in _loc_3)
                {
                    
                    _loc_4 = SpellWrapper.create(_loc_4.position, _loc_4.spellId, _loc_4.spellLevel, true, targetId);
                    var _loc_9:* = _loc_4;
                    var _loc_10:* = _loc_4.versionNum + 1;
                    _loc_9.versionNum = _loc_10;
                }
            }
            super.onApplyed();
            return;
        }// end function

        override public function onRemoved() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!_removed)
            {
                if (targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                {
                    for each (_loc_1 in PlayedCharacterManager.getInstance().characteristics.spellModifications)
                    {
                        
                        if (this.spellId == _loc_1.spellId)
                        {
                            if (_loc_1.modificationType == this.modifType)
                            {
                                _loc_1.value.contextModif = _loc_1.value.contextModif - this.delta;
                            }
                        }
                    }
                    _loc_2 = SpellWrapper.getSpellWrappersById(this.spellId, targetId);
                    for each (_loc_3 in _loc_2)
                    {
                        
                        _loc_3 = SpellWrapper.create(_loc_3.position, _loc_3.spellId, _loc_3.spellLevel, true, targetId);
                        var _loc_6:* = _loc_3;
                        var _loc_7:* = _loc_3.versionNum + 1;
                        _loc_6.versionNum = _loc_7;
                    }
                }
            }
            super.onRemoved();
            return;
        }// end function

        override public function clone(param1:int = 0) : BasicBuff
        {
            var _loc_2:* = new SpellBuff();
            _loc_2.spellId = this.spellId;
            _loc_2.delta = this.delta;
            _loc_2.id = uid;
            _loc_2.uid = uid;
            _loc_2.actionId = actionId;
            _loc_2.targetId = targetId;
            _loc_2.castingSpell = castingSpell;
            _loc_2.duration = duration;
            _loc_2.dispelable = dispelable;
            _loc_2.source = source;
            _loc_2.aliveSource = aliveSource;
            _loc_2.parentBoostUid = parentBoostUid;
            _loc_2.initParam(param1, param2, param3);
            return _loc_2;
        }// end function

    }
}
