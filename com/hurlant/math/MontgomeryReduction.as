package com.hurlant.math
{
   use namespace bi_internal;
   
   class MontgomeryReduction extends Object implements IReduction
   {
      
      function MontgomeryReduction(param1:BigInteger) {
         super();
         this.m = param1;
         this.mp = param1.invDigit();
         this.mpl = this.mp & 32767;
         this.mph = this.mp >> 15;
         this.um = 1 << BigInteger.DB - 15-1;
         this.mt2 = 2 * param1.t;
      }
      
      private var m:BigInteger;
      
      private var mp:int;
      
      private var mpl:int;
      
      private var mph:int;
      
      private var um:int;
      
      private var mt2:int;
      
      public function convert(param1:BigInteger) : BigInteger {
         var _loc2_:BigInteger = new BigInteger();
         param1.abs().dlShiftTo(this.m.t,_loc2_);
         _loc2_.divRemTo(this.m,null,_loc2_);
         if(param1.s < 0 && _loc2_.compareTo(BigInteger.ZERO) > 0)
         {
            this.m.subTo(_loc2_,_loc2_);
         }
         return _loc2_;
      }
      
      public function revert(param1:BigInteger) : BigInteger {
         var _loc2_:BigInteger = new BigInteger();
         param1.copyTo(_loc2_);
         this.reduce(_loc2_);
         return _loc2_;
      }
      
      public function reduce(param1:BigInteger) : void {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         while(param1.t <= this.mt2)
         {
            param1.a[param1.t++] = 0;
         }
         var _loc2_:* = 0;
         while(_loc2_ < this.m.t)
         {
            _loc3_ = param1.a[_loc2_] & 32767;
            _loc4_ = _loc3_ * this.mpl + ((_loc3_ * this.mph + (param1.a[_loc2_] >> 15) * this.mpl & this.um) << 15) & BigInteger.DM;
            _loc3_ = _loc2_ + this.m.t;
            param1.a[_loc3_] = param1.a[_loc3_] + this.m.am(0,_loc4_,param1,_loc2_,0,this.m.t);
            while(param1.a[_loc3_] >= BigInteger.DV)
            {
               param1.a[_loc3_] = param1.a[_loc3_] - BigInteger.DV;
               param1.a[++_loc3_]++;
            }
            _loc2_++;
         }
         param1.clamp();
         param1.drShiftTo(this.m.t,param1);
         if(param1.compareTo(this.m) >= 0)
         {
            param1.subTo(this.m,param1);
         }
      }
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void {
         param1.squareTo(param2);
         this.reduce(param2);
      }
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void {
         param1.multiplyTo(param2,param3);
         this.reduce(param3);
      }
   }
}
