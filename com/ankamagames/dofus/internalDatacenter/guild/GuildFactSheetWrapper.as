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
      
      public function GuildFactSheetWrapper() {
         this.members = new Vector.<CharacterMinimalInformations>();
         super();
      }
      
      protected static const _log:Logger;
      
      public static function create(guildId:uint, guildName:String, guildEmblem:GuildEmblem, leaderId:uint, leaderName:String, guildLevel:uint, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalInformations>, nbConnectedMembers:uint = 0, nbTaxCollectors:uint = 0, lastActivity:Number = 0, enabled:Boolean = true, allianceId:uint = 0, allianceName:String = "", allianceLeader:Boolean = false) : GuildFactSheetWrapper {
         var nowDate:Date = null;
         var item:GuildFactSheetWrapper = new GuildFactSheetWrapper();
         item.guildId = guildId;
         item._guildName = guildName;
         if(guildEmblem != null)
         {
            item.upEmblem = EmblemWrapper.create(guildEmblem.symbolShape,EmblemWrapper.UP,guildEmblem.symbolColor);
            item.backEmblem = EmblemWrapper.create(guildEmblem.backgroundShape,EmblemWrapper.BACK,guildEmblem.backgroundColor);
         }
         item.leaderId = leaderId;
         item.guildLevel = guildLevel;
         item.nbMembers = nbMembers;
         item.creationDate = creationDate;
         item.members = members;
         item._leaderName = leaderName;
         item.allianceId = allianceId;
         item._allianceName = allianceName;
         item.allianceLeader = allianceLeader;
         item.nbConnectedMembers = nbConnectedMembers;
         item.nbTaxCollectors = nbTaxCollectors;
         item.lastActivity = lastActivity;
         if(lastActivity == 0)
         {
            item.hoursSinceLastConnection = 0;
         }
         else
         {
            nowDate = new Date();
            item.hoursSinceLastConnection = (nowDate.time - lastActivity * 1000) / 3600000;
         }
         item.enabled = enabled;
         return item;
      }
      
      private var _guildName:String;
      
      private var _leaderName:String = "";
      
      private var _allianceName:String;
      
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
      
      public function get allianceName() : String {
         if(this._allianceName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._allianceName;
      }
      
      public function get leaderName() : String {
         if((this._leaderName == "") && (this.members) && (this.members.length > 0))
         {
            return this.members[0].name;
         }
         return this._leaderName;
      }
      
      public function update(guildId:uint, guildName:String, guildEmblem:GuildEmblem, leaderId:uint, leaderName:String, guildLevel:uint, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalInformations>, nbConnectedMembers:uint = 0, nbTaxCollectors:uint = 0, lastActivity:Number = 0, enabled:Boolean = true, allianceId:uint = 0, allianceName:String = "", allianceLeader:Boolean = false) : void {
         var nowDate:Date = null;
         this.guildId = guildId;
         this._guildName = guildName;
         this.upEmblem.update(guildEmblem.symbolShape,EmblemWrapper.UP,guildEmblem.symbolColor);
         this.backEmblem.update(guildEmblem.backgroundShape,EmblemWrapper.BACK,guildEmblem.backgroundColor);
         this.leaderId = leaderId;
         this.guildLevel = guildLevel;
         this.nbMembers = nbMembers;
         this.creationDate = creationDate;
         this.members = members;
         this._leaderName = leaderName;
         this.allianceId = allianceId;
         this._allianceName = allianceName;
         this.allianceLeader = allianceLeader;
         this.nbConnectedMembers = nbConnectedMembers;
         this.nbTaxCollectors = nbTaxCollectors;
         this.lastActivity = lastActivity;
         if(lastActivity == 0)
         {
            this.hoursSinceLastConnection = 0;
         }
         else
         {
            nowDate = new Date();
            this.hoursSinceLastConnection = (nowDate.time - lastActivity * 1000) / 3600000;
         }
         this.enabled = enabled;
      }
   }
}
