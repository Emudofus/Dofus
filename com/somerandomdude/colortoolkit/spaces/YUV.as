package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class YUV extends CoreColor implements IColorSpace
   {
      
      public function YUV(param1:Number=0, param2:Number=0, param3:Number=0) {
         super();
         this._y = param1;
         this._u = param2;
         this._v = param3;
         _color = this.generateColorFromYUV(param1,param2,param3);
      }
      
      private var _y:Number;
      
      private var _u:Number;
      
      private var _v:Number;
      
      public function get color() : int {
         return this._color;
      }
      
      public function set color(param1:int) : void {
         this._color = param1;
         var _loc2_:YUV = this.generateYUVFromColor(param1);
         this._y = _loc2_.y;
         this._u = _loc2_.u;
         this._v = _loc2_.v;
      }
      
      public function get y() : Number {
         return this._y;
      }
      
      public function set y(param1:Number) : void {
         this._y = param1;
         this._color = this.generateColorFromYUV(this._y,this._u,this._v);
      }
      
      public function get u() : Number {
         return this._u;
      }
      
      public function set u(param1:Number) : void {
         this._u = param1;
         this._color = this.generateColorFromYUV(this._y,this._u,this._v);
      }
      
      public function get v() : Number {
         return this._v;
      }
      
      public function set v(param1:Number) : void {
         this._v = param1;
         this._color = this.generateColorFromYUV(this._y,this._u,this._v);
      }
      
      public function clone() : IColorSpace {
         return new YUV(this._y,this._u,this._v);
      }
      
      private function generateColorFromYUV(param1:Number, param2:Number, param3:Number) : int {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         _loc4_ = param1 - 16;
         _loc5_ = param2 - 128;
         _loc6_ = param3 - 128;
         _loc7_ = Math.max(0,Math.min(298 * _loc4_ + 409 * _loc6_ + 128 >> 8,255));
         _loc8_ = Math.max(0,Math.min(298 * _loc4_ - 100 * _loc5_ - 208 * _loc6_ + 128 >> 8,255));
         _loc9_ = Math.max(0,Math.min(298 * _loc4_ + 516 * _loc5_ + 128 >> 8,255));
         var _loc10_:* = Math.round(_loc7_) << 16;
         var _loc11_:* = Math.round(_loc8_) << 8;
         var _loc12_:int = Math.round(_loc9_);
         return _loc10_ | _loc11_ | _loc12_;
      }
      
      private function generateYUVFromColor(param1:int) : YUV {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc2_:Number = (param1 >> 16 & 255) / 255;
         var _loc3_:Number = (param1 >> 8 & 255) / 255;
         var _loc4_:Number = (param1 & 255) / 255;
         _loc5_ = 0.299 * _loc2_ + 0.114 * _loc3_ + 0.587 * _loc4_;
         _loc6_ = 0.436 * (_loc4_ - _loc5_) / (1 - 0.114);
         _loc7_ = 0.615 * (_loc2_ - _loc5_) / (1 - 0.299);
         return new YUV(_loc2_ * 0.4124 + _loc3_ * 0.3576 + _loc4_ * 0.1805,_loc2_ * 0.2126 + _loc3_ * 0.7152 + _loc4_ * 0.0722,_loc2_ * 0.0193 + _loc3_ * 0.1192 + _loc4_ * 0.9505);
      }
   }
}
