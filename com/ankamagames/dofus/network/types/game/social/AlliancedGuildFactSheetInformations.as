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
      
      public function initAlliancedGuildFactSheetInformations(param1:uint=0, param2:String="", param3:GuildEmblem=null, param4:BasicNamedAllianceInformations=null) : AlliancedGuildFactSheetInformations {
         super.initGuildInformations(param1,param2,param3);
         this.allianceInfos = param4;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceInfos = new BasicNamedAllianceInformations();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AlliancedGuildFactSheetInformations(param1);
      }
      
      public function serializeAs_AlliancedGuildFactSheetInformations(param1:IDataOutput) : void {
         super.serializeAs_GuildInformations(param1);
         this.allianceInfos.serializeAs_BasicNamedAllianceInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AlliancedGuildFactSheetInformations(param1);
      }
      
      public function deserializeAs_AlliancedGuildFactSheetInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.allianceInfos = new BasicNamedAllianceInformations();
         this.allianceInfos.deserialize(param1);
      }
   }
}
