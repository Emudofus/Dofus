package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class GuildFactSheetWrapper extends Object implements IDataCenter
   {
      
      public function GuildFactSheetWrapper()
      {
         this.members = new Vector.<CharacterMinimalInformations>();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildFactSheetWrapper));
      
      public static function create(param1:uint, param2:String, param3:GuildEmblem, param4:uint, param5:String, param6:uint, param7:uint, param8:Number, param9:Vector.<CharacterMinimalInformations>, param10:uint = 0, param11:uint = 0, param12:Number = 0, param13:Boolean = true, param14:uint = 0, param15:String = "", param16:String = "", param17:Boolean = false) : GuildFactSheetWrapper
      {
         var _loc19_:Date = null;
         var _loc18_:GuildFactSheetWrapper = new GuildFactSheetWrapper();
         _loc18_.guildId = param1;
         _loc18_._guildName = param2;
         if(param3 != null)
         {
            _loc18_.upEmblem = EmblemWrapper.create(param3.symbolShape,EmblemWrapper.UP,param3.symbolColor);
            _loc18_.backEmblem = EmblemWrapper.create(param3.backgroundShape,EmblemWrapper.BACK,param3.backgroundColor);
         }
         _loc18_.leaderId = param4;
         _loc18_.guildLevel = param6;
         _loc18_.nbMembers = param7;
         _loc18_.creationDate = param8;
         _loc18_.members = param9;
         _loc18_._leaderName = param5;
         _loc18_.allianceId = param14;
         _loc18_._allianceName = param15;
         _loc18_._allianceTag = param16;
         _loc18_.allianceLeader = param17;
         _loc18_.nbConnectedMembers = param10;
         _loc18_.nbTaxCollectors = param11;
         _loc18_.lastActivity = param12;
         if(param12 == 0)
         {
            _loc18_.hoursSinceLastConnection = 0;
         }
         else
         {
            _loc19_ = new Date();
            _loc18_.hoursSinceLastConnection = (_loc19_.time - param12 * 1000) / 3600000;
         }
         _loc18_.enabled = param13;
         return _loc18_;
      }
      
      private var _guildName:String;
      
      private var _leaderName:String = "";
      
      private var _allianceName:String;
      
      private var _allianceTag:String;
      
      public var guildId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var leaderId:uint = 0;
      
      public var guildLevel:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var creationDate:Number = 0;
      
      public var members:Vector.<CharacterMinimalInformations>;
      
      public var allianceId:uint = 0;
      
      public var allianceLeader:Boolean = false;
      
      public var nbConnectedMembers:uint = 0;
      
      public var nbTaxCollectors:uint = 0;
      
      public var lastActivity:Number = 0;
      
      public var enabled:Boolean = true;
      
      public var hoursSinceLastConnection:Number;
      
      public function get guildName() : String
      {
         if(this._guildName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._guildName;
      }
      
      public function get realGuildName() : String
      {
         return this._guildName;
      }
      
      public function get allianceName() : String
      {
         if(this._allianceName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._allianceName;
      }
      
      public function get allianceTag() : String
      {
         if(this._allianceTag == "#TAG#")
         {
            return I18n.getUiText("ui.alliance.noTag");
         }
         return this._allianceTag;
      }
      
      public function get leaderName() : String
      {
         if((this._leaderName == "") && (this.members) && this.members.length > 0)
         {
            return this.members[0].name;
         }
         return this._leaderName;
      }
      
      public function update(param1:uint, param2:String, param3:GuildEmblem, param4:uint, param5:String, param6:uint, param7:uint, param8:Number, param9:Vector.<CharacterMinimalInformations>, param10:uint = 0, param11:uint = 0, param12:Number = 0, param13:Boolean = true, param14:uint = 0, param15:String = "", param16:String = "", param17:Boolean = false) : void
      {
         var _loc18_:Date = null;
         this.guildId = param1;
         this._guildName = param2;
         this.upEmblem.update(param3.symbolShape,EmblemWrapper.UP,param3.symbolColor);
         this.backEmblem.update(param3.backgroundShape,EmblemWrapper.BACK,param3.backgroundColor);
         this.leaderId = param4;
         this.guildLevel = param6;
         this.nbMembers = param7;
         this.creationDate = param8;
         this.members = param9;
         this._leaderName = param5;
         this.allianceId = param14;
         this._allianceName = param15;
         this._allianceTag = param16;
         this.allianceLeader = param17;
         this.nbConnectedMembers = param10;
         this.nbTaxCollectors = param11;
         this.lastActivity = param12;
         if(param12 == 0)
         {
            this.hoursSinceLastConnection = 0;
         }
         else
         {
            _loc18_ = new Date();
            this.hoursSinceLastConnection = (_loc18_.time - param12 * 1000) / 3600000;
         }
         this.enabled = param13;
      }
   }
}
