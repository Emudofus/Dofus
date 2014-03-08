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
      
      public function initPaddockBuyableInformations(param1:uint=0, param2:uint=0, param3:uint=0, param4:Boolean=false) : PaddockBuyableInformations {
         super.initPaddockInformations(param1,param2);
         this.price = param3;
         this.locked = param4;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.price = 0;
         this.locked = false;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PaddockBuyableInformations(param1);
      }
      
      public function serializeAs_PaddockBuyableInformations(param1:IDataOutput) : void {
         super.serializeAs_PaddockInformations(param1);
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         else
         {
            param1.writeInt(this.price);
            param1.writeBoolean(this.locked);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PaddockBuyableInformations(param1);
      }
      
      public function deserializeAs_PaddockBuyableInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.price = param1.readInt();
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of PaddockBuyableInformations.price.");
         }
         else
         {
            this.locked = param1.readBoolean();
            return;
         }
      }
   }
}
