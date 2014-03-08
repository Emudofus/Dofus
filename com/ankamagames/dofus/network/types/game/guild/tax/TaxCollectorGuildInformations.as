package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TaxCollectorGuildInformations extends TaxCollectorComplementaryInformations implements INetworkType
   {
      
      public function TaxCollectorGuildInformations() {
         this.guild = new BasicGuildInformations();
         super();
      }
      
      public static const protocolId:uint = 446;
      
      public var guild:BasicGuildInformations;
      
      override public function getTypeId() : uint {
         return 446;
      }
      
      public function initTaxCollectorGuildInformations(param1:BasicGuildInformations=null) : TaxCollectorGuildInformations {
         this.guild = param1;
         return this;
      }
      
      override public function reset() : void {
         this.guild = new BasicGuildInformations();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_TaxCollectorGuildInformations(param1);
      }
      
      public function serializeAs_TaxCollectorGuildInformations(param1:IDataOutput) : void {
         super.serializeAs_TaxCollectorComplementaryInformations(param1);
         this.guild.serializeAs_BasicGuildInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TaxCollectorGuildInformations(param1);
      }
      
      public function deserializeAs_TaxCollectorGuildInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.guild = new BasicGuildInformations();
         this.guild.deserialize(param1);
      }
   }
}
