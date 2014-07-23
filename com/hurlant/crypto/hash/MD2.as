package com.hurlant.crypto.hash
{
   import flash.utils.ByteArray;
   
   public class MD2 extends Object implements IHash
   {
      
      public function MD2() {
         super();
      }
      
      public static const HASH_SIZE:int = 16;
      
      private static const S:Array;
      
      public var pad_size:int = 48;
      
      public function getInputSize() : uint {
         return 16;
      }
      
      public function getPadSize() : int {
         return this.pad_size;
      }
      
      public function getHashSize() : uint {
         return HASH_SIZE;
      }
      
      public function hash(src:ByteArray) : ByteArray {
          var j:uint;
          var t:uint;
          var k:uint;
          var savedLength:uint = src.length;
          var i:uint = (((16 - (src.length % 16))) || (16));
          do  {
              src[src.length] = i;
          } while ((src.length % 16) != 0);
          var len:uint = src.length;
          var checksum:ByteArray = new ByteArray();
          var L:uint;
          i = 0;
          while (i < len) {
              j = 0;
              while (j < 16) {
                  L = (checksum[j] = (checksum[j] ^ S[(src[(i + j)] ^ L)]));
                  j++;
              };
              i = (i + 16);
          };
          src.position = src.length;
          src.writeBytes(checksum);
          len = (len + 16);
          var X:ByteArray = new ByteArray();
          i = 0;
          while (i < len) {
              j = 0;
              while (j < 16) {
                  X[(32 + j)] = ((X[(16 + j)] = src[(i + j)]) ^ X[j]);
                  j++;
              };
              t = 0;
              j = 0;
              while (j < 18) {
                  k = 0;
                  while (k < 48) {
                      t = (X[k] ^ S[t]);
                      X[k] = t;
                      k++;
                  };
                  t = ((t + j) & 0xFF);
                  j++;
              };
              i = (i + 16);
          };
          X.length = 16;
          src.length = savedLength;
          return (X);
      }
      
      public function toString() : String {
         return "md2";
      }
   }
}
