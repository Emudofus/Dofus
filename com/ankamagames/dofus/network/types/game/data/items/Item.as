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
      
      public function serialize(param1:IDataOutput) : void {
      }
      
      public function serializeAs_Item(param1:IDataOutput) : void {
      }
      
      public function deserialize(param1:IDataInput) : void {
      }
      
      public function deserializeAs_Item(param1:IDataInput) : void {
      }
   }
}
