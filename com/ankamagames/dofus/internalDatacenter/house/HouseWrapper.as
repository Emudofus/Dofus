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
      
      public static function create(param1:HouseInformations) : HouseWrapper {
         var _loc4_:HouseInformationsExtended = null;
         var _loc2_:HouseWrapper = new HouseWrapper();
         var _loc3_:House = House.getGuildHouseById(param1.modelId);
         _loc2_.houseId = param1.houseId;
         _loc2_.name = _loc3_.name;
         _loc2_.description = _loc3_.description;
         _loc2_.ownerName = param1.ownerName;
         _loc2_.isOnSale = param1.isOnSale;
         _loc2_.gfxId = _loc3_.gfxId;
         _loc2_.defaultPrice = _loc3_.defaultPrice;
         _loc2_.isSaleLocked = param1.isSaleLocked;
         if(param1 is HouseInformationsExtended)
         {
            _loc4_ = param1 as HouseInformationsExtended;
            _loc2_.guildIdentity = GuildWrapper.create(_loc4_.guildInfo.guildId,_loc4_.guildInfo.guildName,_loc4_.guildInfo.guildEmblem,0,true);
         }
         return _loc2_;
      }
      
      public static function manualCreate(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean=false) : HouseWrapper {
         var _loc6_:HouseWrapper = new HouseWrapper();
         var _loc7_:House = House.getGuildHouseById(param1);
         _loc6_.houseId = param2;
         _loc6_.name = _loc7_.name;
         _loc6_.description = _loc7_.description;
         _loc6_.ownerName = param3;
         _loc6_.isOnSale = param4;
         _loc6_.gfxId = _loc7_.gfxId;
         _loc6_.defaultPrice = _loc7_.defaultPrice;
         _loc6_.isSaleLocked = param5;
         return _loc6_;
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
