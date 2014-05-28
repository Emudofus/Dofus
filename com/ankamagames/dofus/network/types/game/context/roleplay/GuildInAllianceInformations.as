package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GuildInAllianceInformations extends GuildInformations implements INetworkType
   {
      
      public function GuildInAllianceInformations() {
         super();
      }
      
      public static const protocolId:uint = 420;
      
      public var guildLevel:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var enabled:Boolean = false;
      
      override public function getTypeId() : uint {
         return 420;
      }
      
      public function initGuildInAllianceInformations(guildId:uint = 0, guildName:String = "", guildEmblem:GuildEmblem = null, guildLevel:uint = 0, nbMembers:uint = 0, enabled:Boolean = false) : GuildInAllianceInformations {
         super.initGuildInformations(guildId,guildName,guildEmblem);
         this.guildLevel = guildLevel;
         this.nbMembers = nbMembers;
         this.enabled = enabled;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.guildLevel = 0;
         this.nbMembers = 0;
         this.enabled = false;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildInAllianceInformations(output);
      }
      
      public function serializeAs_GuildInAllianceInformations(output:IDataOutput) : void {
         super.serializeAs_GuildInformations(output);
         if((this.guildLevel < 0) || (this.guildLevel > 65535))
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
         }
         else
         {
            output.writeShort(this.guildLevel);
            if((this.nbMembers < 0) || (this.nbMembers > 65535))
            {
               throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
            }
            else
            {
               output.writeShort(this.nbMembers);
               output.writeBoolean(this.enabled);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInAllianceInformations(input);
      }
      
      public function deserializeAs_GuildInAllianceInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.guildLevel = input.readUnsignedShort();
         if((this.guildLevel < 0) || (this.guildLevel > 65535))
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element of GuildInAllianceInformations.guildLevel.");
         }
         else
         {
            this.nbMembers = input.readUnsignedShort();
            if((this.nbMembers < 0) || (this.nbMembers > 65535))
            {
               throw new Error("Forbidden value (" + this.nbMembers + ") on element of GuildInAllianceInformations.nbMembers.");
            }
            else
            {
               this.enabled = input.readBoolean();
               return;
            }
         }
      }
   }
}
