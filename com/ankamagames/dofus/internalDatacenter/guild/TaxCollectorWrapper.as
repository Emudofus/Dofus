package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorComplementaryInformations;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorLootInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorGuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorWaitingForHelpInformations;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.guild.tax.AdditionalTaxCollectorInformations;
   
   public class TaxCollectorWrapper extends Object implements IDataCenter
   {
      
      public function TaxCollectorWrapper() {
         super();
      }
      
      public static function create(pInformations:TaxCollectorInformations, pFightersInformations:TaxCollectorFightersInformation = null) : TaxCollectorWrapper {
         var item:TaxCollectorWrapper = null;
         var comp:TaxCollectorComplementaryInformations = null;
         item = new TaxCollectorWrapper();
         item.uniqueId = pInformations.uniqueId;
         item.lastName = TaxCollectorName.getTaxCollectorNameById(pInformations.lastNameId).name;
         item.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(pInformations.firtNameId).firstname;
         item.additionalInformation = pInformations.additionalInfos;
         item.mapWorldX = pInformations.worldX;
         item.mapWorldY = pInformations.worldY;
         item.subareaId = pInformations.subAreaId;
         item.state = pInformations.state;
         item.entityLook = pInformations.look;
         item.fightTime = 0;
         item.waitTimeForPlacement = 0;
         item.nbPositionPerTeam = 5;
         for each(comp in pInformations.complements)
         {
            if(comp is TaxCollectorLootInformations)
            {
               item.kamas = (comp as TaxCollectorLootInformations).kamas;
               item.experience = (comp as TaxCollectorLootInformations).experience;
               item.pods = (comp as TaxCollectorLootInformations).pods;
               item.itemsValue = (comp as TaxCollectorLootInformations).itemsValue;
            }
            else if(comp is TaxCollectorGuildInformations)
            {
               item.guild = (comp as TaxCollectorGuildInformations).guild;
            }
            else if(comp is TaxCollectorWaitingForHelpInformations)
            {
               item.fightTime = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
               item.waitTimeForPlacement = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.waitTimeForPlacement * 100;
               item.nbPositionPerTeam = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.nbPositionForDefensors;
            }
            
            
         }
         return item;
      }
      
      public var uniqueId:int;
      
      public var guild:BasicGuildInformations;
      
      public var firstName:String;
      
      public var lastName:String;
      
      public var entityLook:EntityLook;
      
      public var additionalInformation:AdditionalTaxCollectorInformations;
      
      public var mapWorldX:int;
      
      public var mapWorldY:int;
      
      public var subareaId:int;
      
      public var state:int;
      
      public var fightTime:Number;
      
      public var waitTimeForPlacement:Number;
      
      public var nbPositionPerTeam:uint;
      
      public var kamas:int;
      
      public var experience:int;
      
      public var pods:int;
      
      public var itemsValue:int;
      
      public function update(pInformations:TaxCollectorInformations, pFightersInformations:TaxCollectorFightersInformation = null) : void {
         var comp:TaxCollectorComplementaryInformations = null;
         this.uniqueId = pInformations.uniqueId;
         this.lastName = TaxCollectorName.getTaxCollectorNameById(pInformations.lastNameId).name;
         this.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(pInformations.firtNameId).firstname;
         this.additionalInformation = pInformations.additionalInfos;
         this.mapWorldX = pInformations.worldX;
         this.mapWorldY = pInformations.worldY;
         this.subareaId = pInformations.subAreaId;
         this.state = pInformations.state;
         this.entityLook = pInformations.look;
         this.fightTime = 0;
         this.waitTimeForPlacement = 0;
         this.nbPositionPerTeam = 5;
         for each(comp in pInformations.complements)
         {
            if(comp is TaxCollectorLootInformations)
            {
               this.kamas = (comp as TaxCollectorLootInformations).kamas;
               this.experience = (comp as TaxCollectorLootInformations).experience;
               this.pods = (comp as TaxCollectorLootInformations).pods;
               this.itemsValue = (comp as TaxCollectorLootInformations).itemsValue;
            }
            else if(comp is TaxCollectorGuildInformations)
            {
               this.guild = (comp as TaxCollectorGuildInformations).guild;
            }
            else if(comp is TaxCollectorWaitingForHelpInformations)
            {
               this.fightTime = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
               this.waitTimeForPlacement = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.waitTimeForPlacement * 100;
               this.nbPositionPerTeam = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.nbPositionForDefensors;
            }
            
            
         }
      }
   }
}
