package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ServerSessionConstantString extends ServerSessionConstant implements INetworkType
   {
      
      public function ServerSessionConstantString() {
         super();
      }
      
      public static const protocolId:uint = 436;
      
      public var value:String = "";
      
      override public function getTypeId() : uint {
         return 436;
      }
      
      public function initServerSessionConstantString(id:uint=0, value:String="") : ServerSessionConstantString {
         super.initServerSessionConstant(id);
         this.value = value;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ServerSessionConstantString(output);
      }
      
      public function serializeAs_ServerSessionConstantString(output:IDataOutput) : void {
         super.serializeAs_ServerSessionConstant(output);
         output.writeUTF(this.value);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerSessionConstantString(input);
      }
      
      public function deserializeAs_ServerSessionConstantString(input:IDataInput) : void {
         super.deserialize(input);
         this.value = input.readUTF();
      }
   }
}
