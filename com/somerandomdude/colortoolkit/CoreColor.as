package com.somerandomdude.colortoolkit
{
   import com.somerandomdude.colortoolkit.spaces.Lab;
   import com.somerandomdude.colortoolkit.spaces.Gray;
   import com.somerandomdude.colortoolkit.spaces.RGB;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.spaces.HSL;
   import com.somerandomdude.colortoolkit.spaces.CMYK;
   import com.somerandomdude.colortoolkit.spaces.XYZ;
   import com.somerandomdude.colortoolkit.spaces.YUV;
   
   public class CoreColor extends Object
   {
      
      public function CoreColor() {
         super();
      }
      
      protected var _color:int;
      
      public function toLab() : Lab {
         var _loc1_:Lab = new Lab();
         _loc1_.color = this._color;
         return _loc1_;
      }
      
      public function toGrayscale() : Gray {
         var _loc1_:Gray = new Gray();
         _loc1_.convertHexToGrayscale(this._color);
         return _loc1_;
      }
      
      public function toRGB() : RGB {
         var _loc1_:RGB = new RGB();
         _loc1_.color = this._color;
         return _loc1_;
      }
      
      public function toHSB() : HSB {
         var _loc1_:HSB = new HSB();
         _loc1_.color = this._color;
         return _loc1_;
      }
      
      public function toHSL() : HSL {
         var _loc1_:HSL = new HSL();
         _loc1_.color = this._color;
         return _loc1_;
      }
      
      public function toCMYK() : CMYK {
         var _loc1_:CMYK = new CMYK();
         _loc1_.color = this._color;
         return _loc1_;
      }
      
      public function toXYZ() : XYZ {
         var _loc1_:XYZ = new XYZ();
         _loc1_.color = this._color;
         return _loc1_;
      }
      
      public function toYUV() : YUV {
         var _loc1_:YUV = new YUV();
         _loc1_.color = this._color;
         return _loc1_;
      }
   }
}
