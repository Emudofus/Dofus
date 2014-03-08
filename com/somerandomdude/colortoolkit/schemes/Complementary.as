package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.ColorUtil;
   
   public class Complementary extends ColorWheelScheme implements IColorScheme
   {
      
      public function Complementary(param1:int) {
         super(param1);
      }
      
      override protected function generate() : void {
         var _loc1_:HSB = new HSB();
         _loc1_.color = _primaryColor;
         var _loc2_:HSB = new HSB();
         _loc2_.color = _primaryColor;
         if(_loc1_.brightness > 40)
         {
            _loc2_.brightness = 10 + _loc1_.brightness * 0.25;
         }
         else
         {
            _loc2_.brightness = 100 - _loc1_.brightness * 0.25;
         }
         _colors.push(_loc2_.color);
         var _loc3_:HSB = new HSB();
         _loc3_.color = _primaryColor;
         _loc3_.brightness = 30 + _loc1_.brightness;
         _loc3_.saturation = 10 + _loc1_.saturation * 0.3;
         _colors.push(_loc3_.color);
         var _loc4_:HSB = new HSB();
         _loc4_.color = ColorUtil.rybRotate(_primaryColor,180);
         _colors.push(_loc4_.color);
         var _loc5_:HSB = new HSB();
         _loc5_.color = _loc4_.color;
         if(_loc4_.brightness > 30)
         {
            _loc5_.brightness = 10 + _loc4_.brightness * 0.25;
         }
         else
         {
            _loc5_.brightness = 100 - _loc4_.brightness * 0.25;
         }
         _colors.push(_loc5_.color);
         var _loc6_:HSB = new HSB();
         _loc6_.color = _loc4_.color;
         _loc6_.brightness = 30 + _loc4_.brightness;
         _loc6_.saturation = 10 + _loc4_.saturation * 0.3;
         _colors.push(_loc6_.color);
      }
   }
}
