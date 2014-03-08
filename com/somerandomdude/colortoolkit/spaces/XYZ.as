package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class XYZ extends CoreColor implements IColorSpace
   {
      
      public function XYZ(param1:Number=0, param2:Number=0, param3:Number=0) {
         super();
         this._x = param1;
         this._y = param2;
         this._z = param3;
         this._color = this.generateColorFromXYZ(param1,param2,param3);
      }
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _z:Number;
      
      public function get color() : int {
         return this._color;
      }
      
      public function set color(param1:int) : void {
         this._color = param1;
         var _loc2_:XYZ = this.generateXYZFromColor(param1);
         this._x = _loc2_.x;
         this._y = _loc2_.y;
         this._z = _loc2_.z;
      }
      
      public function get x() : Number {
         return this._x;
      }
      
      public function set x(param1:Number) : void {
         this._x = param1;
         this._color = this.generateColorFromXYZ(this._x,this._y,this._z);
      }
      
      public function get y() : Number {
         return this._y;
      }
      
      public function set y(param1:Number) : void {
         this._y = param1;
         this._color = this.generateColorFromXYZ(this._x,this._y,this._z);
      }
      
      public function get z() : Number {
         return this._z;
      }
      
      public function set z(param1:Number) : void {
         this._z = param1;
         this._color = this.generateColorFromXYZ(this._x,this._y,this._z);
      }
      
      public function clone() : IColorSpace {
         return new XYZ(this._x,this._y,this._z);
      }
      
      private function generateColorFromXYZ(param1:Number, param2:Number, param3:Number) : int {
         var _loc4_:Number = param1 / 100;
         var _loc5_:Number = param2 / 100;
         var _loc6_:Number = param3 / 100;
         var _loc7_:Number = _loc4_ * 3.2406 + _loc5_ * -1.5372 + _loc6_ * -0.4986;
         var _loc8_:Number = _loc4_ * -0.9689 + _loc5_ * 1.8758 + _loc6_ * 0.0415;
         var _loc9_:Number = _loc4_ * 0.0557 + _loc5_ * -0.204 + _loc6_ * 1.057;
         if(_loc7_ > 0.0031308)
         {
            _loc7_ = 1.055 * Math.pow(_loc7_,1 / 2.4) - 0.055;
         }
         else
         {
            _loc7_ = 12.92 * _loc7_;
         }
         if(_loc8_ > 0.0031308)
         {
            _loc8_ = 1.055 * Math.pow(_loc8_,1 / 2.4) - 0.055;
         }
         else
         {
            _loc8_ = 12.92 * _loc8_;
         }
         if(_loc9_ > 0.0031308)
         {
            _loc9_ = 1.055 * Math.pow(_loc9_,1 / 2.4) - 0.055;
         }
         else
         {
            _loc9_ = 12.92 * _loc9_;
         }
         var _loc10_:* = Math.round(_loc7_) << 16;
         var _loc11_:* = Math.round(_loc8_) << 8;
         var _loc12_:int = Math.round(_loc9_);
         return _loc10_ | _loc11_ | _loc12_;
      }
      
      private function generateXYZFromColor(param1:int) : XYZ {
         var _loc2_:Number = (param1 >> 16 & 255) / 255;
         var _loc3_:Number = (param1 >> 8 & 255) / 255;
         var _loc4_:Number = (param1 & 255) / 255;
         if(_loc2_ > 0.04045)
         {
            _loc2_ = Math.pow((_loc2_ + 0.055) / 1.055,2.4);
         }
         else
         {
            _loc2_ = _loc2_ / 12.92;
         }
         if(_loc3_ > 0.04045)
         {
            _loc3_ = Math.pow((_loc3_ + 0.055) / 1.055,2.4);
         }
         else
         {
            _loc3_ = _loc3_ / 12.92;
         }
         if(_loc4_ > 0.04045)
         {
            _loc4_ = Math.pow((_loc4_ + 0.055) / 1.055,2.4);
         }
         else
         {
            _loc4_ = _loc4_ / 12.92;
         }
         _loc2_ = _loc2_ * 100;
         _loc3_ = _loc3_ * 100;
         _loc4_ = _loc4_ * 100;
         return new XYZ(_loc2_ * 0.4124 + _loc3_ * 0.3576 + _loc4_ * 0.1805,_loc2_ * 0.2126 + _loc3_ * 0.7152 + _loc4_ * 0.0722,_loc2_ * 0.0193 + _loc3_ * 0.1192 + _loc4_ * 0.9505);
      }
   }
}
