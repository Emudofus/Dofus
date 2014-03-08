package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class HSB extends CoreColor implements IColorSpace
   {
      
      public function HSB(param1:Number=0, param2:Number=0, param3:Number=0) {
         super();
         this._hue = Math.min(360,Math.max(param1,0));
         this._saturation = Math.min(100,Math.max(param2,0));
         this._brightness = Math.min(100,Math.max(param3,0));
         this._color = this.generateColorFromHSB(this._hue,this._saturation,this._brightness);
      }
      
      private var _hue:Number;
      
      private var _saturation:Number;
      
      private var _brightness:Number;
      
      public function get hue() : Number {
         return this._hue;
      }
      
      public function set hue(param1:Number) : void {
         this._hue = Math.min(360,Math.max(param1,0));
         this._color = this.generateColorFromHSB(this._hue,this._saturation,this._brightness);
      }
      
      public function get saturation() : Number {
         return this._saturation;
      }
      
      public function set saturation(param1:Number) : void {
         this._saturation = Math.min(100,Math.max(param1,0));
         this._color = this.generateColorFromHSB(this._hue,this._saturation,this._brightness);
      }
      
      public function get brightness() : Number {
         return this._brightness;
      }
      
      public function set brightness(param1:Number) : void {
         this._brightness = Math.min(100,Math.max(param1,0));
         this._color = this.generateColorFromHSB(this._hue,this._saturation,this._brightness);
      }
      
      public function get color() : Number {
         return this._color;
      }
      
      public function set color(param1:Number) : void {
         this._color = param1;
         var _loc2_:HSB = this.generateColorFromHex(param1);
         this._hue = _loc2_.hue;
         this._saturation = _loc2_.saturation;
         this._brightness = _loc2_.brightness;
      }
      
      public function clone() : IColorSpace {
         return new HSB(this._hue,this._saturation,this._brightness);
      }
      
      private function generateColorFromHex(param1:int) : HSB {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc2_:Number = param1 >> 16 & 255;
         var _loc3_:Number = param1 >> 8 & 255;
         var _loc4_:Number = param1 & 255;
         _loc2_ = _loc2_ / 255;
         _loc3_ = _loc3_ / 255;
         _loc4_ = _loc4_ / 255;
         _loc8_ = Math.min(_loc2_,_loc3_,_loc4_);
         _loc9_ = Math.max(_loc2_,_loc3_,_loc4_);
         _loc7_ = _loc9_ * 100;
         _loc10_ = _loc9_ - _loc8_;
         if(_loc10_ == 0)
         {
            _loc10_ = 1;
         }
         if(_loc9_ != 0)
         {
            _loc6_ = _loc10_ / _loc9_ * 100;
            if(_loc2_ == _loc9_)
            {
               _loc5_ = (_loc3_ - _loc4_) / _loc10_;
            }
            else
            {
               if(_loc3_ == _loc9_)
               {
                  _loc5_ = 2 + (_loc4_ - _loc2_) / _loc10_;
               }
               else
               {
                  _loc5_ = 4 + (_loc2_ - _loc3_) / _loc10_;
               }
            }
            _loc5_ = _loc5_ * 60;
            if(_loc5_ < 0)
            {
               _loc5_ = _loc5_ + 360;
            }
            return new HSB(_loc5_,_loc6_,_loc7_);
         }
         _loc6_ = 0;
         _loc5_ = -1;
         return new HSB(_loc5_,_loc6_,_loc7_);
      }
      
      private function generateColorFromHSB(param1:Number, param2:Number, param3:Number) : int {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var param1:Number = param1 % 360;
         if(param3 == 0)
         {
            return 0;
         }
         var param2:Number = param2 / 100;
         var param3:Number = param3 / 100;
         param1 = param1 / 60;
         _loc7_ = Math.floor(param1);
         _loc8_ = param1 - _loc7_;
         _loc9_ = param3 * (1 - param2);
         _loc10_ = param3 * (1 - param2 * _loc8_);
         _loc11_ = param3 * (1 - param2 * (1 - _loc8_));
         if(_loc7_ == 0)
         {
            _loc4_ = param3;
            _loc5_ = _loc11_;
            _loc6_ = _loc9_;
         }
         else
         {
            if(_loc7_ == 1)
            {
               _loc4_ = _loc10_;
               _loc5_ = param3;
               _loc6_ = _loc9_;
            }
            else
            {
               if(_loc7_ == 2)
               {
                  _loc4_ = _loc9_;
                  _loc5_ = param3;
                  _loc6_ = _loc11_;
               }
               else
               {
                  if(_loc7_ == 3)
                  {
                     _loc4_ = _loc9_;
                     _loc5_ = _loc10_;
                     _loc6_ = param3;
                  }
                  else
                  {
                     if(_loc7_ == 4)
                     {
                        _loc4_ = _loc11_;
                        _loc5_ = _loc9_;
                        _loc6_ = param3;
                     }
                     else
                     {
                        if(_loc7_ == 5)
                        {
                           _loc4_ = param3;
                           _loc5_ = _loc9_;
                           _loc6_ = _loc10_;
                        }
                     }
                  }
               }
            }
         }
         _loc4_ = Math.floor(_loc4_ * 255);
         _loc5_ = Math.floor(_loc5_ * 255);
         _loc6_ = Math.floor(_loc6_ * 255);
         return _loc4_ << 16 ^ _loc5_ << 8 ^ _loc6_;
      }
   }
}
