package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ServerSessionConstantLong extends ServerSessionConstant implements INetworkType
   {
      
      public function ServerSessionConstantLong() {
         super();
      }
      
      public static const protocolId:uint = 429;
      
      public var value:Number = 0;
      
      override public function getTypeId() : uint {
         return 429;
      }
      
      public function initServerSessionConstantLong(id:uint = 0, value:Number = 0) : ServerSessionConstantLong {
         super.initServerSessionConstant(id);
         this.value = value;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ServerSessionConstantLong(output);
      }
      
      public function serializeAs_ServerSessionConstantLong(output:IDataOutput) : void {
         super.serializeAs_ServerSessionConstant(output);
         output.writeDouble(this.value);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerSessionConstantLong(input);
      }
      
      public function deserializeAs_ServerSessionConstantLong(input:IDataInput) : void {
         super.deserialize(input);
         this.value = input.readDouble();
      }
   }
}
