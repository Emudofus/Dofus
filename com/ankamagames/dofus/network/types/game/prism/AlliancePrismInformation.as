package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AlliancePrismInformation extends PrismInformation implements INetworkType
   {
      
      public function AlliancePrismInformation() {
         this.alliance = new AllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 427;
      
      public var alliance:AllianceInformations;
      
      override public function getTypeId() : uint {
         return 427;
      }
      
      public function initAlliancePrismInformation(typeId:uint = 0, state:uint = 1, nextVulnerabilityDate:uint = 0, placementDate:uint = 0, rewardTokenCount:uint = 0, alliance:AllianceInformations = null) : AlliancePrismInformation {
         super.initPrismInformation(typeId,state,nextVulnerabilityDate,placementDate,rewardTokenCount);
         this.alliance = alliance;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.alliance = new AllianceInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_AlliancePrismInformation(output);
      }
      
      public function serializeAs_AlliancePrismInformation(output:IDataOutput) : void {
         super.serializeAs_PrismInformation(output);
         this.alliance.serializeAs_AllianceInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlliancePrismInformation(input);
      }
      
      public function deserializeAs_AlliancePrismInformation(input:IDataInput) : void {
         super.deserialize(input);
         this.alliance = new AllianceInformations();
         this.alliance.deserialize(input);
      }
   }
}
