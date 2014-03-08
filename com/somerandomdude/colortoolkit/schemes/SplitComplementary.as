package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.ColorUtil;
   
   public class SplitComplementary extends ColorWheelScheme implements IColorScheme
   {
      
      public function SplitComplementary(param1:int) {
         super(param1);
      }
      
      override protected function generate() : void {
         var _loc1_:HSB = new HSB();
         var _loc2_:HSB = new HSB();
         _loc1_.color = ColorUtil.rybRotate(_primaryColor,150);
         _loc2_.color = ColorUtil.rybRotate(_primaryColor,210);
         _loc1_.brightness = _loc1_.brightness + 10;
         _loc2_.brightness = _loc2_.brightness + 10;
         _colors.push(_loc1_.color);
         _colors.push(_loc2_.color);
      }
   }
}
