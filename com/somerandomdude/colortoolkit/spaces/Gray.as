package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class Gray extends CoreColor implements IColorSpace
   {
      
      public function Gray(param1:Number=0) {
         super();
         this.gray = param1;
         this._grayscale = this.convertGrayValuetoHex(param1);
      }
      
      private var _gray:Number;
      
      private var _grayscale:int;
      
      public function get gray() : Number {
         return this._gray;
      }
      
      public function set gray(param1:Number) : void {
         var param1:Number = Math.min(255,Math.max(param1,0));
         this._gray = param1;
         this._grayscale = this.convertGrayValuetoHex(this._gray);
      }
      
      public function get color() : int {
         return this._grayscale;
      }
      
      public function clone() : IColorSpace {
         return new Gray(this._gray);
      }
      
      public function convertHexToGrayscale(param1:int) : Number {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         _loc2_ = param1 >> 16 & 255;
         _loc3_ = param1 >> 8 & 255;
         _loc4_ = param1 & 255;
         var _loc5_:Number = 0.3 * _loc2_ + 0.59 * _loc3_ + 0.11 * _loc4_;
         this._gray = _loc5_;
         this._grayscale = _loc5_ << 16 ^ _loc5_ << 8 ^ _loc5_;
         return _loc5_ << 16 ^ _loc5_ << 8 ^ _loc5_;
      }
      
      private function convertGrayValuetoHex(param1:Number) : int {
         return param1 << 16 ^ param1 << 8 ^ param1;
      }
   }
}
