package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class Pack extends Object implements IDataCenter
   {
      
      public function Pack() {
         super();
      }
      
      public static const MODULE:String = "Pack";
      
      public static function getPackById(param1:int) : Pack {
         return GameData.getObject(MODULE,param1) as Pack;
      }
      
      public static function getPackByName(param1:String) : Pack {
         var _loc3_:Pack = null;
         var _loc2_:Array = getAllPacks();
         for each (_loc3_ in _loc2_)
         {
            if(param1 == _loc3_.name)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function getAllPacks() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var name:String;
      
      public var hasSubAreas:Boolean;
   }
}
