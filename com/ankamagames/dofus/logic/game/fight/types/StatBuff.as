package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class StatBuff extends BasicBuff
    {
        private var _statName:String;
        private var _isABoost:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(StatBuff));

        public function StatBuff(param1:FightTemporaryBoostEffect = null, param2:CastingSpell = null, param3:int = 0)
        {
            if (param1)
            {
                super(param1, param2, param3, param1.delta, null, null);
                this._statName = ActionIdConverter.getActionStatName(param3);
                this._isABoost = ActionIdConverter.getIsABoost(param3);
            }
            return;
        }// end function

        override public function get type() : String
        {
            return "StatBuff";
        }// end function

        public function get statName() : String
        {
            return this._statName;
        }// end function

        public function get delta() : int
        {
            if (_effect is EffectInstanceDice)
            {
                return this._isABoost ? (EffectInstanceDice(_effect).diceNum) : (-EffectInstanceDice(_effect).diceNum);
            }
            return 0;
        }// end function

        override public function onApplyed() : void
        {
            var _loc_1:int = 0;
            var _loc_3:int = 0;
            if (PlayedCharacterManager.getInstance().id == targetId)
            {
                if (PlayedCharacterManager.getInstance().characteristics.hasOwnProperty(this._statName))
                {
                    CharacterBaseCharacteristic(PlayedCharacterManager.getInstance().characteristics[this._statName]).contextModif = CharacterBaseCharacteristic(PlayedCharacterManager.getInstance().characteristics[this._statName]).contextModif + this.delta;
                }
                switch(this.statName)
                {
                    case "vitality":
                    {
                        _loc_1 = PlayedCharacterManager.getInstance().characteristics.maxLifePoints;
                        if (_loc_1 + this.delta < 0)
                        {
                            PlayedCharacterManager.getInstance().characteristics.maxLifePoints = 0;
                        }
                        else
                        {
                            PlayedCharacterManager.getInstance().characteristics.maxLifePoints = PlayedCharacterManager.getInstance().characteristics.maxLifePoints + this.delta;
                        }
                        _loc_1 = PlayedCharacterManager.getInstance().characteristics.lifePoints;
                        if (_loc_1 + this.delta < 0)
                        {
                            PlayedCharacterManager.getInstance().characteristics.lifePoints = 0;
                        }
                        else
                        {
                            PlayedCharacterManager.getInstance().characteristics.lifePoints = PlayedCharacterManager.getInstance().characteristics.lifePoints + this.delta;
                        }
                        break;
                    }
                    case "lifePoints":
                    case "lifePointsMalus":
                    {
                        _loc_1 = PlayedCharacterManager.getInstance().characteristics.lifePoints;
                        if (_loc_1 + this.delta < 0)
                        {
                            PlayedCharacterManager.getInstance().characteristics.lifePoints = 0;
                        }
                        else
                        {
                            PlayedCharacterManager.getInstance().characteristics.lifePoints = PlayedCharacterManager.getInstance().characteristics.lifePoints + this.delta;
                        }
                        break;
                    }
                    case "movementPoints":
                    {
                        PlayedCharacterManager.getInstance().characteristics.movementPointsCurrent = PlayedCharacterManager.getInstance().characteristics.movementPointsCurrent + this.delta;
                        break;
                    }
                    case "actionPoints":
                    {
                        _log.debug("onApply ActionPoint : " + PlayedCharacterManager.getInstance().characteristics.actionPointsCurrent + " + " + this.delta);
                        PlayedCharacterManager.getInstance().characteristics.actionPointsCurrent = PlayedCharacterManager.getInstance().characteristics.actionPointsCurrent + this.delta;
                        break;
                    }
                    case "summonableCreaturesBoost":
                    {
                        SpellWrapper.refreshAllPlayerSpellHolder(targetId);
                        break;
                    }
                    case "range":
                    {
                        FightSpellCastFrame.updateRangeAndTarget();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            var _loc_2:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(targetId) as GameFightFighterInformations;
            switch(this.statName)
            {
                case "vitality":
                {
                    _loc_2.stats["lifePoints"] = _loc_2.stats["lifePoints"] + this.delta;
                    _loc_2.stats["maxLifePoints"] = _loc_2.stats["maxLifePoints"] + this.delta;
                    break;
                }
                case "lifePointsMalus":
                {
                    _loc_2.stats["lifePoints"] = _loc_2.stats["lifePoints"] + this.delta;
                    break;
                }
                case "lifePoints":
                case "shieldPoints":
                case "dodgePALostProbability":
                case "dodgePMLostProbability":
                {
                    _loc_1 = _loc_2.stats[this._statName];
                    if (_loc_1 + this.delta < 0)
                    {
                        _loc_2.stats[this._statName] = 0;
                    }
                    else
                    {
                        _loc_2.stats[this._statName] = _loc_2.stats[this._statName] + this.delta;
                    }
                    break;
                }
                case "agility":
                {
                    _loc_2.stats["tackleEvade"] = _loc_2.stats["tackleEvade"] + this.delta / 10;
                    _loc_2.stats["tackleBlock"] = _loc_2.stats["tackleBlock"] + this.delta / 10;
                    break;
                }
                case "globalResistPercentBonus":
                case "globalResistPercentMalus":
                {
                    _loc_3 = this.statName == "globalResistPercentMalus" ? (-1) : (1);
                    _loc_2.stats["neutralElementResistPercent"] = _loc_2.stats["neutralElementResistPercent"] + this.delta * _loc_3;
                    _loc_2.stats["airElementResistPercent"] = _loc_2.stats["airElementResistPercent"] + this.delta * _loc_3;
                    _loc_2.stats["waterElementResistPercent"] = _loc_2.stats["waterElementResistPercent"] + this.delta * _loc_3;
                    _loc_2.stats["earthElementResistPercent"] = _loc_2.stats["earthElementResistPercent"] + this.delta * _loc_3;
                    _loc_2.stats["fireElementResistPercent"] = _loc_2.stats["fireElementResistPercent"] + this.delta * _loc_3;
                    break;
                }
                case "actionPoints":
                {
                    _loc_2.stats["actionPoints"] = _loc_2.stats["actionPoints"] + this.delta;
                    _loc_2.stats["maxActionPoints"] = _loc_2.stats["maxActionPoints"] + this.delta;
                    break;
                }
                case "movementPoints":
                {
                    _loc_2.stats["movementPoints"] = _loc_2.stats["movementPoints"] + this.delta;
                    _loc_2.stats["maxMovementPoints"] = _loc_2.stats["maxMovementPoints"] + this.delta;
                    break;
                }
                default:
                {
                    if (_loc_2)
                    {
                        if (_loc_2.stats.hasOwnProperty(this._statName))
                        {
                            _loc_2.stats[this._statName] = _loc_2.stats[this._statName] + this.delta;
                        }
                    }
                    else
                    {
                        _log.fatal("ATTENTION, le serveur essaye de buffer une entité qui n\'existe plus ! id=" + targetId);
                    }
                    break;
                    break;
                }
            }
            super.onApplyed();
            return;
        }// end function

        override public function onRemoved() : void
        {
            var _loc_1:Effect = null;
            if (!_removed)
            {
                _loc_1 = Effect.getEffectById(actionId);
                if (!_loc_1.active)
                {
                    this.decrementStats();
                }
            }
            super.onRemoved();
            return;
        }// end function

        override public function onDisabled() : void
        {
            var _loc_1:Effect = null;
            if (!_disabled)
            {
                _loc_1 = Effect.getEffectById(actionId);
                if (_loc_1.active)
                {
                    this.decrementStats();
                }
            }
            super.onDisabled();
            return;
        }// end function

        private function decrementStats() : void
        {
            var _loc_1:int = 0;
            var _loc_3:int = 0;
            if (PlayedCharacterManager.getInstance().id == targetId)
            {
                if (PlayedCharacterManager.getInstance().characteristics.hasOwnProperty(this._statName))
                {
                    CharacterBaseCharacteristic(PlayedCharacterManager.getInstance().characteristics[this._statName]).contextModif = CharacterBaseCharacteristic(PlayedCharacterManager.getInstance().characteristics[this._statName]).contextModif - this.delta;
                }
                switch(this._statName)
                {
                    case "movementPoints":
                    {
                        PlayedCharacterManager.getInstance().characteristics.movementPointsCurrent = PlayedCharacterManager.getInstance().characteristics.movementPointsCurrent - this.delta;
                        break;
                    }
                    case "actionPoints":
                    {
                        _log.debug("onRemoved ActionPoint : " + PlayedCharacterManager.getInstance().characteristics.actionPointsCurrent + " - " + this.delta);
                        PlayedCharacterManager.getInstance().characteristics.actionPointsCurrent = PlayedCharacterManager.getInstance().characteristics.actionPointsCurrent - this.delta;
                        break;
                    }
                    case "vitality":
                    {
                        PlayedCharacterManager.getInstance().characteristics.maxLifePoints = PlayedCharacterManager.getInstance().characteristics.maxLifePoints - this.delta;
                        if (PlayedCharacterManager.getInstance().characteristics.lifePoints > this.delta)
                        {
                            PlayedCharacterManager.getInstance().characteristics.lifePoints = PlayedCharacterManager.getInstance().characteristics.lifePoints - this.delta;
                        }
                        else
                        {
                            PlayedCharacterManager.getInstance().characteristics.lifePoints = 0;
                        }
                        break;
                    }
                    case "lifePoints":
                    case "lifePointsMalus":
                    {
                        if (PlayedCharacterManager.getInstance().characteristics.lifePoints > this.delta)
                        {
                            PlayedCharacterManager.getInstance().characteristics.lifePoints = PlayedCharacterManager.getInstance().characteristics.lifePoints - this.delta;
                        }
                        else
                        {
                            PlayedCharacterManager.getInstance().characteristics.lifePoints = 0;
                        }
                        break;
                    }
                    case "summonableCreaturesBoost":
                    {
                        break;
                    }
                    case "range:":
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            var _loc_2:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(targetId) as GameFightFighterInformations;
            switch(this.statName)
            {
                case "vitality":
                {
                    _loc_2.stats["lifePoints"] = _loc_2.stats["lifePoints"] - this.delta;
                    _loc_2.stats["maxLifePoints"] = _loc_2.stats["maxLifePoints"] - this.delta;
                    break;
                }
                case "lifePointsMalus":
                {
                    _loc_2.stats["lifePoints"] = _loc_2.stats["lifePoints"] - this.delta;
                    if (_loc_2.stats["lifePoints"] > _loc_2.stats["maxLifePoints"])
                    {
                        _loc_2.stats["lifePoints"] = _loc_2.stats["maxLifePoints"];
                    }
                    break;
                }
                case "lifePoints":
                case "shieldPoints":
                case "dodgePALostProbability":
                case "dodgePMLostProbability":
                {
                    _loc_1 = _loc_2.stats[this._statName];
                    if (_loc_1 - this.delta < 0)
                    {
                        _loc_2.stats[this._statName] = 0;
                    }
                    else
                    {
                        _loc_2.stats[this._statName] = _loc_2.stats[this._statName] - this.delta;
                    }
                    break;
                }
                case "globalResistPercentBonus":
                case "globalResistPercentMalus":
                {
                    _loc_3 = this.statName == "globalResistPercentMalus" ? (-1) : (1);
                    _loc_2.stats["neutralElementResistPercent"] = _loc_2.stats["neutralElementResistPercent"] - this.delta * _loc_3;
                    _loc_2.stats["airElementResistPercent"] = _loc_2.stats["airElementResistPercent"] - this.delta * _loc_3;
                    _loc_2.stats["waterElementResistPercent"] = _loc_2.stats["waterElementResistPercent"] - this.delta * _loc_3;
                    _loc_2.stats["earthElementResistPercent"] = _loc_2.stats["earthElementResistPercent"] - this.delta * _loc_3;
                    _loc_2.stats["fireElementResistPercent"] = _loc_2.stats["fireElementResistPercent"] - this.delta * _loc_3;
                    break;
                }
                case "agility":
                {
                    _loc_2.stats["tackleEvade"] = _loc_2.stats["tackleEvade"] - this.delta / 10;
                    _loc_2.stats["tackleBlock"] = _loc_2.stats["tackleBlock"] - this.delta / 10;
                    break;
                }
                case "actionPoints":
                {
                    _loc_2.stats["actionPoints"] = _loc_2.stats["actionPoints"] - this.delta;
                    _loc_2.stats["maxActionPoints"] = _loc_2.stats["maxActionPoints"] - this.delta;
                    break;
                }
                case "movementPoints":
                {
                    _loc_2.stats["movementPoints"] = _loc_2.stats["movementPoints"] - this.delta;
                    _loc_2.stats["maxMovementPoints"] = _loc_2.stats["maxMovementPoints"] - this.delta;
                    break;
                }
                default:
                {
                    if (_loc_2)
                    {
                        if (_loc_2.stats.hasOwnProperty(this._statName))
                        {
                            _loc_2.stats[this._statName] = _loc_2.stats[this._statName] - this.delta;
                        }
                        else
                        {
                            _log.fatal("On essaye de supprimer une stat non prise en compte : " + this.statName);
                        }
                    }
                    else
                    {
                        _log.fatal("ATTENTION, Le serveur essaye de buffer une entité qui n\'existe plus ! id=" + targetId);
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        override public function clone(param1:int = 0) : BasicBuff
        {
            var _loc_2:* = new StatBuff();
            _loc_2._statName = this._statName;
            _loc_2._isABoost = this._isABoost;
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
