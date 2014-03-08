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
      
      public function initServerSessionConstantString(param1:uint=0, param2:String="") : ServerSessionConstantString {
         super.initServerSessionConstant(param1);
         this.value = param2;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = "";
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ServerSessionConstantString(param1);
      }
      
      public function serializeAs_ServerSessionConstantString(param1:IDataOutput) : void {
         super.serializeAs_ServerSessionConstant(param1);
         param1.writeUTF(this.value);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ServerSessionConstantString(param1);
      }
      
      public function deserializeAs_ServerSessionConstantString(param1:IDataInput) : void {
         super.deserialize(param1);
         this.value = param1.readUTF();
      }
   }
}
