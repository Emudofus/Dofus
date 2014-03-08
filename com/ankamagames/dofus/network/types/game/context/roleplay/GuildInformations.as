package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GuildInformations extends BasicGuildInformations implements INetworkType
   {
      
      public function GuildInformations() {
         this.guildEmblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 127;
      
      public var guildEmblem:GuildEmblem;
      
      override public function getTypeId() : uint {
         return 127;
      }
      
      public function initGuildInformations(param1:uint=0, param2:String="", param3:GuildEmblem=null) : GuildInformations {
         super.initBasicGuildInformations(param1,param2);
         this.guildEmblem = param3;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.guildEmblem = new GuildEmblem();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildInformations(param1);
      }
      
      public function serializeAs_GuildInformations(param1:IDataOutput) : void {
         super.serializeAs_BasicGuildInformations(param1);
         this.guildEmblem.serializeAs_GuildEmblem(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInformations(param1);
      }
      
      public function deserializeAs_GuildInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.guildEmblem = new GuildEmblem();
         this.guildEmblem.deserialize(param1);
      }
   }
}
