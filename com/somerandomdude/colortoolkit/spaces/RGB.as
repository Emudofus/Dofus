package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class RGB extends CoreColor implements IColorSpace
   {
      
      public function RGB(param1:Number=0, param2:Number=0, param3:Number=0) {
         super();
         this._red = Math.min(255,Math.max(param1,0));
         this._green = Math.min(255,Math.max(param2,0));
         this._blue = Math.min(255,Math.max(param3,0));
         this._color = this.RGBToHex(this._red,this._green,this._blue);
      }
      
      private var _red:Number;
      
      private var _green:Number;
      
      private var _blue:Number;
      
      public function get red() : Number {
         return this._red;
      }
      
      public function set red(param1:Number) : void {
         var param1:Number = Math.min(255,Math.max(param1,0));
         this._red = param1;
         this._color = this.RGBToHex(this._red,this._green,this._blue);
      }
      
      public function get green() : Number {
         return this._green;
      }
      
      public function set green(param1:Number) : void {
         var param1:Number = Math.min(255,Math.max(param1,0));
         this._green = param1;
         this._color = this.RGBToHex(this._red,this._green,this._blue);
      }
      
      public function get blue() : Number {
         return this._blue;
      }
      
      public function set blue(param1:Number) : void {
         var param1:Number = Math.min(255,Math.max(param1,0));
         this._blue = param1;
         this._color = this.RGBToHex(this._red,this._green,this._blue);
      }
      
      public function get color() : int {
         return this._color;
      }
      
      public function set color(param1:int) : void {
         this._color = param1;
         var _loc2_:RGB = this.hexToRGB(param1);
         this._red = _loc2_.red;
         this._green = _loc2_.green;
         this._blue = _loc2_.blue;
      }
      
      public function clone() : IColorSpace {
         return new RGB(this._red,this._green,this._blue);
      }
      
      private function hexToRGB(param1:int) : RGB {
         return new RGB(param1 >> 16 & 255,param1 >> 8 & 255,param1 & 255);
      }
      
      private function RGBToHex(param1:int, param2:int, param3:int) : int {
         var _loc4_:* = Math.round(param1) << 16;
         var _loc5_:* = Math.round(param2) << 8;
         var _loc6_:int = Math.round(param3);
         var _loc7_:* = _loc4_ | _loc5_ | _loc6_;
         return _loc7_;
      }
   }
}
