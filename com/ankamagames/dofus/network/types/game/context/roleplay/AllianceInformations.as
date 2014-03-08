package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AllianceInformations extends BasicNamedAllianceInformations implements INetworkType
   {
      
      public function AllianceInformations() {
         this.allianceEmblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 417;
      
      public var allianceEmblem:GuildEmblem;
      
      override public function getTypeId() : uint {
         return 417;
      }
      
      public function initAllianceInformations(param1:uint=0, param2:String="", param3:String="", param4:GuildEmblem=null) : AllianceInformations {
         super.initBasicNamedAllianceInformations(param1,param2,param3);
         this.allianceEmblem = param4;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceEmblem = new GuildEmblem();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AllianceInformations(param1);
      }
      
      public function serializeAs_AllianceInformations(param1:IDataOutput) : void {
         super.serializeAs_BasicNamedAllianceInformations(param1);
         this.allianceEmblem.serializeAs_GuildEmblem(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceInformations(param1);
      }
      
      public function deserializeAs_AllianceInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.allianceEmblem = new GuildEmblem();
         this.allianceEmblem.deserialize(param1);
      }
   }
}
