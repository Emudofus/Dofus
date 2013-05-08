package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;


   public class TaxCollectorTooltipInformation extends Object
   {
         

      public function TaxCollectorTooltipInformation(pFirstName:String, pLastName:String, pGuildIdentity:GuildWrapper, pTaxCollectorAttack:int) {
         super();
         this.lastName=pLastName;
         this.firstName=pFirstName;
         this.guildIdentity=pGuildIdentity;
         this.taxCollectorAttack=pTaxCollectorAttack;
      }



      public var lastName:String;

      public var firstName:String;

      public var guildIdentity:GuildWrapper;

      public var taxCollectorAttack:int;
   }

}