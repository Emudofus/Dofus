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
      
      public static function setColorOpaque(color:int) : int {
         return 4.27819008E9 | (color >> 16 & 255) << 16 | (color >> 8 & 255) << 8 | color & 255;
      }
      
      public static function desaturate(color:int) : int {
         return new Gray(color).color;
      }
      
      public static function shiftBrightenessBy(color:int, degree:Number) : int {
         var col:HSB = new HSB();
         col.color = color;
         col.brightness = col.brightness + degree;
         return col.color;
      }
      
      public static function shiftSaturation(color:int, degree:Number) : int {
         var col:HSB = new HSB();
         col.color = color;
         col.saturation = col.saturation + degree;
         return col.color;
      }
      
      public static function shiftHue(color:int, degree:Number) : int {
         var col:HSB = new HSB();
         col.color = color;
         col.hue = col.hue + degree;
         return col.color;
      }
      
      public static function toRGB(color:int) : RGB {
         return new Color(color).toRGB();
      }
      
      public static function toCMYK(color:int) : CMYK {
         return new Color(color).toCMYK();
      }
      
      public static function toHSB(color:int) : HSB {
         return new Color(color).toHSB();
      }
      
      public static function toHSL(color:int) : HSL {
         return new Color(color).toHSL();
      }
      
      public static function toGrayscale(color:int) : Gray {
         return new Color(color).toGrayscale();
      }
      
      public static function toLab(color:int) : Lab {
         return new Color(color).toLab();
      }
      
      public static function toXYZ(color:int) : XYZ {
         return new Color(color).toXYZ();
      }
      
      public static function toYUV(color:int) : YUV {
         return new Color(color).toYUV();
      }
      
      public static function getComplement(color:int) : int {
         return rybRotate(color,180);
      }
      
      public static function rybRotate(color:int, angle:Number) : int {
         var a:* = NaN;
         var newHue:* = NaN;
         var x0:* = NaN;
         var y0:* = NaN;
         var x1:* = NaN;
         var y1:* = NaN;
         var xx0:* = NaN;
         var yy0:* = NaN;
         var xx1:* = NaN;
         var yy1:* = NaN;
         var hsb:HSB = new HSB();
         hsb.color = color;
         var i:int = 0;
         while(i < rybWheel.length)
         {
            x0 = rybWheel[i][0];
            y0 = rybWheel[i][1];
            x1 = rybWheel[i + 1][0];
            y1 = rybWheel[i + 1][1];
            if(y1 < y0)
            {
               y1 = y1 + 360;
            }
            if((y0 <= hsb.hue) && (hsb.hue <= y1))
            {
               a = 1 * x0 + (x1 - x0) * (hsb.hue - y0) / (y1 - y0);
               break;
            }
            i++;
         }
         a = a + angle % 360;
         if(a < 0)
         {
            a = 360 + a;
         }
         if(a > 360)
         {
            a = a - 360;
         }
         a = a % 360;
         var k:int = 0;
         while(k < rybWheel.length)
         {
            xx0 = rybWheel[k][0];
            yy0 = rybWheel[k][1];
            xx1 = rybWheel[k + 1][0];
            yy1 = rybWheel[k + 1][1];
            if(yy1 < yy0)
            {
               yy1 = yy1 + 360;
            }
            if((xx0 <= a) && (a <= xx1))
            {
               newHue = 1 * yy0 + (yy1 - yy0) * (a - xx0) / (xx1 - xx0);
               break;
            }
            k++;
         }
         newHue = newHue % 360;
         hsb.hue = newHue;
         return hsb.color;
      }
   }
}
