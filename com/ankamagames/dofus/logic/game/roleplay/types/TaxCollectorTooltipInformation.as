package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   
   public class TaxCollectorTooltipInformation extends Object
   {
      
      public function TaxCollectorTooltipInformation(pFirstName:String, pLastName:String, pGuildIdentity:GuildWrapper, pAllianceIdentity:AllianceWrapper, pTaxCollectorAttack:int) {
         super();
         this.lastName = pLastName;
         this.firstName = pFirstName;
         this.guildIdentity = pGuildIdentity;
         this.allianceIdentity = pAllianceIdentity;
         this.taxCollectorAttack = pTaxCollectorAttack;
      }
      
      public var lastName:String;
      
      public var firstName:String;
      
      public var guildIdentity:GuildWrapper;
      
      public var taxCollectorAttack:int;
      
      public var allianceIdentity:AllianceWrapper;
   }
}
