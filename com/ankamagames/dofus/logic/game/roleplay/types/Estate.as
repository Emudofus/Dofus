package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForSell;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.houses.House;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Estate extends Object
   {
      
      public function Estate(param1:Object) {
         var _loc2_:HouseInformationsForSell = null;
         var _loc3_:SubArea = null;
         var _loc4_:House = null;
         var _loc5_:Area = null;
         var _loc6_:PaddockInformationsForSell = null;
         var _loc7_:SubArea = null;
         var _loc8_:Area = null;
         super();
         if(param1 is HouseInformationsForSell)
         {
            _loc2_ = param1 as HouseInformationsForSell;
            _loc3_ = SubArea.getSubAreaById(_loc2_.subAreaId);
            _loc4_ = House.getGuildHouseById(_loc2_.modelId);
            if(!_loc4_)
            {
               this.name = "-";
            }
            else
            {
               this.name = _loc4_.name;
            }
            if(_loc3_)
            {
               _loc5_ = Area.getAreaById(_loc3_.areaId);
               if(!_loc5_)
               {
                  this.area = "-";
               }
               else
               {
                  this.area = _loc5_.name;
               }
            }
            else
            {
               this.area = "-";
            }
            this.price = _loc2_.price;
            this.infos = _loc2_;
         }
         else
         {
            if(param1 is PaddockInformationsForSell)
            {
               _loc6_ = param1 as PaddockInformationsForSell;
               _loc7_ = SubArea.getSubAreaById(_loc6_.subAreaId);
               this.name = I18n.getUiText("ui.mount.paddockWithRoom",[_loc6_.nbMount]);
               if(_loc7_)
               {
                  _loc8_ = Area.getAreaById(_loc7_.areaId);
                  if(!_loc8_)
                  {
                     this.area = "-";
                  }
                  else
                  {
                     this.area = _loc8_.name;
                  }
               }
               else
               {
                  this.area = "-";
               }
               this.price = _loc6_.price;
               this.infos = _loc6_;
            }
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Estate));
      
      public var name:String;
      
      public var area:String;
      
      public var price:uint;
      
      public var infos:Object;
   }
}
