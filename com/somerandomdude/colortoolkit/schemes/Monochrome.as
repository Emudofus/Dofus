package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.HSB;
   
   public class Monochrome extends ColorWheelScheme implements IColorScheme
   {
      
      public function Monochrome(param1:int) {
         super(param1);
      }
      
      override protected function generate() : void {
         var _loc1_:HSB = new HSB();
         _loc1_.color = _primaryColor;
         var _loc2_:HSB = new HSB();
         _loc2_.color = _primaryColor;
         _loc2_.brightness = wrap(_loc1_.brightness,50,20,30);
         _loc2_.saturation = wrap(_loc1_.saturation,30,10,20);
         _colors.push(_loc2_.color);
         var _loc3_:HSB = new HSB();
         _loc3_.color = _primaryColor;
         _loc3_.brightness = wrap(_loc1_.brightness,20,20,60);
         _colors.push(_loc3_.color);
         var _loc4_:HSB = new HSB();
         _loc4_.color = _primaryColor;
         _loc4_.brightness = Math.max(20,_loc1_.brightness + (100 - _loc1_.brightness) * 0.2);
         _loc4_.saturation = wrap(_loc1_.saturation,30,10,30);
         _colors.push(_loc4_.color);
         var _loc5_:HSB = new HSB();
         _loc5_.color = _primaryColor;
         _loc5_.brightness = wrap(_loc1_.brightness,50,20,30);
         _colors.push(_loc5_.color);
      }
   }
}
