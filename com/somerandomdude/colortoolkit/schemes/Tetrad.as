package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.Color;
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.ColorUtil;
   
   public class Tetrad extends ColorWheelScheme implements IColorScheme
   {
      
      public function Tetrad(param1:int, param2:Number=90) {
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
      
      public var alt:Boolean;
      
      override protected function generate() : void {
         var _loc5_:* = NaN;
         var _loc1_:Color = new Color(_primaryColor);
         var _loc2_:HSB = new HSB();
         _loc2_.color = ColorUtil.rybRotate(_primaryColor,this._angle);
         if(!this.alt)
         {
            if(_loc1_.brightness < 50)
            {
               _loc2_.brightness = _loc2_.brightness + 20;
            }
            else
            {
               _loc2_.brightness = _loc2_.brightness - 20;
            }
         }
         else
         {
            _loc5_ = (50 - _loc1_.brightness) / 50;
            _loc2_.brightness = _loc2_.brightness + Math.min(20,Math.max(-20,20 * _loc5_));
         }
         _colors.push(_loc2_.color);
         var _loc3_:HSB = new HSB();
         _loc3_.color = ColorUtil.rybRotate(_primaryColor,this._angle * 2);
         if(!this.alt)
         {
            if(_loc1_.brightness > 50)
            {
               _loc3_.brightness = _loc3_.brightness + 10;
            }
            else
            {
               _loc3_.brightness = _loc3_.brightness - 10;
            }
         }
         else
         {
            _loc5_ = (50 - _loc1_.brightness) / 50;
            _loc3_.brightness = _loc3_.brightness + Math.min(10,Math.max(-10,10 * _loc5_));
         }
         _colors.push(_loc3_.color);
         var _loc4_:HSB = new HSB();
         _loc4_.color = ColorUtil.rybRotate(_primaryColor,this._angle * 3);
         _loc4_.brightness = _loc4_.brightness + 10;
         _colors.push(_loc4_.color);
      }
   }
}
