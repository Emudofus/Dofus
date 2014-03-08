package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class CMYK extends CoreColor implements IColorSpace
   {
      
      public function CMYK(param1:Number=0, param2:Number=0, param3:Number=0, param4:Number=0) {
         super();
         this._cyan = Math.min(100,Math.max(param1,0));
         this._magenta = Math.min(100,Math.max(param2,0));
         this._yellow = Math.min(100,Math.max(param3,0));
         this._black = Math.min(100,Math.max(param4,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      private var _cyan:Number;
      
      private var _yellow:Number;
      
      private var _magenta:Number;
      
      private var _black:Number;
      
      public function get cyan() : Number {
         return this._cyan;
      }
      
      public function set cyan(param1:Number) : void {
         this._cyan = Math.min(100,Math.max(param1,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get magenta() : Number {
         return this._magenta;
      }
      
      public function set magenta(param1:Number) : void {
         this._magenta = Math.min(100,Math.max(param1,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get yellow() : Number {
         return this._yellow;
      }
      
      public function set yellow(param1:Number) : void {
         this._yellow = Math.min(100,Math.max(param1,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get black() : Number {
         return this._black;
      }
      
      public function set black(param1:Number) : void {
         this._black = Math.min(100,Math.max(param1,0));
         this._color = this.generateColorsFromCMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      public function get color() : int {
         return this._color;
      }
      
      public function set color(param1:int) : void {
         this._color = param1;
         var _loc2_:CMYK = this.generateColorsFromHex(param1);
         this._cyan = _loc2_.cyan;
         this._magenta = _loc2_.magenta;
         this._yellow = _loc2_.yellow;
         this._black = _loc2_.black;
      }
      
      public function clone() : IColorSpace {
         return new CMYK(this._cyan,this._magenta,this._yellow,this._black);
      }
      
      private function generateColorsFromHex(param1:int) : CMYK {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc2_:Number = param1 >> 16 & 255;
         var _loc3_:Number = param1 >> 8 & 255;
         var _loc4_:Number = param1 & 255;
         _loc5_ = 1 - _loc2_ / 255;
         _loc6_ = 1 - _loc3_ / 255;
         _loc7_ = 1 - _loc4_ / 255;
         _loc9_ = 1;
         if(_loc5_ < _loc9_)
         {
            _loc9_ = _loc5_;
         }
         if(_loc6_ < _loc9_)
         {
            _loc9_ = _loc6_;
         }
         if(_loc7_ < _loc9_)
         {
            _loc9_ = _loc7_;
         }
         if(_loc9_ == 1)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
         }
         else
         {
            _loc5_ = (_loc5_ - _loc9_) / (1 - _loc9_) * 100;
            _loc6_ = (_loc6_ - _loc9_) / (1 - _loc9_) * 100;
            _loc7_ = (_loc7_ - _loc9_) / (1 - _loc9_) * 100;
         }
         _loc8_ = _loc9_ * 100;
         return new CMYK(_loc5_,_loc6_,_loc7_,_loc8_);
      }
      
      private function generateColorsFromCMYK(param1:Number, param2:Number, param3:Number, param4:Number) : int {
         var param1:Number = Math.min(100,param1 + param4);
         var param2:Number = Math.min(100,param2 + param4);
         var param3:Number = Math.min(100,param3 + param4);
         var _loc5_:Number = (100 - param1) * 255 / 100;
         var _loc6_:Number = (100 - param2) * 255 / 100;
         var _loc7_:Number = (100 - param3) * 255 / 100;
         return _loc5_ << 16 ^ _loc6_ << 8 ^ _loc7_;
      }
   }
}
