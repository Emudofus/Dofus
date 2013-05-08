package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformationsInWaitForHelpState;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.guild.tax.AdditionalTaxCollectorInformations;


   public class TaxCollectorWrapper extends Object implements IDataCenter
   {
         

      public function TaxCollectorWrapper() {
         super();
      }

      public static function create(pInformations:TaxCollectorInformations, pFightersInformations:TaxCollectorFightersInformation=null) : TaxCollectorWrapper {
         var item:TaxCollectorWrapper = null;
         item=new TaxCollectorWrapper();
         item.uniqueId=pInformations.uniqueId;
         item.lastName=TaxCollectorName.getTaxCollectorNameById(pInformations.lastNameId).name;
         item.firstName=TaxCollectorFirstname.getTaxCollectorFirstnameById(pInformations.firtNameId).firstname;
         item.additionalInformation=pInformations.additionalInfos;
         item.mapWorldX=pInformations.worldX;
         item.mapWorldY=pInformations.worldY;
         item.subareaId=pInformations.subAreaId;
         item.state=pInformations.state;
         item.entityLook=pInformations.look;
         item.kamas=pInformations.kamas;
         item.experience=pInformations.experience;
         item.pods=pInformations.pods;
         item.itemsValue=pInformations.itemsValue;
         if(pInformations.state==1)
         {
            item.fightTime=(pInformations as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.timeLeftBeforeFight*100+getTimer();
            item.waitTimeForPlacement=(pInformations as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.waitTimeForPlacement*100;
            item.nbPositionPerTeam=(pInformations as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.nbPositionForDefensors;
         }
         else
         {
            item.fightTime=0;
            item.waitTimeForPlacement=0;
            item.nbPositionPerTeam=7;
         }
         return item;
      }

      public var uniqueId:int;

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

      public function update(pInformations:TaxCollectorInformations, pFightersInformations:TaxCollectorFightersInformation=null) : void {
         this.uniqueId=pInformations.uniqueId;
         this.lastName=TaxCollectorName.getTaxCollectorNameById(pInformations.lastNameId).name;
         this.firstName=TaxCollectorFirstname.getTaxCollectorFirstnameById(pInformations.firtNameId).firstname;
         this.additionalInformation=pInformations.additionalInfos;
         this.mapWorldX=pInformations.worldX;
         this.mapWorldY=pInformations.worldY;
         this.subareaId=pInformations.subAreaId;
         this.state=pInformations.state;
         this.entityLook=pInformations.look;
         this.kamas=pInformations.kamas;
         this.experience=pInformations.experience;
         this.pods=pInformations.pods;
         this.itemsValue=pInformations.itemsValue;
         if(pInformations.state==1)
         {
            this.fightTime=(pInformations as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.timeLeftBeforeFight*100+getTimer();
            this.waitTimeForPlacement=(pInformations as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.waitTimeForPlacement*100;
            this.nbPositionPerTeam=(pInformations as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.nbPositionForDefensors;
         }
         else
         {
            this.fightTime=0;
            this.waitTimeForPlacement=0;
            this.nbPositionPerTeam=7;
         }
      }
   }

}