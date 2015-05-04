package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GoldItem extends Item implements INetworkType
   {
      
      public function GoldItem()
      {
         super();
      }
      
      public static const protocolId:uint = 123;
      
      public var sum:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 123;
      }
      
      public function initGoldItem(param1:uint = 0) : GoldItem
      {
         this.sum = param1;
         return this;
      }
      
      override public function reset() : void
      {
         this.sum = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GoldItem(param1);
      }
      
      public function serializeAs_GoldItem(param1:ICustomDataOutput) : void
      {
         super.serializeAs_Item(param1);
         if(this.sum < 0)
         {
            throw new Error("Forbidden value (" + this.sum + ") on element sum.");
         }
         else
         {
            param1.writeVarInt(this.sum);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GoldItem(param1);
      }
      
      public function deserializeAs_GoldItem(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.sum = param1.readVarUhInt();
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
