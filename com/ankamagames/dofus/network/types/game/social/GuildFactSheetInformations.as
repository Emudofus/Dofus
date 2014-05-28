package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GuildFactSheetInformations extends GuildInformations implements INetworkType
   {
      
      public function GuildFactSheetInformations() {
         super();
      }
      
      public static const protocolId:uint = 424;
      
      public var leaderId:uint = 0;
      
      public var guildLevel:uint = 0;
      
      public var nbMembers:uint = 0;
      
      override public function getTypeId() : uint {
         return 424;
      }
      
      public function initGuildFactSheetInformations(guildId:uint = 0, guildName:String = "", guildEmblem:GuildEmblem = null, leaderId:uint = 0, guildLevel:uint = 0, nbMembers:uint = 0) : GuildFactSheetInformations {
         super.initGuildInformations(guildId,guildName,guildEmblem);
         this.leaderId = leaderId;
         this.guildLevel = guildLevel;
         this.nbMembers = nbMembers;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.leaderId = 0;
         this.guildLevel = 0;
         this.nbMembers = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildFactSheetInformations(output);
      }
      
      public function serializeAs_GuildFactSheetInformations(output:IDataOutput) : void {
         super.serializeAs_GuildInformations(output);
         if(this.leaderId < 0)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
         }
         else
         {
            output.writeInt(this.leaderId);
            if((this.guildLevel < 0) || (this.guildLevel > 255))
            {
               throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
            }
            else
            {
               output.writeByte(this.guildLevel);
               if(this.nbMembers < 0)
               {
                  throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
               }
               else
               {
                  output.writeShort(this.nbMembers);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFactSheetInformations(input);
      }
      
      public function deserializeAs_GuildFactSheetInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.leaderId = input.readInt();
         if(this.leaderId < 0)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element of GuildFactSheetInformations.leaderId.");
         }
         else
         {
            this.guildLevel = input.readUnsignedByte();
            if((this.guildLevel < 0) || (this.guildLevel > 255))
            {
               throw new Error("Forbidden value (" + this.guildLevel + ") on element of GuildFactSheetInformations.guildLevel.");
            }
            else
            {
               this.nbMembers = input.readShort();
               if(this.nbMembers < 0)
               {
                  throw new Error("Forbidden value (" + this.nbMembers + ") on element of GuildFactSheetInformations.nbMembers.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
