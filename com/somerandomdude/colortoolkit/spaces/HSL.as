package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class HSL extends CoreColor implements IColorSpace
   {
      
      public function HSL(param1:Number=0, param2:Number=0, param3:Number=0) {
         super();
         this._hue = Math.min(360,Math.max(param1,0));
         this._saturation = Math.min(100,Math.max(param2,0));
         this._lightness = Math.min(100,Math.max(param3,0));
         this._color = this.generateColorFromHSL(this._hue,this._saturation,this._lightness);
      }
      
      private var _hue:Number;
      
      private var _saturation:Number;
      
      private var _lightness:Number;
      
      public function get hue() : Number {
         return this._hue;
      }
      
      public function set hue(param1:Number) : void {
         this._hue = Math.min(360,Math.max(param1,0));
         this._color = this.generateColorFromHSL(this._hue,this._saturation,this._lightness);
      }
      
      public function get saturation() : Number {
         return this._saturation;
      }
      
      public function set saturation(param1:Number) : void {
         this._saturation = Math.min(100,Math.max(param1,0));
         this._color = this.generateColorFromHSL(this._hue,this._saturation,this._lightness);
      }
      
      public function get lightness() : Number {
         return this._lightness;
      }
      
      public function set lightness(param1:Number) : void {
         this._lightness = Math.min(100,Math.max(param1,0));
         this._color = this.generateColorFromHSL(this._hue,this._saturation,this._lightness);
      }
      
      public function get color() : Number {
         return this._color;
      }
      
      public function set color(param1:Number) : void {
         this._color = param1;
         var _loc2_:HSL = this.generateColorFromHex(param1);
         this._hue = _loc2_.hue;
         this._saturation = _loc2_.saturation;
         this._lightness = _loc2_.lightness;
      }
      
      public function clone() : IColorSpace {
         return new HSL(this._hue,this._saturation,this._lightness);
      }
      
      private function generateColorFromHex(param1:int) : HSL {
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
         var _loc5_:Number = Math.max(_loc2_,_loc3_,_loc4_);
         var _loc6_:Number = Math.min(_loc2_,_loc3_,_loc4_);
         _loc7_ = _loc8_ = _loc9_ = (_loc5_ + _loc6_) / 2;
         if(_loc5_ == _loc6_)
         {
            _loc7_ = _loc8_ = 0;
         }
         else
         {
            _loc10_ = _loc5_ - _loc6_;
            _loc8_ = _loc9_ > 0.5?_loc10_ / (2 - _loc5_ - _loc6_):_loc10_ / (_loc5_ + _loc6_);
            switch(_loc5_)
            {
               case _loc2_:
                  _loc7_ = (_loc3_ - _loc4_) / _loc10_ + (_loc3_ < _loc4_?6:0);
                  break;
               case _loc3_:
                  _loc7_ = (_loc4_ - _loc2_) / _loc10_ + 2;
                  break;
               case _loc4_:
                  _loc7_ = (_loc2_ - _loc3_) / _loc10_ + 4;
                  break;
            }
            _loc7_ = _loc7_ / 6;
         }
         _loc7_ = Math.round(_loc7_ * 360);
         _loc8_ = Math.round(_loc8_ * 100);
         _loc9_ = Math.round(_loc9_ * 100);
         return new HSL(_loc7_,_loc8_,_loc9_);
      }
      
      private function generateColorFromHSL(param1:Number, param2:Number, param3:Number) : int {
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         var q:Number = NaN;
         var p:Number = NaN;
         var hue:Number = param1;
         var saturation:Number = param2;
         var lightness:Number = param3;
         hue = hue / 360;
         saturation = saturation / 100;
         lightness = lightness / 100;
         if(saturation == 0)
         {
            r = g = b = lightness;
         }
         else
         {
            hue2rgb = function(param1:Number, param2:Number, param3:Number):Number
            {
               if(param3 < 0)
               {
                  param3 = param3 + 1;
               }
               if(param3 > 1)
               {
                  param3--;
               }
               if(param3 < 1 / 6)
               {
                  return param1 + (param2 - param1) * 6 * param3;
               }
               if(param3 < 1 / 2)
               {
                  return param2;
               }
               if(param3 < 2 / 3)
               {
                  return param1 + (param2 - param1) * (2 / 3 - param3) * 6;
               }
               return param1;
            };
            q = lightness < 0.5?lightness * (1 + saturation):lightness + saturation - lightness * saturation;
            p = 2 * lightness - q;
            r = hue2rgb(p,q,hue + 1 / 3);
            g = hue2rgb(p,q,hue);
            b = hue2rgb(p,q,hue - 1 / 3);
         }
         r = Math.floor(r * 255);
         g = Math.floor(g * 255);
         b = Math.floor(b * 255);
         return r << 16 ^ g << 8 ^ b;
      }
   }
}
