package com.hurlant.math
{
   class MontgomeryReduction extends Object implements IReduction
   {
      
      function MontgomeryReduction(m:BigInteger) {
         super();
         this.m = m;
         this.mp = m.invDigit();
         this.mpl = this.mp & 32767;
         this.mph = this.mp >> 15;
         this.um = (1 << BigInteger.DB - 15) - 1;
         this.mt2 = 2 * m.t;
      }
      
      private var m:BigInteger;
      
      private var mp:int;
      
      private var mpl:int;
      
      private var mph:int;
      
      private var um:int;
      
      private var mt2:int;
      
      public function convert(x:BigInteger) : BigInteger {
         var r:BigInteger = new BigInteger();
         x.abs().dlShiftTo(this.m.t,r);
         r.divRemTo(this.m,null,r);
         if((x.s < 0) && (r.compareTo(BigInteger.ZERO) > 0))
         {
            this.m.subTo(r,r);
         }
         return r;
      }
      
      public function revert(x:BigInteger) : BigInteger {
         var r:BigInteger = new BigInteger();
         x.copyTo(r);
         this.reduce(r);
         return r;
      }
      
      public function reduce(x:BigInteger) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function sqrTo(x:BigInteger, r:BigInteger) : void {
         x.squareTo(r);
         this.reduce(r);
      }
      
      public function mulTo(x:BigInteger, y:BigInteger, r:BigInteger) : void {
         x.multiplyTo(y,r);
         this.reduce(r);
      }
   }
}
