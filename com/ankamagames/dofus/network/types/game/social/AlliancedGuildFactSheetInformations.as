package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AlliancedGuildFactSheetInformations extends GuildInformations implements INetworkType
   {
      
      public function AlliancedGuildFactSheetInformations() {
         this.allianceInfos = new BasicNamedAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 422;
      
      public var allianceInfos:BasicNamedAllianceInformations;
      
      override public function getTypeId() : uint {
         return 422;
      }
      
      public function initAlliancedGuildFactSheetInformations(guildId:uint=0, guildName:String="", guildEmblem:GuildEmblem=null, allianceInfos:BasicNamedAllianceInformations=null) : AlliancedGuildFactSheetInformations {
         super.initGuildInformations(guildId,guildName,guildEmblem);
         this.allianceInfos = allianceInfos;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceInfos = new BasicNamedAllianceInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_AlliancedGuildFactSheetInformations(output);
      }
      
      public function serializeAs_AlliancedGuildFactSheetInformations(output:IDataOutput) : void {
         super.serializeAs_GuildInformations(output);
         this.allianceInfos.serializeAs_BasicNamedAllianceInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlliancedGuildFactSheetInformations(input);
      }
      
      public function deserializeAs_AlliancedGuildFactSheetInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.allianceInfos = new BasicNamedAllianceInformations();
         this.allianceInfos.deserialize(input);
      }
   }
}
