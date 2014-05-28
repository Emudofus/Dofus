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
      
      public function initUpdateMountBoost(type:int = 0) : UpdateMountBoost {
         this.type = type;
         return this;
      }
      
      public function reset() : void {
         this.type = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_UpdateMountBoost(output);
      }
      
      public function serializeAs_UpdateMountBoost(output:IDataOutput) : void {
         output.writeByte(this.type);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_UpdateMountBoost(input);
      }
      
      public function deserializeAs_UpdateMountBoost(input:IDataInput) : void {
         this.type = input.readByte();
      }
   }
}
