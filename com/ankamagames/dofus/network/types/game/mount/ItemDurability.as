package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ItemDurability extends Object implements INetworkType
   {
      
      public function ItemDurability() {
         super();
      }
      
      public static const protocolId:uint = 168;
      
      public var durability:int = 0;
      
      public var durabilityMax:int = 0;
      
      public function getTypeId() : uint {
         return 168;
      }
      
      public function initItemDurability(durability:int=0, durabilityMax:int=0) : ItemDurability {
         this.durability = durability;
         this.durabilityMax = durabilityMax;
         return this;
      }
      
      public function reset() : void {
         this.durability = 0;
         this.durabilityMax = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ItemDurability(output);
      }
      
      public function serializeAs_ItemDurability(output:IDataOutput) : void {
         output.writeShort(this.durability);
         output.writeShort(this.durabilityMax);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ItemDurability(input);
      }
      
      public function deserializeAs_ItemDurability(input:IDataInput) : void {
         this.durability = input.readShort();
         this.durabilityMax = input.readShort();
      }
   }
}
