package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GuildInsiderFactSheetInformations extends GuildFactSheetInformations implements INetworkType
   {
      
      public function GuildInsiderFactSheetInformations() {
         super();
      }
      
      public static const protocolId:uint = 423;
      
      public var leaderName:String = "";
      
      public var nbConnectedMembers:uint = 0;
      
      public var nbTaxCollectors:uint = 0;
      
      public var lastActivity:uint = 0;
      
      public var enabled:Boolean = false;
      
      override public function getTypeId() : uint {
         return 423;
      }
      
      public function initGuildInsiderFactSheetInformations(guildId:uint=0, guildName:String="", guildEmblem:GuildEmblem=null, leaderId:uint=0, guildLevel:uint=0, nbMembers:uint=0, leaderName:String="", nbConnectedMembers:uint=0, nbTaxCollectors:uint=0, lastActivity:uint=0, enabled:Boolean=false) : GuildInsiderFactSheetInformations {
         super.initGuildFactSheetInformations(guildId,guildName,guildEmblem,leaderId,guildLevel,nbMembers);
         this.leaderName = leaderName;
         this.nbConnectedMembers = nbConnectedMembers;
         this.nbTaxCollectors = nbTaxCollectors;
         this.lastActivity = lastActivity;
         this.enabled = enabled;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.leaderName = "";
         this.nbConnectedMembers = 0;
         this.nbTaxCollectors = 0;
         this.lastActivity = 0;
         this.enabled = false;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildInsiderFactSheetInformations(output);
      }
      
      public function serializeAs_GuildInsiderFactSheetInformations(output:IDataOutput) : void {
         super.serializeAs_GuildFactSheetInformations(output);
         output.writeUTF(this.leaderName);
         if(this.nbConnectedMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element nbConnectedMembers.");
         }
         else
         {
            output.writeShort(this.nbConnectedMembers);
            if(this.nbTaxCollectors < 0)
            {
               throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element nbTaxCollectors.");
            }
            else
            {
               output.writeByte(this.nbTaxCollectors);
               if(this.lastActivity < 0)
               {
                  throw new Error("Forbidden value (" + this.lastActivity + ") on element lastActivity.");
               }
               else
               {
                  output.writeInt(this.lastActivity);
                  output.writeBoolean(this.enabled);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInsiderFactSheetInformations(input);
      }
      
      public function deserializeAs_GuildInsiderFactSheetInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.leaderName = input.readUTF();
         this.nbConnectedMembers = input.readShort();
         if(this.nbConnectedMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element of GuildInsiderFactSheetInformations.nbConnectedMembers.");
         }
         else
         {
            this.nbTaxCollectors = input.readByte();
            if(this.nbTaxCollectors < 0)
            {
               throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element of GuildInsiderFactSheetInformations.nbTaxCollectors.");
            }
            else
            {
               this.lastActivity = input.readInt();
               if(this.lastActivity < 0)
               {
                  throw new Error("Forbidden value (" + this.lastActivity + ") on element of GuildInsiderFactSheetInformations.lastActivity.");
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
}
