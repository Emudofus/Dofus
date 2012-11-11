package com.ankamagames.dofus.internalDatacenter.spells
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.spellZone.*;
    import flash.utils.*;

    dynamic public class SpellWrapper extends Proxy implements ISlotData, IClonable, ICellZoneProvider, IDataCenter
    {
        private var _uri:Uri;
        private var _slotDataHolderManager:SlotDataHolderManager;
        private var _spellLevel:SpellLevel;
        public var position:uint;
        public var id:uint = 0;
        public var spellLevel:int;
        public var effects:Vector.<EffectInstance>;
        public var criticalEffect:Vector.<EffectInstance>;
        public var gfxId:int;
        public var playerId:int;
        public var versionNum:int;
        private var _actualCooldown:uint = 0;
        private static var _cache:Array = new Array();
        private static var _playersCache:Dictionary = new Dictionary();
        private static var _cac:Array = new Array();
        private static var _errorIconUri:Uri;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellWrapper));

        public function SpellWrapper()
        {
            return;
        }// end function

        public function set actualCooldown(param1:uint) : void
        {
            this._actualCooldown = param1;
            this._slotDataHolderManager.refreshAll();
            return;
        }// end function

        public function get actualCooldown() : uint
        {
            return PlayedCharacterManager.getInstance().isFighting ? (this._actualCooldown) : (0);
        }// end function

        public function get spellLevelInfos() : SpellLevel
        {
            return this._spellLevel;
        }// end function

        public function get minimalRange() : uint
        {
            return this["minRange"];
        }// end function

        public function get maximalRange() : uint
        {
            return this["range"];
        }// end function

        public function get castZoneInLine() : Boolean
        {
            return this["castInLine"];
        }// end function

        public function get castZoneInDiagonal() : Boolean
        {
            return this["castInDiagonal"];
        }// end function

        public function get spellZoneEffects() : Vector.<IZoneShape>
        {
            var _loc_1:* = null;
            if (this.id != 0 || !PlayedCharacterManager.getInstance().currentWeapon)
            {
                _loc_1 = this.spell.getSpellLevel(this.spellLevel);
                if (_loc_1)
                {
                    return _loc_1.spellZoneEffects;
                }
            }
            return null;
        }// end function

        public function get hideEffects() : Boolean
        {
            if (this.id == 0 && PlayedCharacterManager.getInstance().currentWeapon != null)
            {
                return (PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper).hideEffects;
            }
            var _loc_1:* = this.spell.getSpellLevel(this.spellLevel);
            if (_loc_1)
            {
                return _loc_1.hideEffects;
            }
            return false;
        }// end function

        public function get backGroundIconUri() : Uri
        {
            if (this.id == 0 && PlayedCharacterManager.getInstance().currentWeapon != null)
            {
                return new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/spells/all.swf|noIcon"));
            }
            return null;
        }// end function

        public function get iconUri() : Uri
        {
            return this.fullSizeIconUri;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            if (!this._uri || this.id == 0)
            {
                if (this.id == 0 && PlayedCharacterManager.getInstance().currentWeapon != null)
                {
                    this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|weapon_").concat(PlayedCharacterManager.getInstance().currentWeapon.typeId));
                }
                else
                {
                    this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|sort_").concat(this.spell.iconId));
                }
                this._uri.tag = Slot.NEED_CACHE_AS_BITMAP;
            }
            return this._uri;
        }// end function

        public function get errorIconUri() : Uri
        {
            if (!_errorIconUri)
            {
                _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|noIcon"));
            }
            return _errorIconUri;
        }// end function

        public function get info1() : String
        {
            if (this.actualCooldown == 0 || !PlayedCharacterManager.getInstance().isFighting)
            {
                return null;
            }
            if (this.actualCooldown == 63)
            {
                return "-";
            }
            return this.actualCooldown.toString();
        }// end function

        public function get timer() : int
        {
            return 0;
        }// end function

        public function get active() : Boolean
        {
            if (!PlayedCharacterManager.getInstance().isFighting)
            {
                return true;
            }
            var _loc_1:* = CurrentPlayedFighterManager.getInstance().canCastThisSpell(this.spellId, this.spellLevel);
            return _loc_1;
        }// end function

        public function get spell() : Spell
        {
            return Spell.getSpellById(this.id);
        }// end function

        public function get spellId() : uint
        {
            return this.spell.id;
        }// end function

        public function get playerCriticalRate() : int
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_1:* = this.getCriticalHitProbability();
            if (_loc_1 && PlayedCharacterApi.knowSpell(this.spell.id) >= 0)
            {
                _loc_2 = PlayedCharacterManager.getInstance().characteristics;
                if (_loc_2)
                {
                    _loc_3 = _loc_2.criticalHit;
                    _loc_4 = _loc_2.agility;
                    _loc_5 = _loc_3.alignGiftBonus + _loc_3.base + _loc_3.contextModif + _loc_3.objectsAndMountBonus;
                    _loc_6 = _loc_4.alignGiftBonus + _loc_4.base + _loc_4.contextModif + _loc_4.objectsAndMountBonus;
                    if (_loc_6 < 0)
                    {
                        _loc_6 = 0;
                    }
                    _loc_7 = _loc_1 - _loc_5;
                    _loc_8 = int(_loc_7 * Math.E * 1.1 / Math.log(_loc_6 + 12));
                    _loc_9 = Math.min(_loc_7, _loc_8);
                    if (_loc_9 < 2)
                    {
                        _loc_9 = 2;
                    }
                    return _loc_9;
                }
            }
            return 0;
        }// end function

        public function get playerCriticalFailureRate() : int
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = this.criticalFailureProbability;
            if (_loc_1 && PlayedCharacterApi.knowSpell(this.spell.id) >= 0)
            {
                _loc_2 = PlayedCharacterManager.getInstance().characteristics;
                if (_loc_2)
                {
                    _loc_3 = _loc_2.criticalMiss;
                    _loc_4 = _loc_1 - _loc_3.alignGiftBonus - _loc_3.base - _loc_3.contextModif - _loc_3.objectsAndMountBonus;
                    return _loc_4;
                }
            }
            return 0;
        }// end function

        public function get maximalRangeWithBoosts() : int
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (this._spellLevel.rangeCanBeBoosted)
            {
                _loc_1 = PlayedCharacterManager.getInstance().characteristics;
                _loc_2 = _loc_1.range.base + _loc_1.range.alignGiftBonus + _loc_1.range.contextModif + _loc_1.range.objectsAndMountBonus;
                if (this.maximalRange + _loc_2 < this.minimalRange)
                {
                    return this.minimalRange;
                }
                return this.maximalRange + _loc_2;
            }
            else
            {
            }
            return this.maximalRange;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return isAttribute(param1);
        }// end function

        override function getProperty(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (isAttribute(param1))
            {
                return this[param1];
            }
            if (this.id == 0 && PlayedCharacterManager.getInstance().currentWeapon != null)
            {
                return this.getWeaponProperty(param1);
            }
            _loc_2 = CurrentPlayedFighterManager.getInstance();
            switch(param1.toString())
            {
                case "id":
                case "nameId":
                case "descriptionId":
                case "typeId":
                case "scriptParams":
                case "scriptParamsCritical":
                case "scriptId":
                case "scriptIdCritical":
                case "iconId":
                case "spellLevels":
                case "useParamCache":
                case "name":
                case "description":
                {
                    return Spell.getSpellById(this.id)[param1];
                }
                case "spellBreed":
                case "needFreeCell":
                case "needTakenCell":
                case "criticalFailureEndsTurn":
                case "criticalFailureProbability":
                case "minPlayerLevel":
                case "minRange":
                case "maxStack":
                case "globalCooldown":
                {
                    return this._spellLevel[param1.toString()];
                }
                case "criticalHitProbability":
                {
                    return this.getCriticalHitProbability();
                }
                case "maxCastPerTurn":
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN);
                    if (_loc_3)
                    {
                        return this._spellLevel["maxCastPerTurn"] + _loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus;
                    }
                    return this._spellLevel["maxCastPerTurn"];
                }
                case "range":
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.RANGE);
                    if (_loc_3)
                    {
                        return this._spellLevel["range"] + _loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus;
                    }
                    return this._spellLevel["range"];
                }
                case "maxCastPerTarget":
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET);
                    if (_loc_3)
                    {
                        return this._spellLevel["maxCastPerTarget"] + _loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus;
                    }
                    return this._spellLevel["maxCastPerTarget"];
                }
                case "castInLine":
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.CAST_LINE);
                    if (_loc_3)
                    {
                        return this._spellLevel["castInLine"] && _loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus + _loc_3.value.base + _loc_3.value.alignGiftBonus == 0;
                    }
                    return this._spellLevel["castInLine"];
                }
                case "castInDiagonal":
                {
                    return this._spellLevel["castInDiagonal"];
                }
                case "castTestLos":
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.LOS);
                    if (_loc_3)
                    {
                        return this._spellLevel["castTestLos"] && _loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus + _loc_3.value.base + _loc_3.value.alignGiftBonus == 0;
                    }
                    return this._spellLevel["castTestLos"];
                }
                case "rangeCanBeBoosted":
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.RANGEABLE);
                    if (_loc_3)
                    {
                        return this._spellLevel["rangeCanBeBoosted"] || _loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus + _loc_3.value.base + _loc_3.value.alignGiftBonus > 0;
                    }
                    return this._spellLevel["rangeCanBeBoosted"];
                }
                case "apCost":
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.AP_COST);
                    if (_loc_3)
                    {
                        return this._spellLevel["apCost"] - (_loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus + _loc_3.value.base + _loc_3.value.alignGiftBonus);
                    }
                    return this._spellLevel["apCost"];
                }
                case "minCastInterval":
                {
                    _loc_3 = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.CAST_INTERVAL);
                    if (_loc_3)
                    {
                        return this._spellLevel["minCastInterval"] - (_loc_3.value.contextModif + _loc_3.value.objectsAndMountBonus + _loc_3.value.base + _loc_3.value.alignGiftBonus);
                    }
                    return this._spellLevel["minCastInterval"];
                }
                case "isSpellWeapon":
                {
                    return this.id == 0;
                }
                case "isDefaultSpellWeapon":
                {
                    return this.id == 0 && !PlayedCharacterManager.getInstance().currentWeapon;
                }
                case "statesRequired":
                {
                    return this._spellLevel.statesRequired;
                }
                case "statesForbidden":
                {
                    return this._spellLevel.statesForbidden;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        override function callProperty(param1, ... args)
        {
            return null;
        }// end function

        private function getWeaponProperty(param1)
        {
            var _loc_3:* = 0;
            var _loc_2:* = PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper;
            if (!_loc_2)
            {
                return null;
            }
            switch(param1.toString())
            {
                case "id":
                {
                    return 0;
                }
                case "nameId":
                case "descriptionId":
                case "iconId":
                case "name":
                case "description":
                case "criticalFailureProbability":
                case "criticalHitProbability":
                case "castInLine":
                case "castInDiagonal":
                case "castTestLos":
                case "apCost":
                case "minRange":
                case "range":
                {
                    return _loc_2[param1];
                }
                case "isDefaultSpellWeapon":
                case "useParamCache":
                case "needTakenCell":
                case "rangeCanBeBoosted":
                {
                    return false;
                }
                case "isSpellWeapon":
                case "needFreeCell":
                case "criticalFailureEndsTurn":
                {
                    return true;
                }
                case "minCastInterval":
                case "minPlayerLevel":
                case "maxStack":
                case "maxCastPerTurn":
                case "maxCastPerTarget":
                {
                    return 0;
                }
                case "typeId":
                {
                    return 24;
                }
                case "scriptParams":
                case "scriptParamsCritical":
                case "spellLevels":
                {
                    return null;
                }
                case "scriptId":
                case "scriptIdCritical":
                case "spellBreed":
                {
                    return 0;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getCriticalHitProbability() : Number
        {
            var _loc_2:* = 0;
            var _loc_1:* = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id, CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS);
            if (_loc_1)
            {
                _loc_2 = _loc_1.value.contextModif + _loc_1.value.objectsAndMountBonus + _loc_1.value.alignGiftBonus + _loc_1.value.base;
                return this._spellLevel["criticalHitProbability"] > 0 ? (Math.max(this._spellLevel["criticalHitProbability"] - _loc_2, 2)) : (0);
            }
            else
            {
            }
            return this._spellLevel["criticalHitProbability"];
        }// end function

        public function clone()
        {
            var _loc_2:* = null;
            var _loc_1:* = false;
            if (_cache[this.spellId] != null || _playersCache[this.playerId][this.spellId])
            {
                _loc_1 = true;
            }
            _loc_2 = SpellWrapper.create(this.position, this.id, this.spellLevel, _loc_1, this.playerId);
            return _loc_2;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            this._slotDataHolderManager.addHolder(param1);
            return;
        }// end function

        public function setLinkedSlotData(param1:ISlotData) : void
        {
            this._slotDataHolderManager.setLinkedSlotData(param1);
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            this._slotDataHolderManager.removeHolder(param1);
            return;
        }// end function

        public function toString() : String
        {
            return "[SpellWrapper #" + this.id + "]";
        }// end function

        public static function create(param1:int, param2:uint, param3:int, param4:Boolean = true, param5:int = 0) : SpellWrapper
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            if (param2 == 0)
            {
                param4 = false;
            }
            param1 = 63;
            if (param4)
            {
                if (_cache[param2] && _cache[param2].length > 0 && _cache[param2][param1] && !param5)
                {
                    _loc_6 = _cache[param2][param1];
                }
                else if (_playersCache[param5] && _playersCache[param5][param2] && _playersCache[param5][param2].length > 0 && _playersCache[param5][param2][param1])
                {
                    _loc_6 = _playersCache[param5][param2][param1];
                }
            }
            if (param2 == 0 && _cac != null && _cac.length > 0 && _cac[param1])
            {
                _loc_6 = _cac[param1];
            }
            if (!_loc_6)
            {
                _loc_6 = new SpellWrapper;
                _loc_6.id = param2;
                if (param4)
                {
                    if (param5)
                    {
                        if (!_playersCache[param5])
                        {
                            _playersCache[param5] = new Array();
                        }
                        if (!_playersCache[param5][param2])
                        {
                            _playersCache[param5][param2] = new Array();
                        }
                        _playersCache[param5][param2][param1] = _loc_6;
                    }
                    else
                    {
                        if (!_cache[param2])
                        {
                            _cache[param2] = new Array();
                        }
                        _cache[param2][param1] = _loc_6;
                    }
                }
                _loc_6._slotDataHolderManager = new SlotDataHolderManager(_loc_6);
            }
            if (param2 == 0)
            {
                if (!_cac)
                {
                    _cac = new Array();
                }
                _cac[param1] = _loc_6;
            }
            _loc_6.id = param2;
            _loc_6.gfxId = param2;
            if (param1 != -1)
            {
                _loc_6.position = param1;
            }
            _loc_6.spellLevel = param3;
            _loc_6.playerId = param5;
            _loc_6.effects = new Vector.<EffectInstance>;
            _loc_6.criticalEffect = new Vector.<EffectInstance>;
            _loc_6._spellLevel = SpellLevel.getLevelById(Spell.getSpellById(param2).spellLevels[(param3 - 1)]);
            for each (_loc_7 in _loc_6._spellLevel.effects)
            {
                
                _loc_7 = _loc_7.clone();
                if (_loc_7.category == 2)
                {
                    _loc_8 = CurrentPlayedFighterManager.getInstance().getSpellModifications(param2, CharacterSpellModificationTypeEnum.BASE_DAMAGE);
                    if (_loc_8 && _loc_7 is EffectInstanceDice)
                    {
                        _loc_11 = _loc_8.value.alignGiftBonus + _loc_8.value.base + _loc_8.value.contextModif + _loc_8.value.objectsAndMountBonus;
                        (_loc_7 as EffectInstanceDice).diceNum = (_loc_7 as EffectInstanceDice).diceNum + _loc_11;
                        (_loc_7 as EffectInstanceDice).diceSide = (_loc_7 as EffectInstanceDice).diceSide + _loc_11;
                    }
                    _loc_9 = CurrentPlayedFighterManager.getInstance().getSpellModifications(param2, CharacterSpellModificationTypeEnum.DAMAGE);
                    _loc_10 = CurrentPlayedFighterManager.getInstance().getSpellModifications(param2, CharacterSpellModificationTypeEnum.HEAL_BONUS);
                    if (_loc_9)
                    {
                        _loc_7.modificator = _loc_9.value.alignGiftBonus + _loc_9.value.base + _loc_9.value.contextModif + _loc_9.value.objectsAndMountBonus;
                    }
                    else if (_loc_10)
                    {
                        _loc_7.modificator = _loc_10.value.alignGiftBonus + _loc_10.value.base + _loc_10.value.contextModif + _loc_10.value.objectsAndMountBonus;
                    }
                }
                _loc_6.effects.push(_loc_7);
            }
            for each (_loc_7 in _loc_6._spellLevel.criticalEffect)
            {
                
                _loc_7 = _loc_7.clone();
                if (_loc_7.category == 2)
                {
                    _loc_8 = CurrentPlayedFighterManager.getInstance().getSpellModifications(param2, CharacterSpellModificationTypeEnum.BASE_DAMAGE);
                    if (_loc_8 && _loc_7 is EffectInstanceDice)
                    {
                        _loc_11 = _loc_8.value.alignGiftBonus + _loc_8.value.base + _loc_8.value.contextModif + _loc_8.value.objectsAndMountBonus;
                        (_loc_7 as EffectInstanceDice).diceNum = (_loc_7 as EffectInstanceDice).diceNum + _loc_11;
                        (_loc_7 as EffectInstanceDice).diceSide = (_loc_7 as EffectInstanceDice).diceSide + _loc_11;
                    }
                    _loc_9 = CurrentPlayedFighterManager.getInstance().getSpellModifications(param2, CharacterSpellModificationTypeEnum.DAMAGE);
                    _loc_10 = CurrentPlayedFighterManager.getInstance().getSpellModifications(param2, CharacterSpellModificationTypeEnum.HEAL_BONUS);
                    if (_loc_9)
                    {
                        _loc_7.modificator = _loc_9.value.alignGiftBonus + _loc_9.value.base + _loc_9.value.contextModif + _loc_9.value.objectsAndMountBonus;
                    }
                    else if (_loc_10)
                    {
                        _loc_7.modificator = _loc_10.value.alignGiftBonus + _loc_10.value.base + _loc_10.value.contextModif + _loc_10.value.objectsAndMountBonus;
                    }
                }
                _loc_6.criticalEffect.push(_loc_7);
            }
            return _loc_6;
        }// end function

        public static function getSpellWrapperById(param1:uint, param2:int, param3:int) : SpellWrapper
        {
            var _loc_4:* = 0;
            if (param2 != 0)
            {
                if (!_playersCache[param2])
                {
                    return null;
                }
                if (!_playersCache[param2][param1] && _cache[param1])
                {
                    _playersCache[param2][param1] = new Array();
                    _loc_4 = 0;
                    while (_loc_4 < 20)
                    {
                        
                        if (_cache[param1][_loc_4])
                        {
                            _playersCache[param2][param1][_loc_4] = _cache[param1][_loc_4].clone();
                        }
                        _loc_4++;
                    }
                }
                if (param1 == 0 && _cac && _cac[param3])
                {
                    return _cac[param3];
                }
                return _playersCache[param2][param1][param3];
            }
            else
            {
            }
            return _cache[param1][param3];
        }// end function

        public static function getFirstSpellWrapperById(param1:uint, param2:int) : SpellWrapper
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param2 != 0)
            {
                if (!_playersCache[param2])
                {
                    return null;
                }
                if (!_playersCache[param2][param1] && _cache[param1])
                {
                    _playersCache[param2][param1] = new Array();
                    _loc_4 = 0;
                    while (_loc_4 < 20)
                    {
                        
                        if (_cache[param1][_loc_4])
                        {
                            _playersCache[param2][param1][_loc_4] = _cache[param1][_loc_4].clone();
                        }
                        _loc_4++;
                    }
                }
                if (param1 == 0 && _cac && _cac.length)
                {
                    _loc_3 = _cac;
                }
                else
                {
                    _loc_3 = _playersCache[param2][param1];
                }
            }
            else
            {
                _loc_3 = _cache[param1];
            }
            if (_loc_3)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_3.length)
                {
                    
                    if (_loc_3[_loc_5])
                    {
                        return _loc_3[_loc_5];
                    }
                    _loc_5++;
                }
            }
            return null;
        }// end function

        public static function getSpellWrappersById(param1:uint, param2:int) : Array
        {
            var _loc_3:* = 0;
            if (param2 != 0)
            {
                if (!_playersCache[param2])
                {
                    return null;
                }
                if (!_playersCache[param2][param1] && _cache[param1])
                {
                    _playersCache[param2][param1] = new Array();
                    _loc_3 = 0;
                    while (_loc_3 < 20)
                    {
                        
                        if (_cache[param1][_loc_3])
                        {
                            _playersCache[param2][param1][_loc_3] = _cache[param1][_loc_3].clone();
                        }
                        _loc_3++;
                    }
                }
                if (param1 == 0)
                {
                    return _cac;
                }
                return _playersCache[param2][param1];
            }
            else
            {
            }
            return _cache[param1];
        }// end function

        public static function refreshAllPlayerSpellHolder(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_2 in _playersCache[param1])
            {
                
                for each (_loc_3 in _loc_2)
                {
                    
                    _loc_3._slotDataHolderManager.refreshAll();
                }
            }
            if (_cac)
            {
                for each (_loc_4 in _cac)
                {
                    
                    if (_loc_4)
                    {
                        _loc_5 = _loc_4._slotDataHolderManager;
                        SpellWrapper.SpellWrapper(_loc_4)._slotDataHolderManager.refreshAll();
                    }
                }
                ;
            }
            return;
        }// end function

        public static function resetAllCoolDown(param1:int, param2:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            SecureCenter.checkAccessKey(param2);
            for each (_loc_3 in _playersCache[param1])
            {
                
                for each (_loc_4 in _loc_3)
                {
                    
                    SpellWrapper.SpellWrapper(_loc_4).actualCooldown = 0;
                }
            }
            return;
        }// end function

        public static function removeAllSpellWrapperBut(param1:int, param2:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            SecureCenter.checkAccessKey(param2);
            var _loc_3:* = new Array();
            for (_loc_4 in _playersCache)
            {
                
                if (int(_loc_4) != param1)
                {
                    _loc_3.push(_loc_4);
                }
            }
            _loc_5 = _loc_3.length;
            _loc_6 = -1;
            while (++_loc_6 < _loc_5)
            {
                
                delete _playersCache[_loc_3[_loc_6]];
            }
            return;
        }// end function

        public static function removeAllSpellWrapper() : void
        {
            _playersCache = new Dictionary();
            _cache = new Array();
            return;
        }// end function

    }
}
