package com.hurlant.crypto.hash
{
   public class SHA224 extends SHA256
   {
      
      public function SHA224()
      {
         super();
         h = [3.238371032E9,914150663,812702999,4.144912697E9,4.290775857E9,1750603025,1694076839,3.204075428E9];
      }
      
      override public function getHashSize() : uint
      {
         return 28;
      }
      
      override public function toString() : String
      {
         return "sha224";
      }
   }
}
