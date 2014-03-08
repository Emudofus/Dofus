package com.ankamagames.jerakine.utils.prng
{
   public class ParkMillerCarta extends Object implements PRNG
   {
      
      public function ParkMillerCarta(param1:uint=0) {
         super();
         this.seed(param1);
      }
      
      private var _seed:uint;
      
      public function seed(param1:uint) : void {
         this._seed = param1;
      }
      
      public function nextInt() : uint {
         return this.gen();
      }
      
      public function nextDouble() : Number {
         return this.gen() / 2147483647;
      }
      
      public function nextIntR(param1:Number, param2:Number) : uint {
         var param1:Number = param1 - 0.4999;
         var param2:Number = param2 + 0.4999;
         return Math.round(param1 + (param2 - param1) * this.nextDouble());
      }
      
      public function nextDoubleR(param1:Number, param2:Number) : Number {
         return param1 + (param2 - param1) * this.nextDouble();
      }
      
      private function gen() : uint {
         var _loc1_:uint = 16807 * (this._seed >> 16);
         var _loc2_:uint = 16807 * (this._seed & 65535) + ((_loc1_ & 32767) << 16) + (_loc1_ >> 15);
         return this._seed = _loc2_ > 2147483647?_loc2_ - 2147483647:_loc2_;
      }
   }
}
