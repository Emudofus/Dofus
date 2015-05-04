package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ServerSessionConstantInteger extends ServerSessionConstant implements INetworkType
   {
      
      public function ServerSessionConstantInteger()
      {
         super();
      }
      
      public static const protocolId:uint = 433;
      
      public var value:int = 0;
      
      override public function getTypeId() : uint
      {
         return 433;
      }
      
      public function initServerSessionConstantInteger(param1:uint = 0, param2:int = 0) : ServerSessionConstantInteger
      {
         super.initServerSessionConstant(param1);
         this.value = param2;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ServerSessionConstantInteger(param1);
      }
      
      public function serializeAs_ServerSessionConstantInteger(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ServerSessionConstant(param1);
         param1.writeInt(this.value);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSessionConstantInteger(param1);
      }
      
      public function deserializeAs_ServerSessionConstantInteger(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.value = param1.readInt();
      }
   }
}
