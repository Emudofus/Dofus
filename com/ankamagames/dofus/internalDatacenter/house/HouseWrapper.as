package com.ankamagames.dofus.internalDatacenter.house
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.house.HouseInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsExtended;
   import com.ankamagames.dofus.datacenter.houses.House;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   
   public class HouseWrapper extends Object implements IDataCenter
   {
      
      public function HouseWrapper() {
         super();
      }
      
      public static function create(houseInformations:HouseInformations) : HouseWrapper {
         var hie:HouseInformationsExtended = null;
         var house:HouseWrapper = new HouseWrapper();
         var houseInfo:House = House.getGuildHouseById(houseInformations.modelId);
         house.houseId = houseInformations.houseId;
         house.name = houseInfo.name;
         house.description = houseInfo.description;
         house.ownerName = houseInformations.ownerName;
         house.isOnSale = houseInformations.isOnSale;
         house.gfxId = houseInfo.gfxId;
         house.defaultPrice = houseInfo.defaultPrice;
         house.isSaleLocked = houseInformations.isSaleLocked;
         if(houseInformations is HouseInformationsExtended)
         {
            hie = houseInformations as HouseInformationsExtended;
            house.guildIdentity = GuildWrapper.create(hie.guildInfo.guildId,hie.guildInfo.guildName,hie.guildInfo.guildEmblem,0,true);
         }
         return house;
      }
      
      public static function manualCreate(typeId:int, houseId:int, ownerName:String, isOnSale:Boolean, isSaleLocked:Boolean=false) : HouseWrapper {
         var house:HouseWrapper = new HouseWrapper();
         var houseInfo:House = House.getGuildHouseById(typeId);
         house.houseId = houseId;
         house.name = houseInfo.name;
         house.description = houseInfo.description;
         house.ownerName = ownerName;
         house.isOnSale = isOnSale;
         house.gfxId = houseInfo.gfxId;
         house.defaultPrice = houseInfo.defaultPrice;
         house.isSaleLocked = isSaleLocked;
         return house;
      }
      
      public var houseId:int;
      
      public var name:String;
      
      public var description:String;
      
      public var ownerName:String;
      
      public var isOnSale:Boolean = false;
      
      public var gfxId:int;
      
      public var defaultPrice:uint;
      
      public var guildIdentity:GuildWrapper;
      
      public var isSaleLocked:Boolean;
   }
}
