package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class UpdateMountIntBoost extends UpdateMountBoost implements INetworkType
   {
      
      public function UpdateMountIntBoost() {
         super();
      }
      
      public static const protocolId:uint = 357;
      
      public var value:int = 0;
      
      override public function getTypeId() : uint {
         return 357;
      }
      
      public function initUpdateMountIntBoost(type:int=0, value:int=0) : UpdateMountIntBoost {
         super.initUpdateMountBoost(type);
         this.value = value;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_UpdateMountIntBoost(output);
      }
      
      public function serializeAs_UpdateMountIntBoost(output:IDataOutput) : void {
         super.serializeAs_UpdateMountBoost(output);
         output.writeInt(this.value);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_UpdateMountIntBoost(input);
      }
      
      public function deserializeAs_UpdateMountIntBoost(input:IDataInput) : void {
         super.deserialize(input);
         this.value = input.readInt();
      }
   }
}
