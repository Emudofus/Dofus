package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.HSB;
   import com.somerandomdude.colortoolkit.ColorUtil;
   
   public class Analogous extends ColorWheelScheme implements IColorScheme
   {
      
      public function Analogous(param1:int, param2:Number=10, param3:Number=25) {
         this._angle = param2;
         this._contrast = param3;
         super(param1);
      }
      
      private var _angle:Number;
      
      private var _contrast:Number;
      
      public function get angle() : Number {
         return this._angle;
      }
      
      public function set angle(param1:Number) : void {
         _colors = new ColorList();
         this._angle = param1;
         this.generate();
      }
      
      public function get contrast() : Number {
         return this._contrast;
      }
      
      public function set contrast(param1:Number) : void {
         _colors = new ColorList();
         this._contrast = param1;
         this.generate();
      }
      
      override protected function generate() : void {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc1_:HSB = new HSB();
         _loc1_.color = _primaryColor;
         var _loc2_:HSB = new HSB();
         var _loc3_:Array = new Array(new Array(1,2.2),new Array(2,1),new Array(-1,-0.5),new Array(-2,1));
         var _loc4_:Number = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_][0];
            _loc6_ = _loc3_[_loc4_][1];
            _loc2_.color = ColorUtil.rybRotate(_loc1_.color,this._angle * _loc5_);
            _loc7_ = 0.44 - _loc6_ * 0.1;
            if(_loc1_.brightness - this._contrast * _loc6_ < _loc7_)
            {
               _loc2_.brightness = _loc7_ * 100;
            }
            else
            {
               _loc2_.brightness = _loc1_.brightness - this._contrast * _loc6_;
            }
            _loc2_.saturation = _loc2_.saturation - 5;
            _colors.push(_loc2_.color);
            _loc4_++;
         }
      }
   }
}
