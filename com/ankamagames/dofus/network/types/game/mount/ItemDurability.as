package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ItemDurability extends Object implements INetworkType
   {
      
      public function ItemDurability()
      {
         super();
      }
      
      public static const protocolId:uint = 168;
      
      public var durability:int = 0;
      
      public var durabilityMax:int = 0;
      
      public function getTypeId() : uint
      {
         return 168;
      }
      
      public function initItemDurability(param1:int = 0, param2:int = 0) : ItemDurability
      {
         this.durability = param1;
         this.durabilityMax = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.durability = 0;
         this.durabilityMax = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ItemDurability(param1);
      }
      
      public function serializeAs_ItemDurability(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.durability);
         param1.writeShort(this.durabilityMax);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ItemDurability(param1);
      }
      
      public function deserializeAs_ItemDurability(param1:ICustomDataInput) : void
      {
         this.durability = param1.readShort();
         this.durabilityMax = param1.readShort();
      }
   }
}
