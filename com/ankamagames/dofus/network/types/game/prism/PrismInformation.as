package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PrismInformation extends Object implements INetworkType
   {
      
      public function PrismInformation() {
         super();
      }
      
      public static const protocolId:uint = 428;
      
      public var typeId:uint = 0;
      
      public var state:uint = 1;
      
      public var nextVulnerabilityDate:uint = 0;
      
      public var placementDate:uint = 0;
      
      public var rewardTokenCount:uint = 0;
      
      public function getTypeId() : uint {
         return 428;
      }
      
      public function initPrismInformation(typeId:uint = 0, state:uint = 1, nextVulnerabilityDate:uint = 0, placementDate:uint = 0, rewardTokenCount:uint = 0) : PrismInformation {
         this.typeId = typeId;
         this.state = state;
         this.nextVulnerabilityDate = nextVulnerabilityDate;
         this.placementDate = placementDate;
         this.rewardTokenCount = rewardTokenCount;
         return this;
      }
      
      public function reset() : void {
         this.typeId = 0;
         this.state = 1;
         this.nextVulnerabilityDate = 0;
         this.placementDate = 0;
         this.rewardTokenCount = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PrismInformation(output);
      }
      
      public function serializeAs_PrismInformation(output:IDataOutput) : void {
         if(this.typeId < 0)
         {
            throw new Error("Forbidden value (" + this.typeId + ") on element typeId.");
         }
         else
         {
            output.writeByte(this.typeId);
            output.writeByte(this.state);
            if(this.nextVulnerabilityDate < 0)
            {
               throw new Error("Forbidden value (" + this.nextVulnerabilityDate + ") on element nextVulnerabilityDate.");
            }
            else
            {
               output.writeInt(this.nextVulnerabilityDate);
               if(this.placementDate < 0)
               {
                  throw new Error("Forbidden value (" + this.placementDate + ") on element placementDate.");
               }
               else
               {
                  output.writeInt(this.placementDate);
                  if(this.rewardTokenCount < 0)
                  {
                     throw new Error("Forbidden value (" + this.rewardTokenCount + ") on element rewardTokenCount.");
                  }
                  else
                  {
                     output.writeInt(this.rewardTokenCount);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismInformation(input);
      }
      
      public function deserializeAs_PrismInformation(input:IDataInput) : void {
         this.typeId = input.readByte();
         if(this.typeId < 0)
         {
            throw new Error("Forbidden value (" + this.typeId + ") on element of PrismInformation.typeId.");
         }
         else
         {
            this.state = input.readByte();
            if(this.state < 0)
            {
               throw new Error("Forbidden value (" + this.state + ") on element of PrismInformation.state.");
            }
            else
            {
               this.nextVulnerabilityDate = input.readInt();
               if(this.nextVulnerabilityDate < 0)
               {
                  throw new Error("Forbidden value (" + this.nextVulnerabilityDate + ") on element of PrismInformation.nextVulnerabilityDate.");
               }
               else
               {
                  this.placementDate = input.readInt();
                  if(this.placementDate < 0)
                  {
                     throw new Error("Forbidden value (" + this.placementDate + ") on element of PrismInformation.placementDate.");
                  }
                  else
                  {
                     this.rewardTokenCount = input.readInt();
                     if(this.rewardTokenCount < 0)
                     {
                        throw new Error("Forbidden value (" + this.rewardTokenCount + ") on element of PrismInformation.rewardTokenCount.");
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
}
