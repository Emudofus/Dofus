package com.hurlant.crypto.hash
{
   public class SHA256 extends SHABase implements IHash
   {
      
      public function SHA256() {
         this.h = [1779033703,3.144134277E9,1013904242,2.773480762E9,1359893119,2.600822924E9,528734635,1541459225];
         super();
      }
      
      protected static const k:Array;
      
      protected var h:Array;
      
      override public function getHashSize() : uint {
         return 32;
      }
      
      override protected function core(x:Array, len:uint) : Array {
         var olda:uint = 0;
         var oldb:uint = 0;
         var oldc:uint = 0;
         var oldd:uint = 0;
         var olde:uint = 0;
         var oldf:uint = 0;
         var oldg:uint = 0;
         var oldh:uint = 0;
         var j:uint = 0;
         var t2:uint = 0;
         var t1:uint = 0;
         var s0:uint = 0;
         var s1:uint = 0;
         x[len >> 5] = x[len >> 5] | 128 << 24 - len % 32;
         x[(len + 64 >> 9 << 4) + 15] = len;
         var w:Array = [];
         var a:uint = this.h[0];
         var b:uint = this.h[1];
         var c:uint = this.h[2];
         var d:uint = this.h[3];
         var e:uint = this.h[4];
         var f:uint = this.h[5];
         var g:uint = this.h[6];
         var h:uint = this.h[7];
         var i:uint = 0;
         while(i < x.length)
         {
            olda = a;
            oldb = b;
            oldc = c;
            oldd = d;
            olde = e;
            oldf = f;
            oldg = g;
            oldh = h;
            j = 0;
            while(j < 64)
            {
               if(j < 16)
               {
                  w[j] = x[i + j] || 0;
               }
               else
               {
                  s0 = this.rrol(w[j - 15],7) ^ this.rrol(w[j - 15],18) ^ w[j - 15] >>> 3;
                  s1 = this.rrol(w[j - 2],17) ^ this.rrol(w[j - 2],19) ^ w[j - 2] >>> 10;
                  w[j] = w[j - 16] + s0 + w[j - 7] + s1;
               }
               t2 = (this.rrol(a,2) ^ this.rrol(a,13) ^ this.rrol(a,22)) + (a & b ^ a & c ^ b & c);
               t1 = h + (this.rrol(e,6) ^ this.rrol(e,11) ^ this.rrol(e,25)) + (e & f ^ g & ~e) + k[j] + w[j];
               h = g;
               g = f;
               f = e;
               e = d + t1;
               d = c;
               c = b;
               b = a;
               a = t1 + t2;
               j++;
            }
            a = a + olda;
            b = b + oldb;
            c = c + oldc;
            d = d + oldd;
            e = e + olde;
            f = f + oldf;
            g = g + oldg;
            h = h + oldh;
            i = i + 16;
         }
         return [a,b,c,d,e,f,g,h];
      }
      
      protected function rrol(num:uint, cnt:uint) : uint {
         return num << 32 - cnt | num >>> cnt;
      }
      
      override public function toString() : String {
         return "sha256";
      }
   }
}
