package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class UpdateMountBoost extends Object implements INetworkType
   {
      
      public function UpdateMountBoost() {
         super();
      }
      
      public static const protocolId:uint = 356;
      
      public var type:int = 0;
      
      public function getTypeId() : uint {
         return 356;
      }
      
      public function initUpdateMountBoost(param1:int=0) : UpdateMountBoost {
         this.type = param1;
         return this;
      }
      
      public function reset() : void {
         this.type = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_UpdateMountBoost(param1);
      }
      
      public function serializeAs_UpdateMountBoost(param1:IDataOutput) : void {
         param1.writeByte(this.type);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_UpdateMountBoost(param1);
      }
      
      public function deserializeAs_UpdateMountBoost(param1:IDataInput) : void {
         this.type = param1.readByte();
      }
   }
}
