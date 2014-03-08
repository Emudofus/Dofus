package com.ankamagames.jerakine.utils.misc
{
   public class Levenshtein extends Object
   {
      
      public function Levenshtein() {
         super();
      }
      
      public static function distance(param1:String, param2:String) : Number {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:* = NaN;
         var _loc6_:Array = new Array();
         if(param1.length == 0)
         {
            return param2.length;
         }
         if(param2.length == 0)
         {
            return param1.length;
         }
         _loc3_ = 0;
         while(_loc3_ <= param1.length)
         {
            _loc6_[_loc3_] = new Array();
            _loc6_[_loc3_][0] = _loc3_;
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ <= param2.length)
         {
            _loc6_[0][_loc4_] = _loc4_;
            _loc4_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= param1.length)
         {
            _loc4_ = 1;
            while(_loc4_ <= param2.length)
            {
               if(param1.charAt(_loc3_-1) == param2.charAt(_loc4_-1))
               {
                  _loc5_ = 0;
               }
               else
               {
                  _loc5_ = 1;
               }
               _loc6_[_loc3_][_loc4_] = Math.min(_loc6_[_loc3_-1][_loc4_] + 1,_loc6_[_loc3_][_loc4_-1] + 1,_loc6_[_loc3_-1][_loc4_-1] + _loc5_);
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc6_[param1.length][param2.length];
      }
      
      public static function suggest(param1:String, param2:Array, param3:uint=5) : String {
         var _loc4_:String = null;
         var _loc6_:uint = 0;
         var _loc5_:uint = 100000;
         var _loc7_:uint = 0;
         while(_loc7_ < param2.length)
         {
            _loc6_ = distance(param1,param2[_loc7_]);
            if(_loc5_ > _loc6_ && _loc6_ <= param3)
            {
               _loc5_ = _loc6_;
               _loc4_ = param2[_loc7_];
            }
            _loc7_++;
         }
         return _loc4_;
      }
   }
}
