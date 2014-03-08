package com.somerandomdude.colortoolkit.spaces
{
   import com.somerandomdude.colortoolkit.CoreColor;
   
   public class Lab extends CoreColor implements IColorSpace
   {
      
      public function Lab(param1:Number=0, param2:Number=0, param3:Number=0) {
         super();
         this._lightness = param1;
         this._a = param2;
         this._b = param3;
         this._color = this.generateColorFromLab(this._lightness,this._a,this._b);
      }
      
      private var _lightness:Number;
      
      private var _a:Number;
      
      private var _b:Number;
      
      public function get color() : int {
         return this._color;
      }
      
      public function set color(param1:int) : void {
         this._color = param1;
         var _loc2_:Lab = this.generateLabFromHex(param1);
         this._lightness = _loc2_.lightness;
         this._a = _loc2_.a;
         this._b = _loc2_.b;
      }
      
      public function get lightness() : Number {
         return this._lightness;
      }
      
      public function set lightness(param1:Number) : void {
         this._lightness = param1;
         this._color = this.generateColorFromLab(this._lightness,this._a,this._b);
      }
      
      public function get a() : Number {
         return this._a;
      }
      
      public function set a(param1:Number) : void {
         this._a = param1;
         this._color = this.generateColorFromLab(this._lightness,this._a,this._b);
      }
      
      public function get b() : Number {
         return this._b;
      }
      
      public function set b(param1:Number) : void {
         this._b = param1;
         this._color = this.generateColorFromLab(this._lightness,this._a,this._b);
      }
      
      public function clone() : IColorSpace {
         return new Lab(this._lightness,this._a,this._b);
      }
      
      private function generateColorFromLab(param1:Number, param2:Number, param3:Number) : int {
         var _loc4_:Number = 95.047;
         var _loc5_:Number = 100;
         var _loc6_:Number = 108.883;
         var _loc7_:Number = (param1 + 16) / 116;
         var _loc8_:Number = param2 / 500 + _loc7_;
         var _loc9_:Number = _loc7_ - param3 / 200;
         if(Math.pow(_loc7_,3) > 0.008856)
         {
            _loc7_ = Math.pow(_loc7_,3);
         }
         else
         {
            _loc7_ = (_loc7_ - 16 / 116) / 7.787;
         }
         if(Math.pow(_loc8_,3) > 0.008856)
         {
            _loc8_ = Math.pow(_loc8_,3);
         }
         else
         {
            _loc8_ = (_loc8_ - 16 / 116) / 7.787;
         }
         if(Math.pow(_loc9_,3) > 0.008856)
         {
            _loc9_ = Math.pow(_loc9_,3);
         }
         else
         {
            _loc9_ = (_loc9_ - 16 / 116) / 7.787;
         }
         var _loc10_:XYZ = new XYZ(_loc4_ * _loc8_,_loc5_ * _loc7_,_loc6_ * _loc9_);
         return _loc10_.color;
      }
      
      private function generateLabFromHex(param1:int) : Lab {
         var _loc2_:XYZ = new XYZ();
         _loc2_.color = param1;
         var _loc3_:Number = 95.047;
         var _loc4_:Number = 100;
         var _loc5_:Number = 108.883;
         var _loc6_:Number = _loc2_.x / _loc3_;
         var _loc7_:Number = _loc2_.y / _loc4_;
         var _loc8_:Number = _loc2_.z / _loc5_;
         if(_loc6_ > 0.008856)
         {
            _loc6_ = Math.pow(_loc6_,1 / 3);
         }
         else
         {
            _loc6_ = 7.787 * _loc6_ + 16 / 116;
         }
         if(_loc7_ > 0.008856)
         {
            _loc7_ = Math.pow(_loc7_,1 / 3);
         }
         else
         {
            _loc7_ = 7.787 * _loc7_ + 16 / 116;
         }
         if(_loc8_ > 0.008856)
         {
            _loc8_ = Math.pow(_loc8_,1 / 3);
         }
         else
         {
            _loc8_ = 7.787 * _loc8_ + 16 / 116;
         }
         return new Lab(116 * _loc7_ - 16,500 * (_loc6_ - _loc7_),200 * (_loc7_ - _loc8_));
      }
   }
}
