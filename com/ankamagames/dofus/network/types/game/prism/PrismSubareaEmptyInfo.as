package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PrismSubareaEmptyInfo extends Object implements INetworkType
   {
      
      public function PrismSubareaEmptyInfo()
      {
         super();
      }
      
      public static const protocolId:uint = 438;
      
      public var subAreaId:uint = 0;
      
      public var allianceId:uint = 0;
      
      public function getTypeId() : uint
      {
         return 438;
      }
      
      public function initPrismSubareaEmptyInfo(param1:uint = 0, param2:uint = 0) : PrismSubareaEmptyInfo
      {
         this.subAreaId = param1;
         this.allianceId = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.subAreaId = 0;
         this.allianceId = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PrismSubareaEmptyInfo(param1);
      }
      
      public function serializeAs_PrismSubareaEmptyInfo(param1:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeVarShort(this.subAreaId);
            if(this.allianceId < 0)
            {
               throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
            }
            else
            {
               param1.writeVarInt(this.allianceId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PrismSubareaEmptyInfo(param1);
      }
      
      public function deserializeAs_PrismSubareaEmptyInfo(param1:ICustomDataInput) : void
      {
         this.subAreaId = param1.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSubareaEmptyInfo.subAreaId.");
         }
         else
         {
            this.allianceId = param1.readVarUhInt();
            if(this.allianceId < 0)
            {
               throw new Error("Forbidden value (" + this.allianceId + ") on element of PrismSubareaEmptyInfo.allianceId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
