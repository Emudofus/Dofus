package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HumanOptionGuild extends HumanOption implements INetworkType
   {
      
      public function HumanOptionGuild() {
         this.guildInformations = new GuildInformations();
         super();
      }
      
      public static const protocolId:uint = 409;
      
      public var guildInformations:GuildInformations;
      
      override public function getTypeId() : uint {
         return 409;
      }
      
      public function initHumanOptionGuild(guildInformations:GuildInformations = null) : HumanOptionGuild {
         this.guildInformations = guildInformations;
         return this;
      }
      
      override public function reset() : void {
         this.guildInformations = new GuildInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_HumanOptionGuild(output);
      }
      
      public function serializeAs_HumanOptionGuild(output:IDataOutput) : void {
         super.serializeAs_HumanOption(output);
         this.guildInformations.serializeAs_GuildInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HumanOptionGuild(input);
      }
      
      public function deserializeAs_HumanOptionGuild(input:IDataInput) : void {
         super.deserialize(input);
         this.guildInformations = new GuildInformations();
         this.guildInformations.deserialize(input);
      }
   }
}
