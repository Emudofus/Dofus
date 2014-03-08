package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.ColorUtil;
   
   public class FlippedCompound extends ColorWheelScheme implements IColorScheme
   {
      
      public function FlippedCompound(param1:int) {
         super(param1);
      }
      
      override protected function generate() : void {
         var _loc1_:HSB = new HSB();
         _loc1_.color = _primaryColor;
         var _loc2_:Number = 1;
         var _loc3_:HSB = new HSB();
         _loc3_.color = ColorUtil.rybRotate(_primaryColor,30 * -1);
         _loc3_.brightness = wrap(_loc1_.brightness,25,60,25);
         _colors.push(_loc3_.color);
         var _loc4_:HSB = new HSB();
         _loc4_.color = ColorUtil.rybRotate(_primaryColor,30 * -1);
         _loc4_.brightness = wrap(_loc1_.brightness,40,10,40);
         _loc4_.saturation = wrap(_loc1_.saturation,40,20,40);
         _colors.push(_loc4_.color);
         var _loc5_:HSB = new HSB();
         _loc5_.color = ColorUtil.rybRotate(_primaryColor,160 * -1);
         _loc5_.brightness = Math.max(20,_loc1_.brightness);
         _loc5_.saturation = wrap(_loc1_.saturation,25,10,25);
         _colors.push(_loc5_.color);
         var _loc6_:HSB = new HSB();
         _loc6_.color = ColorUtil.rybRotate(_primaryColor,150 * -1);
         _loc6_.brightness = wrap(_loc1_.brightness,30,60,30);
         _loc6_.saturation = wrap(_loc1_.saturation,10,80,10);
         _colors.push(_loc6_.color);
         var _loc7_:HSB = new HSB();
         _loc7_.color = ColorUtil.rybRotate(_primaryColor,150 * -1);
         _loc7_.brightness = wrap(_loc1_.brightness,40,20,40);
         _loc7_.saturation = wrap(_loc1_.saturation,10,80,10);
         _colors.push(_loc7_.color);
      }
   }
}
