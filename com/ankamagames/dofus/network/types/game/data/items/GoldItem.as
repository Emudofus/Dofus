package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GoldItem extends Item implements INetworkType
   {
      
      public function GoldItem() {
         super();
      }
      
      public static const protocolId:uint = 123;
      
      public var sum:uint = 0;
      
      override public function getTypeId() : uint {
         return 123;
      }
      
      public function initGoldItem(sum:uint=0) : GoldItem {
         this.sum = sum;
         return this;
      }
      
      override public function reset() : void {
         this.sum = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GoldItem(output);
      }
      
      public function serializeAs_GoldItem(output:IDataOutput) : void {
         super.serializeAs_Item(output);
         if(this.sum < 0)
         {
            throw new Error("Forbidden value (" + this.sum + ") on element sum.");
         }
         else
         {
            output.writeInt(this.sum);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GoldItem(input);
      }
      
      public function deserializeAs_GoldItem(input:IDataInput) : void {
         super.deserialize(input);
         this.sum = input.readInt();
         if(this.sum < 0)
         {
            throw new Error("Forbidden value (" + this.sum + ") on element of GoldItem.sum.");
         }
         else
         {
            return;
         }
      }
   }
}
