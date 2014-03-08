package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AllianceVersatileInformations extends Object implements INetworkType
   {
      
      public function AllianceVersatileInformations() {
         super();
      }
      
      public static const protocolId:uint = 432;
      
      public var allianceId:uint = 0;
      
      public var nbGuilds:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var nbSubarea:uint = 0;
      
      public function getTypeId() : uint {
         return 432;
      }
      
      public function initAllianceVersatileInformations(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0) : AllianceVersatileInformations {
         this.allianceId = param1;
         this.nbGuilds = param2;
         this.nbMembers = param3;
         this.nbSubarea = param4;
         return this;
      }
      
      public function reset() : void {
         this.allianceId = 0;
         this.nbGuilds = 0;
         this.nbMembers = 0;
         this.nbSubarea = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AllianceVersatileInformations(param1);
      }
      
      public function serializeAs_AllianceVersatileInformations(param1:IDataOutput) : void {
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         else
         {
            param1.writeInt(this.allianceId);
            if(this.nbGuilds < 0)
            {
               throw new Error("Forbidden value (" + this.nbGuilds + ") on element nbGuilds.");
            }
            else
            {
               param1.writeShort(this.nbGuilds);
               if(this.nbMembers < 0)
               {
                  throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
               }
               else
               {
                  param1.writeShort(this.nbMembers);
                  if(this.nbSubarea < 0)
                  {
                     throw new Error("Forbidden value (" + this.nbSubarea + ") on element nbSubarea.");
                  }
                  else
                  {
                     param1.writeShort(this.nbSubarea);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceVersatileInformations(param1);
      }
      
      public function deserializeAs_AllianceVersatileInformations(param1:IDataInput) : void {
         this.allianceId = param1.readInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of AllianceVersatileInformations.allianceId.");
         }
         else
         {
            this.nbGuilds = param1.readShort();
            if(this.nbGuilds < 0)
            {
               throw new Error("Forbidden value (" + this.nbGuilds + ") on element of AllianceVersatileInformations.nbGuilds.");
            }
            else
            {
               this.nbMembers = param1.readShort();
               if(this.nbMembers < 0)
               {
                  throw new Error("Forbidden value (" + this.nbMembers + ") on element of AllianceVersatileInformations.nbMembers.");
               }
               else
               {
                  this.nbSubarea = param1.readShort();
                  if(this.nbSubarea < 0)
                  {
                     throw new Error("Forbidden value (" + this.nbSubarea + ") on element of AllianceVersatileInformations.nbSubarea.");
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
}
