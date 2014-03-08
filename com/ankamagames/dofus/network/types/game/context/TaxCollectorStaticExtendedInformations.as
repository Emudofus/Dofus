package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TaxCollectorStaticExtendedInformations extends TaxCollectorStaticInformations implements INetworkType
   {
      
      public function TaxCollectorStaticExtendedInformations() {
         this.allianceIdentity = new AllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 440;
      
      public var allianceIdentity:AllianceInformations;
      
      override public function getTypeId() : uint {
         return 440;
      }
      
      public function initTaxCollectorStaticExtendedInformations(firstNameId:uint=0, lastNameId:uint=0, guildIdentity:GuildInformations=null, allianceIdentity:AllianceInformations=null) : TaxCollectorStaticExtendedInformations {
         super.initTaxCollectorStaticInformations(firstNameId,lastNameId,guildIdentity);
         this.allianceIdentity = allianceIdentity;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceIdentity = new AllianceInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_TaxCollectorStaticExtendedInformations(output);
      }
      
      public function serializeAs_TaxCollectorStaticExtendedInformations(output:IDataOutput) : void {
         super.serializeAs_TaxCollectorStaticInformations(output);
         this.allianceIdentity.serializeAs_AllianceInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorStaticExtendedInformations(input);
      }
      
      public function deserializeAs_TaxCollectorStaticExtendedInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.allianceIdentity = new AllianceInformations();
         this.allianceIdentity.deserialize(input);
      }
   }
}
