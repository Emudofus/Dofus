package com.hurlant.math
{
   use namespace bi_internal;
   
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
         var j:* = 0;
         var u0:* = 0;
         while(x.t <= this.mt2)
         {
            x.a[x.t++] = 0;
         }
         var i:int = 0;
         while(i < this.m.t)
         {
            j = x.a[i] & 32767;
            u0 = j * this.mpl + ((j * this.mph + (x.a[i] >> 15) * this.mpl & this.um) << 15) & BigInteger.DM;
            j = i + this.m.t;
            x.a[j] = x.a[j] + this.m.am(0,u0,x,i,0,this.m.t);
            while(x.a[j] >= BigInteger.DV)
            {
               x.a[j] = x.a[j] - BigInteger.DV;
               x.a[++j]++;
            }
            i++;
         }
         x.clamp();
         x.drShiftTo(this.m.t,x);
         if(x.compareTo(this.m) >= 0)
         {
            x.subTo(this.m,x);
         }
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
