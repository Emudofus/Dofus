package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class Item extends Object implements INetworkType
   {
      
      public function Item() {
         super();
      }
      
      public static const protocolId:uint = 7;
      
      public function getTypeId() : uint {
         return 7;
      }
      
      public function initItem() : Item {
         return this;
      }
      
      public function reset() : void {
      }
      
      public function serialize(output:IDataOutput) : void {
      }
      
      public function serializeAs_Item(output:IDataOutput) : void {
      }
      
      public function deserialize(input:IDataInput) : void {
      }
      
      public function deserializeAs_Item(input:IDataInput) : void {
      }
   }
}
