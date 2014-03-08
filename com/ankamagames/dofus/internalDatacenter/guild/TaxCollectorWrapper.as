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
      
      public static function create(param1:TaxCollectorInformations, param2:TaxCollectorFightersInformation=null) : TaxCollectorWrapper {
         var _loc3_:TaxCollectorWrapper = null;
         var _loc4_:TaxCollectorComplementaryInformations = null;
         _loc3_ = new TaxCollectorWrapper();
         _loc3_.uniqueId = param1.uniqueId;
         _loc3_.lastName = TaxCollectorName.getTaxCollectorNameById(param1.lastNameId).name;
         _loc3_.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(param1.firtNameId).firstname;
         _loc3_.additionalInformation = param1.additionalInfos;
         _loc3_.mapWorldX = param1.worldX;
         _loc3_.mapWorldY = param1.worldY;
         _loc3_.subareaId = param1.subAreaId;
         _loc3_.state = param1.state;
         _loc3_.entityLook = param1.look;
         _loc3_.fightTime = 0;
         _loc3_.waitTimeForPlacement = 0;
         _loc3_.nbPositionPerTeam = 5;
         for each (_loc4_ in param1.complements)
         {
            if(_loc4_ is TaxCollectorLootInformations)
            {
               _loc3_.kamas = (_loc4_ as TaxCollectorLootInformations).kamas;
               _loc3_.experience = (_loc4_ as TaxCollectorLootInformations).experience;
               _loc3_.pods = (_loc4_ as TaxCollectorLootInformations).pods;
               _loc3_.itemsValue = (_loc4_ as TaxCollectorLootInformations).itemsValue;
            }
            else
            {
               if(_loc4_ is TaxCollectorGuildInformations)
               {
                  _loc3_.guild = (_loc4_ as TaxCollectorGuildInformations).guild;
               }
               else
               {
                  if(_loc4_ is TaxCollectorWaitingForHelpInformations)
                  {
                     _loc3_.fightTime = (_loc4_ as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
                     _loc3_.waitTimeForPlacement = (_loc4_ as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.waitTimeForPlacement * 100;
                     _loc3_.nbPositionPerTeam = (_loc4_ as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.nbPositionForDefensors;
                  }
               }
            }
         }
         return _loc3_;
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
      
      public function update(param1:TaxCollectorInformations, param2:TaxCollectorFightersInformation=null) : void {
         var _loc3_:TaxCollectorComplementaryInformations = null;
         this.uniqueId = param1.uniqueId;
         this.lastName = TaxCollectorName.getTaxCollectorNameById(param1.lastNameId).name;
         this.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(param1.firtNameId).firstname;
         this.additionalInformation = param1.additionalInfos;
         this.mapWorldX = param1.worldX;
         this.mapWorldY = param1.worldY;
         this.subareaId = param1.subAreaId;
         this.state = param1.state;
         this.entityLook = param1.look;
         this.fightTime = 0;
         this.waitTimeForPlacement = 0;
         this.nbPositionPerTeam = 5;
         for each (_loc3_ in param1.complements)
         {
            if(_loc3_ is TaxCollectorLootInformations)
            {
               this.kamas = (_loc3_ as TaxCollectorLootInformations).kamas;
               this.experience = (_loc3_ as TaxCollectorLootInformations).experience;
               this.pods = (_loc3_ as TaxCollectorLootInformations).pods;
               this.itemsValue = (_loc3_ as TaxCollectorLootInformations).itemsValue;
            }
            else
            {
               if(_loc3_ is TaxCollectorGuildInformations)
               {
                  this.guild = (_loc3_ as TaxCollectorGuildInformations).guild;
               }
               else
               {
                  if(_loc3_ is TaxCollectorWaitingForHelpInformations)
                  {
                     this.fightTime = (_loc3_ as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
                     this.waitTimeForPlacement = (_loc3_ as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.waitTimeForPlacement * 100;
                     this.nbPositionPerTeam = (_loc3_ as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.nbPositionForDefensors;
                  }
               }
            }
         }
      }
   }
}
