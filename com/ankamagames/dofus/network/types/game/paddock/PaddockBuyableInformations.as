package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PaddockBuyableInformations extends PaddockInformations implements INetworkType
   {
      
      public function PaddockBuyableInformations() {
         super();
      }
      
      public static const protocolId:uint = 130;
      
      public var price:uint = 0;
      
      public var locked:Boolean = false;
      
      override public function getTypeId() : uint {
         return 130;
      }
      
      public function initPaddockBuyableInformations(maxOutdoorMount:uint=0, maxItems:uint=0, price:uint=0, locked:Boolean=false) : PaddockBuyableInformations {
         super.initPaddockInformations(maxOutdoorMount,maxItems);
         this.price = price;
         this.locked = locked;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.price = 0;
         this.locked = false;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PaddockBuyableInformations(output);
      }
      
      public function serializeAs_PaddockBuyableInformations(output:IDataOutput) : void {
         super.serializeAs_PaddockInformations(output);
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         else
         {
            output.writeInt(this.price);
            output.writeBoolean(this.locked);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockBuyableInformations(input);
      }
      
      public function deserializeAs_PaddockBuyableInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.price = input.readInt();
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of PaddockBuyableInformations.price.");
         }
         else
         {
            this.locked = input.readBoolean();
            return;
         }
      }
   }
}
