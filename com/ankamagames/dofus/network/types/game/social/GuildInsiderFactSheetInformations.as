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
      
      public function initGuildInsiderFactSheetInformations(param1:uint=0, param2:String="", param3:GuildEmblem=null, param4:uint=0, param5:uint=0, param6:uint=0, param7:String="", param8:uint=0, param9:uint=0, param10:uint=0, param11:Boolean=false) : GuildInsiderFactSheetInformations {
         super.initGuildFactSheetInformations(param1,param2,param3,param4,param5,param6);
         this.leaderName = param7;
         this.nbConnectedMembers = param8;
         this.nbTaxCollectors = param9;
         this.lastActivity = param10;
         this.enabled = param11;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildInsiderFactSheetInformations(param1);
      }
      
      public function serializeAs_GuildInsiderFactSheetInformations(param1:IDataOutput) : void {
         super.serializeAs_GuildFactSheetInformations(param1);
         param1.writeUTF(this.leaderName);
         if(this.nbConnectedMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element nbConnectedMembers.");
         }
         else
         {
            param1.writeShort(this.nbConnectedMembers);
            if(this.nbTaxCollectors < 0)
            {
               throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element nbTaxCollectors.");
            }
            else
            {
               param1.writeByte(this.nbTaxCollectors);
               if(this.lastActivity < 0)
               {
                  throw new Error("Forbidden value (" + this.lastActivity + ") on element lastActivity.");
               }
               else
               {
                  param1.writeInt(this.lastActivity);
                  param1.writeBoolean(this.enabled);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInsiderFactSheetInformations(param1);
      }
      
      public function deserializeAs_GuildInsiderFactSheetInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.leaderName = param1.readUTF();
         this.nbConnectedMembers = param1.readShort();
         if(this.nbConnectedMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element of GuildInsiderFactSheetInformations.nbConnectedMembers.");
         }
         else
         {
            this.nbTaxCollectors = param1.readByte();
            if(this.nbTaxCollectors < 0)
            {
               throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element of GuildInsiderFactSheetInformations.nbTaxCollectors.");
            }
            else
            {
               this.lastActivity = param1.readInt();
               if(this.lastActivity < 0)
               {
                  throw new Error("Forbidden value (" + this.lastActivity + ") on element of GuildInsiderFactSheetInformations.lastActivity.");
               }
               else
               {
                  this.enabled = param1.readBoolean();
                  return;
               }
            }
         }
      }
   }
}
