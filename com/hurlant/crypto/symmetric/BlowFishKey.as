package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   import com.hurlant.util.Memory;
   
   public class BlowFishKey extends Object implements ISymmetricKey
   {
      
      public function BlowFishKey(key:ByteArray) {
         super();
         this.key = key;
         this.setKey(key);
      }
      
      private static const KP:Array;
      
      private static const KS0:Array;
      
      private static const KS1:Array;
      
      private static const KS2:Array;
      
      private static const KS3:Array;
      
      private static const ROUNDS:uint = 16;
      
      private static const BLOCK_SIZE:uint = 8;
      
      private static const SBOX_SK:uint = 256;
      
      private static const P_SZ:uint = 18.0;
      
      private var S0:Array;
      
      private var S1:Array;
      
      private var S2:Array;
      
      private var S3:Array;
      
      private var P:Array;
      
      private var key:ByteArray = null;
      
      public function getBlockSize() : uint {
         return BLOCK_SIZE;
      }
      
      public function decrypt(block:ByteArray, index:uint = 0) : void {
         this.decryptBlock(block,index,block,index);
      }
      
      public function dispose() : void {
         var i:uint = 0;
         i = 0;
         while(i < this.S0.length)
         {
            this.S0[i] = 0;
            i++;
         }
         i = 0;
         while(i < this.S1.length)
         {
            this.S1[i] = 0;
            i++;
         }
         i = 0;
         while(i < this.S2.length)
         {
            this.S2[i] = 0;
            i++;
         }
         i = 0;
         while(i < this.S3.length)
         {
            this.S3[i] = 0;
            i++;
         }
         i = 0;
         while(i < this.P.length)
         {
            this.P[i] = 0;
            i++;
         }
         this.S0 = null;
         this.S1 = null;
         this.S2 = null;
         this.S3 = null;
         this.P = null;
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
         this.encryptBlock(block,index,block,index);
      }
      
      private function F(x:uint) : uint {
         return (this.S0[x >>> 24] + this.S1[x >>> 16 & 255] ^ this.S2[x >>> 8 & 255]) + this.S3[x & 255];
      }
      
      private function processTable(xl:uint, xr:uint, table:Array) : void {
         var i:uint = 0;
         var size:uint = table.length;
         var s:uint = 0;
         while(s < size)
         {
            xl = xl ^ this.P[0];
            i = 1;
            while(i < ROUNDS)
            {
               xr = xr ^ this.F(xl) ^ this.P[i];
               xl = xl ^ this.F(xr) ^ this.P[i + 1];
               i = i + 2;
            }
            xr = xr ^ this.P[ROUNDS + 1];
            table[s] = xr;
            table[s + 1] = xl;
            xr = xl;
            xl = table[s];
            s = s + 2;
         }
      }
      
      private function setKey(key:ByteArray) : void {
         var data:uint = 0;
         var j:uint = 0;
         this.S0 = KS0.concat();
         this.S1 = KS1.concat();
         this.S2 = KS2.concat();
         this.S3 = KS3.concat();
         this.P = KP.concat();
         var keyLength:uint = key.length;
         var keyIndex:uint = 0;
         var i:uint = 0;
         while(i < P_SZ)
         {
            data = 0;
            j = 0;
            while(j < 4)
            {
               data = data << 8 | key[keyIndex++] & 255;
               if(keyIndex >= keyLength)
               {
                  keyIndex = 0;
               }
               j++;
            }
            this.P[i] = this.P[i] ^ data;
            i++;
         }
         this.processTable(0,0,this.P);
         this.processTable(this.P[P_SZ - 2],this.P[P_SZ - 1],this.S0);
         this.processTable(this.S0[SBOX_SK - 2],this.S0[SBOX_SK - 1],this.S1);
         this.processTable(this.S1[SBOX_SK - 2],this.S1[SBOX_SK - 1],this.S2);
         this.processTable(this.S2[SBOX_SK - 2],this.S2[SBOX_SK - 1],this.S3);
      }
      
      private function encryptBlock(src:ByteArray, srcIndex:uint, dst:ByteArray, dstIndex:uint) : void {
         var xl:uint = this.BytesTo32bits(src,srcIndex);
         var xr:uint = this.BytesTo32bits(src,srcIndex + 4);
         xl = xl ^ this.P[0];
         var i:uint = 1;
         while(i < ROUNDS)
         {
            xr = xr ^ this.F(xl) ^ this.P[i];
            xl = xl ^ this.F(xr) ^ this.P[i + 1];
            i = i + 2;
         }
         xr = xr ^ this.P[ROUNDS + 1];
         this.Bits32ToBytes(xr,dst,dstIndex);
         this.Bits32ToBytes(xl,dst,dstIndex + 4);
      }
      
      private function decryptBlock(src:ByteArray, srcIndex:uint, dst:ByteArray, dstIndex:uint) : void {
         var xl:uint = this.BytesTo32bits(src,srcIndex);
         var xr:uint = this.BytesTo32bits(src,srcIndex + 4);
         xl = xl ^ this.P[ROUNDS + 1];
         var i:uint = ROUNDS;
         while(i > 0)
         {
            xr = xr ^ this.F(xl) ^ this.P[i];
            xl = xl ^ this.F(xr) ^ this.P[i - 1];
            i = i - 2;
         }
         xr = xr ^ this.P[0];
         this.Bits32ToBytes(xr,dst,dstIndex);
         this.Bits32ToBytes(xl,dst,dstIndex + 4);
      }
      
      private function BytesTo32bits(b:ByteArray, i:uint) : uint {
         return (b[i] & 255) << 24 | (b[i + 1] & 255) << 16 | (b[i + 2] & 255) << 8 | b[i + 3] & 255;
      }
      
      private function Bits32ToBytes(i:uint, b:ByteArray, offset:uint) : void {
         b[offset + 3] = i;
         b[offset + 2] = i >> 8;
         b[offset + 1] = i >> 16;
         b[offset] = i >> 24;
      }
      
      public function toString() : String {
         return "blowfish";
      }
   }
}
