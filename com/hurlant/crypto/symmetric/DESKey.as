package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   import com.hurlant.util.Memory;
   
   public class DESKey extends Object implements ISymmetricKey
   {
      
      public function DESKey(key:ByteArray) {
         super();
         this.key = key;
         this.encKey = this.generateWorkingKey(true,key,0);
         this.decKey = this.generateWorkingKey(false,key,0);
      }
      
      private static const Df_Key:Array;
      
      private static const bytebit:Array;
      
      private static const bigbyte:Array;
      
      private static const pc1:Array;
      
      private static const totrot:Array;
      
      private static const pc2:Array;
      
      private static const SP1:Array;
      
      private static const SP2:Array;
      
      private static const SP3:Array;
      
      private static const SP4:Array;
      
      private static const SP5:Array;
      
      private static const SP6:Array;
      
      private static const SP7:Array;
      
      private static const SP8:Array;
      
      protected var key:ByteArray;
      
      protected var encKey:Array;
      
      protected var decKey:Array;
      
      public function getBlockSize() : uint {
         return 8;
      }
      
      public function decrypt(block:ByteArray, index:uint = 0) : void {
         this.desFunc(this.decKey,block,index,block,index);
      }
      
      public function dispose() : void {
         var i:uint = 0;
         i = 0;
         while(i < this.encKey.length)
         {
            this.encKey[i] = 0;
            i++;
         }
         i = 0;
         while(i < this.decKey.length)
         {
            this.decKey[i] = 0;
            i++;
         }
         this.encKey = null;
         this.decKey = null;
         i = 0;
         while(i < this.key.length)
         {
            this.key[i] = 0;
            i++;
         }
         this.key.length = 0;
         this.key = null;
         Memory.gc();
      }
      
      public function encrypt(block:ByteArray, index:uint = 0) : void {
         this.desFunc(this.encKey,block,index,block,index);
      }
      
      protected function generateWorkingKey(encrypting:Boolean, key:ByteArray, off:uint) : Array {
         var l:uint = 0;
         var m:uint = 0;
         var n:uint = 0;
         var i1:uint = 0;
         var i2:uint = 0;
         var newKey:Array = [];
         var pc1m:ByteArray = new ByteArray();
         var pcr:ByteArray = new ByteArray();
         var j:uint = 0;
         while(j < 56)
         {
            l = pc1[j];
            pc1m[j] = !((key[off + (l >>> 3)] & bytebit[l & 7]) == 0);
            j++;
         }
         var i:uint = 0;
         while(i < 16)
         {
            if(encrypting)
            {
               m = i << 1;
            }
            else
            {
               m = 15 - i << 1;
            }
            n = m + 1;
            newKey[m] = newKey[n] = 0;
            j = 0;
            while(j < 28)
            {
               l = j + totrot[i];
               if(l < 28)
               {
                  pcr[j] = pc1m[l];
               }
               else
               {
                  pcr[j] = pc1m[l - 28];
               }
               j++;
            }
            j = 28;
            while(j < 56)
            {
               l = j + totrot[i];
               if(l < 56)
               {
                  pcr[j] = pc1m[l];
               }
               else
               {
                  pcr[j] = pc1m[l - 28];
               }
               j++;
            }
            j = 0;
            while(j < 24)
            {
               if(pcr[pc2[j]])
               {
                  newKey[m] = newKey[m] | bigbyte[j];
               }
               if(pcr[pc2[j + 24]])
               {
                  newKey[n] = newKey[n] | bigbyte[j];
               }
               j++;
            }
            i++;
         }
         i = 0;
         while(i != 32)
         {
            i1 = newKey[i];
            i2 = newKey[i + 1];
            newKey[i] = (i1 & 16515072) << 6 | (i1 & 4032) << 10 | (i2 & 16515072) >>> 10 | (i2 & 4032) >>> 6;
            newKey[i + 1] = (i1 & 258048) << 12 | (i1 & 63) << 16 | (i2 & 258048) >>> 4 | i2 & 63;
            i = i + 2;
         }
         return newKey;
      }
      
      protected function desFunc(wKey:Array, inp:ByteArray, inOff:uint, out:ByteArray, outOff:uint) : void {
         var work:uint = 0;
         var right:uint = 0;
         var left:uint = 0;
         var fval:uint = 0;
         left = (inp[inOff + 0] & 255) << 24;
         left = left | (inp[inOff + 1] & 255) << 16;
         left = left | (inp[inOff + 2] & 255) << 8;
         left = left | inp[inOff + 3] & 255;
         right = (inp[inOff + 4] & 255) << 24;
         right = right | (inp[inOff + 5] & 255) << 16;
         right = right | (inp[inOff + 6] & 255) << 8;
         right = right | inp[inOff + 7] & 255;
         work = (left >>> 4 ^ right) & 252645135;
         right = right ^ work;
         left = left ^ work << 4;
         work = (left >>> 16 ^ right) & 65535;
         right = right ^ work;
         left = left ^ work << 16;
         work = (right >>> 2 ^ left) & 858993459;
         left = left ^ work;
         right = right ^ work << 2;
         work = (right >>> 8 ^ left) & 16711935;
         left = left ^ work;
         right = right ^ work << 8;
         right = (right << 1 | right >>> 31 & 1) & 4.294967295E9;
         work = (left ^ right) & 2.86331153E9;
         left = left ^ work;
         right = right ^ work;
         left = (left << 1 | left >>> 31 & 1) & 4.294967295E9;
         var round:uint = 0;
         while(round < 8)
         {
            work = right << 28 | right >>> 4;
            work = work ^ wKey[round * 4 + 0];
            fval = SP7[work & 63];
            fval = fval | SP5[work >>> 8 & 63];
            fval = fval | SP3[work >>> 16 & 63];
            fval = fval | SP1[work >>> 24 & 63];
            work = right ^ wKey[round * 4 + 1];
            fval = fval | SP8[work & 63];
            fval = fval | SP6[work >>> 8 & 63];
            fval = fval | SP4[work >>> 16 & 63];
            fval = fval | SP2[work >>> 24 & 63];
            left = left ^ fval;
            work = left << 28 | left >>> 4;
            work = work ^ wKey[round * 4 + 2];
            fval = SP7[work & 63];
            fval = fval | SP5[work >>> 8 & 63];
            fval = fval | SP3[work >>> 16 & 63];
            fval = fval | SP1[work >>> 24 & 63];
            work = left ^ wKey[round * 4 + 3];
            fval = fval | SP8[work & 63];
            fval = fval | SP6[work >>> 8 & 63];
            fval = fval | SP4[work >>> 16 & 63];
            fval = fval | SP2[work >>> 24 & 63];
            right = right ^ fval;
            round++;
         }
         right = right << 31 | right >>> 1;
         work = (left ^ right) & 2.86331153E9;
         left = left ^ work;
         right = right ^ work;
         left = left << 31 | left >>> 1;
         work = (left >>> 8 ^ right) & 16711935;
         right = right ^ work;
         left = left ^ work << 8;
         work = (left >>> 2 ^ right) & 858993459;
         right = right ^ work;
         left = left ^ work << 2;
         work = (right >>> 16 ^ left) & 65535;
         left = left ^ work;
         right = right ^ work << 16;
         work = (right >>> 4 ^ left) & 252645135;
         left = left ^ work;
         right = right ^ work << 4;
         out[outOff + 0] = right >>> 24 & 255;
         out[outOff + 1] = right >>> 16 & 255;
         out[outOff + 2] = right >>> 8 & 255;
         out[outOff + 3] = right & 255;
         out[outOff + 4] = left >>> 24 & 255;
         out[outOff + 5] = left >>> 16 & 255;
         out[outOff + 6] = left >>> 8 & 255;
         out[outOff + 7] = left & 255;
      }
      
      public function toString() : String {
         return "des";
      }
   }
}
