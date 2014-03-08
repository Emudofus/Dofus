package com.hurlant.math
{
   use namespace bi_internal;
   
   class ClassicReduction extends Object implements IReduction
   {
      
      function ClassicReduction(param1:BigInteger) {
         super();
         this.m = param1;
      }
      
      private var m:BigInteger;
      
      public function convert(param1:BigInteger) : BigInteger {
         if(param1.s < 0 || param1.compareTo(this.m) >= 0)
         {
            return param1.mod(this.m);
         }
         return param1;
      }
      
      public function revert(param1:BigInteger) : BigInteger {
         return param1;
      }
      
      public function reduce(param1:BigInteger) : void {
         param1.divRemTo(this.m,null,param1);
      }
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void {
         param1.multiplyTo(param2,param3);
         this.reduce(param3);
      }
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void {
         param1.squareTo(param2);
         this.reduce(param2);
      }
   }
}
