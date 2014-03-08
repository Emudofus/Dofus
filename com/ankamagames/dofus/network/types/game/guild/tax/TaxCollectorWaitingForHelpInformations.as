package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TaxCollectorWaitingForHelpInformations extends TaxCollectorComplementaryInformations implements INetworkType
   {
      
      public function TaxCollectorWaitingForHelpInformations() {
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         super();
      }
      
      public static const protocolId:uint = 447;
      
      public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo;
      
      override public function getTypeId() : uint {
         return 447;
      }
      
      public function initTaxCollectorWaitingForHelpInformations(param1:ProtectedEntityWaitingForHelpInfo=null) : TaxCollectorWaitingForHelpInformations {
         this.waitingForHelpInfo = param1;
         return this;
      }
      
      override public function reset() : void {
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_TaxCollectorWaitingForHelpInformations(param1);
      }
      
      public function serializeAs_TaxCollectorWaitingForHelpInformations(param1:IDataOutput) : void {
         super.serializeAs_TaxCollectorComplementaryInformations(param1);
         this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TaxCollectorWaitingForHelpInformations(param1);
      }
      
      public function deserializeAs_TaxCollectorWaitingForHelpInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         this.waitingForHelpInfo.deserialize(param1);
      }
   }
}
