package com.ankamagames.jerakine.pools
{
   import flash.utils.Dictionary;
   
   public class GenericPool extends Object
   {
      
      public function GenericPool() {
         super();
      }
      
      private static var _pools:Dictionary = new Dictionary();
      
      public static function get(param1:Class, ... rest) : * {
         if((_pools[param1]) && (_pools[param1].length))
         {
            return param1["create"].apply(null,rest.concat(_pools[param1].pop()));
         }
         return param1["create"].apply(null,rest);
      }
      
      public static function free(param1:Poolable) : void {
         param1.free();
         var _loc2_:Class = Object(param1).constructor;
         if(!_pools[_loc2_])
         {
            _pools[_loc2_] = new Array();
         }
         (_pools[_loc2_] as Array).push(param1);
      }
   }
}
