package com.ankamagames.dofus.network.types.common.basic
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class StatisticDataShort extends StatisticData implements INetworkType
   {
      
      public function StatisticDataShort()
      {
         super();
      }
      
      public static const protocolId:uint = 488;
      
      public var value:int = 0;
      
      override public function getTypeId() : uint
      {
         return 488;
      }
      
      public function initStatisticDataShort(param1:uint = 0, param2:int = 0) : StatisticDataShort
      {
         super.initStatisticData(param1);
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
         this.serializeAs_StatisticDataShort(param1);
      }
      
      public function serializeAs_StatisticDataShort(param1:ICustomDataOutput) : void
      {
         super.serializeAs_StatisticData(param1);
         param1.writeShort(this.value);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_StatisticDataShort(param1);
      }
      
      public function deserializeAs_StatisticDataShort(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.value = param1.readShort();
      }
   }
}
