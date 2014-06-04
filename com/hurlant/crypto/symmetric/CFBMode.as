package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class CFBMode extends IVMode implements IMode
   {
      
      public function CFBMode(key:ISymmetricKey, padding:IPad = null) {
         super(key,null);
      }
      
      public function encrypt(src:ByteArray) : void {
         var chunk:uint = 0;
         var j:uint = 0;
         var l:uint = src.length;
         var vector:ByteArray = getIV4e();
         var i:uint = 0;
         while(i < src.length)
         {
            key.encrypt(vector);
            chunk = i + blockSize < l?blockSize:l - i;
            j = 0;
            while(j < chunk)
            {
               src[i + j] = src[i + j] ^ vector[j];
               j++;
            }
            vector.position = 0;
            vector.writeBytes(src,i,chunk);
            i = i + blockSize;
         }
      }
      
      public function decrypt(src:ByteArray) : void {
         var chunk:uint = 0;
         var j:uint = 0;
         var l:uint = src.length;
         var vector:ByteArray = getIV4d();
         var tmp:ByteArray = new ByteArray();
         var i:uint = 0;
         while(i < src.length)
         {
            key.encrypt(vector);
            chunk = i + blockSize < l?blockSize:l - i;
            tmp.position = 0;
            tmp.writeBytes(src,i,chunk);
            j = 0;
            while(j < chunk)
            {
               src[i + j] = src[i + j] ^ vector[j];
               j++;
            }
            vector.position = 0;
            vector.writeBytes(tmp);
            i = i + blockSize;
         }
      }
      
      public function toString() : String {
         return key.toString() + "-cfb";
      }
   }
}
