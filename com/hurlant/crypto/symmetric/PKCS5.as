package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class PKCS5 extends Object implements IPad
   {
      
      public function PKCS5(blockSize:uint=0) {
         super();
         this.blockSize = blockSize;
      }
      
      private var blockSize:uint;
      
      public function pad(a:ByteArray) : void {
         var c:uint = this.blockSize - a.length % this.blockSize;
         var i:uint = 0;
         while(i < c)
         {
            a[a.length] = c;
            i++;
         }
      }
      
      public function unpad(a:ByteArray) : void {
         var v:uint = 0;
         var c:uint = a.length % this.blockSize;
         if(c != 0)
         {
            throw new Error("PKCS#5::unpad: ByteArray.length isn\'t a multiple of the blockSize");
         }
         else
         {
            c = a[a.length - 1];
            i = c;
            while(i > 0)
            {
               v = a[a.length - 1];
               a.length--;
               if(c != v)
               {
                  throw new Error("PKCS#5:unpad: Invalid padding value. expected [" + c + "], found [" + v + "]");
               }
               else
               {
                  i--;
                  continue;
               }
            }
            return;
         }
      }
      
      public function setBlockSize(bs:uint) : void {
         this.blockSize = bs;
      }
   }
}
