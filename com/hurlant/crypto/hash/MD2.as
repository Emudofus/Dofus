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
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function toString() : String {
         return "md2";
      }
   }
}
