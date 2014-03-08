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
      
      public function initPrismInformation(param1:uint=0, param2:uint=1, param3:uint=0, param4:uint=0, param5:uint=0) : PrismInformation {
         this.typeId = param1;
         this.state = param2;
         this.nextVulnerabilityDate = param3;
         this.placementDate = param4;
         this.rewardTokenCount = param5;
         return this;
      }
      
      public function reset() : void {
         this.typeId = 0;
         this.state = 1;
         this.nextVulnerabilityDate = 0;
         this.placementDate = 0;
         this.rewardTokenCount = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PrismInformation(param1);
      }
      
      public function serializeAs_PrismInformation(param1:IDataOutput) : void {
         if(this.typeId < 0)
         {
            throw new Error("Forbidden value (" + this.typeId + ") on element typeId.");
         }
         else
         {
            param1.writeByte(this.typeId);
            param1.writeByte(this.state);
            if(this.nextVulnerabilityDate < 0)
            {
               throw new Error("Forbidden value (" + this.nextVulnerabilityDate + ") on element nextVulnerabilityDate.");
            }
            else
            {
               param1.writeInt(this.nextVulnerabilityDate);
               if(this.placementDate < 0)
               {
                  throw new Error("Forbidden value (" + this.placementDate + ") on element placementDate.");
               }
               else
               {
                  param1.writeInt(this.placementDate);
                  if(this.rewardTokenCount < 0)
                  {
                     throw new Error("Forbidden value (" + this.rewardTokenCount + ") on element rewardTokenCount.");
                  }
                  else
                  {
                     param1.writeInt(this.rewardTokenCount);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismInformation(param1);
      }
      
      public function deserializeAs_PrismInformation(param1:IDataInput) : void {
         this.typeId = param1.readByte();
         if(this.typeId < 0)
         {
            throw new Error("Forbidden value (" + this.typeId + ") on element of PrismInformation.typeId.");
         }
         else
         {
            this.state = param1.readByte();
            if(this.state < 0)
            {
               throw new Error("Forbidden value (" + this.state + ") on element of PrismInformation.state.");
            }
            else
            {
               this.nextVulnerabilityDate = param1.readInt();
               if(this.nextVulnerabilityDate < 0)
               {
                  throw new Error("Forbidden value (" + this.nextVulnerabilityDate + ") on element of PrismInformation.nextVulnerabilityDate.");
               }
               else
               {
                  this.placementDate = param1.readInt();
                  if(this.placementDate < 0)
                  {
                     throw new Error("Forbidden value (" + this.placementDate + ") on element of PrismInformation.placementDate.");
                  }
                  else
                  {
                     this.rewardTokenCount = param1.readInt();
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
