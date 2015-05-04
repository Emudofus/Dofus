package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AlliancePrismInformation extends PrismInformation implements INetworkType
   {
      
      public function AlliancePrismInformation()
      {
         this.alliance = new AllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 427;
      
      public var alliance:AllianceInformations;
      
      override public function getTypeId() : uint
      {
         return 427;
      }
      
      public function initAlliancePrismInformation(param1:uint = 0, param2:uint = 1, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:AllianceInformations = null) : AlliancePrismInformation
      {
         super.initPrismInformation(param1,param2,param3,param4,param5);
         this.alliance = param6;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.alliance = new AllianceInformations();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AlliancePrismInformation(param1);
      }
      
      public function serializeAs_AlliancePrismInformation(param1:ICustomDataOutput) : void
      {
         super.serializeAs_PrismInformation(param1);
         this.alliance.serializeAs_AllianceInformations(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AlliancePrismInformation(param1);
      }
      
      public function deserializeAs_AlliancePrismInformation(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.alliance = new AllianceInformations();
         this.alliance.deserialize(param1);
      }
   }
}
