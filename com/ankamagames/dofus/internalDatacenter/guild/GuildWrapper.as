package com.ankamagames.dofus.internalDatacenter.guild
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import flash.utils.*;

    public class GuildWrapper extends Object implements IDataCenter
    {
        private var _guildName:String;
        public var guildId:uint;
        public var upEmblem:EmblemWrapper;
        public var backEmblem:EmblemWrapper;
        public var level:uint = 0;
        public var enabled:Boolean;
        public var creationDate:uint;
        public var experience:Number;
        public var expLevelFloor:Number;
        public var expNextLevelFloor:Number;
        private var _memberRightsNumber:uint;
        public static const IS_BOSS:String = "isBoss";
        public static const MANAGE_GUILD_BOOSTS:String = "manageGuildBoosts";
        public static const MANAGE_RIGHTS:String = "manageRights";
        public static const MANAGE_LIGHT_RIGHTS:String = "manageLightRights";
        public static const INVITE_NEW_MEMBERS:String = "inviteNewMembers";
        public static const BAN_MEMBERS:String = "banMembers";
        public static const MANAGE_XP_CONTRIBUTION:String = "manageXPContribution";
        public static const MANAGE_RANKS:String = "manageRanks";
        public static const HIRE_TAX_COLLECTOR:String = "hireTaxCollector";
        public static const MANAGE_MY_XP_CONTRIBUTION:String = "manageMyXpContribution";
        public static const COLLECT:String = "collect";
        public static const USE_FARMS:String = "useFarms";
        public static const ORGANIZE_FARMS:String = "organizeFarms";
        public static const TAKE_OTHERS_RIDES_IN_FARM:String = "takeOthersRidesInFarm";
        public static const PRIORITIZE_DEFENSE:String = "prioritizeMeInDefense";
        public static const COLLECT_MY_TAX_COLLECTORS:String = "collectMyTaxCollectors";
        public static const guildRights:Array = new Array(IS_BOSS, MANAGE_GUILD_BOOSTS, MANAGE_RIGHTS, MANAGE_LIGHT_RIGHTS, INVITE_NEW_MEMBERS, BAN_MEMBERS, MANAGE_XP_CONTRIBUTION, MANAGE_RANKS, HIRE_TAX_COLLECTOR, MANAGE_MY_XP_CONTRIBUTION, COLLECT, USE_FARMS, ORGANIZE_FARMS, TAKE_OTHERS_RIDES_IN_FARM, PRIORITIZE_DEFENSE, COLLECT_MY_TAX_COLLECTORS);
        public static var _rightDictionnary:Dictionary = new Dictionary();

        public function GuildWrapper()
        {
            return;
        }// end function

        public function get guildName() : String
        {
            if (this._guildName == "#NONAME#")
            {
                return I18n.getUiText("ui.guild.noName");
            }
            return this._guildName;
        }// end function

        public function get realGuildName() : String
        {
            return this._guildName;
        }// end function

        public function set memberRightsNumber(param1:uint) : void
        {
            this._memberRightsNumber = param1;
            return;
        }// end function

        public function get memberRightsNumber() : uint
        {
            return this._memberRightsNumber;
        }// end function

        public function get memberRights() : Vector.<Boolean>
        {
            var _loc_1:* = new Vector.<Boolean>;
            _loc_1.push(this.isBoss);
            _loc_1.push(this.manageGuildBoosts);
            _loc_1.push(this.manageRights);
            _loc_1.push(this.manageLightRights);
            _loc_1.push(this.inviteNewMembers);
            _loc_1.push(this.banMembers);
            _loc_1.push(this.manageXPContribution);
            _loc_1.push(this.manageRanks);
            _loc_1.push(this.manageMyXpContribution);
            _loc_1.push(this.hireTaxCollector);
            _loc_1.push(this.collect);
            _loc_1.push(this.useFarms);
            _loc_1.push(this.organizeFarms);
            _loc_1.push(this.takeOthersRidesInFarm);
            _loc_1.push(this.prioritizeMeInDefense);
            _loc_1.push(this.collectMyTaxCollectors);
            return _loc_1;
        }// end function

        public function get isBoss() : Boolean
        {
            return (1 & this._memberRightsNumber) > 0;
        }// end function

        public function get manageGuildBoosts() : Boolean
        {
            return this.isBoss || this.manageRights || (2 & this._memberRightsNumber) > 0;
        }// end function

        public function get manageRights() : Boolean
        {
            return this.isBoss || (4 & this._memberRightsNumber) > 0;
        }// end function

        public function get inviteNewMembers() : Boolean
        {
            return this.isBoss || this.manageRights || (8 & this._memberRightsNumber) > 0;
        }// end function

        public function get banMembers() : Boolean
        {
            return this.isBoss || this.manageRights || (16 & this._memberRightsNumber) > 0;
        }// end function

        public function get manageXPContribution() : Boolean
        {
            return this.isBoss || this.manageRights || (32 & this._memberRightsNumber) > 0;
        }// end function

        public function get manageRanks() : Boolean
        {
            return this.isBoss || this.manageRights || (64 & this._memberRightsNumber) > 0;
        }// end function

        public function get hireTaxCollector() : Boolean
        {
            return this.isBoss || this.manageRights || (128 & this._memberRightsNumber) > 0;
        }// end function

        public function get manageMyXpContribution() : Boolean
        {
            return this.isBoss || this.manageRights || (256 & this._memberRightsNumber) > 0;
        }// end function

        public function get collect() : Boolean
        {
            return this.isBoss || this.manageRights || (512 & this._memberRightsNumber) > 0;
        }// end function

        public function get manageLightRights() : Boolean
        {
            return this.isBoss || this.manageRights || (1024 & this._memberRightsNumber) > 0;
        }// end function

        public function get useFarms() : Boolean
        {
            return this.isBoss || this.manageRights || (4096 & this._memberRightsNumber) > 0;
        }// end function

        public function get organizeFarms() : Boolean
        {
            return this.isBoss || this.manageRights || (8192 & this._memberRightsNumber) > 0;
        }// end function

        public function get takeOthersRidesInFarm() : Boolean
        {
            return this.isBoss || this.manageRights || (16384 & this._memberRightsNumber) > 0;
        }// end function

        public function get prioritizeMeInDefense() : Boolean
        {
            return this.isBoss || this.manageRights || (32768 & this._memberRightsNumber) > 0;
        }// end function

        public function get collectMyTaxCollectors() : Boolean
        {
            return this.isBoss || this.manageRights || (65536 & this._memberRightsNumber) > 0;
        }// end function

        public function update(param1:uint, param2:String, param3:GuildEmblem, param4:Number, param5:Boolean) : void
        {
            this.guildId = param1;
            this._guildName = param2;
            this._memberRightsNumber = param4;
            this.enabled = param5;
            this.upEmblem.update(param3.symbolShape, EmblemWrapper.UP, param3.symbolColor);
            this.backEmblem.update(param3.backgroundShape, EmblemWrapper.BACK, param3.backgroundColor);
            return;
        }// end function

        public function hasRight(param1:String) : Boolean
        {
            var _loc_2:* = false;
            switch(param1)
            {
                case IS_BOSS:
                {
                    _loc_2 = this.isBoss;
                    break;
                }
                case MANAGE_GUILD_BOOSTS:
                {
                    _loc_2 = this.manageGuildBoosts;
                    break;
                }
                case MANAGE_RIGHTS:
                {
                    _loc_2 = this.manageRights;
                    break;
                }
                case MANAGE_LIGHT_RIGHTS:
                {
                    _loc_2 = this.manageLightRights;
                    break;
                }
                case INVITE_NEW_MEMBERS:
                {
                    _loc_2 = this.inviteNewMembers;
                    break;
                }
                case BAN_MEMBERS:
                {
                    _loc_2 = this.banMembers;
                    break;
                }
                case MANAGE_XP_CONTRIBUTION:
                {
                    _loc_2 = this.manageXPContribution;
                    break;
                }
                case MANAGE_RANKS:
                {
                    _loc_2 = this.manageRanks;
                    break;
                }
                case MANAGE_MY_XP_CONTRIBUTION:
                {
                    _loc_2 = this.manageMyXpContribution;
                    break;
                }
                case HIRE_TAX_COLLECTOR:
                {
                    _loc_2 = this.hireTaxCollector;
                    break;
                }
                case COLLECT:
                {
                    _loc_2 = this.collect;
                    break;
                }
                case USE_FARMS:
                {
                    _loc_2 = this.useFarms;
                    break;
                }
                case ORGANIZE_FARMS:
                {
                    _loc_2 = this.organizeFarms;
                    break;
                }
                case TAKE_OTHERS_RIDES_IN_FARM:
                {
                    _loc_2 = this.takeOthersRidesInFarm;
                    break;
                }
                case PRIORITIZE_DEFENSE:
                {
                    _loc_2 = this.prioritizeMeInDefense;
                    break;
                }
                case COLLECT_MY_TAX_COLLECTORS:
                {
                    _loc_2 = this.collectMyTaxCollectors;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function initDictionary() : void
        {
            _rightDictionnary[IS_BOSS] = 0;
            _rightDictionnary[MANAGE_GUILD_BOOSTS] = 1;
            _rightDictionnary[MANAGE_RIGHTS] = 2;
            _rightDictionnary[INVITE_NEW_MEMBERS] = 3;
            _rightDictionnary[BAN_MEMBERS] = 4;
            _rightDictionnary[MANAGE_XP_CONTRIBUTION] = 5;
            _rightDictionnary[MANAGE_RANKS] = 6;
            _rightDictionnary[HIRE_TAX_COLLECTOR] = 7;
            _rightDictionnary[MANAGE_MY_XP_CONTRIBUTION] = 8;
            _rightDictionnary[COLLECT] = 9;
            _rightDictionnary[MANAGE_LIGHT_RIGHTS] = 10;
            _rightDictionnary[USE_FARMS] = 12;
            _rightDictionnary[ORGANIZE_FARMS] = 13;
            _rightDictionnary[TAKE_OTHERS_RIDES_IN_FARM] = 14;
            _rightDictionnary[PRIORITIZE_DEFENSE] = 15;
            _rightDictionnary[COLLECT_MY_TAX_COLLECTORS] = 16;
            return;
        }// end function

        public static function create(param1:uint, param2:String, param3:GuildEmblem, param4:Number, param5:Boolean) : GuildWrapper
        {
            var _loc_6:* = null;
            _loc_6 = new GuildWrapper;
            _loc_6.initDictionary();
            _loc_6.guildId = param1;
            _loc_6._guildName = param2;
            _loc_6._memberRightsNumber = param4;
            _loc_6.enabled = param5;
            if (param3 != null)
            {
                _loc_6.upEmblem = EmblemWrapper.create(param3.symbolShape, EmblemWrapper.UP, param3.symbolColor);
                _loc_6.backEmblem = EmblemWrapper.create(param3.backgroundShape, EmblemWrapper.BACK, param3.backgroundColor);
            }
            return _loc_6;
        }// end function

        public static function getRightsNumber(param1:Array) : Number
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_2:* = 0;
            for each (_loc_3 in guildRights)
            {
                
                _loc_4 = false;
                for each (_loc_5 in param1)
                {
                    
                    if (_loc_5 == _loc_3)
                    {
                        _loc_2 = _loc_2 | 1 << _rightDictionnary[_loc_5];
                    }
                }
            }
            return _loc_2;
        }// end function

    }
}
