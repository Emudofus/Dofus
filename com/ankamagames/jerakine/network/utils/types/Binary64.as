package com.ankamagames.jerakine.network.utils.types
{
   public class Binary64 extends Object
   {
      
      public function Binary64(param1:uint = 0, param2:uint = 0)
      {
         super();
         this.low = param1;
         this.internalHigh = param2;
      }
      
      static const CHAR_CODE_0:uint = "0".charCodeAt();
      
      static const CHAR_CODE_9:uint = "9".charCodeAt();
      
      static const CHAR_CODE_A:uint = "a".charCodeAt();
      
      static const CHAR_CODE_Z:uint = "z".charCodeAt();
      
      public var low:uint;
      
      var internalHigh:uint;
      
      final function div(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         _loc2_ = this.internalHigh % param1;
         var _loc3_:uint = (this.low % param1 + _loc2_ * 6) % param1;
         this.internalHigh = this.internalHigh / param1;
         var _loc4_:Number = (_loc2_ * 4.294967296E9 + this.low) / param1;
         this.internalHigh = this.internalHigh + uint(_loc4_ / 4.294967296E9);
         this.low = _loc4_;
         return _loc3_;
      }
      
      final function mul(param1:uint) : void
      {
         var _loc2_:Number = Number(this.low) * param1;
         this.internalHigh = this.internalHigh * param1;
         this.internalHigh = this.internalHigh + uint(_loc2_ / 4.294967296E9);
         this.low = this.low * param1;
      }
      
      final function add(param1:uint) : void
      {
         var _loc2_:Number = Number(this.low) + param1;
         this.internalHigh = this.internalHigh + uint(_loc2_ / 4.294967296E9);
         this.low = _loc2_;
      }
      
      final function bitwiseNot() : void
      {
         this.low = ~this.low;
         this.internalHigh = ~this.internalHigh;
      }
   }
}
