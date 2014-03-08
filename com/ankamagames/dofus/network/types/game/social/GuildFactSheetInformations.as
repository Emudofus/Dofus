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
      
      public function initGuildFactSheetInformations(param1:uint=0, param2:String="", param3:GuildEmblem=null, param4:uint=0, param5:uint=0, param6:uint=0) : GuildFactSheetInformations {
         super.initGuildInformations(param1,param2,param3);
         this.leaderId = param4;
         this.guildLevel = param5;
         this.nbMembers = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.leaderId = 0;
         this.guildLevel = 0;
         this.nbMembers = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildFactSheetInformations(param1);
      }
      
      public function serializeAs_GuildFactSheetInformations(param1:IDataOutput) : void {
         super.serializeAs_GuildInformations(param1);
         if(this.leaderId < 0)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
         }
         else
         {
            param1.writeInt(this.leaderId);
            if(this.guildLevel < 0 || this.guildLevel > 255)
            {
               throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
            }
            else
            {
               param1.writeByte(this.guildLevel);
               if(this.nbMembers < 0)
               {
                  throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
               }
               else
               {
                  param1.writeShort(this.nbMembers);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildFactSheetInformations(param1);
      }
      
      public function deserializeAs_GuildFactSheetInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.leaderId = param1.readInt();
         if(this.leaderId < 0)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element of GuildFactSheetInformations.leaderId.");
         }
         else
         {
            this.guildLevel = param1.readUnsignedByte();
            if(this.guildLevel < 0 || this.guildLevel > 255)
            {
               throw new Error("Forbidden value (" + this.guildLevel + ") on element of GuildFactSheetInformations.guildLevel.");
            }
            else
            {
               this.nbMembers = param1.readShort();
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
