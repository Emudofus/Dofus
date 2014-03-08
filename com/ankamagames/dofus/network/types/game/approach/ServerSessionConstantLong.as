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
      
      public function initServerSessionConstantLong(param1:uint=0, param2:Number=0) : ServerSessionConstantLong {
         super.initServerSessionConstant(param1);
         this.value = param2;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ServerSessionConstantLong(param1);
      }
      
      public function serializeAs_ServerSessionConstantLong(param1:IDataOutput) : void {
         super.serializeAs_ServerSessionConstant(param1);
         param1.writeDouble(this.value);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ServerSessionConstantLong(param1);
      }
      
      public function deserializeAs_ServerSessionConstantLong(param1:IDataInput) : void {
         super.deserialize(param1);
         this.value = param1.readDouble();
      }
   }
}
