package com.ankamagames.dofus.network.types.common.basic
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class StatisticDataBoolean extends StatisticData implements INetworkType
   {
      
      public function StatisticDataBoolean()
      {
         super();
      }
      
      public static const protocolId:uint = 482;
      
      public var value:Boolean = false;
      
      override public function getTypeId() : uint
      {
         return 482;
      }
      
      public function initStatisticDataBoolean(param1:uint = 0, param2:Boolean = false) : StatisticDataBoolean
      {
         super.initStatisticData(param1);
         this.value = param2;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = false;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_StatisticDataBoolean(param1);
      }
      
      public function serializeAs_StatisticDataBoolean(param1:ICustomDataOutput) : void
      {
         super.serializeAs_StatisticData(param1);
         param1.writeBoolean(this.value);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_StatisticDataBoolean(param1);
      }
      
      public function deserializeAs_StatisticDataBoolean(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.value = param1.readBoolean();
      }
   }
}
