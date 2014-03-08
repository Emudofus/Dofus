package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.ColorUtil;
   
   public class Triad extends ColorWheelScheme implements IColorScheme
   {
      
      public function Triad(param1:int, param2:Number=120) {
         this._angle = param2;
         super(param1);
      }
      
      private var _angle:Number;
      
      public function get angle() : Number {
         return this._angle;
      }
      
      public function set angle(param1:Number) : void {
         _colors = new ColorList();
         this._angle = param1;
         this.generate();
      }
      
      override protected function generate() : void {
         var _loc1_:HSB = new HSB();
         _loc1_.color = ColorUtil.rybRotate(_primaryColor,this._angle);
         _loc1_.brightness = _loc1_.brightness + 10;
         _colors.push(_loc1_.color);
         var _loc2_:HSB = new HSB();
         _loc2_.color = ColorUtil.rybRotate(_primaryColor,-this._angle);
         _loc2_.brightness = _loc2_.brightness + 10;
         _colors.push(_loc2_.color);
      }
   }
}
