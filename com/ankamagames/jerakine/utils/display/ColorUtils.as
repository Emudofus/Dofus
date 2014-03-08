package com.ankamagames.jerakine.utils.display
{
   public class ColorUtils extends Object
   {
      
      public function ColorUtils() {
         super();
      }
      
      public static function rgb2hsl(param1:uint) : Object {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         _loc2_ = (param1 & 16711680) >> 16;
         _loc3_ = (param1 & 65280) >> 8;
         _loc4_ = param1 & 255;
         _loc2_ = _loc2_ / 255;
         _loc3_ = _loc3_ / 255;
         _loc4_ = _loc4_ / 255;
         var _loc8_:Number = Math.min(_loc2_,_loc3_,_loc4_);
         var _loc9_:Number = Math.max(_loc2_,_loc3_,_loc4_);
         var _loc10_:Number = _loc9_ - _loc8_;
         _loc7_ = 1 - (_loc9_ + _loc8_) / 2;
         if(_loc10_ == 0)
         {
            _loc5_ = 0;
            _loc6_ = 0;
         }
         else
         {
            if(_loc9_ + _loc8_ < 1)
            {
               _loc6_ = 1 - _loc10_ / (_loc9_ + _loc8_);
            }
            else
            {
               _loc6_ = 1 - _loc10_ / (2 - _loc9_ - _loc8_);
            }
            _loc11_ = ((_loc9_ - _loc2_) / 6 + _loc10_ / 2) / _loc10_;
            _loc12_ = ((_loc9_ - _loc3_) / 6 + _loc10_ / 2) / _loc10_;
            _loc13_ = ((_loc9_ - _loc4_) / 6 + _loc10_ / 2) / _loc10_;
            if(_loc2_ == _loc9_)
            {
               _loc5_ = _loc13_ - _loc12_;
            }
            else
            {
               if(_loc3_ == _loc9_)
               {
                  _loc5_ = 1 / 3 + _loc11_ - _loc13_;
               }
               else
               {
                  if(_loc4_ == _loc9_)
                  {
                     _loc5_ = 2 / 3 + _loc12_ - _loc11_;
                  }
               }
            }
            if(_loc5_ < 0)
            {
               _loc5_++;
            }
            if(_loc5_ > 1)
            {
               _loc5_--;
            }
         }
         return 
            {
               "h":_loc5_,
               "s":_loc6_,
               "l":_loc7_
            };
      }
   }
}
