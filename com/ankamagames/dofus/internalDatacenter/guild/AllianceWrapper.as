package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceVersatileInformations;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsMessage;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.network.enums.AllianceRightsBitEnum;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AllianceWrapper extends Object implements IDataCenter
   {
      
      public function AllianceWrapper()
      {
         this.guilds = new Vector.<GuildFactSheetWrapper>();
         this.prismIds = new Vector.<uint>();
         super();
      }
      
      public static const IS_BOSS:String = "isBoss";
      
      public static const allianceRights:Array = new Array(IS_BOSS);
      
      public static var _rightDictionnary:Dictionary = new Dictionary();
      
      private static var _ref:Dictionary = new Dictionary();
      
      public static function getAllianceById(param1:int) : AllianceWrapper
      {
         return _ref[param1];
      }
      
      public static function clearCache() : void
      {
         _ref = new Dictionary();
         GuildWrapper.clearCache();
      }
      
      public static function getFromNetwork(param1:*) : AllianceWrapper
      {
         if(param1 is BasicAllianceInformations)
         {
            return getFromBasicAllianceInformations(BasicAllianceInformations(param1));
         }
         if(param1 is AllianceVersatileInformations)
         {
            return getFromAllianceVersatileInformations(AllianceVersatileInformations(param1));
         }
         if(param1 is AllianceFactsMessage)
         {
            return getFromAllianceFactsMessage(AllianceFactsMessage(param1));
         }
         return null;
      }
      
      public static function updateRef(param1:uint, param2:AllianceWrapper) : void
      {
         _ref[param1] = param2;
      }
      
      private static function getFromAllianceFactsMessage(param1:AllianceFactsMessage) : AllianceWrapper
      {
         var _loc2_:AllianceWrapper = getFromBasicAllianceInformations(param1.infos);
         if((param1.guilds) && param1.guilds.length > 0)
         {
            _loc2_.leaderGuildId = param1.guilds[0].guildId;
            if((SocialFrame.getInstance().hasGuild) && SocialFrame.getInstance().guild.guildId == param1.guilds[0].guildId && (SocialFrame.getInstance().guild.hasRight("isBoss")))
            {
               _loc2_._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         _loc2_.nbGuilds = param1.guilds.length;
         _loc2_.nbMembers = 0;
         _loc2_.enabled = false;
         _loc2_.guilds.length = 0;
         _loc2_.leaderCharacterId = param1.leaderCharacterId;
         _loc2_.leaderCharacterName = param1.leaderCharacterName;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.guilds.length)
         {
            _loc2_.nbMembers = _loc2_.nbMembers + param1.guilds[_loc3_].nbMembers;
            _loc2_.enabled = (_loc2_.enabled) || (param1.guilds[_loc3_].enabled);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function getFromAllianceVersatileInformations(param1:AllianceVersatileInformations) : AllianceWrapper
      {
         var _loc2_:AllianceWrapper = null;
         if(_ref[param1.allianceId])
         {
            _loc2_ = _ref[param1.allianceId];
         }
         else
         {
            _loc2_ = new AllianceWrapper();
            _ref[param1.allianceId] = _loc2_;
         }
         _loc2_.allianceId = param1.allianceId;
         _loc2_.nbMembers = param1.nbMembers;
         _loc2_.nbGuilds = param1.nbGuilds;
         _loc2_.nbSubareas = param1.nbSubarea;
         return _loc2_;
      }
      
      private static function getFromBasicAllianceInformations(param1:BasicAllianceInformations) : AllianceWrapper
      {
         var _loc2_:AllianceWrapper = null;
         var _loc3_:GuildEmblem = null;
         if(_ref[param1.allianceId])
         {
            _loc2_ = _ref[param1.allianceId];
         }
         else
         {
            _loc2_ = new AllianceWrapper();
            _ref[param1.allianceId] = _loc2_;
         }
         _loc2_.allianceId = param1.allianceId;
         _loc2_._allianceTag = param1.allianceTag;
         if(param1 is BasicNamedAllianceInformations)
         {
            _loc2_._allianceName = BasicNamedAllianceInformations(param1).allianceName;
         }
         if(param1 is AllianceInformations)
         {
            _loc3_ = AllianceInformations(param1).allianceEmblem;
            _loc2_.upEmblem = EmblemWrapper.fromNetwork(_loc3_,false);
            _loc2_.backEmblem = EmblemWrapper.fromNetwork(_loc3_,true);
         }
         if(param1 is AllianceFactSheetInformations)
         {
            _loc2_.creationDate = AllianceFactSheetInformations(param1).creationDate;
         }
         return _loc2_;
      }
      
      public static function create(param1:uint, param2:String, param3:String, param4:GuildEmblem, param5:Number = 0, param6:uint = 0, param7:uint = 0, param8:Vector.<GuildFactSheetWrapper> = null, param9:Vector.<uint> = null, param10:int = 0, param11:String = "") : AllianceWrapper
      {
         var _loc12_:AllianceWrapper = null;
         var _loc13_:GuildFactSheetWrapper = null;
         _loc12_ = new AllianceWrapper();
         _loc12_.allianceId = param1;
         _loc12_._allianceTag = param2;
         _loc12_._allianceName = param3;
         _loc12_.leaderCharacterId = param10;
         _loc12_.leaderCharacterName = param11;
         if(param4 != null)
         {
            _loc12_.upEmblem = EmblemWrapper.create(param4.symbolShape,EmblemWrapper.UP,param4.symbolColor);
            _loc12_.backEmblem = EmblemWrapper.create(param4.backgroundShape,EmblemWrapper.BACK,param4.backgroundColor);
         }
         _loc12_.creationDate = param5;
         _loc12_.nbGuilds = param6;
         _loc12_.nbMembers = param7;
         _loc12_.guilds = param8;
         if((param8) && param8.length > 0)
         {
            _loc12_.leaderGuildId = param8[0].guildId;
            if((SocialFrame.getInstance().hasGuild) && SocialFrame.getInstance().guild.guildId == param8[0].guildId && (SocialFrame.getInstance().guild.hasRight("isBoss")))
            {
               _loc12_._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         if(param9)
         {
            _loc12_.prismIds = param9;
         }
         _loc12_.enabled = false;
         for each(_loc13_ in param8)
         {
            if(_loc13_.enabled)
            {
               _loc12_.enabled = true;
               break;
            }
         }
         return _loc12_;
      }
      
      public static function getRightsNumber(param1:Array) : Number
      {
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:String = null;
         var _loc2_:Number = 0;
         for each(_loc3_ in allianceRights)
         {
            _loc4_ = false;
            for each(_loc5_ in param1)
            {
               if(_loc5_ == _loc3_)
               {
                  _loc2_ = _loc2_ | 1 << _rightDictionnary[_loc5_];
               }
            }
         }
         return _loc2_;
      }
      
      private var _allianceName:String;
      
      private var _allianceTag:String;
      
      public var allianceId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var enabled:Boolean;
      
      public var creationDate:uint;
      
      public var nbGuilds:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var nbSubareas:uint = 0;
      
      public var leaderGuildId:uint = 0;
      
      public var leaderCharacterId:uint = 0;
      
      public var leaderCharacterName:String = "";
      
      public var guilds:Vector.<GuildFactSheetWrapper>;
      
      public var prismIds:Vector.<uint>;
      
      private var _memberRightsNumber:uint;
      
      public function get allianceTag() : String
      {
         if(this._allianceTag == "#TAG#")
         {
            return I18n.getUiText("ui.alliance.noTag");
         }
         return this._allianceTag;
      }
      
      public function get realAllianceTag() : String
      {
         return this._allianceTag;
      }
      
      public function get allianceName() : String
      {
         if(this._allianceName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._allianceName;
      }
      
      public function get realAllianceName() : String
      {
         return this._allianceName;
      }
      
      public function set memberRightsNumber(param1:uint) : void
      {
         this._memberRightsNumber = param1;
      }
      
      public function get memberRightsNumber() : uint
      {
         return this._memberRightsNumber;
      }
      
      public function get memberRights() : Vector.<Boolean>
      {
         var _loc1_:Vector.<Boolean> = new Vector.<Boolean>();
         _loc1_.push(this.isBoss);
         return _loc1_;
      }
      
      public function get isBoss() : Boolean
      {
         return (1 & this._memberRightsNumber) > 0;
      }
      
      public function clone() : AllianceWrapper
      {
         var _loc1_:AllianceWrapper = create(this.allianceId,this.allianceTag,this.allianceName,null,this.creationDate,this.nbGuilds,this.nbMembers,this.guilds,this.prismIds,this.leaderCharacterId,this.leaderCharacterName);
         _loc1_.upEmblem = this.upEmblem;
         _loc1_.backEmblem = this.backEmblem;
         return _loc1_;
      }
      
      public function update(param1:uint, param2:String, param3:String, param4:GuildEmblem, param5:Number = 0, param6:uint = 0, param7:uint = 0, param8:Vector.<GuildFactSheetWrapper> = null, param9:Vector.<uint> = null, param10:int = 0, param11:String = "") : void
      {
         var _loc12_:GuildFactSheetWrapper = null;
         this.allianceId = param1;
         this._allianceTag = param2;
         this._allianceName = param3;
         this.leaderCharacterId = param10;
         this.leaderCharacterName = param11;
         this.upEmblem.update(param4.symbolShape,EmblemWrapper.UP,param4.symbolColor);
         this.backEmblem.update(param4.backgroundShape,EmblemWrapper.BACK,param4.backgroundColor);
         this.creationDate = param5;
         this.nbGuilds = param6;
         this.nbMembers = param7;
         this.guilds = param8;
         if((param8) && param8.length > 0)
         {
            this.leaderGuildId = param8[0].guildId;
            if((SocialFrame.getInstance().hasGuild) && SocialFrame.getInstance().guild.guildId == param8[0].guildId && (SocialFrame.getInstance().guild.hasRight("isBoss")))
            {
               this._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         if(param9)
         {
            this.prismIds = param9;
         }
         this.enabled = false;
         for each(_loc12_ in param8)
         {
            if(_loc12_.enabled)
            {
               this.enabled = true;
               break;
            }
         }
      }
      
      public function hasRight(param1:String) : Boolean
      {
         var _loc2_:* = false;
         switch(param1)
         {
            case IS_BOSS:
               _loc2_ = this.isBoss;
               break;
         }
         return _loc2_;
      }
      
      private function initDictionary() : void
      {
         _rightDictionnary[IS_BOSS] = 0;
      }
   }
}
