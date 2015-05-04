package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ServerSessionConstantString extends ServerSessionConstant implements INetworkType
   {
      
      public function ServerSessionConstantString()
      {
         super();
      }
      
      public static const protocolId:uint = 436;
      
      public var value:String = "";
      
      override public function getTypeId() : uint
      {
         return 436;
      }
      
      public function initServerSessionConstantString(param1:uint = 0, param2:String = "") : ServerSessionConstantString
      {
         super.initServerSessionConstant(param1);
         this.value = param2;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = "";
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ServerSessionConstantString(param1);
      }
      
      public function serializeAs_ServerSessionConstantString(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ServerSessionConstant(param1);
         param1.writeUTF(this.value);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSessionConstantString(param1);
      }
      
      public function deserializeAs_ServerSessionConstantString(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.value = param1.readUTF();
      }
   }
}
