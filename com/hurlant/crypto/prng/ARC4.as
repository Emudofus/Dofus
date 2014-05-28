package com.hurlant.crypto.prng
{
   import com.hurlant.crypto.symmetric.IStreamCipher;
   import flash.utils.ByteArray;
   import com.hurlant.util.Memory;
   
   public class ARC4 extends Object implements IPRNG, IStreamCipher
   {
      
      public function ARC4(key:ByteArray = null) {
         super();
         this.S = new ByteArray();
         if(key)
         {
            this.init(key);
         }
      }
      
      private var i:int = 0;
      
      private var j:int = 0;
      
      private var S:ByteArray;
      
      private const psize:uint = 256;
      
      public function getPoolSize() : uint {
         return this.psize;
      }
      
      public function init(key:ByteArray) : void {
         var i:* = 0;
         var j:* = 0;
         var t:* = 0;
         i = 0;
         while(i < 256)
         {
            this.S[i] = i;
            i++;
         }
         j = 0;
         i = 0;
         while(i < 256)
         {
            j = j + this.S[i] + key[i % key.length] & 255;
            t = this.S[i];
            this.S[i] = this.S[j];
            this.S[j] = t;
            i++;
         }
         this.i = 0;
         this.j = 0;
      }
      
      public function next() : uint {
         var t:* = 0;
         this.i = this.i + 1 & 255;
         this.j = this.j + this.S[this.i] & 255;
         t = this.S[this.i];
         this.S[this.i] = this.S[this.j];
         this.S[this.j] = t;
         return this.S[t + this.S[this.i] & 255];
      }
      
      public function getBlockSize() : uint {
         return 1;
      }
      
      public function encrypt(block:ByteArray) : void {
         var i:uint = 0;
         while(i < block.length)
         {
            block[i++] = block[i++] ^ this.next();
         }
      }
      
      public function decrypt(block:ByteArray) : void {
         this.encrypt(block);
      }
      
      public function dispose() : void {
         var i:uint = 0;
         if(this.S != null)
         {
            i = 0;
            while(i < this.S.length)
            {
               this.S[i] = Math.random() * 256;
               i++;
            }
            this.S.length = 0;
            this.S = null;
         }
         this.i = 0;
         this.j = 0;
         Memory.gc();
      }
      
      public function toString() : String {
         return "rc4";
      }
   }
}
