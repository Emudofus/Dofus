package com.somerandomdude.colortoolkit.schemes
{
   public class ColorWheelScheme extends ColorScheme
   {
      
      public function ColorWheelScheme(param1:int) {
         super();
         this.primaryColor = param1;
      }
      
      protected var _primaryColor:int;
      
      override public function addColor(param1:int) : void {
      }
      
      override public function removeColor(param1:int) : void {
      }
      
      public function get primaryColor() : int {
         return this._primaryColor;
      }
      
      public function set primaryColor(param1:int) : void {
         if(!_colors)
         {
            _colors = new ColorList();
         }
         _colors.empty();
         this._primaryColor = param1;
         _colors.push(this._primaryColor);
         this.generate();
      }
      
      protected function generate() : void {
         throw new Error("Method must be called by child class");
      }
      
      protected function wrap(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         var _loc5_:Number = 0;
         if(param1 - param2 < param3)
         {
            _loc5_ = param1 + param4;
         }
         else
         {
            _loc5_ = param1 - param2;
         }
         return _loc5_;
      }
   }
}
