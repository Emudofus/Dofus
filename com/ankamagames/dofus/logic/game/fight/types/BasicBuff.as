package com.ankamagames.dofus.logic.game.fight.types
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class BasicBuff extends Object
    {
        protected var _effect:EffectInstance;
        protected var _disabled:Boolean = false;
        protected var _removed:Boolean = false;
        public var uid:uint;
        public var duration:int;
        public var castingSpell:CastingSpell;
        public var targetId:int;
        public var critical:Boolean = false;
        public var dispelable:int;
        public var actionId:uint;
        public var id:uint;
        public var source:int;
        public var aliveSource:int;
        public var stack:Vector.<BasicBuff>;
        public var parentBoostUid:uint;
        public var finishing:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(BasicBuff));

        public function BasicBuff(param1:AbstractFightDispellableEffect = null, param2:CastingSpell = null, param3:uint = 0, param4 = null, param5 = null, param6 = null)
        {
            var _loc_7:* = null;
            if (param1)
            {
                this.id = param1.uid;
                this.uid = param1.uid;
                this.actionId = param3;
                this.targetId = param1.targetId;
                this.castingSpell = param2;
                this.duration = param1.turnDuration;
                this.dispelable = param1.dispelable;
                this.source = param2.casterId;
                _loc_7 = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
                if (Kernel.beingInReconection || PlayedCharacterManager.getInstance().isSpectator)
                {
                    this.aliveSource = this.source;
                }
                else
                {
                    this.aliveSource = _loc_7.currentPlayerId;
                }
                this.parentBoostUid = this.parentBoostUid;
                this.initParam(param4, param5, param6);
            }
            return;
        }// end function

        public function get effects() : EffectInstance
        {
            return this._effect;
        }// end function

        public function get type() : String
        {
            return "BasicBuff";
        }// end function

        public function get param1()
        {
            if (this._effect is EffectInstanceDice)
            {
                return EffectInstanceDice(this._effect).diceNum;
            }
            return null;
        }// end function

        public function get param2()
        {
            if (this._effect is EffectInstanceDice)
            {
                return EffectInstanceDice(this._effect).diceSide;
            }
            return null;
        }// end function

        public function get param3()
        {
            if (this._effect is EffectInstanceInteger)
            {
                return EffectInstanceInteger(this._effect).value;
            }
            return null;
        }// end function

        public function set param1(param1) : void
        {
            this._effect.setParameter(0, param1 == 0 ? (null) : (param1));
            return;
        }// end function

        public function set param2(param1) : void
        {
            this._effect.setParameter(1, param1 == 0 ? (null) : (param1));
            return;
        }// end function

        public function set param3(param1) : void
        {
            this._effect.setParameter(2, param1 == 0 ? (null) : (param1));
            return;
        }// end function

        public function get unusableNextTurn() : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (this.duration > 1 || this.duration < 0)
            {
                return false;
            }
            var _loc_1:* = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            if (_loc_1)
            {
                _loc_2 = _loc_1.currentPlayerId;
                _loc_3 = PlayedCharacterManager.getInstance().id;
                if (_loc_2 == _loc_3 || _loc_2 == this.source)
                {
                    return false;
                }
                _loc_4 = -1;
                _loc_5 = -1;
                _loc_6 = -1;
                _loc_7 = 0;
                while (_loc_7 < _loc_1.fightersList.length)
                {
                    
                    _loc_8 = _loc_1.fightersList[_loc_7];
                    if (_loc_8 == _loc_3)
                    {
                        _loc_4 = _loc_7;
                    }
                    else if (_loc_8 == _loc_2)
                    {
                        _loc_5 = _loc_7;
                    }
                    else if (_loc_8 == this.source)
                    {
                        _loc_6 = _loc_7;
                    }
                    _loc_7++;
                }
                if (_loc_6 < _loc_5)
                {
                    _loc_6 = _loc_6 + _loc_1.fightersList.length;
                }
                if (_loc_4 < _loc_5)
                {
                    _loc_4 = _loc_4 + _loc_1.fightersList.length;
                }
                if (_loc_4 > _loc_5 && _loc_4 < _loc_6)
                {
                    return false;
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function get trigger() : Boolean
        {
            return false;
        }// end function

        public function initParam(param1:int, param2:int, param3:int) : void
        {
            if (param1 && param1 != 0 || param2 && param2 != 0)
            {
                this._effect = new EffectInstanceDice();
                this._effect.effectId = this.actionId;
                this._effect.duration = this.duration;
                (this._effect as EffectInstanceDice).diceNum = param1;
                (this._effect as EffectInstanceDice).diceSide = param2;
                (this._effect as EffectInstanceDice).value = param3;
            }
            else
            {
                this._effect = new EffectInstanceInteger();
                this._effect.effectId = this.actionId;
                this._effect.duration = this.duration;
                (this._effect as EffectInstanceInteger).value = param3;
                this._effect.trigger = this.trigger;
            }
            return;
        }// end function

        public function canBeDispell(param1:Boolean = false, param2:int = -2.14748e+009, param3:Boolean = false) : Boolean
        {
            if (param2 == this.id)
            {
                return true;
            }
            switch(this.dispelable)
            {
                case FightDispellableEnum.DISPELLABLE:
                {
                    return true;
                }
                case FightDispellableEnum.DISPELLABLE_BY_STRONG_DISPEL:
                {
                    return param1;
                }
                case FightDispellableEnum.DISPELLABLE_BY_DEATH:
                {
                    return param3 || param1;
                }
                case FightDispellableEnum.REALLY_NOT_DISPELLABLE:
                {
                    return param2 == this.id;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function dispellableByDeath() : Boolean
        {
            return this.dispelable == FightDispellableEnum.DISPELLABLE_BY_DEATH || this.dispelable == FightDispellableEnum.DISPELLABLE;
        }// end function

        public function onDisabled() : void
        {
            this._disabled = true;
            return;
        }// end function

        public function undisable() : void
        {
            this._disabled = false;
            return;
        }// end function

        public function onRemoved() : void
        {
            this._removed = true;
            if (!this._disabled)
            {
                this.onDisabled();
            }
            return;
        }// end function

        public function onApplyed() : void
        {
            this._disabled = false;
            this._removed = false;
            return;
        }// end function

        public function equals(param1:BasicBuff, param2:Boolean = false) : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this.targetId != param1.targetId || this.effects.effectId != param1.actionId || this.duration != param1.duration || this.effects.hasOwnProperty("delay") && param1.effects.hasOwnProperty("delay") && this.effects.delay != param1.effects.delay || this.castingSpell.spellRank && !param2 && this.castingSpell.spellRank.id != param1.castingSpell.spellRank.id || !param2 && this.castingSpell.spell.id != param1.castingSpell.spell.id || getQualifiedClassName(this) != getQualifiedClassName(param1) || this.source != param1.source || this.trigger)
            {
                return false;
            }
            var _loc_3:* = [ActionIdConverter.ACTION_BOOST_SPELL_RANGE, ActionIdConverter.ACTION_BOOST_SPELL_RANGEABLE, ActionIdConverter.ACTION_BOOST_SPELL_DMG, ActionIdConverter.ACTION_BOOST_SPELL_HEAL, ActionIdConverter.ACTION_BOOST_SPELL_AP_COST, ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL, ActionIdConverter.ACTION_BOOST_SPELL_CC, ActionIdConverter.ACTION_BOOST_SPELL_CASTOUTLINE, ActionIdConverter.ACTION_BOOST_SPELL_NOLINEOFSIGHT, ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTURN, ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTARGET, ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL_SET, ActionIdConverter.ACTION_BOOST_SPELL_BASE_DMG, ActionIdConverter.ACTION_DEBOOST_SPELL_RANGE, 406, 787, 792, 793, 1017, 1018, 1019, 1035, 1036, 1044, 1045];
            var _loc_4:* = this.actionId;
            if (this.actionId == 788)
            {
                if (this.param1 != param1.param1)
                {
                    return false;
                }
            }
            else if (_loc_3.indexOf(_loc_4) != -1)
            {
                if (this.param1 != param1.param1)
                {
                    return false;
                }
            }
            else
            {
                if (_loc_4 == 165)
                {
                    return false;
                }
                if (_loc_4 == param1.actionId && (_loc_4 == 951 || _loc_4 == 950))
                {
                    _loc_5 = this as StateBuff;
                    _loc_6 = param1 as StateBuff;
                    if (_loc_5 && _loc_6)
                    {
                        if (_loc_5.stateId != _loc_6.stateId)
                        {
                            return false;
                        }
                    }
                }
            }
            return true;
        }// end function

        public function add(param1:BasicBuff) : void
        {
            if (!this.stack)
            {
                this.stack = new Vector.<BasicBuff>;
                this.stack.push(this.clone(this.id));
            }
            this.stack.push(param1);
            switch(this.actionId)
            {
                case 293:
                {
                    this.param1 = param1.param1;
                    this.param2 = this.param2 + param1.param2;
                    this.param3 = this.param3 + param1.param3;
                    break;
                }
                case 788:
                {
                    this.param1 = this.param1 + param1.param2;
                    break;
                }
                case 950:
                case 951:
                {
                    break;
                }
                default:
                {
                    this.param1 = this.param1 + param1.param1;
                    this.param2 = this.param2 + param1.param2;
                    this.param3 = this.param3 + param1.param3;
                    break;
                    break;
                }
            }
            this.refreshDescription();
            return;
        }// end function

        public function updateParam(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = -1) : void
        {
            var _loc_8:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (param4 == -1)
            {
                _loc_5 = param1;
                _loc_6 = param2;
                _loc_7 = param3;
            }
            else if (this.stack && this.stack.length < 1)
            {
                for each (_loc_8 in this.stack)
                {
                    
                    if (_loc_8.id == param4)
                    {
                        switch(_loc_8.actionId)
                        {
                            case 788:
                            case 950:
                            case 951:
                            {
                                break;
                            }
                            default:
                            {
                                _loc_8.param1 = param1;
                                _loc_8.param2 = param2;
                                _loc_8.param3 = param3;
                                break;
                                break;
                            }
                        }
                    }
                    _loc_5 = _loc_5 + _loc_8.param1;
                    _loc_6 = _loc_6 + _loc_8.param2;
                    _loc_7 = _loc_7 + _loc_8.param3;
                }
            }
            else
            {
                _loc_5 = param1;
                _loc_6 = param2;
                _loc_7 = param3;
            }
            switch(this.actionId)
            {
                case 788:
                {
                    this.param1 = _loc_6;
                    break;
                }
                case 950:
                case 951:
                {
                    break;
                }
                default:
                {
                    this.param1 = _loc_5;
                    this.param2 = _loc_6;
                    this.param3 = _loc_7;
                    break;
                    break;
                }
            }
            this.refreshDescription();
            return;
        }// end function

        public function refreshDescription() : void
        {
            this._effect.forceDescriptionRefresh();
            return;
        }// end function

        public function incrementDuration(param1:int, param2:Boolean = false) : Boolean
        {
            if (!param2 || this.canBeDispell())
            {
                if (this.duration >= 63)
                {
                    return false;
                }
                if (this.duration + param1 > 0)
                {
                    this.duration = this.duration + param1;
                    this.effects.duration = this.effects.duration + param1;
                    return true;
                }
                if (this.duration > 0)
                {
                    this.duration = 0;
                    this.effects.duration = 0;
                    return true;
                }
                return false;
            }
            else
            {
                return false;
            }
        }// end function

        public function get active() : Boolean
        {
            return this.duration != 0;
        }// end function

        public function clone(param1:int = 0) : BasicBuff
        {
            var _loc_2:* = new BasicBuff();
            _loc_2.id = this.uid;
            _loc_2.uid = this.uid;
            _loc_2.actionId = this.actionId;
            _loc_2.targetId = this.targetId;
            _loc_2.castingSpell = this.castingSpell;
            _loc_2.duration = this.duration;
            _loc_2.dispelable = this.dispelable;
            _loc_2.source = this.source;
            _loc_2.aliveSource = this.aliveSource;
            _loc_2.parentBoostUid = this.parentBoostUid;
            _loc_2.initParam(this.param1, this.param2, this.param3);
            return _loc_2;
        }// end function

    }
}
