package com.hurlant.math
{
   class ClassicReduction extends Object implements IReduction
   {
      
      function ClassicReduction(m:BigInteger) {
         super();
         this.m = m;
      }
      
      private var m:BigInteger;
      
      public function convert(x:BigInteger) : BigInteger {
         if((x.s < 0) || (x.compareTo(this.m) >= 0))
         {
            return x.mod(this.m);
         }
         return x;
      }
      
      public function revert(x:BigInteger) : BigInteger {
         return x;
      }
      
      public function reduce(x:BigInteger) : void {
         x.divRemTo(this.m,null,x);
      }
      
      public function mulTo(x:BigInteger, y:BigInteger, r:BigInteger) : void {
         x.multiplyTo(y,r);
         this.reduce(r);
      }
      
      public function sqrTo(x:BigInteger, r:BigInteger) : void {
         x.squareTo(r);
         this.reduce(r);
      }
   }
}
