package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TaxCollectorComplementaryInformations extends Object implements INetworkType
   {
      
      public function TaxCollectorComplementaryInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 448;
      
      public function getTypeId() : uint
      {
         return 448;
      }
      
      public function initTaxCollectorComplementaryInformations() : TaxCollectorComplementaryInformations
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_TaxCollectorComplementaryInformations(param1:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_TaxCollectorComplementaryInformations(param1:ICustomDataInput) : void
      {
      }
   }
}
