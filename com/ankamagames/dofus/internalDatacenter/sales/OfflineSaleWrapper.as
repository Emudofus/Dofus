package com.ankamagames.dofus.internalDatacenter.sales
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.items.Item;
   
   public class OfflineSaleWrapper extends Object implements IDataCenter
   {
      
      public function OfflineSaleWrapper()
      {
         super();
      }
      
      public static const TYPE_BIDHOUSE:uint = 1;
      
      public static const TYPE_MERCHANT:uint = 2;
      
      public static function create(param1:uint, param2:uint, param3:uint, param4:Number) : OfflineSaleWrapper
      {
         var _loc5_:OfflineSaleWrapper = new OfflineSaleWrapper();
         _loc5_.type = param1;
         _loc5_.itemId = param2;
         _loc5_.itemName = Item.getItemById(_loc5_.itemId).name;
         _loc5_.quantity = param3;
         _loc5_.kamas = param4;
         return _loc5_;
      }
      
      public var type:uint;
      
      public var itemId:uint;
      
      public var itemName:String;
      
      public var quantity:uint;
      
      public var kamas:Number;
   }
}
