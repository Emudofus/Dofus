package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TaxCollectorLootInformations extends TaxCollectorComplementaryInformations implements INetworkType
   {
      
      public function TaxCollectorLootInformations() {
         super();
      }
      
      public static const protocolId:uint = 372;
      
      public var kamas:uint = 0;
      
      public var experience:Number = 0;
      
      public var pods:uint = 0;
      
      public var itemsValue:uint = 0;
      
      override public function getTypeId() : uint {
         return 372;
      }
      
      public function initTaxCollectorLootInformations(kamas:uint = 0, experience:Number = 0, pods:uint = 0, itemsValue:uint = 0) : TaxCollectorLootInformations {
         this.kamas = kamas;
         this.experience = experience;
         this.pods = pods;
         this.itemsValue = itemsValue;
         return this;
      }
      
      override public function reset() : void {
         this.kamas = 0;
         this.experience = 0;
         this.pods = 0;
         this.itemsValue = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_TaxCollectorLootInformations(output);
      }
      
      public function serializeAs_TaxCollectorLootInformations(output:IDataOutput) : void {
         super.serializeAs_TaxCollectorComplementaryInformations(output);
         if(this.kamas < 0)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         else
         {
            output.writeInt(this.kamas);
            if(this.experience < 0)
            {
               throw new Error("Forbidden value (" + this.experience + ") on element experience.");
            }
            else
            {
               output.writeDouble(this.experience);
               if(this.pods < 0)
               {
                  throw new Error("Forbidden value (" + this.pods + ") on element pods.");
               }
               else
               {
                  output.writeInt(this.pods);
                  if(this.itemsValue < 0)
                  {
                     throw new Error("Forbidden value (" + this.itemsValue + ") on element itemsValue.");
                  }
                  else
                  {
                     output.writeInt(this.itemsValue);
                     return;
                  }
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorLootInformations(input);
      }
      
      public function deserializeAs_TaxCollectorLootInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.kamas = input.readInt();
         if(this.kamas < 0)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of TaxCollectorLootInformations.kamas.");
         }
         else
         {
            this.experience = input.readDouble();
            if(this.experience < 0)
            {
               throw new Error("Forbidden value (" + this.experience + ") on element of TaxCollectorLootInformations.experience.");
            }
            else
            {
               this.pods = input.readInt();
               if(this.pods < 0)
               {
                  throw new Error("Forbidden value (" + this.pods + ") on element of TaxCollectorLootInformations.pods.");
               }
               else
               {
                  this.itemsValue = input.readInt();
                  if(this.itemsValue < 0)
                  {
                     throw new Error("Forbidden value (" + this.itemsValue + ") on element of TaxCollectorLootInformations.itemsValue.");
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
