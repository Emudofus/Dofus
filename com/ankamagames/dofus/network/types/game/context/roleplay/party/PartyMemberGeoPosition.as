package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PartyMemberGeoPosition extends Object implements INetworkType
   {
      
      public function PartyMemberGeoPosition() {
         super();
      }
      
      public static const protocolId:uint = 378;
      
      public var memberId:uint = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public function getTypeId() : uint {
         return 378;
      }
      
      public function initPartyMemberGeoPosition(memberId:uint=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0) : PartyMemberGeoPosition {
         this.memberId = memberId;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         return this;
      }
      
      public function reset() : void {
         this.memberId = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyMemberGeoPosition(output);
      }
      
      public function serializeAs_PartyMemberGeoPosition(output:IDataOutput) : void {
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         else
         {
            output.writeInt(this.memberId);
            if((this.worldX < -255) || (this.worldX > 255))
            {
               throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
            }
            else
            {
               output.writeShort(this.worldX);
               if((this.worldY < -255) || (this.worldY > 255))
               {
                  throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
               }
               else
               {
                  output.writeShort(this.worldY);
                  output.writeInt(this.mapId);
                  if(this.subAreaId < 0)
                  {
                     throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                  }
                  else
                  {
                     output.writeShort(this.subAreaId);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyMemberGeoPosition(input);
      }
      
      public function deserializeAs_PartyMemberGeoPosition(input:IDataInput) : void {
         this.memberId = input.readInt();
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of PartyMemberGeoPosition.memberId.");
         }
         else
         {
            this.worldX = input.readShort();
            if((this.worldX < -255) || (this.worldX > 255))
            {
               throw new Error("Forbidden value (" + this.worldX + ") on element of PartyMemberGeoPosition.worldX.");
            }
            else
            {
               this.worldY = input.readShort();
               if((this.worldY < -255) || (this.worldY > 255))
               {
                  throw new Error("Forbidden value (" + this.worldY + ") on element of PartyMemberGeoPosition.worldY.");
               }
               else
               {
                  this.mapId = input.readInt();
                  this.subAreaId = input.readShort();
                  if(this.subAreaId < 0)
                  {
                     throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyMemberGeoPosition.subAreaId.");
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
