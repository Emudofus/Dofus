package com.ankamagames.dofus.network.types.common.basic
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class StatisticDataInt extends StatisticData implements INetworkType
   {
      
      public function StatisticDataInt()
      {
         super();
      }
      
      public static const protocolId:uint = 485;
      
      public var value:int = 0;
      
      override public function getTypeId() : uint
      {
         return 485;
      }
      
      public function initStatisticDataInt(param1:uint = 0, param2:int = 0) : StatisticDataInt
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
         this.serializeAs_StatisticDataInt(param1);
      }
      
      public function serializeAs_StatisticDataInt(param1:ICustomDataOutput) : void
      {
         super.serializeAs_StatisticData(param1);
         param1.writeInt(this.value);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_StatisticDataInt(param1);
      }
      
      public function deserializeAs_StatisticDataInt(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.value = param1.readInt();
      }
   }
}
