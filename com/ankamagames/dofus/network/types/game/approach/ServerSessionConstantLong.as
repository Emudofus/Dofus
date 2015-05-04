package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ServerSessionConstantLong extends ServerSessionConstant implements INetworkType
   {
      
      public function ServerSessionConstantLong()
      {
         super();
      }
      
      public static const protocolId:uint = 429;
      
      public var value:Number = 0;
      
      override public function getTypeId() : uint
      {
         return 429;
      }
      
      public function initServerSessionConstantLong(param1:uint = 0, param2:Number = 0) : ServerSessionConstantLong
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
         this.serializeAs_ServerSessionConstantLong(param1);
      }
      
      public function serializeAs_ServerSessionConstantLong(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ServerSessionConstant(param1);
         if(this.value < -9.007199254740992E15 || this.value > 9.007199254740992E15)
         {
            throw new Error("Forbidden value (" + this.value + ") on element value.");
         }
         else
         {
            param1.writeDouble(this.value);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSessionConstantLong(param1);
      }
      
      public function deserializeAs_ServerSessionConstantLong(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.value = param1.readDouble();
         if(this.value < -9.007199254740992E15 || this.value > 9.007199254740992E15)
         {
            throw new Error("Forbidden value (" + this.value + ") on element of ServerSessionConstantLong.value.");
         }
         else
         {
            return;
         }
      }
   }
}
