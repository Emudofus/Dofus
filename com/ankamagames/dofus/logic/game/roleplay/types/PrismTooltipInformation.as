package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   
   public class PrismTooltipInformation extends Object
   {
      
      public function PrismTooltipInformation(pAllianceIdentity:AllianceWrapper) {
         super();
         this.allianceIdentity = pAllianceIdentity;
      }
      
      public var allianceIdentity:AllianceWrapper;
   }
}
