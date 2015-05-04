package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class UpdateMountIntBoost extends UpdateMountBoost implements INetworkType
   {
      
      public function UpdateMountIntBoost()
      {
         super();
      }
      
      public static const protocolId:uint = 357;
      
      public var value:int = 0;
      
      override public function getTypeId() : uint
      {
         return 357;
      }
      
      public function initUpdateMountIntBoost(param1:uint = 0, param2:int = 0) : UpdateMountIntBoost
      {
         super.initUpdateMountBoost(param1);
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
         this.serializeAs_UpdateMountIntBoost(param1);
      }
      
      public function serializeAs_UpdateMountIntBoost(param1:ICustomDataOutput) : void
      {
         super.serializeAs_UpdateMountBoost(param1);
         param1.writeInt(this.value);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateMountIntBoost(param1);
      }
      
      public function deserializeAs_UpdateMountIntBoost(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.value = param1.readInt();
      }
   }
}
