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
      
      public function initAllianceVersatileInformations(allianceId:uint=0, nbGuilds:uint=0, nbMembers:uint=0, nbSubarea:uint=0) : AllianceVersatileInformations {
         this.allianceId = allianceId;
         this.nbGuilds = nbGuilds;
         this.nbMembers = nbMembers;
         this.nbSubarea = nbSubarea;
         return this;
      }
      
      public function reset() : void {
         this.allianceId = 0;
         this.nbGuilds = 0;
         this.nbMembers = 0;
         this.nbSubarea = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AllianceVersatileInformations(output);
      }
      
      public function serializeAs_AllianceVersatileInformations(output:IDataOutput) : void {
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         else
         {
            output.writeInt(this.allianceId);
            if(this.nbGuilds < 0)
            {
               throw new Error("Forbidden value (" + this.nbGuilds + ") on element nbGuilds.");
            }
            else
            {
               output.writeShort(this.nbGuilds);
               if(this.nbMembers < 0)
               {
                  throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
               }
               else
               {
                  output.writeShort(this.nbMembers);
                  if(this.nbSubarea < 0)
                  {
                     throw new Error("Forbidden value (" + this.nbSubarea + ") on element nbSubarea.");
                  }
                  else
                  {
                     output.writeShort(this.nbSubarea);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceVersatileInformations(input);
      }
      
      public function deserializeAs_AllianceVersatileInformations(input:IDataInput) : void {
         this.allianceId = input.readInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of AllianceVersatileInformations.allianceId.");
         }
         else
         {
            this.nbGuilds = input.readShort();
            if(this.nbGuilds < 0)
            {
               throw new Error("Forbidden value (" + this.nbGuilds + ") on element of AllianceVersatileInformations.nbGuilds.");
            }
            else
            {
               this.nbMembers = input.readShort();
               if(this.nbMembers < 0)
               {
                  throw new Error("Forbidden value (" + this.nbMembers + ") on element of AllianceVersatileInformations.nbMembers.");
               }
               else
               {
                  this.nbSubarea = input.readShort();
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
