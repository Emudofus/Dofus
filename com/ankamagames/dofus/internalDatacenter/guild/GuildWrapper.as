package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.social.GuildVersatileInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.social.AlliancedGuildFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.data.I18n;
   import __AS3__.vec.Vector;
   
   public class GuildWrapper extends Object implements IDataCenter
   {
      
      public function GuildWrapper() {
         super();
      }
      
      private static var _ref:Dictionary = new Dictionary();
      
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
      
      public static const SET_ALLIANCE_PRISM:String = "setAlliancePrism";
      
      public static const TALK_IN_ALLIANCE_CHANNEL:String = "talkInAllianceChannel";
      
      public static const guildRights:Array = new Array(IS_BOSS,MANAGE_GUILD_BOOSTS,MANAGE_RIGHTS,MANAGE_LIGHT_RIGHTS,INVITE_NEW_MEMBERS,BAN_MEMBERS,MANAGE_XP_CONTRIBUTION,MANAGE_RANKS,HIRE_TAX_COLLECTOR,MANAGE_MY_XP_CONTRIBUTION,COLLECT,USE_FARMS,ORGANIZE_FARMS,TAKE_OTHERS_RIDES_IN_FARM,PRIORITIZE_DEFENSE,COLLECT_MY_TAX_COLLECTORS,SET_ALLIANCE_PRISM,TALK_IN_ALLIANCE_CHANNEL);
      
      public static var _rightDictionnary:Dictionary = new Dictionary();
      
      public static function clearCache() : void {
         _ref = new Dictionary();
      }
      
      public static function getFromNetwork(param1:Object) : GuildWrapper {
         var _loc2_:GuildWrapper = null;
         var _loc3_:GuildVersatileInformations = null;
         if(_ref[param1.guildId])
         {
            _loc2_ = _ref[param1.guildId];
         }
         else
         {
            _loc2_ = new GuildWrapper();
            _ref[param1.guildId] = _loc2_;
         }
         _loc2_.guildId = param1.guildId;
         if(param1 is GuildVersatileInformations)
         {
            _loc3_ = param1 as GuildVersatileInformations;
            _loc2_.level = _loc3_.guildLevel;
            _loc2_.leaderId = _loc3_.leaderId;
            _loc2_.nbMembers = _loc3_.nbMembers;
         }
         else
         {
            if(param1 is BasicGuildInformations)
            {
               _loc2_._guildName = BasicGuildInformations(param1).guildName;
               if(param1 is GuildInformations)
               {
                  _loc2_.backEmblem = EmblemWrapper.fromNetwork(GuildInformations(param1).guildEmblem,true);
                  _loc2_.upEmblem = EmblemWrapper.fromNetwork(GuildInformations(param1).guildEmblem,false);
               }
               if(param1 is AlliancedGuildFactSheetInformations)
               {
                  _loc2_.alliance = AllianceWrapper.getFromNetwork(AlliancedGuildFactSheetInformations(param1).allianceInfos);
                  _loc2_.allianceTag = _loc2_.alliance.allianceTag;
               }
            }
         }
         return _loc2_;
      }
      
      public static function updateRef(param1:uint, param2:GuildWrapper) : void {
         _ref[param1] = param2;
      }
      
      public static function create(param1:uint, param2:String, param3:GuildEmblem, param4:Number, param5:Boolean) : GuildWrapper {
         var _loc6_:GuildWrapper = null;
         _loc6_ = new GuildWrapper();
         _loc6_.initDictionary();
         _loc6_.guildId = param1;
         _loc6_._guildName = param2;
         _loc6_._memberRightsNumber = param4;
         _loc6_.enabled = param5;
         if(param3 != null)
         {
            _loc6_.upEmblem = EmblemWrapper.create(param3.symbolShape,EmblemWrapper.UP,param3.symbolColor);
            _loc6_.backEmblem = EmblemWrapper.create(param3.backgroundShape,EmblemWrapper.BACK,param3.backgroundColor);
         }
         return _loc6_;
      }
      
      public static function getRightsNumber(param1:Array) : Number {
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:String = null;
         var _loc2_:Number = 0;
         for each (_loc3_ in guildRights)
         {
            _loc4_ = false;
            for each (_loc5_ in param1)
            {
               if(_loc5_ == _loc3_)
               {
                  _loc2_ = _loc2_ | 1 << _rightDictionnary[_loc5_];
               }
            }
         }
         return _loc2_;
      }
      
      private var _guildName:String;
      
      public var guildId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var level:uint = 0;
      
      public var enabled:Boolean;
      
      public var creationDate:uint;
      
      public var leaderId:uint;
      
      public var nbMembers:uint;
      
      public var experience:Number;
      
      public var expLevelFloor:Number;
      
      public var expNextLevelFloor:Number;
      
      public var alliance:AllianceWrapper;
      
      public var allianceTag:String;
      
      private var _memberRightsNumber:uint;
      
      public function get guildName() : String {
         if(this._guildName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._guildName;
      }
      
      public function get realGuildName() : String {
         return this._guildName;
      }
      
      public function set memberRightsNumber(param1:uint) : void {
         this._memberRightsNumber = param1;
      }
      
      public function get memberRightsNumber() : uint {
         return this._memberRightsNumber;
      }
      
      public function get memberRights() : Vector.<Boolean> {
         var _loc1_:Vector.<Boolean> = new Vector.<Boolean>();
         _loc1_.push(this.isBoss);
         _loc1_.push(this.manageGuildBoosts);
         _loc1_.push(this.manageRights);
         _loc1_.push(this.manageLightRights);
         _loc1_.push(this.inviteNewMembers);
         _loc1_.push(this.banMembers);
         _loc1_.push(this.manageXPContribution);
         _loc1_.push(this.manageRanks);
         _loc1_.push(this.manageMyXpContribution);
         _loc1_.push(this.hireTaxCollector);
         _loc1_.push(this.collect);
         _loc1_.push(this.useFarms);
         _loc1_.push(this.organizeFarms);
         _loc1_.push(this.takeOthersRidesInFarm);
         _loc1_.push(this.prioritizeMeInDefense);
         _loc1_.push(this.collectMyTaxCollectors);
         _loc1_.push(this.setAlliancePrism);
         _loc1_.push(this.talkInAllianceChannel);
         return _loc1_;
      }
      
      public function get isBoss() : Boolean {
         return (1 & this._memberRightsNumber) > 0;
      }
      
      public function get manageGuildBoosts() : Boolean {
         return (this.isBoss) || (this.manageRights) || (2 & this._memberRightsNumber) > 0;
      }
      
      public function get manageRights() : Boolean {
         return (this.isBoss) || (4 & this._memberRightsNumber) > 0;
      }
      
      public function get inviteNewMembers() : Boolean {
         return (this.isBoss) || (this.manageRights) || (8 & this._memberRightsNumber) > 0;
      }
      
      public function get banMembers() : Boolean {
         return (this.isBoss) || (this.manageRights) || (16 & this._memberRightsNumber) > 0;
      }
      
      public function get manageXPContribution() : Boolean {
         return (this.isBoss) || (this.manageRights) || (32 & this._memberRightsNumber) > 0;
      }
      
      public function get manageRanks() : Boolean {
         return (this.isBoss) || (this.manageRights) || (64 & this._memberRightsNumber) > 0;
      }
      
      public function get hireTaxCollector() : Boolean {
         return (this.isBoss) || (this.manageRights) || (128 & this._memberRightsNumber) > 0;
      }
      
      public function get manageMyXpContribution() : Boolean {
         return (this.isBoss) || (this.manageRights) || (256 & this._memberRightsNumber) > 0;
      }
      
      public function get collect() : Boolean {
         return (this.isBoss) || (this.manageRights) || (512 & this._memberRightsNumber) > 0;
      }
      
      public function get manageLightRights() : Boolean {
         return (this.isBoss) || (this.manageRights) || (1024 & this._memberRightsNumber) > 0;
      }
      
      public function get useFarms() : Boolean {
         return (this.isBoss) || (this.manageRights) || (4096 & this._memberRightsNumber) > 0;
      }
      
      public function get organizeFarms() : Boolean {
         return (this.isBoss) || (this.manageRights) || (8192 & this._memberRightsNumber) > 0;
      }
      
      public function get takeOthersRidesInFarm() : Boolean {
         return (this.isBoss) || (this.manageRights) || (16384 & this._memberRightsNumber) > 0;
      }
      
      public function get prioritizeMeInDefense() : Boolean {
         return (this.isBoss) || (this.manageRights) || (32768 & this._memberRightsNumber) > 0;
      }
      
      public function get collectMyTaxCollectors() : Boolean {
         return (this.isBoss) || (this.manageRights) || (65536 & this._memberRightsNumber) > 0;
      }
      
      public function get setAlliancePrism() : Boolean {
         return (this.isBoss) || (this.manageRights) || (131072 & this._memberRightsNumber) > 0;
      }
      
      public function get talkInAllianceChannel() : Boolean {
         return (this.isBoss) || (this.manageRights) || (262144 & this._memberRightsNumber) > 0;
      }
      
      public function clone() : GuildWrapper {
         var _loc1_:GuildWrapper = create(this.guildId,this.guildName,null,this.memberRightsNumber,this.enabled);
         _loc1_.upEmblem = this.upEmblem;
         _loc1_.backEmblem = this.backEmblem;
         return _loc1_;
      }
      
      public function update(param1:uint, param2:String, param3:GuildEmblem, param4:Number, param5:Boolean) : void {
         this.guildId = param1;
         this._guildName = param2;
         this._memberRightsNumber = param4;
         this.enabled = param5;
         this.upEmblem.update(param3.symbolShape,EmblemWrapper.UP,param3.symbolColor);
         this.backEmblem.update(param3.backgroundShape,EmblemWrapper.BACK,param3.backgroundColor);
      }
      
      public function hasRight(param1:String) : Boolean {
         var _loc2_:* = false;
         switch(param1)
         {
            case IS_BOSS:
               _loc2_ = this.isBoss;
               break;
            case MANAGE_GUILD_BOOSTS:
               _loc2_ = this.manageGuildBoosts;
               break;
            case MANAGE_RIGHTS:
               _loc2_ = this.manageRights;
               break;
            case MANAGE_LIGHT_RIGHTS:
               _loc2_ = this.manageLightRights;
               break;
            case INVITE_NEW_MEMBERS:
               _loc2_ = this.inviteNewMembers;
               break;
            case BAN_MEMBERS:
               _loc2_ = this.banMembers;
               break;
            case MANAGE_XP_CONTRIBUTION:
               _loc2_ = this.manageXPContribution;
               break;
            case MANAGE_RANKS:
               _loc2_ = this.manageRanks;
               break;
            case MANAGE_MY_XP_CONTRIBUTION:
               _loc2_ = this.manageMyXpContribution;
               break;
            case HIRE_TAX_COLLECTOR:
               _loc2_ = this.hireTaxCollector;
               break;
            case COLLECT:
               _loc2_ = this.collect;
               break;
            case USE_FARMS:
               _loc2_ = this.useFarms;
               break;
            case ORGANIZE_FARMS:
               _loc2_ = this.organizeFarms;
               break;
            case TAKE_OTHERS_RIDES_IN_FARM:
               _loc2_ = this.takeOthersRidesInFarm;
               break;
            case PRIORITIZE_DEFENSE:
               _loc2_ = this.prioritizeMeInDefense;
               break;
            case COLLECT_MY_TAX_COLLECTORS:
               _loc2_ = this.collectMyTaxCollectors;
               break;
            case SET_ALLIANCE_PRISM:
               _loc2_ = this.setAlliancePrism;
               break;
            case TALK_IN_ALLIANCE_CHANNEL:
               _loc2_ = this.talkInAllianceChannel;
               break;
         }
         return _loc2_;
      }
      
      private function initDictionary() : void {
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
         _rightDictionnary[SET_ALLIANCE_PRISM] = 17;
         _rightDictionnary[TALK_IN_ALLIANCE_CHANNEL] = 18;
      }
   }
}
