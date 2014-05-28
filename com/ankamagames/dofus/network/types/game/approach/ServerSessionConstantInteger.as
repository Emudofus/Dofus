package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ServerSessionConstantInteger extends ServerSessionConstant implements INetworkType
   {
      
      public function ServerSessionConstantInteger() {
         super();
      }
      
      public static const protocolId:uint = 433;
      
      public var value:int = 0;
      
      override public function getTypeId() : uint {
         return 433;
      }
      
      public function initServerSessionConstantInteger(id:uint = 0, value:int = 0) : ServerSessionConstantInteger {
         super.initServerSessionConstant(id);
         this.value = value;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ServerSessionConstantInteger(output);
      }
      
      public function serializeAs_ServerSessionConstantInteger(output:IDataOutput) : void {
         super.serializeAs_ServerSessionConstant(output);
         output.writeInt(this.value);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerSessionConstantInteger(input);
      }
      
      public function deserializeAs_ServerSessionConstantInteger(input:IDataInput) : void {
         super.deserialize(input);
         this.value = input.readInt();
      }
   }
}
