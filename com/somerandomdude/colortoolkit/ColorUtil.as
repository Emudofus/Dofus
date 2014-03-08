package com.somerandomdude.colortoolkit
{
   import com.somerandomdude.colortoolkit.spaces.Gray;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.spaces.RGB;
   import com.somerandomdude.colortoolkit.spaces.CMYK;
   import com.somerandomdude.colortoolkit.spaces.HSL;
   import com.somerandomdude.colortoolkit.spaces.Lab;
   import com.somerandomdude.colortoolkit.spaces.XYZ;
   import com.somerandomdude.colortoolkit.spaces.YUV;
   
   public class ColorUtil extends Object
   {
      
      public function ColorUtil() {
         super();
      }
      
      private static var rybWheel:Array = [[0,0],[15,8],[30,17],[45,26],[60,34],[75,41],[90,48],[105,54],[120,60],[135,81],[150,103],[165,123],[180,138],[195,155],[210,171],[225,187],[240,204],[255,219],[270,234],[285,251],[300,267],[315,282],[330,298],[345,329],[360,0]];
      
      public static function setColorOpaque(param1:int) : int {
         return 4.27819008E9 | (param1 >> 16 & 255) << 16 | (param1 >> 8 & 255) << 8 | param1 & 255;
      }
      
      public static function desaturate(param1:int) : int {
         return new Gray(param1).color;
      }
      
      public static function shiftBrightenessBy(param1:int, param2:Number) : int {
         var _loc3_:HSB = new HSB();
         _loc3_.color = param1;
         _loc3_.brightness = _loc3_.brightness + param2;
         return _loc3_.color;
      }
      
      public static function shiftSaturation(param1:int, param2:Number) : int {
         var _loc3_:HSB = new HSB();
         _loc3_.color = param1;
         _loc3_.saturation = _loc3_.saturation + param2;
         return _loc3_.color;
      }
      
      public static function shiftHue(param1:int, param2:Number) : int {
         var _loc3_:HSB = new HSB();
         _loc3_.color = param1;
         _loc3_.hue = _loc3_.hue + param2;
         return _loc3_.color;
      }
      
      public static function toRGB(param1:int) : RGB {
         return new Color(param1).toRGB();
      }
      
      public static function toCMYK(param1:int) : CMYK {
         return new Color(param1).toCMYK();
      }
      
      public static function toHSB(param1:int) : HSB {
         return new Color(param1).toHSB();
      }
      
      public static function toHSL(param1:int) : HSL {
         return new Color(param1).toHSL();
      }
      
      public static function toGrayscale(param1:int) : Gray {
         return new Color(param1).toGrayscale();
      }
      
      public static function toLab(param1:int) : Lab {
         return new Color(param1).toLab();
      }
      
      public static function toXYZ(param1:int) : XYZ {
         return new Color(param1).toXYZ();
      }
      
      public static function toYUV(param1:int) : YUV {
         return new Color(param1).toYUV();
      }
      
      public static function getComplement(param1:int) : int {
         return rybRotate(param1,180);
      }
      
      public static function rybRotate(param1:int, param2:Number) : int {
         var _loc4_:* = NaN;
         var _loc6_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc15_:* = NaN;
         var _loc3_:HSB = new HSB();
         _loc3_.color = param1;
         var _loc5_:* = 0;
         while(_loc5_ < rybWheel.length)
         {
            _loc8_ = rybWheel[_loc5_][0];
            _loc9_ = rybWheel[_loc5_][1];
            _loc10_ = rybWheel[_loc5_ + 1][0];
            _loc11_ = rybWheel[_loc5_ + 1][1];
            if(_loc11_ < _loc9_)
            {
               _loc11_ = _loc11_ + 360;
            }
            if(_loc9_ <= _loc3_.hue && _loc3_.hue <= _loc11_)
            {
               _loc4_ = 1 * _loc8_ + (_loc10_ - _loc8_) * (_loc3_.hue - _loc9_) / (_loc11_ - _loc9_);
               break;
            }
            _loc5_++;
         }
         _loc4_ = _loc4_ + param2 % 360;
         if(_loc4_ < 0)
         {
            _loc4_ = 360 + _loc4_;
         }
         if(_loc4_ > 360)
         {
            _loc4_ = _loc4_ - 360;
         }
         _loc4_ = _loc4_ % 360;
         var _loc7_:* = 0;
         while(_loc7_ < rybWheel.length)
         {
            _loc12_ = rybWheel[_loc7_][0];
            _loc13_ = rybWheel[_loc7_][1];
            _loc14_ = rybWheel[_loc7_ + 1][0];
            _loc15_ = rybWheel[_loc7_ + 1][1];
            if(_loc15_ < _loc13_)
            {
               _loc15_ = _loc15_ + 360;
            }
            if(_loc12_ <= _loc4_ && _loc4_ <= _loc14_)
            {
               _loc6_ = 1 * _loc13_ + (_loc15_ - _loc13_) * (_loc4_ - _loc12_) / (_loc14_ - _loc12_);
               break;
            }
            _loc7_++;
         }
         _loc6_ = _loc6_ % 360;
         _loc3_.hue = _loc6_;
         return _loc3_.color;
      }
   }
}
