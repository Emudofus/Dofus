package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TaxCollectorComplementaryInformations extends Object implements INetworkType
   {
      
      public function TaxCollectorComplementaryInformations() {
         super();
      }
      
      public static const protocolId:uint = 448;
      
      public function getTypeId() : uint {
         return 448;
      }
      
      public function initTaxCollectorComplementaryInformations() : TaxCollectorComplementaryInformations {
         return this;
      }
      
      public function reset() : void {
      }
      
      public function serialize(param1:IDataOutput) : void {
      }
      
      public function serializeAs_TaxCollectorComplementaryInformations(param1:IDataOutput) : void {
      }
      
      public function deserialize(param1:IDataInput) : void {
      }
      
      public function deserializeAs_TaxCollectorComplementaryInformations(param1:IDataInput) : void {
      }
   }
}
