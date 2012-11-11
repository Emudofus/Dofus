package com.ankamagames.dofus.datacenter.effects
{
    import com.ankamagames.dofus.datacenter.alignments.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.datacenter.documents.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.pattern.*;
    import flash.utils.*;

    public class EffectInstance extends Object implements IDataCenter
    {
        public var effectId:uint;
        public var targetId:int;
        public var duration:int;
        public var delay:int;
        public var random:int;
        public var group:int;
        public var modificator:int;
        public var trigger:Boolean;
        public var hidden:Boolean;
        public var zoneSize:uint;
        public var zoneShape:uint;
        public var zoneMinSize:uint;
        private var _durationStringValue:int;
        private var _delayStringValue:int;
        private var _durationString:String;
        private var _category:int = -2;
        private var _description:String = "undefined";
        private var _showSet:int = -1;
        private var _rawZoneInit:Boolean;
        private var _rawZone:String;
        private static const UNKNOWN_NAME:String = "???";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EffectInstance));
        private static const UNDEFINED_CATEGORY:int = -2;
        private static const UNDEFINED_SHOW:int = -1;
        private static const UNDEFINED_DESCRIPTION:String = "undefined";

        public function EffectInstance()
        {
            return;
        }// end function

        public function set rawZone(param1:String) : void
        {
            this._rawZone = param1;
            this.parseZone();
            return;
        }// end function

        public function get rawZone() : String
        {
            return this._rawZone;
        }// end function

        public function get durationString() : String
        {
            if (!this._durationString || this._durationStringValue != this.duration || this._delayStringValue != this.delay)
            {
                this._durationStringValue = this.duration;
                this._delayStringValue = this.delay;
                this._durationString = this.getTurnCountStr(false);
            }
            return this._durationString;
        }// end function

        public function get category() : int
        {
            var _loc_1:* = null;
            if (this._category == UNDEFINED_CATEGORY)
            {
                _loc_1 = Effect.getEffectById(this.effectId);
                this._category = _loc_1 ? (_loc_1.category) : (-1);
            }
            return this._category;
        }// end function

        public function get showInSet() : int
        {
            var _loc_1:* = null;
            if (this._showSet == UNDEFINED_SHOW)
            {
                _loc_1 = Effect.getEffectById(this.effectId);
                this._showSet = _loc_1 ? (_loc_1.showInSet ? (1) : (0)) : (0);
            }
            return this._showSet;
        }// end function

        public function get parameter0() : Object
        {
            return null;
        }// end function

        public function get parameter1() : Object
        {
            return null;
        }// end function

        public function get parameter2() : Object
        {
            return null;
        }// end function

        public function get parameter3() : Object
        {
            return null;
        }// end function

        public function get parameter4() : Object
        {
            return null;
        }// end function

        public function get description() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (this._description == UNDEFINED_DESCRIPTION)
            {
                _loc_1 = Effect.getEffectById(this.effectId);
                if (!_loc_1)
                {
                    this._description = null;
                    return null;
                }
                _loc_2 = _loc_1.description;
                _loc_3 = [this.parameter0, this.parameter1, this.parameter2, this.parameter3, this.parameter4];
                switch(_loc_1.id)
                {
                    case 10:
                    {
                        _loc_3[2] = this.getEmoticonName(_loc_3[0]);
                        break;
                    }
                    case 165:
                    case 1084:
                    {
                        _loc_3[0] = this.getItemTypeName(_loc_3[0]);
                        break;
                    }
                    case 197:
                    case 181:
                    case 185:
                    {
                        _loc_3[0] = this.getMonsterName(_loc_3[0]);
                        break;
                    }
                    case 281:
                    case 282:
                    case 283:
                    case 284:
                    case 285:
                    case 286:
                    case 287:
                    case 288:
                    case 289:
                    case 290:
                    case 291:
                    case 292:
                    case 293:
                    case 294:
                    {
                        _loc_3[0] = this.getSpellName(_loc_3[0]);
                        break;
                    }
                    case 406:
                    {
                        _loc_3[0] = this.getSpellName(_loc_3[0]);
                        break;
                    }
                    case 603:
                    case 615:
                    {
                        _loc_3[2] = this.getJobName(_loc_3[0]);
                        break;
                    }
                    case 604:
                    {
                        if (_loc_3[2] == null)
                        {
                            _loc_3[2] = _loc_3[0];
                        }
                        _loc_3[2] = this.getSpellLevelName(_loc_3[2]);
                        break;
                    }
                    case 614:
                    case 1050:
                    {
                        _loc_3[0] = _loc_3[2];
                        _loc_3[1] = this.getJobName(_loc_3[1]);
                        break;
                    }
                    case 616:
                    case 624:
                    {
                        _loc_3[2] = this.getSpellName(_loc_3[0]);
                        break;
                    }
                    case 620:
                    {
                        _loc_3[2] = this.getDocumentTitle(_loc_3[0]);
                        break;
                    }
                    case 621:
                    {
                        _loc_3[2] = this.getMonsterName(_loc_3[1]);
                        break;
                    }
                    case 623:
                    case 628:
                    {
                        _loc_3[1] = this.getMonsterGrade(_loc_3[2], _loc_3[0]);
                        _loc_3[2] = this.getMonsterName(_loc_3[2]);
                        break;
                    }
                    case 649:
                    case 960:
                    {
                        _loc_3[2] = this.getAlignmentSideName(_loc_3[0]);
                        break;
                    }
                    case 669:
                    {
                        break;
                    }
                    case 699:
                    {
                        _loc_3[0] = this.getJobName(_loc_3[0]);
                        break;
                    }
                    case 706:
                    {
                        break;
                    }
                    case 715:
                    {
                        _loc_3[0] = this.getMonsterSuperRaceName(_loc_3[0]);
                        break;
                    }
                    case 716:
                    {
                        _loc_3[0] = this.getMonsterRaceName(_loc_3[0]);
                        break;
                    }
                    case 717:
                    case 1008:
                    case 1011:
                    {
                        _loc_3[0] = this.getMonsterName(_loc_3[0]);
                        break;
                    }
                    case 724:
                    {
                        _loc_3[2] = this.getTitleName(_loc_3[0]);
                        break;
                    }
                    case 787:
                    case 792:
                    case 793:
                    case 1017:
                    case 1018:
                    case 1019:
                    case 1035:
                    case 1036:
                    case 1044:
                    case 1045:
                    {
                        _loc_3[0] = this.getSpellName(_loc_3[0]);
                        break;
                    }
                    case 800:
                    {
                        _loc_3[2] = _loc_3[0];
                        break;
                    }
                    case 806:
                    {
                        if (_loc_3[1] > 6)
                        {
                            _loc_3[0] = I18n.getUiText("ui.petWeight.fat", [_loc_3[1]]);
                        }
                        else if (_loc_3[2] > 6)
                        {
                            _loc_3[0] = I18n.getUiText("ui.petWeight.lean", [_loc_3[2]]);
                        }
                        else if (this is EffectInstanceInteger && _loc_3[0] > 6)
                        {
                            _loc_3[0] = I18n.getUiText("ui.petWeight.lean", [_loc_3[0]]);
                        }
                        else
                        {
                            _loc_3[0] = I18n.getUiText("ui.petWeight.nominal");
                        }
                        break;
                    }
                    case 807:
                    {
                        if (_loc_3[0])
                        {
                            _loc_3[0] = this.getItemName(_loc_3[0]);
                        }
                        else
                        {
                            _loc_3[0] = I18n.getUiText("ui.common.none");
                        }
                        break;
                    }
                    case 814:
                    {
                        _loc_3[0] = this.getItemName(_loc_3[0]);
                        break;
                    }
                    case 905:
                    {
                        _loc_3[1] = this.getMonsterName(_loc_3[1]);
                        break;
                    }
                    case 939:
                    case 940:
                    {
                        _loc_3[2] = this.getItemName(_loc_3[0]);
                        break;
                    }
                    case 950:
                    case 951:
                    case 952:
                    {
                        if (_loc_3[2])
                        {
                            _loc_3[2] = this.getSpellStateName(_loc_3[2]);
                        }
                        else
                        {
                            _loc_3[2] = this.getSpellStateName(_loc_3[0]);
                        }
                        break;
                    }
                    case 961:
                    case 962:
                    {
                        _loc_3[2] = _loc_3[0];
                        break;
                    }
                    case 982:
                    {
                        break;
                    }
                    case 988:
                    case 987:
                    case 985:
                    case 996:
                    {
                        _loc_3[3] = "{player," + _loc_3[3] + "}";
                        break;
                    }
                    case 1111:
                    {
                        _loc_3[2] = _loc_3[0];
                        break;
                    }
                    case 805:
                    case 808:
                    case 983:
                    {
                        _loc_3[2] = _loc_3[2] == undefined ? (0) : (_loc_3[2]);
                        _loc_6 = _loc_3[0];
                        _loc_7 = _loc_3[1].substr(0, 2);
                        _loc_8 = _loc_3[1].substr(2, 2);
                        _loc_9 = _loc_3[2].substr(0, 2);
                        _loc_10 = _loc_3[2].substr(2, 2);
                        _loc_11 = XmlConfig.getInstance().getEntry("config.lang.current");
                        switch(_loc_11)
                        {
                            case LanguageEnum.LANG_FR:
                            {
                                _loc_3[0] = _loc_8 + "/" + _loc_7 + "/" + _loc_6 + " " + _loc_9 + ":" + _loc_10;
                                break;
                            }
                            case LanguageEnum.LANG_EN:
                            {
                                _loc_3[0] = _loc_7 + "/" + _loc_8 + "/" + _loc_6 + " " + _loc_9 + ":" + _loc_10;
                                break;
                            }
                            default:
                            {
                                _loc_3[0] = _loc_7 + "/" + _loc_8 + "/" + _loc_6 + " " + _loc_9 + ":" + _loc_10;
                                break;
                                break;
                            }
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_4 = "";
                if (_loc_2 == null)
                {
                    this._description = "";
                    return this._description;
                }
                _loc_5 = PatternDecoder.getDescription(_loc_2, _loc_3);
                if (_loc_5 == null || _loc_5 == "")
                {
                    this._description = "";
                    return this._description;
                }
                _loc_4 = _loc_4 + _loc_5;
                if (this.modificator != 0)
                {
                    _loc_4 = _loc_4 + (" " + I18n.getUiText("ui.effect.boosted.spell.complement", [this.modificator], "%"));
                }
                if (this.random > 0)
                {
                    if (this.group > 0)
                    {
                        _loc_4 = _loc_4 + (" (" + I18n.getUiText("ui.common.random") + ")");
                    }
                    else
                    {
                        _loc_4 = _loc_4 + (" " + I18n.getUiText("ui.effect.randomProbability", [this.random], "%"));
                    }
                }
                this._description = _loc_4;
            }
            return this._description;
        }// end function

        public function clone() : EffectInstance
        {
            var _loc_1:* = new EffectInstance();
            _loc_1.zoneShape = this.zoneShape;
            _loc_1.zoneSize = this.zoneSize;
            _loc_1.zoneMinSize = this.zoneMinSize;
            _loc_1.effectId = this.effectId;
            _loc_1.duration = this.duration;
            _loc_1.delay = this.delay;
            _loc_1.random = this.random;
            _loc_1.group = this.group;
            _loc_1.targetId = this.targetId;
            return _loc_1;
        }// end function

        public function add(param1) : EffectInstance
        {
            return new EffectInstance();
        }// end function

        public function setParameter(param1:uint, param2) : void
        {
            return;
        }// end function

        public function forceDescriptionRefresh() : void
        {
            this._description = UNDEFINED_DESCRIPTION;
            return;
        }// end function

        private function getTurnCountStr(param1:Boolean) : String
        {
            var _loc_2:* = new String();
            if (this.delay > 0)
            {
                return PatternDecoder.combine(I18n.getUiText("ui.common.delayTurn", [this.delay]), "n", this.delay <= 1);
            }
            var _loc_3:* = this.duration;
            if (isNaN(_loc_3))
            {
                return "";
            }
            if (_loc_3 > -1)
            {
                if (_loc_3 > 1)
                {
                    return PatternDecoder.combine(I18n.getUiText("ui.common.turn", [_loc_3]), "n", false);
                }
                if (_loc_3 == 0)
                {
                    return "";
                }
                if (param1)
                {
                    return I18n.getUiText("ui.common.lastTurn");
                }
                return PatternDecoder.combine(I18n.getUiText("ui.common.turn", [_loc_3]), "n", true);
            }
            else
            {
            }
            return I18n.getUiText("ui.common.infinit");
        }// end function

        private function getEmoticonName(param1:int) : String
        {
            var _loc_2:* = Emoticon.getEmoticonById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getItemTypeName(param1:int) : String
        {
            var _loc_2:* = ItemType.getItemTypeById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getMonsterName(param1:int) : String
        {
            var _loc_2:* = Monster.getMonsterById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getMonsterGrade(param1:int, param2:int) : String
        {
            var _loc_3:* = Monster.getMonsterById(param1);
            return _loc_3 ? (_loc_3.getMonsterGrade(param2).level.toString()) : (UNKNOWN_NAME);
        }// end function

        private function getSpellName(param1:int) : String
        {
            var _loc_2:* = Spell.getSpellById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getSpellLevelName(param1:int) : String
        {
            var _loc_2:* = SpellLevel.getLevelById(param1);
            var _loc_3:* = _loc_2 ? (this.getSpellName(_loc_2.spellId)) : (UNKNOWN_NAME);
            return _loc_2 ? (this.getSpellName(_loc_2.spellId)) : (UNKNOWN_NAME);
        }// end function

        private function getJobName(param1:int) : String
        {
            var _loc_2:* = Job.getJobById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getDocumentTitle(param1:int) : String
        {
            var _loc_2:* = Document.getDocumentById(param1);
            return _loc_2 ? (_loc_2.title) : (UNKNOWN_NAME);
        }// end function

        private function getAlignmentSideName(param1:int) : String
        {
            var _loc_2:* = AlignmentSide.getAlignmentSideById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getItemName(param1:int) : String
        {
            var _loc_2:* = Item.getItemById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getMonsterSuperRaceName(param1:int) : String
        {
            var _loc_2:* = MonsterSuperRace.getMonsterSuperRaceById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getMonsterRaceName(param1:int) : String
        {
            var _loc_2:* = MonsterRace.getMonsterRaceById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getTitleName(param1:int) : String
        {
            var _loc_2:* = Title.getTitleById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function getSpellStateName(param1:int) : String
        {
            var _loc_2:* = SpellState.getSpellStateById(param1);
            return _loc_2 ? (_loc_2.name) : (UNKNOWN_NAME);
        }// end function

        private function parseZone() : void
        {
            var _loc_1:* = null;
            if (this.rawZone && this.rawZone.length)
            {
                this.zoneShape = this.rawZone.charCodeAt(0);
                _loc_1 = this.rawZone.substr(1).split(",");
                if (_loc_1.length > 0)
                {
                    this.zoneSize = parseInt(_loc_1[0]);
                }
                else
                {
                    this.zoneSize = 0;
                }
                if (_loc_1.length > 1)
                {
                    this.zoneMinSize = parseInt(_loc_1[1]);
                }
                else
                {
                    this.zoneMinSize = 0;
                }
                this._rawZoneInit = true;
            }
            else
            {
                _log.error("Zone incorrect (" + this.rawZone + ")");
            }
            return;
        }// end function

    }
}
